-- datos de prueba para warehouse
INSERT INTO warehouse (addres, latitude, longitude, geom, delivery_zone) VALUES

('Av. Providencia 1234', -33.4350, -70.6280, ST_SetSRID(ST_MakePoint(-70.6280, -33.4350), 4326), 83),
('Av. Providencia 5678', -33.4335, -70.6275, ST_SetSRID(ST_MakePoint(-70.6275, -33.4335), 4326), 83); -- Geometría en la misma zona de reparto (comuna 83 Santiago)


-- datos de prueba para client
INSERT INTO client (client_name, direction, email, client_number, client_password, direction_geom) VALUES
('Juan Pérez', 'Av. Nueva Providencia 456', 'juan.perez@example.com', '123456789', 'password123', ST_SetSRID(ST_MakePoint(-70.6263, -33.4340), 4326)),
('María López', 'Av. Las Condes 789', 'maria.lopez@example.com', '987654321', 'password456', ST_SetSRID(ST_MakePoint(-70.6000, -33.4200), 4326)),
('Carlos Díaz', 'Calle San Diego 123', 'carlos.diaz@example.com', '555123456', 'password789', ST_SetSRID(ST_MakePoint(-70.6500, -33.4500), 4326)),
('Ana Rojas', 'Av. La Florida 890', 'ana.rojas@example.com', '555789123', 'password101', ST_SetSRID(ST_MakePoint(-70.5850, -33.5400), 4326)),
('Pedro Sánchez', 'Av. Independencia 333', 'pedro.sanchez@example.com', '555321789', 'password202', ST_SetSRID(ST_MakePoint(-70.6500, -33.4000), 4326)),
('Lucía Ortega', 'Av. Macul 432', 'lucia.ortega@example.com', '555987654', 'password303', ST_SetSRID(ST_MakePoint(-70.5700, -33.4700), 4326)),
('Ricardo Fernández', 'Av. Quilicura 765', 'ricardo.fernandez@example.com', '555654321', 'password404', ST_SetSRID(ST_MakePoint(-70.7300, -33.3750), 4326)),
('Laura Salas', 'Av. Maipú 1234', 'laura.salas@example.com', '555111222', 'password505', ST_SetSRID(ST_MakePoint(-70.7650, -33.5100), 4326)),
('Sofía Castillo', 'Calle Vitacura 876', 'sofia.castillo@example.com', '555222333', 'password606', ST_SetSRID(ST_MakePoint(-70.6000, -33.3900), 4326));
