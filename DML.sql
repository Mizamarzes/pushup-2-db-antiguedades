-- Inserciones para la tabla Rol
INSERT INTO Rol (nombre) VALUES ('Administrador');
INSERT INTO Rol (nombre) VALUES ('Vendedor');
INSERT INTO Rol (nombre) VALUES ('Comprador');

-- Inserciones para la tabla Usuario
INSERT INTO Usuario (nombre) VALUES ('Juan Contreras');
INSERT INTO Usuario (nombre) VALUES ('María López');
INSERT INTO Usuario (nombre) VALUES ('Carlos Pérez');

-- Inserciones para la tabla usuario_rol
INSERT INTO usuario_rol (rol_id, usuario_id) VALUES (1, 1); -- Juan Contreras es Administrador
INSERT INTO usuario_rol (rol_id, usuario_id) VALUES (2, 2); -- María López es Vendedora
INSERT INTO usuario_rol (rol_id, usuario_id) VALUES (3, 3); -- Carlos Pérez es Comprador

-- Inserciones para la tabla categoria
INSERT INTO categoria (nombre) VALUES ('Muebles');
INSERT INTO categoria (nombre) VALUES ('Pinturas');
INSERT INTO categoria (nombre) VALUES ('Joyería');

-- Inserciones para la tabla epoca
INSERT INTO epoca (nombre) VALUES ('Siglo XIX');
INSERT INTO epoca (nombre) VALUES ('Siglo XVIII');
INSERT INTO epoca (nombre) VALUES ('Renacimiento');

-- Inserciones para la tabla estado_conservacion
INSERT INTO estado_conservacion (nombre) VALUES ('Bueno');
INSERT INTO estado_conservacion (nombre) VALUES ('Regular');
INSERT INTO estado_conservacion (nombre) VALUES ('Restaurado');

-- Inserciones para la tabla antiguedad
INSERT INTO antiguedad (nombre, descripcion, categoria_id, epoca_id, estado_conservacion_id, estado, precio) 
VALUES ('Mesa de Roble', 'Mesa antigua de roble del siglo XIX', 1, 1, 1, 'En venta', 5000);
INSERT INTO antiguedad (nombre, descripcion, categoria_id, epoca_id, estado_conservacion_id, estado, precio) 
VALUES ('Pintura de Goya', 'Pintura famosa del artista Goya', 2, 2, 3, 'En venta', 12000);
INSERT INTO antiguedad (nombre, descripcion, categoria_id, epoca_id, estado_conservacion_id, estado, precio) 
VALUES ('Anillo de Oro', 'Anillo de oro con esmeraldas', 3, 3, 2, 'En venta', 8000);

-- Inserciones para la tabla inventario
INSERT INTO inventario (antiguedad_id, cantidad, estado, ultima_actualizacion) 
VALUES (1, 5, 'En stock', '2024-09-17');
INSERT INTO inventario (antiguedad_id, cantidad, estado, ultima_actualizacion) 
VALUES (2, 2, 'En stock', '2024-09-17');
INSERT INTO inventario (antiguedad_id, cantidad, estado, ultima_actualizacion) 
VALUES (3, 1, 'En stock', '2024-09-17');

-- Inserciones para la tabla foto
INSERT INTO foto (antiguedad_id, photo_url) VALUES (1, 'https://example.com/mesa_roble.jpg');
INSERT INTO foto (antiguedad_id, photo_url) VALUES (2, 'https://example.com/pintura_goya.jpg');
INSERT INTO foto (antiguedad_id, photo_url) VALUES (3, 'https://example.com/anillo_oro.jpg');

-- Inserciones para la tabla cambio_propiedad (Juan compra a María)
INSERT INTO cambio_propiedad (antiguedad_id, nuevo_dueno_id, anterior_dueno_id, fecha) 
VALUES (1, 1, 2, '2024-09-15');
INSERT INTO cambio_propiedad (antiguedad_id, nuevo_dueno_id, anterior_dueno_id, fecha) 
VALUES (2, 3, 2, '2024-09-16');
INSERT INTO cambio_propiedad (antiguedad_id, nuevo_dueno_id, anterior_dueno_id, fecha) 
VALUES (3, 1, 3, '2024-09-16');

-- Inserciones para la tabla actividad_usuario
INSERT INTO actividad_usuario (usuario_id, tipo_actividad, antiguedad_id, fecha) 
VALUES (1, 'Compra', 1, '2024-09-15');
INSERT INTO actividad_usuario (usuario_id, tipo_actividad, antiguedad_id, fecha) 
VALUES (2, 'Venta', 1, '2024-09-15');
INSERT INTO actividad_usuario (usuario_id, tipo_actividad, antiguedad_id, fecha) 
VALUES (3, 'Compra', 2, '2024-09-16');

-- Inserciones para la tabla transaccion (Juan compra antigüedad a María)
INSERT INTO transaccion (fecha, vendedor_id, comprador_id, antiguedad_id) 
VALUES ('2024-09-15', 2, 1, 1);
INSERT INTO transaccion (fecha, vendedor_id, comprador_id, antiguedad_id) 
VALUES ('2024-09-16', 2, 3, 2);
INSERT INTO transaccion (fecha, vendedor_id, comprador_id, antiguedad_id) 
VALUES ('2024-09-16', 3, 1, 3);

-- Inserciones para la tabla precio_history
INSERT INTO precio_history (antiguedad_id, price, date) VALUES (1, 5000, '2024-09-01');
INSERT INTO precio_history (antiguedad_id, price, date) VALUES (2, 12000, '2024-09-01');
INSERT INTO precio_history (antiguedad_id, price, date) VALUES (3, 8000, '2024-09-01');

-- Inserciones para la tabla metodo_pago
INSERT INTO metodo_pago (nombre) VALUES ('Tarjeta de Crédito');
INSERT INTO metodo_pago (nombre) VALUES ('Transferencia Bancaria');
INSERT INTO metodo_pago (nombre) VALUES ('PayPal');

-- Inserciones para la tabla pago
INSERT INTO pago (transaccion_id, dinero, fecha, metodo_pago_id) 
VALUES (1, 5000, '2024-09-15', 1);
INSERT INTO pago (transaccion_id, dinero, fecha, metodo_pago_id) 
VALUES (2, 12000, '2024-09-16', 2);
INSERT INTO pago (transaccion_id, dinero, fecha, metodo_pago_id) 
VALUES (3, 8000, '2024-09-16', 3);

-- Inserciones para la tabla entregas
INSERT INTO entregas (transaccion_id, date, estado) 
VALUES (1, '2024-09-17', 'Entregado');
INSERT INTO entregas (transaccion_id, date, estado) 
VALUES (2, '2024-09-18', 'En proceso');
INSERT INTO entregas (transaccion_id, date, estado) 
VALUES (3, '2024-09-18', 'Entregado');
