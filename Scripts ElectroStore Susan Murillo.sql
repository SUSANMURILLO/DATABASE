DROP DATABASE IF EXISTS ElectroStoreSusanMurillo;
CREATE DATABASE ElectroStoreSusanMurillo;
GO

USE ElectroStoreSusanMurillo;
GO

-- =========================
-- Tabla Cargo
-- =========================
CREATE TABLE Cargo (
    CodigoCargo INT IDENTITY(1,1) PRIMARY KEY,
    NombreCargo VARCHAR(45) NOT NULL
);

-- =========================
-- Tabla Categoria
-- =========================
CREATE TABLE Categoria (
    CodigoCategoria INT IDENTITY(1,1) PRIMARY KEY,
    NombreCategoria VARCHAR(45) NOT NULL
);

-- =========================
-- Tabla Marca
-- =========================
CREATE TABLE Marca (
    CodigoMarca INT IDENTITY(1,1) PRIMARY KEY,
    NombreMarca VARCHAR(45) NOT NULL
);

-- =========================
-- Tabla Persona
-- =========================
CREATE TABLE Persona (
    IdPersona INT IDENTITY(1,1) PRIMARY KEY,
    Identificacion VARCHAR(45) NOT NULL,
    Nombre VARCHAR(45) NOT NULL,
    Apellidos VARCHAR(45) NOT NULL,
    Telefono VARCHAR(10),
    Correo VARCHAR(45),
    Direccion VARCHAR(100)
);

-- =========================
-- Tabla Sucursal
-- =========================
CREATE TABLE Sucursal (
    CodigoSucursal INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Telefono VARCHAR(10),
    Correo VARCHAR(45),
    Direccion VARCHAR(100)
);

-- =========================
-- Tabla Cliente
-- =========================
CREATE TABLE Cliente (
    IdCliente INT IDENTITY(1,1) PRIMARY KEY,
    IdPersona INT NOT NULL,
    FOREIGN KEY (IdPersona) REFERENCES Persona(IdPersona)
);

-- =========================
-- Tabla Empleado
-- =========================
CREATE TABLE Empleado (
    CodigoEmpleado INT IDENTITY(1,1) PRIMARY KEY,
    FechaContratacion DATE NOT NULL,
    CodigoSucursal INT NOT NULL,
    CodigoCargo INT NOT NULL,
    IdPersona INT NOT NULL,

    FOREIGN KEY (CodigoSucursal) REFERENCES Sucursal(CodigoSucursal),
    FOREIGN KEY (CodigoCargo) REFERENCES Cargo(CodigoCargo),
    FOREIGN KEY (IdPersona) REFERENCES Persona(IdPersona)
);

-- =========================
-- Tabla Producto
-- =========================
CREATE TABLE Producto (
    CodigoProducto INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(45) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Cantidad INT NOT NULL,
    CodigoMarca INT NOT NULL,
    CodigoCategoria INT NOT NULL,
    CodigoSucursal INT NOT NULL,

    FOREIGN KEY (CodigoMarca) REFERENCES Marca(CodigoMarca),
    FOREIGN KEY (CodigoCategoria) REFERENCES Categoria(CodigoCategoria),
    FOREIGN KEY (CodigoSucursal) REFERENCES Sucursal(CodigoSucursal)
);

-- =========================
-- Factura Encabezado
-- =========================
CREATE TABLE FacturaEncabezado (
    NumeroFactura INT IDENTITY(1,1) PRIMARY KEY,
    FechaEmision DATE NOT NULL,
    IdCliente INT NOT NULL,
    CodigoEmpleado INT NOT NULL,
    CodigoSucursal INT NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    FechaEntrega DATE,
    Estado BIT NOT NULL,

    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente),
    FOREIGN KEY (CodigoEmpleado) REFERENCES Empleado(CodigoEmpleado),
    FOREIGN KEY (CodigoSucursal) REFERENCES Sucursal(CodigoSucursal)
);

-- =========================
-- Factura Detalle
-- =========================
CREATE TABLE FacturaDetalle (
    NumeroItem INT IDENTITY(1,1) PRIMARY KEY,
    NumeroFactura INT NOT NULL,
    CodigoProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Descuento DECIMAL(10,2),

    FOREIGN KEY (NumeroFactura) REFERENCES FacturaEncabezado(NumeroFactura),
    FOREIGN KEY (CodigoProducto) REFERENCES Producto(CodigoProducto)
);