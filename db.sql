--Tablas

CREATE DATABASE tech_zone;
\c tech_zone

CREATE TABLE proveedores(
    id_proveedores SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    telefono VARCHAR(50)
);

CREATE TABLE categorias(
    id_categorias SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);


CREATE TABLE productos(
    id_productos SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio NUMERIC(10,2) NOT NULL CHECK(precio>=0),
    stock INTEGER NOT NULL CHECK(stock>=0),
    id_proveedores INTEGER NOT NULL,
    id_categorias INTEGER NOT NULL,
    FOREIGN KEY (id_categorias) REFERENCES categorias(id_categorias),
    FOREIGN KEY (id_proveedores) REFERENCES proveedores(id_proveedores)
);

CREATE TABLE clientes(
    id_clientes SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    telefono VARCHAR(50) NOT NULL
);

CREATE TABLE ventas(
    id_ventas SERIAL PRIMARY KEY,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_clientes INTEGER NOT NULL,
    FOREIGN KEY (id_clientes) REFERENCES clientes(id_clientes)
);

CREATE TABLE registro_venta (
    id_registo SERIAL PRIMARY KEY,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    subtotal NUMERIC(10,2) NOT NULL CHECK (subtotal > 0),
    id_ventas INTEGER NOT NULL,
    id_productos INTEGER NOT NULL,
    FOREIGN KEY (id_ventas) REFERENCES ventas(id_ventas),
    FOREIGN KEY (id_productos) REFERENCES productos(id_productos)
);
