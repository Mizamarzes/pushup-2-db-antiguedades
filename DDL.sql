-- #########################################################################
-- #### COMANDOS DDL CREACION DE TABLAS | Juan Diego Contreras ##############
-- #########################################################################

DROP DATABASE IF EXISTS antiguedades_db;
CREATE DATABASE antiguedades_db;
USE antiguedades_db;

-- Tabla Rol
CREATE TABLE Rol (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

-- Tabla Usuario
CREATE TABLE Usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

-- Tabla usuario_rol (Relación muchos a muchos entre Usuario y Rol)
CREATE TABLE usuario_rol (
    rol_id INT,
    usuario_id INT,
    PRIMARY KEY (rol_id, usuario_id),
    FOREIGN KEY (rol_id) REFERENCES Rol(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuario(id)
);

-- Tabla categoria
CREATE TABLE categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

-- Tabla epoca
CREATE TABLE epoca (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

-- Tabla estado_conservacion
CREATE TABLE estado_conservacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

-- Tabla antiguedad
CREATE TABLE antiguedad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    categoria_id INT,
    epoca_id INT,
    estado_conservacion_id INT,
    estado VARCHAR(50),
    precio DECIMAL(10, 2),
    FOREIGN KEY (categoria_id) REFERENCES categoria(id),
    FOREIGN KEY (epoca_id) REFERENCES epoca(id),
    FOREIGN KEY (estado_conservacion_id) REFERENCES estado_conservacion(id)
);

-- Tabla inventario
CREATE TABLE inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    antiguedad_id INT,
    cantidad INT,
    estado VARCHAR(50),
    ultima_actualizacion DATE,
    FOREIGN KEY (antiguedad_id) REFERENCES antiguedad(id)
);

-- Tabla foto
CREATE TABLE foto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    antiguedad_id INT,
    photo_url VARCHAR(255),
    FOREIGN KEY (antiguedad_id) REFERENCES antiguedad(id)
);

-- Tabla cambio_propiedad (Registro de cambios de dueño)
CREATE TABLE cambio_propiedad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    antiguedad_id INT,
    nuevo_dueno_id INT,
    anterior_dueno_id INT,
    fecha DATE,
    FOREIGN KEY (antiguedad_id) REFERENCES antiguedad(id),
    FOREIGN KEY (nuevo_dueno_id) REFERENCES Usuario(id),
    FOREIGN KEY (anterior_dueno_id) REFERENCES Usuario(id)
);

-- Tabla actividad_usuario (Historial de actividades de los usuarios)
CREATE TABLE actividad_usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    tipo_actividad VARCHAR(255),
    antiguedad_id INT,
    fecha DATE,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(id),
    FOREIGN KEY (antiguedad_id) REFERENCES antiguedad(id)
);

-- Tabla transaccion (Registro de transacciones de compra/venta)
CREATE TABLE transaccion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    vendedor_id INT,
    comprador_id INT,
    antiguedad_id INT,
    FOREIGN KEY (vendedor_id) REFERENCES Usuario(id),
    FOREIGN KEY (comprador_id) REFERENCES Usuario(id),
    FOREIGN KEY (antiguedad_id) REFERENCES antiguedad(id)
);

-- Tabla precio_history (Historial de precios de antigüedades)
CREATE TABLE precio_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    antiguedad_id INT,
    price DECIMAL(10, 2),
    date DATE,
    FOREIGN KEY (antiguedad_id) REFERENCES antiguedad(id)
);

-- Tabla metodo_pago
CREATE TABLE metodo_pago (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

-- Tabla pago (Gestión de pagos de transacciones)
CREATE TABLE pago (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transaccion_id INT,
    dinero DECIMAL(10, 2),
    fecha DATE,
    metodo_pago_id INT,
    FOREIGN KEY (transaccion_id) REFERENCES transaccion(id),
    FOREIGN KEY (metodo_pago_id) REFERENCES metodo_pago(id)
);

-- Tabla entregas (Registro de entregas)
CREATE TABLE entregas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transaccion_id INT,
    date DATE,
    estado VARCHAR(50),
    FOREIGN KEY (transaccion_id) REFERENCES transaccion(id)
);
