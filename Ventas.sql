CREATE DATABASE AnalisisVentasETL;
GO

USE AnalisisVentasETL;
GO

CREATE TABLE dbo.paises (
    pais_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nombre_pais NVARCHAR(150) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.ciudades (
    ciudad_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nombre_ciudad NVARCHAR(150) NOT NULL,
    pais_id INT NOT NULL,
    CONSTRAINT uq_ciudad_pais UNIQUE (nombre_ciudad, pais_id),
    CONSTRAINT fk_ciudad_pais FOREIGN KEY (pais_id)
        REFERENCES dbo.paises(pais_id)
);
GO

CREATE TABLE dbo.clientes (
    cliente_id INT NOT NULL PRIMARY KEY,
    nombre NVARCHAR(100) NULL,
    apellido NVARCHAR(100) NULL,
    correo NVARCHAR(200) NULL,
    telefono NVARCHAR(80) NULL,
    ciudad_id INT NOT NULL,
    CONSTRAINT fk_cliente_ciudad FOREIGN KEY (ciudad_id)
        REFERENCES dbo.ciudades(ciudad_id)
);
GO

CREATE TABLE dbo.categorias (
    categoria_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nombre_categoria NVARCHAR(150) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.productos (
    producto_id INT NOT NULL PRIMARY KEY,
    nombre_producto NVARCHAR(200) NULL,
    categoria_id INT NOT NULL,
    precio DECIMAL(10,2) NULL,
    stock INT NULL,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (categoria_id)
        REFERENCES dbo.categorias(categoria_id)
);
GO

CREATE TABLE dbo.estados_orden (
    estado_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nombre_estado NVARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.ordenes (
    orden_id INT NOT NULL PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha_orden DATE NULL,
    estado_id INT NOT NULL,
    CONSTRAINT fk_orden_cliente FOREIGN KEY (cliente_id)
        REFERENCES dbo.clientes(cliente_id),
    CONSTRAINT fk_orden_estado FOREIGN KEY (estado_id)
        REFERENCES dbo.estados_orden(estado_id)
);
GO

CREATE TABLE dbo.detalle_ordenes (
    detalle_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    orden_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NULL,
    precio_total DECIMAL(12,2) NULL,
    CONSTRAINT fk_detalle_orden FOREIGN KEY (orden_id)
        REFERENCES dbo.ordenes(orden_id),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (producto_id)
        REFERENCES dbo.productos(producto_id)
);
GO
