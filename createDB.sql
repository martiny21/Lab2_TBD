CREATE DATABASE tbd2;
\c

-- Extensión PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;


-- Crear tabla categoría
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Crear la tabla almacén
CREATE TABLE warehouse (
    warehouse_id SERIAL PRIMARY KEY, -- ID único almacén
    addres VARCHAR(255) NOT NULL,  -- dirección del almacén, escrito con una "s" menos para evitar problemas
    latitude DECIMAL(9,6) NOT NULL, -- Latitud del almacén
    longitude DECIMAL(9,6) NOT NULL, -- Longitud del almacén
    geom GEOMETRY(point, 4326) NOT NULL, -- Geometría de tipo punto (lugar almacén)
    delivery_zone INTEGER REFERENCES comunas (gid) -- Comuna de donde se reparte (zona de reparto)
);

-- Chequeos de geometrías válidas
ALTER TABLE warehouse
ADD CONSTRAINT  check_point CHECK (ST_GeometryType(geom) = 'ST_Point');

-- Crear tabla producto
CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_desc TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    state VARCHAR(50) NOT NULL CHECK (
        state IN ('disponible', 'agotado')
    ),
    category_id INTEGER NOT NULL REFERENCES category (category_id),
    warehouse_id INTEGER NOT NULL REFERENCES warehouse (warehouse_id)
);

-- Crear tabla cliente
CREATE TABLE client (
    client_id SERIAL PRIMARY KEY,
    client_name VARCHAR(255) NOT NULL,
    direction VARCHAR(255),
    email VARCHAR(100) UNIQUE NOT NULL,
    client_number VARCHAR(20),
    client_password VARCHAR(100) NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE,
    direction_geom GEOMETRY (point, 4326)   -- Geometría de tipo punto (punto asociado a la dirección)
);

-- Crear tabla orden
CREATE TABLE order_info (
    order_id SERIAL PRIMARY KEY,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    state VARCHAR(50) NOT NULL CHECK (
        state IN (
            'pendiente',
            'pagada',
            'enviada',
            'devolucion'
        )
    ),
    client_id INTEGER NOT NULL REFERENCES client (client_id),
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0)
);

-- Crear la tabla de repartidor
CREATE TABLE delivery_person (
    delivery_person_id SERIAL PRIMARY KEY, -- ID único del repartidor
    name VARCHAR(255) NOT NULL, -- Nombre del repartidor
    contact_number VARCHAR(20) -- Número de contacto
);

-- Crear Tabla con los puntos donde se repartieron órdenes
CREATE TABLE delivery_points (
    delivery_id SERIAL PRIMARY KEY, -- ID único de la entrega
    delivery_person_id INTEGER NOT NULL
     REFERENCES delivery_person (delivery_person_id) ON DELETE CASCADE, -- Relación con el repartidor
    order_id INTEGER NOT NULL
    REFERENCES order_info (order_id) ON DELETE CASCADE, -- Relación con la orden
    delivery_geom GEOMETRY(Point, 4326) NOT NULL, -- Punto donde se realizó la entrega
    delivery_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Fecha y hora de la entrega
);

