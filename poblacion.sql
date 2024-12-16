-- Actualizar usuario administrador
INSERT INTO client (client_id, client_name, direction, email, client_number, client_password, direction_geom, is_admin) VALUES
(1, 'admin', 'admin', 'admin@gmail.com', '+56912345678', '$2a$10$ttamfhlAvqrzcdztH4iEIezjv9AdnP34bBniL36WvgooPxnsymC3G', ST_SetSRID(ST_MakePoint(-70.6263, -33.4340), 4326), true),
(2,'Juan Pérez', 'Av. Nueva Providencia 456', 'juan.perez@example.com', '123456789', '$2a$10$ttamfhlAvqrzcdztH4iEIezjv9AdnP34bBniL36WvgooPxnsymC3G', ST_SetSRID(ST_MakePoint(-70.6263, -33.4340), 4326),false), -- Comuna santiago
(3,'María López', 'Av. Las Condes 789', 'maria.lopez@example.com', '987654321', '$2a$10$ttamfhlAvqrzcdztH4iEIezjv9AdnP34bBniL36WvgooPxnsymC3G', ST_SetSRID(ST_MakePoint(-70.6000, -33.4200), 4326),false),
(4,'Carlos Díaz', 'Calle San Diego 123', 'carlos.diaz@example.com', '555123456', '$2a$10$ttamfhlAvqrzcdztH4iEIezjv9AdnP34bBniL36WvgooPxnsymC3G', ST_SetSRID(ST_MakePoint(-70.6500, -33.4500), 4326),false),
(5,'Ana Rojas', 'Av. La Florida 890', 'ana.rojas@example.com', '555789123', '$2a$10$ttamfhlAvqrzcdztH4iEIezjv9AdnP34bBniL36WvgooPxnsymC3G', ST_SetSRID(ST_MakePoint(-70.5850, -33.5400), 4326),false),
(6,'Pedro Sánchez', 'Av. Independencia 333', 'pedro.sanchez@example.com', '555321789', 'password202', ST_SetSRID(ST_MakePoint(-70.6500, -33.4000), 4326),false);
-- Insertar categorías
INSERT INTO
    category (category_id, category_name)
VALUES (1,'Electrónica'),
    (2,'Hogar'),
    (3,'Deportes'),
    (4,'Juguetes'),
    (5,'Libros');

INSERT INTO warehouse (warehouse_id, addres, latitude, longitude, geom, delivery_zone)
VALUES 
(1, 'Av. Apoquindo 5678', -33.418500, -70.597500, ST_SetSRID(ST_MakePoint(-70.597500, -33.418500), 4326), 121),
(2, 'Calle Moneda 3456', -33.448900, -70.666700, ST_SetSRID(ST_MakePoint(-70.666700, -33.448900), 4326), 130),
(3, 'Calle San Diego 7890', -33.455000, -70.648000, ST_SetSRID(ST_MakePoint(-70.648000, -33.455000), 4326), 305),
(4, 'Av. La Florida 123', -33.550000, -70.610000, ST_SetSRID(ST_MakePoint(-70.610000, -33.550000), 4326), 323),
(5, 'Av. Independencia 456', -33.399800, -70.658000, ST_SetSRID(ST_MakePoint(-70.658000, -33.399800), 4326), 186),
(6, 'Calle Macul 789', -33.475000, -70.568000, ST_SetSRID(ST_MakePoint(-70.568000, -33.475000), 4326), 326),
(7, 'Av. Quilicura 321', -33.370000, -70.734000, ST_SetSRID(ST_MakePoint(-70.734000, -33.370000), 4326), 48),
(8, 'Av. Maipú 654', -33.507000, -70.675000, ST_SetSRID(ST_MakePoint(-70.675000, -33.507000), 4326), 128),
(9, 'Calle Vitacura 987', -33.390000, -70.580000, ST_SetSRID(ST_MakePoint(-70.580000, -33.390000), 4326), 129),
(10, 'Av. Providencia 1234', -33.435000, -70.620000, ST_SetSRID(ST_MakePoint(-70.620000, -33.435000), 4326), 123),
(11, 'Av. Providencia 5678', -33.433500, -70.627500, ST_SetSRID(ST_MakePoint(-70.627500, -33.433500), 4326), 83);


insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Yezz Classic C21A', 'Yezz Classic C21A', 722033, 6, 'disponible', 3, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Energizer Energy 100', 'Energizer Energy 100', 675119, 5, 'disponible', 2, 9);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('LG Optimus Mach LU3000', 'LG Optimus Mach LU3000', 628552, 9, 'disponible', 2, 4);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('ZTE PF 100', 'ZTE PF 100', 751952, 13, 'disponible', 4, 10);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('LG Optimus S', 'LG Optimus S', 740766, 12, 'disponible', 1, 10);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Nokia Asha 306', 'Nokia Asha 306', 864908, 9, 'disponible', 1, 9);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('LG G Pad 10.1 LTE', 'LG G Pad 10.1 LTE', 733876, 3, 'disponible', 4, 11);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('verykool R16', 'verykool R16', 565865, 15, 'disponible', 3, 6);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Microsoft Lumia 540 Dual SIM', 'Microsoft Lumia 540 Dual SIM', 411843, 2, 'disponible', 4, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('BLU G50', 'BLU G50', 704193, 15, 'disponible', 5, 1);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('alcatel OT-997D', 'alcatel OT-997D', 22491, 0, 'agotado', 4, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('vivo Y15 (2013)', 'vivo Y15 (2013)', 865727, 17, 'disponible', 4, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Asus Transformer Book Trio', 'Asus Transformer Book Trio', 213594, 18, 'disponible', 1, 5);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('BLU J6', 'BLU J6', 761756, 2, 'disponible', 1, 10);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('alcatel OT-S850', 'alcatel OT-S850', 530760, 20, 'disponible', 2, 11);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Micromax A109 Canvas XL2', 'Micromax A109 Canvas XL2', 449909, 14, 'disponible', 2, 6);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Nokia 106 (2018)', 'Nokia 106 (2018)', 417129, 11, 'disponible', 2, 9);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Archos 50 Saphir', 'Archos 50 Saphir', 672744, 3, 'disponible', 2, 10);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Nokia 6', 'Nokia 6', 110943, 14, 'disponible', 4, 11);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Tecno Spark Go', 'Tecno Spark Go', 351174, 3, 'disponible', 2, 8);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Philips E210', 'Philips E210', 476068, 4, 'disponible', 3, 6);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Toshiba 904T', 'Toshiba 904T', 825670, 4, 'disponible', 2, 9);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Motorola W220', 'Motorola W220', 400295, 20, 'disponible', 2, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('BenQ-Siemens E52', 'BenQ-Siemens E52', 285714, 12, 'disponible', 4, 9);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Tecno Pop 2 Plus', 'Tecno Pop 2 Plus', 129504, 16, 'disponible', 4, 4);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Vertu Ascent Ti Damascus Steel', 'Vertu Ascent Ti Damascus Steel', 540730, 4, 'disponible', 3, 3);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Vodafone Smart ultra 7', 'Vodafone Smart ultra 7', 617419, 9, 'disponible', 4, 9);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('alcatel Pixi 3 (4)', 'alcatel Pixi 3 (4)', 77131, 19, 'disponible', 1, 4);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Nokia 6260', 'Nokia 6260', 703296, 7, 'disponible', 4, 6);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('alcatel Pop Star', 'alcatel Pop Star', 57261, 11, 'disponible', 2, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Lava Z91', 'Lava Z91', 846275, 18, 'disponible', 5, 1);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Kyocera Torque E6710', 'Kyocera Torque E6710', 128040, 11, 'disponible', 4, 5);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Meizu 16X', 'Meizu 16X', 746752, 11, 'disponible', 3, 10);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Allview P6 Quad Plus', 'Allview P6 Quad Plus', 793562, 6, 'disponible', 1, 9);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Gionee S6s', 'Gionee S6s', 704092, 9, 'disponible', 3, 6);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Yezz Bono 3G YZ700', 'Yezz Bono 3G YZ700', 276776, 10, 'disponible', 1, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('verykool s5702 Royale Quattro', 'verykool s5702 Royale Quattro', 337002, 8, 'disponible', 1, 7);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('BLU Brooklyn', 'BLU Brooklyn', 735273, 3, 'disponible', 1, 9);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Celkon CT 2', 'Celkon CT 2', 726204, 2, 'disponible', 3, 7);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Honor 20i', 'Honor 20i', 752408, 7, 'disponible', 1, 3);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Icemobile G8', 'Icemobile G8', 725091, 0, 'agotado', 1, 10);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('VK Mobile VK900', 'VK Mobile VK900', 222073, 16, 'disponible', 2, 4);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Lava Iris Pro 30', 'Lava Iris Pro 30', 816401, 12, 'disponible', 2, 6);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Celkon A69', 'Celkon A69', 110651, 8, 'disponible', 3, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Yezz Andy 5EI', 'Yezz Andy 5EI', 539734, 4, 'disponible', 4, 5);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('HTC Wildfire S', 'HTC Wildfire S', 883332, 18, 'disponible', 1, 4);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Meizu M5s', 'Meizu M5s', 491182, 11, 'disponible', 4, 1);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung X550', 'Samsung X550', 769340, 14, 'disponible', 4, 3);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('alcatel OT-E265', 'alcatel OT-E265', 582071, 6, 'disponible', 5, 1);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('QMobile Noir Z3', 'QMobile Noir Z3', 304943, 17, 'disponible', 4, 3);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung E2120', 'Samsung E2120', 434195, 11, 'disponible', 2, 11);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Acer DX650', 'Acer DX650', 227544, 20, 'disponible', 3, 10);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Asus Memo Pad ME172V', 'Asus Memo Pad ME172V', 777172, 11, 'disponible', 5, 1);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung T139', 'Samsung T139', 42546, 11, 'disponible', 3, 11);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Micromax Ninja A91', 'Micromax Ninja A91', 162381, 4, 'disponible', 1, 3);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Lenovo Golden Warrior S8', 'Lenovo Golden Warrior S8', 258241, 6, 'disponible', 5, 11);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung U750 Zeal', 'Samsung U750 Zeal', 200552, 15, 'disponible', 3, 8);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Honor Play 3', 'Honor Play 3', 306871, 18, 'disponible', 3, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Xiaomi Poco X2', 'Xiaomi Poco X2', 136670, 0, 'agotado', 1, 10);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Tecno Pop 2 Plus', 'Tecno Pop 2 Plus', 20907, 17, 'disponible', 3, 10);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Sony Xperia Z4 Tablet LTE', 'Sony Xperia Z4 Tablet LTE', 333607, 6, 'disponible', 2, 6);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('XOLO Q1010i', 'XOLO Q1010i', 110928, 0, 'agotado', 5, 4);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Philips W715', 'Philips W715', 43689, 20, 'disponible', 1, 3);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Vodafone 845', 'Vodafone 845', 109807, 20, 'disponible', 3, 10);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Philips 392', 'Philips 392', 347714, 20, 'disponible', 4, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Sony Xperia C670X', 'Sony Xperia C670X', 82061, 12, 'disponible', 4, 5);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('BLU Life Pure', 'BLU Life Pure', 443105, 4, 'disponible', 1, 8);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung Comment 2 R390C', 'Samsung Comment 2 R390C', 563750, 2, 'disponible', 1, 5);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung Impact sf', 'Samsung Impact sf', 663754, 17, 'disponible', 2, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Asus Pegasus', 'Asus Pegasus', 506172, 1, 'disponible', 2, 9);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Sagem MC 3000', 'Sagem MC 3000', 530933, 12, 'disponible', 3, 3);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('LG G Pad 5 10.1', 'LG G Pad 5 10.1', 802757, 11, 'disponible', 1, 6);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('ZTE Grand S Pro', 'ZTE Grand S Pro', 616958, 0, 'agotado', 5, 8);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('ZTE Maven 2', 'ZTE Maven 2', 876127, 9, 'disponible', 2, 4);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('alcatel 1s', 'alcatel 1s', 193986, 17, 'disponible', 2, 9);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Prestigio MultiPad 4 Ultimate 8.0 3G', 'Prestigio MultiPad 4 Ultimate 8.0 3G', 481048, 15, 'disponible', 1, 4);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Acer Iconia B1-721', 'Acer Iconia B1-721', 670844, 8, 'disponible', 2, 7);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Emporia RL1', 'Emporia RL1', 383612, 13, 'disponible', 4, 3);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung L770', 'Samsung L770', 785993, 4, 'disponible', 1, 9);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Nokia N93', 'Nokia N93', 388277, 19, 'disponible', 1, 7);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('ZTE Blade V7 Max', 'ZTE Blade V7 Max', 593466, 14, 'disponible', 1, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('QMobile Noir X800', 'QMobile Noir X800', 98151, 2, 'disponible', 2, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung Galaxy Tab A 8.0 (2017)', 'Samsung Galaxy Tab A 8.0 (2017)', 435575, 15, 'disponible', 3, 4);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung B7620 Giorgio Armani', 'Samsung B7620 Giorgio Armani', 207224, 10, 'disponible', 2, 3);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Huawei Impulse 4G', 'Huawei Impulse 4G', 532675, 12, 'disponible', 1, 7);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung F480i', 'Samsung F480i', 242454, 0, 'agotado', 1, 4);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Qtek 8100', 'Qtek 8100', 529414, 8, 'disponible', 5, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Nokia N-Gage', 'Nokia N-Gage', 265838, 19, 'disponible', 4, 1);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Posh Revel Pro X510', 'Posh Revel Pro X510', 170795, 14, 'disponible', 4, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('i-mate SPJAS', 'i-mate SPJAS', 385882, 15, 'disponible', 3, 6);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('LG CU915 Vu', 'LG CU915 Vu', 218405, 20, 'disponible', 3, 11);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Nokia C6', 'Nokia C6', 626151, 13, 'disponible', 5, 4);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung A827 Access', 'Samsung A827 Access', 347266, 8, 'disponible', 5, 6);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('alcatel OT-C507', 'alcatel OT-C507', 501729, 9, 'disponible', 2, 3);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Motorola XT810', 'Motorola XT810', 402206, 17, 'disponible', 4, 3);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung F210', 'Samsung F210', 361180, 3, 'disponible', 1, 6);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Yezz Zenior YZ888', 'Yezz Zenior YZ888', 430579, 7, 'disponible', 4, 5);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Siemens Xelibri 8', 'Siemens Xelibri 8', 72410, 13, 'disponible', 1, 2);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Samsung Galaxy M01', 'Samsung Galaxy M01', 272280, 10, 'disponible', 2, 3);
insert into product (product_name, product_desc, price, stock, state, category_id, warehouse_id) values ('Icemobile Apollo 3G', 'Icemobile Apollo 3G', 229956, 12, 'disponible', 2, 9);

