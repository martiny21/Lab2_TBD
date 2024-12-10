INSERT INTO warehouse (warehouse_id, geom, latitude, longitude)
VALUES 
    (1, ST_GeomFromText('POINT(-70.6506 -33.4405)', 4326), -33.4405, -70.6506), -- Santiago Centro
    (2, ST_GeomFromText('POINT(-70.6106 -33.4263)', 4326), -33.4263, -70.6106), -- Providencia
    (3, ST_GeomFromText('POINT(-70.7631 -33.5084)', 4326), -33.5084, -70.7631), -- Maipú
    (4, ST_GeomFromText('POINT(-70.5788 -33.6117)', 4326), -33.6117, -70.5788), -- Puente Alto
    (5, ST_GeomFromText('POINT(-70.5933 -33.4565)', 4326), -33.4565, -70.5933), -- Ñuñoa
    (6, ST_GeomFromText('POINT(-71.0000 -33.0000)', 4326), -33.0000, -71.0000); -- Fuera del polígono

