CREATE DATABASE AnalisisVentasETL;
GO

USE AnalisisVentasETL;
GO

CREATE TABLE dbo.DIM_TIEMPO (
    tiempo_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    fecha DATE NOT NULL UNIQUE,
    anio SMALLINT NOT NULL,
    trimestre TINYINT NOT NULL,
    mes TINYINT NOT NULL,
    nombre_mes NVARCHAR(20) NOT NULL,
    dia TINYINT NOT NULL,
    dia_semana TINYINT NOT NULL,
    nombre_dia NVARCHAR(20) NOT NULL
);
GO

CREATE TABLE dbo.DIM_CLIENTE (
    cliente_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    cliente_id_natural INT NOT NULL UNIQUE,
    nombre NVARCHAR(100) NULL,
    apellido NVARCHAR(100) NULL,
    correo NVARCHAR(200) NULL,
    telefono NVARCHAR(80) NULL,
    ciudad NVARCHAR(150) NULL,
    pais NVARCHAR(150) NULL
);
GO

CREATE TABLE dbo.DIM_PRODUCTO (
    producto_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    producto_id_natural INT NOT NULL UNIQUE,
    nombre_producto NVARCHAR(200) NULL,
    categoria NVARCHAR(150) NULL,
    precio_lista DECIMAL(10,2) NULL
);
GO

CREATE TABLE dbo.DIM_ESTADO_ORDEN (
    estado_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    estado_id_natural INT NOT NULL UNIQUE,
    nombre_estado NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE dbo.FACT_VENTAS (
    venta_key BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    tiempo_key INT NOT NULL,
    cliente_key INT NOT NULL,
    producto_key INT NOT NULL,
    estado_key INT NOT NULL,
    orden_id_natural INT NOT NULL,
    cantidad INT NOT NULL,
    ingreso_total DECIMAL(12,2) NOT NULL,
    precio_unitario DECIMAL(10,2) NULL,

    CONSTRAINT fk_FACT_VENTAS_DIM_TIEMPO FOREIGN KEY (tiempo_key)
        REFERENCES dbo.DIM_TIEMPO(tiempo_key),

    CONSTRAINT fk_FACT_VENTAS_DIM_CLIENTE FOREIGN KEY (cliente_key)
        REFERENCES dbo.DIM_CLIENTE(cliente_key),

    CONSTRAINT fk_FACT_VENTAS_DIM_PRODUCTO FOREIGN KEY (producto_key)
        REFERENCES dbo.DIM_PRODUCTO(producto_key),

    CONSTRAINT fk_FACT_VENTAS_DIM_ESTADO_ORDEN FOREIGN KEY (estado_key)
        REFERENCES dbo.DIM_ESTADO_ORDEN(estado_key)
);
GO