insert into order_info(order_id,state, order_date, client_id, total) 
values 
(1,'enviada', '2020-10-01', 2, 1000), 
(2,'enviada', '2020-10-02', 2, 2000), 
(3,'enviada', '2020-10-03', 5, 3000), 
(4,'enviada', '2020-10-04', 5, 4000), 
(5,'enviada', '2020-10-05', 5, 5000);

INSERT INTO delivery_person (delivery_person_id,name, contact_number) VALUES (1,'Juan Pérez', '+56 9 8765 4321'); 
INSERT INTO delivery_person (delivery_person_id,name, contact_number) VALUES (2,'María González', '+56 9 9876 5432'); 
INSERT INTO delivery_person (delivery_person_id,name, contact_number) VALUES (3,'Carlos Rodríguez', '+56 9 8765 1234'); 
INSERT INTO delivery_person (delivery_person_id,name, contact_number) VALUES (4,'Ana López', '+56 9 9876 2345'); 
INSERT INTO delivery_person (delivery_person_id,name, contact_number) VALUES (5,'Pedro Martínez', '+56 9 8765 3456'); 


insert into delivery_points(delivery_id, delivery_person_id, order_id, delivery_geom, delivery_date)
values
(1, 1, 1, ST_SetSRID(ST_MakePoint(-70.6263, -33.4340), 4326), '2020-10-01'),
(2, 2, 2, ST_SetSRID(ST_MakePoint(-70.6263, -33.4340), 4326), '2020-10-02'),
(3, 3, 3, ST_SetSRID(ST_MakePoint(-70.5850, -33.5400), 4326), '2020-10-03'),
(4, 4, 4, ST_SetSRID(ST_MakePoint(-70.5850, -33.5400), 4326), '2020-10-04'),
(5, 5, 5, ST_SetSRID(ST_MakePoint(-70.5850, -33.5400), 4326), '2020-10-05');