--Crear tabla de devoluciones
CREATE TABLE returns (
    return_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES order_info (order_id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES product (product_id),
    return_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount INT NOT NULL CHECK (amount > 0),
    reason TEXT
);

-- Crear tabla detalle_orden
CREATE TABLE order_detail (
    detail_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES order_info (order_id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES product (product_id),
    amount INT NOT NULL CHECK (amount > 0),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0)
);


-- Crear tabla para registrar auditorías de inserciones y cambios
CREATE TABLE audit_log (
    insertion_id SERIAL PRIMARY KEY, -- Identificador único para cada entrada de auditoría
    table_name_affected TEXT NOT NULL, -- Nombre de la tabla afectada
    operation_type TEXT NOT NULL CHECK ( -- Tipo de operación realizada: INSERT, UPDATE, DELETE
        operation_type IN ('INSERT', 'UPDATE', 'DELETE')
    ),
    client_id INTEGER REFERENCES client (client_id) ON DELETE SET NULL, -- ID del cliente relacionado, permite NULL si no aplica
    query_time TIMESTAMP DEFAULT NOW(), -- Fecha y hora en que se realizó la operación
    new_data JSONB -- Datos nuevos en caso de INSERT o UPDATE
);

-- Crear tabla para las alertas
CREATE TABLE shop_alerts (
    alert_id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES client (client_id),
    alert_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    alert_desc TEXT NOT NULL
);

-- Crear la tabla problematic_order
CREATE TABLE problematic_order (
    order_id INTEGER PRIMARY KEY REFERENCES order_info (order_id) ON DELETE CASCADE,
    stock_issues_count INT NOT NULL DEFAULT 0 CHECK (stock_issues_count >= 0)
);

-- Crear insertion trigger function
CREATE OR REPLACE FUNCTION insertion_trigger_function()
RETURNS TRIGGER AS $$
DECLARE
    v_client_id INT;

BEGIN

    -- Estos datos deben ser enviados por la aplicación al realizar una consulta.
    v_client_id := current_setting('app.client_id', true)::INT;


    INSERT INTO audit_log(
        table_name_affected,
        operation_type,
        client_id,
        query_time,
        new_data
    )
    VALUES (
        TG_TABLE_NAME, -- Nombre de la tabla afectada
        TG_OP,         -- Tipo de operación (INSERT, UPDATE, DELETE)
        v_client_id,
        NOW(),

        CASE WHEN TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN row_to_json(NEW) ELSE NULL END -- Datos nuevos
    );

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_client_query_report()
RETURNS TABLE(client_id INTEGER, query_count BIGINT) AS $$
BEGIN
    RETURN QUERY
    SELECT audit_log.client_id, COUNT(*) AS query_count
    FROM audit_log
    WHERE audit_log.operation_type IN ('INSERT', 'UPDATE', 'DELETE')
    GROUP BY audit_log.client_id
    ORDER BY query_count DESC;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verify_reciently_shop()
RETURNS TRIGGER AS $$
DECLARE
    shops_in_24 INT;
BEGIN
    -- Contar las compras realizadas por el cliente en las últimas 24 horas
    SELECT COUNT(*)
    INTO shops_in_24
    FROM order_info
    WHERE client_id = NEW.client_id
      AND order_date >= NOW() - INTERVAL '24 hours';

    -- Si el cliente tiene más de una compra en las últimas 24 horas, registrar una alerta
    IF shops_in_24 > 1 THEN
        INSERT INTO shop_alerts (client_id, alert_desc)
        VALUES (
            NEW.client_id,
            'El cliente con ID ' || NEW.client_id ||
            ' ha realizado más de una compra en las últimas 24 horas.'
        );
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertion_trigger AFTER
INSERT
    OR
UPDATE
OR DELETE ON category FOR EACH ROW
EXECUTE FUNCTION insertion_trigger_function ();

CREATE TRIGGER insertion_trigger AFTER
INSERT
    OR
UPDATE
OR DELETE ON product FOR EACH ROW
EXECUTE FUNCTION insertion_trigger_function ();

CREATE TRIGGER insertion_trigger AFTER
INSERT
    OR
UPDATE
OR DELETE ON client FOR EACH ROW
EXECUTE FUNCTION insertion_trigger_function ();

CREATE TRIGGER insertion_trigger AFTER
INSERT
    OR
UPDATE
OR DELETE ON order_info FOR EACH ROW
EXECUTE FUNCTION insertion_trigger_function ();

CREATE TRIGGER insertion_trigger AFTER
INSERT
    OR
UPDATE
OR DELETE ON order_detail FOR EACH ROW
EXECUTE FUNCTION insertion_trigger_function ();

CREATE TRIGGER verify_reciently_shop_trigger AFTER
INSERT
    ON order_info FOR EACH ROW
EXECUTE FUNCTION verify_reciently_shop ();

--trigger para actualizar stock

-- Función para manejar devoluciones y actualizar el stock
CREATE OR REPLACE FUNCTION update_stock_on_return_via_order()
RETURNS TRIGGER AS $$
DECLARE
    detail RECORD;
BEGIN
    -- Verificar si el estado de la orden cambia a "devolución"
    IF NEW.state = 'devolucion' THEN
        -- Recorrer los detalles de la orden en order_detail
        FOR detail IN
            SELECT product_id, amount
            FROM order_detail
            WHERE order_id = NEW.order_id
        LOOP
            -- Actualizar el stock del producto
            UPDATE product
            SET stock = stock + detail.amount
            WHERE product_id = detail.product_id;

            -- Registrar la devolución en la tabla returns
            INSERT INTO returns (order_id, product_id, amount, reason)
            VALUES (NEW.order_id, detail.product_id, detail.amount, 'Devolución de orden');
        END LOOP;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para manejar devoluciones
CREATE TRIGGER update_stock_on_order_return AFTER
UPDATE OF state ON order_info FOR EACH ROW
EXECUTE FUNCTION update_stock_on_return_via_order ();

--query ¿Qué porcentaje de las órdenes de cada cliente ha tenido problemas de stock (algún producto en la orden no estaba disponible al momento de la compra)?

CREATE TABLE stock_issues (
    issue_id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES client (client_id),
    order_id INTEGER NOT NULL REFERENCES order_info (order_id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES product (product_id),
    issue_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    requested_amount INT NOT NULL,
    available_stock INT NOT NULL
);

CREATE OR REPLACE FUNCTION get_stock_issue_percentage()
RETURNS TABLE (
    client_id INTEGER,
    client_name VARCHAR(255),
    total_orders INT,
    problematic_orders INT,
    issue_percentage NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        c.client_id,
        c.client_name,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COUNT(DISTINCT si.order_id) AS problematic_orders,
        CASE
            WHEN COUNT(DISTINCT o.order_id) = 0 THEN 0
            ELSE ROUND(
                (COUNT(DISTINCT si.order_id)::NUMERIC / COUNT(DISTINCT o.order_id)) * 100, 2
            )
        END AS issue_percentage
    FROM
        client c
    LEFT JOIN order_info o ON o.client_id = c.client_id
    LEFT JOIN stock_issues si ON si.order_id = o.order_id
    GROUP BY c.client_id, c.client_name
    ORDER BY issue_percentage DESC;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_stock_and_order_total()
RETURNS TRIGGER AS $$
BEGIN
    -- Reducir el stock del producto
    UPDATE product
    SET stock = stock - NEW.amount
    WHERE product_id = NEW.product_id;

    -- Verificar que el stock no sea negativo
    IF (SELECT stock FROM product WHERE product_id = NEW.product_id) < 0 THEN
        RAISE EXCEPTION 'No hay suficiente stock para el producto con ID %', NEW.product_id;
    END IF;

    -- Actualizar el total de la orden
    UPDATE order_info
    SET total = total + (NEW.amount * NEW.unit_price)
    WHERE order_id = NEW.order_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger que llama a la función después de insertar en order_detail
CREATE TRIGGER update_stock_and_total_trigger AFTER
INSERT
    ON order_detail FOR EACH ROW
EXECUTE FUNCTION update_stock_and_order_total ();


-- procedimiento almacenado que devuelve todos los almacenes de una región
CREATE OR REPLACE FUNCTION get_warehouses_in_region(region_name VARCHAR(60))
RETURNS TABLE (
    warehouse_id INT,
    geom GEOMETRY,
    latitude DECIMAL(9,6) ,
    longitude DECIMAL(9,6)
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        w.warehouse_id,
        w.geom,
        w.latitude,
        w.longitude
    FROM
        warehouse w
    JOIN
        regional r
    ON
        ST_Contains(r.geom, w.geom)
    WHERE
        r.region = region_name;
END;
$$ LANGUAGE plpgsql;

-- procedimiento almacenado que devuelve el almacén más cercano a un cliente
CREATE OR REPLACE FUNCTION find_nearest_warehouse(client_id_param INT)
RETURNS TABLE (
    warehouse_id INT,
    address VARCHAR,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    distance DOUBLE PRECISION
) AS $$
DECLARE
    client_comuna_gid INT;
BEGIN
    -- Paso 1: Obtener la comuna donde se encuentra el cliente
    SELECT co.gid
    INTO client_comuna_gid
    FROM comunas co, client c
    WHERE c.client_id = client_id_param
    AND ST_Contains(co.geom, c.direction_geom);

    -- Verificar si se encontró la comuna del cliente
    IF client_comuna_gid IS NULL THEN
        RAISE EXCEPTION 'El cliente no está dentro de ninguna comuna válida';
    END IF;

    -- Paso 2: Buscar el almacén más cercano dentro de la misma comuna
    RETURN QUERY
    SELECT
        w.warehouse_id,
        w.addres,
        w.latitude,
        w.longitude,
        ST_Distance(w.geom, c.direction_geom)
    FROM
        warehouse w, client c
    WHERE
        w.delivery_zone = client_comuna_gid -- Filtrar almacenes en la misma comuna
    ORDER BY
        w.geom <-> (SELECT direction_geom FROM client WHERE client_id = client_id_param) -- Ordenar por distancia
    LIMIT 1; -- Devuelve el almacén más cercano
END;
$$ LANGUAGE plpgsql;

-- Procedimiento almacenado que devuelve todos los repartidores que han entregado pedidos en una comuna
CREATE OR REPLACE FUNCTION get_delivery_persons_in_comuna(comuna_name VARCHAR(60))
    RETURNS TABLE (
        delivery_person_id INT,
        name VARCHAR,
        contact_number VARCHAR
    ) AS $$
    BEGIN
        RETURN QUERY
            SELECT 
                dp.delivery_person_id,
                dp.name,
                dp.contact_number
            FROM
                delivery_person dp
            JOIN
                delivery_points dpt ON dp.delivery_person_id = dpt.delivery_person_id
            JOIN
                comunas c ON ST_Contains(c.geom, dpt.delivery_geom)
            WHERE
                c.comuna = comuna_name;
    END;
$$ LANGUAGE plpgsql;


-- final