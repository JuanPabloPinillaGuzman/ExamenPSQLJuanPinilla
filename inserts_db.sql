-- Inserts

INSERT INTO categorias (nombre) VALUES
('Laptops'),('Monitores'),('Mouses'),('Teclados'),('Cascos'),('Audifonos'),('Celulares'),('Cargadores'),('Televisores'),('Antenas'),('Caminadoras'),('Smartwatches'),('Lavadoras'),('Impresoras'),('Routers');

INSERT INTO clientes (nombre,correo,telefono) VALUES
('Carlos Perez','carlosperez@gmail.com','3107886699'),
('Karol Rosales','karolrosales@gmail.com','3165489699'),
('Juan Gonzales','juangonzales@gmail.com','3105435499'),
('Roger Federer','rogerfederer@gmail.com','3125486699'),
('Lionel Messi','lionelmessi@gmail.com','3185443359'),
('Cristiano Ronaldo','cristianoronaldo@gmail.com','3174324599'),
('Luka Doncic','lukadoncic@gmail.com','3210548699'),
('Kobe Brayan','kobe@gmail.com','3103532478'),
('Kylian Mbappe','mbappe@gmail.com','3788995699'),
('Rocio Cardenas','rociocardenas@gmail.com','3202554599'),
('Alexis Silvador','silvador@gmail.com','3205647849'),
('Fabian Malo','fabianmalo@gmail.com','3104564859'),
('Carlitos Russi','carlitos@gmail.com','3167487981'),
('Lamine Yamal','lamineyamal@gmail.com','3171566871'),
('Neymar Junior','neymar@gmail.com','3108974587');

INSERT INTO proveedores (nombre,correo,telefono)VALUES
('ElPanaProveedor','Elpana@gmail.com','3123246699'),
('TuPCProveedor','TuPC@gmail.com','3123200009'),
('LaVentaProveedor','LaVenta@gmail.com','3122232229'),
('ElGranDescuentoProveedor','ElGranDescuentoProveedor@gmail.com','3134875409'),
('LaEsquinaProveedor','LaEsquina@gmail.com','3204587565'),
('TauretProveedor','tauret@gmail.com','3248951548'),
('MasterProveedor','master@gmail.com','3175347889'),
('CompumaxProveedor','compumax@gmail.com','3162573756'),
('acerProveedor','acer@gmail.com','3895655123'),
('hacedProveedor','haced@gmail.com','3852656789'),
('ArturitoProveedor','arturito@gmail.com','1841988186'),
('LaNovenaProveedor','lanovena@gmail.com','1568677119'),
('LenovoProveedor','lenovo@gmail.com','4894631615'),
('AsusProveedor','asus@gmail.com','2489893864'),
('AlexitorProveedor','alexeitor@gmail.com','4127789198');

INSERT INTO productos(nombre, precio, stock, id_categorias, id_proveedores) VALUES 
('Monitor AOC 24', '800000', '20', '1', '6'),
('Teclado Logitech K120', '250000', '50', '2', '3'),
('Ratón Logitech M100', '150000', '80', '2', '3'),
('Laptop Dell Inspiron 15', '1800000', '10', '3', '5'),
('Mochila Samsonite', '450000', '30', '4', '4'),
('Auriculares Sony WH-1000XM4', '1200000', '15', '5', '2'),
('Impresora HP LaserJet Pro', '700000', '25', '6', '1'),
('Cámara Web Logitech C920', '350000', '40', '7', '3'),
('Smartphone Samsung Galaxy S21', '2500000', '12', '8', '7'),
('Silla Gamer DXRacer', '1200000', '8', '9', '4'),
('Micrófono Blue Yeti', '900000', '35', '10', '2'),
('UPS APC 600VA', '400000', '18', '11', '1'),
('Disco Duro Externo Seagate 1TB', '550000', '60', '12', '5'),
('Tablet Apple iPad Air', '1500000', '14', '13', '6'),
('Router TP-Link Archer C80', '350000', '45', '14', '7');

INSERT INTO ventas(fecha, id_clientes) VALUES 
('2025-01-05 10:56:15', 1),
('2025-01-06 11:20:30', 2),
('2025-01-07 09:45:00', 3),
('2025-01-08 14:30:10', 4),
('2025-01-09 16:15:05', 5),
('2025-01-10 13:00:25', 6),
('2025-01-11 10:10:40', 7),
('2025-01-12 12:50:55', 8),
('2025-01-13 15:25:30', 9),
('2025-01-14 08:40:50', 10),
('2025-01-15 11:30:05', 11),
('2025-01-16 17:05:15', 12),
('2025-01-17 09:00:35', 13),
('2025-01-18 16:25:45', 14),
('2025-01-19' '20:45:55', 15);

INSENT INTO registo_venta (cantidad,subtotal,id_ventas,id_productos) VALUES
('','','','','')
