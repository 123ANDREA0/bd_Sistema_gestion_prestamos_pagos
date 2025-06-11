--- Creacion de la base de datos---

CREATE DATABASE bd_Sistema_gestion_prestamos_pagos;
GO

--- Seleccionar de base de datos---

USE bd_Sistema_gestion_prestamos_pagos;
GO

---Creacion de tablas--

-- TABLA SUCURSALES
CREATE TABLE sucursales (
    id INT IDENTITY (1,1) PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(155) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NULL,
    estado VARCHAR(50) NOT NULL,
    telefono VARCHAR(25) NULL
);

-- TABLA RESPONSABLES
CREATE TABLE responsables (
    id INT IDENTITY (1,1) PRIMARY KEY,
    nombre VARCHAR(300) NOT NULL,
    cod_empleado VARCHAR(20) UNIQUE NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    correo VARCHAR(200) NULL
);

-- TABLA CLIENTES
CREATE TABLE clientes (
    id INT IDENTITY (1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    numero_idc VARCHAR(30) UNIQUE NOT NULL,
    tipo_de_idc VARCHAR(50) NOT NULL,
    tipo_de_cliente VARCHAR(10) NOT NULL,
    direccion VARCHAR(255) NULL,
    email VARCHAR(255) NULL,
    telefono VARCHAR(25) NULL
);

-- TABLA TIPO DE PRESTAMOS
CREATE TABLE tipo_de_prestamos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL
);

-- TABLA PRESTAMOS
CREATE TABLE prestamos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cliente_id INT NOT NULL,
    responsable_id INT NOT NULL,
    sucursal_id INT NOT NULL,
    tipo_de_prestamo_id INT NOT NULL,
    tasa_interes DECIMAL(5,2) NOT NULL,
    monto_prestamo DECIMAL(10,2) NOT NULL,
    plazo INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    estado VARCHAR(15) NOT NULL CHECK (estado IN ('activo', 'pagado', 'moroso')),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (responsable_id) REFERENCES responsables(id),
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(id),
    FOREIGN KEY (tipo_de_prestamo_id) REFERENCES tipo_de_prestamos(id)
);

-- TABLA CUOTAS
CREATE TABLE cuotas (
    id INT IDENTITY(1,1) PRIMARY KEY,
    prestamo_id INT NOT NULL,
    numero_cuota INT NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    monto_cuota DECIMAL(10,2) NOT NULL,
    estado_pago VARCHAR(50) NOT NULL CHECK (estado_pago IN ('pendiente', 'pagada', 'vencida')),
    FOREIGN KEY (prestamo_id) REFERENCES prestamos(id)
);

-- TABLA PAGOS
CREATE TABLE pagos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cuota_id INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto_pagado DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(20) NOT NULL CHECK (metodo_pago IN ('efectivo', 'transferencia', 'tarjeta')),
    FOREIGN KEY (cuota_id) REFERENCES cuotas(id)
);

-- TABLA DETALLE PAGOS (opcional, útil para pagos distribuidos)
CREATE TABLE detalle_pagos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cuota_id INT NOT NULL,
    pago_id INT NOT NULL,
    monto_afectado DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cuota_id) REFERENCES cuotas(id),
    FOREIGN KEY (pago_id) REFERENCES pagos(id)
);

USE bd_Sistema_gestion_prestamos_pagos;
GO

---INSERCION DE DATOS---

SELECT*FROM sucursales;

INSERT INTO sucursales (codigo, nombre, ciudad, region, direccion, estado, telefono) 
VALUES 
('SUC001', 'Sucursal Salamanca', 'Baleares', 'Sevilla', 'Vial Paca Marí 1 Puerta 2 Valencia, 23464', 'activo', '+34 743565422'),
('SUC002', 'Sucursal Palencia', 'Salamanca', 'Córdoba', 'Paseo Rodrigo Acuña 79 Puerta 6 Lleida, 98592', 'activo', '+34 673 158 138'),
('SUC003', 'Sucursal Madrid', 'Tarragona', 'Alicante', 'C. de Victor Jover 84 Sevilla, 45062', 'activo', '+34 705 033 493'),
('SUC004', 'Sucursal Ourense', 'Lugo', 'Málaga', 'Vial Sonia Pozuelo 52 Ourense, 88752', 'activo', '+34864 37 41 28'),
('SUC005', 'Sucursal Salamanca', 'Baleares', 'Granada', 'Vial de Amparo Naranjo 55 Jaén, 99156', 'activo', '+34720 624 745'),
('SUC006', 'Sucursal Cantabria', 'Huelva', 'Baleares', 'Pasadizo de María Del Carmen Pozuelo 2 Piso 4 Ciudad, 49172', 'activo', '+34735 11 80 60'),
('SUC007', 'Sucursal Badajoz', 'Murcia', 'Murcia', 'Cuesta de Onofre Gomez 6 Ávila, 45411', 'activo', '+34 716 48 82 14'),
('SUC008', 'Sucursal Ourense', 'Murcia', 'Lugo', 'Urbanización Socorro Sánchez 81 Puerta 5 Las Palmas, 28632', 'activo', '+34623 26 31 77'),
('SUC009', 'Sucursal Zaragoza', 'Salamanca', 'Teruel', 'Cuesta Estela Torres 7 Puerta 2 Madrid, 01605', 'activo', '+34 731 37 98 74'),
('SUC010', 'Sucursal Las Palmas', 'Melilla', 'Málaga', 'Pasadizo Carmelita Clemente 50 Apt. 68 Vizcaya, 51575', 'activo', '+34 700 224 154'),
('SUC011', 'Sucursal Córdoba', 'Guipúzcoa', 'Ourense', 'C. de Ovidio Quintero 25 Apt. 34 Melilla, 70515', 'activo', '+34 623 44 71 30'),
('SUC012', 'Sucursal Ciudad', 'Albacete', 'Murcia', 'Plaza Piedad Riera 438 Piso 3 Ávila, 66573', 'activo', '+34703 77 01 64'),
('SUC013', 'Sucursal Lugo', 'Burgos', 'Zamora', 'Plaza Alba Murillo 51 Apt. 89 Valencia, 03466', 'activo', '+34 659 866 520'),
('SUC014', 'Sucursal Salamanca', 'Melilla', 'Toledo', 'Acceso de Marcela Galán 71 Apt. 28 Zaragoza, 21345', 'activo', '+34714190539'),
('SUC015', 'Sucursal Santa Cruz de Tenerife', 'Huesca', 'La Rioja', 'Plaza Lupe Luján 9 Piso 8 Barcelona, 68842', 'activo', '+34 818 51 40 44');
GO

SELECT*FROM responsables;

INSERT INTO responsables (nombre, cod_empleado, cargo, correo) 
VALUES 
('Abilio Anglada Exposito', 'EMP0001', 'Asesor', 'canetenilda@gmail.com'),
('Adela Cadenas Vélez', 'EMP0002', 'Gerente', 'aledonoso@yahoo.com'),
('Jose Luis Lucena Cózar', 'EMP0003', 'Gerente', 'calvetester@gmail.com'),
('Carmelo Omar Antón Calatayud', 'EMP0004', 'Analista', 'kpou@hotmail.com'),
('María Jesús Rico Blanca', 'EMP0005', 'Analista', 'severino13@yahoo.com'),
('Adelina Delgado Molina', 'EMP0006', 'Asesor', 'isaiassolsona@jara.org'),
('Evangelina de Acuña', 'EMP0007', 'Asesor', 'sfuertes@talavera-marco.es'),
('Gema Vall Sastre', 'EMP0008', 'Gerente', 'enriquezencarnacion@hotmail.com'),
('Apolonia del Montserrat', 'EMP0009', 'Gerente', 'juanito63@hotmail.com'),
('Rita Español Alemán', 'EMP0010', 'Analista', 'manola66@villegas.net'),
('Jafet Barrena Castilla', 'EMP0011', 'Asesor', 'guzmanaitor@hotmail.com'),
('Emigdio Velasco Martí', 'EMP0012', 'Asesor', 'bchamorro@gmail.com'),
('Obdulia Nieto Marqués', 'EMP0013', 'Analista', 'ingrid53@pelayo-quintanilla.com'),
('Ariel Marquez Acedo', 'EMP0014', 'Gerente', 'yparejo@pedrero.es'),
('Maite Domingo Marqués', 'EMP0015', 'Analista', 'carinacatala@hotmail.com');
GO

SELECT*FROM clientes;

INSERT INTO clientes (nombre, numero_idc, tipo_de_idc, tipo_de_cliente, direccion, email, telefono) 
VALUES 
('Damián Páez Salas', 'DNI63030431', 'DNI', 'NAT', 'Rambla de Blas Miguel 92 Baleares, 96223', 'pascual06@gmail.com', '+34729 425 659'),
('Nicolás Blazquez Pelayo', 'DNI11920138', 'DNI', 'NAT', 'Pasaje Bernardo Figueras 7 Ávila, 50373', 'salomepalau@yahoo.com', '+34601209201'),
('Teodosio de Sebastián', 'DNI19796204', 'DNI', 'NAT', 'Ronda de Alejandro Riba 93 Granada, 02219', 'alberto36@jerez.es', '+34 724 608 057'),
('Lucho Corbacho Bayona', 'DNI57359138', 'DNI', 'NAT', 'Cuesta Apolinar Tur 89 Toledo, 22227', 'martin05@lobato-soler.org', '+34 899 489 601'),
('Eusebia Fabregat Lago', 'DNI95335451', 'DNI', 'JUR', 'Rambla de Joaquín Arce 31 Apt. 72 Ourense, 44509', 'nazaret14@hotmail.com', '+34701 82 33 25'),
('Fulgencio Soria', 'DNI72938098', 'DNI', 'JUR', 'Cañada de Natalia Cañizares 2 Puerta 2 Las Palmas, 65706', 'verduvinicio@yahoo.com', '+34 728627557'),
('Asdrubal Enríquez Berenguer', 'DNI12827833', 'DNI', 'NAT', 'Plaza Javi Solsona 32 León, 47627', 'aroa16@yahoo.com', '+34700527081'),
('Otilia Solís Real', 'DNI32426306', 'DNI', 'JUR', 'Callejón de Teodoro Elorza 86 Puerta 9 Valencia, 19936', 'higuerasjosep@criado-sureda.com', '+34 735 98 18 15'),
('Emiliana Rosell Caro', 'DNI10314702', 'DNI', 'JUR', 'Cuesta Lorenzo Ferrando 87 Apt. 43  Valencia, 01420', 'arocamerche@velazquez.es', '+34641772828'),
('Elvira Luisina Barberá Gascón', 'DNI68782677', 'DNI', 'NAT', 'Urbanización de Albano Huerta 81 Piso 7 Castellón, 69371', 'patriciaconesa@yahoo.com', '+34732 952 336'),
('Eloy Bustos Verdú', 'DNI91819862', 'DNI', 'JUR', 'Ronda de Néstor Revilla 484 Pontevedra, 60593', 'renato59@yahoo.com', '+34990 336 651'),
('Sarita Sacristán Verdú', 'DNI60268947', 'DNI', 'JUR', 'Acceso Agapito Bejarano 22 Apt. 71 Toledo, 05489', 'dimasrubio@corral.org', '+34710290941'),
('Lilia Pedraza Pizarro', 'DNI52700218', 'DNI', 'NAT', 'Acceso Rosario Osuna 42 Puerta 2 Almería, 87352', 'cvilaplana@hotmail.com', '+34961 89 25 54'),
('Carlota de Torrens', 'DNI70685418', 'DNI', 'JUR', 'C. Georgina Cámara 10 Puerta 9  Valencia, 83881', 'zduarte@hotmail.com', '+34741 56 36 34'),
('Ramón Nogués Carrera', 'DNI40898530', 'DNI', 'JUR', 'Rambla Ruben Cerdán 42 Ávila, 38970', 'erasmoluna@pelayo-martorell.net', '+34 884414590');
GO

SELECT*FROM tipo_de_prestamos;


INSERT INTO tipo_de_prestamos (nombre_tipo) 
VALUES 
('hipotecario'),
('vehicular'),
('educativo'),
('negocios'),
('personal');
GO

SELECT*FROM prestamos;

INSERT INTO prestamos (cliente_id, responsable_id, sucursal_id, tipo_de_prestamo_id, tasa_interes, monto_prestamo, plazo, fecha_inicio, estado) 
VALUES 
(12, 5, 12, 1, 5.0, 1000, 6, '2025-05-09', 'activo'),
(2, 8, 15, 2, 7.0, 3000, 12, '2025-06-06', 'activo'),
(13, 9, 1, 3, 4.25, 5000, 12, '2025-06-06', 'pagado'),
(7, 12, 13, 4, 7.0, 1000, 12, '2025-05-03', 'pagado'),
(13, 11, 9, 5, 5.0, 1000, 24, '2025-04-05', 'pagado'),
(4, 12, 10, 1, 7.0, 8000, 12, '2025-04-20', 'pagado'),
(4, 9, 5, 2, 6.75, 1000, 12, '2025-05-06', 'moroso'),
(15, 9, 1, 3, 7.0, 3000, 12, '2025-04-08', 'activo'),
(4, 6, 2, 4, 6.75, 3000, 6, '2025-05-07', 'pagado'),
(7, 9, 1, 5, 4.25, 8000, 24, '2025-05-01', 'pagado'),
(2, 14, 5, 1, 6.75, 1000, 24, '2025-06-07', 'moroso'),
(4, 6, 14, 2, 6.75, 8000, 24, '2025-06-01', 'activo'),
(13, 12, 10, 3, 5.0, 5000, 6, '2025-06-06', 'moroso'),
(1, 4, 14, 4, 4.25, 10000, 12, '2025-05-10', 'activo'),
(1, 2, 7, 5, 7.0, 5000, 24, '2025-04-06', 'pagado');
GO


SELECT*FROM cuotas;

INSERT INTO cuotas (prestamo_id, numero_cuota, fecha_vencimiento, monto_cuota, estado_pago) 
VALUES
(1, 1, '2025-06-08', 166.67, 'pendiente'),
(1, 2, '2025-07-08', 166.67, 'pendiente'),
(1, 3, '2025-08-07', 166.67, 'pagada'),
(1, 4, '2025-09-06', 166.67, 'vencida'),
(1, 5, '2025-10-06', 166.67, 'pagada'),
(1, 6, '2025-11-05', 166.67, 'pagada'),
(2, 1, '2025-07-06', 250.0, 'pagada'),
(2, 2, '2025-08-05', 250.0, 'vencida'),
(2, 3, '2025-09-04', 250.0, 'pagada'),
(2, 4, '2025-10-04', 250.0, 'pagada'),
(2, 5, '2025-11-03', 250.0, 'pagada'),
(2, 6, '2025-12-03', 250.0, 'pagada'),
(2, 7, '2026-01-02', 250.0, 'pagada'),
(2, 8, '2026-02-01', 250.0, 'pendiente'),
(2, 9, '2026-03-03', 250.0, 'pagada'),
(2, 10, '2026-04-02', 250.0, 'vencida'),
(2, 11, '2026-05-02', 250.0, 'vencida'),
(2, 12, '2026-06-01', 250.0, 'vencida'),
(3, 1, '2025-07-06', 416.67, 'pagada'),
(3, 2, '2025-08-05', 416.67, 'pagada'),
(3, 3, '2025-09-04', 416.67, 'pendiente'),
(3, 4, '2025-10-04', 416.67, 'vencida'),
(3, 5, '2025-11-03', 416.67, 'pagada'),
(3, 6, '2025-12-03', 416.67, 'pagada'),
(3, 7, '2026-01-02', 416.67, 'pagada'),
(3, 8, '2026-02-01', 416.67, 'pendiente'),
(3, 9, '2026-03-03', 416.67, 'pendiente'),
(3, 10, '2026-04-02', 416.67, 'pendiente'),
(3, 11, '2026-05-02', 416.67, 'pendiente'),
(3, 12, '2026-06-01', 416.67, 'pagada'),
(4, 1, '2025-06-02', 83.33, 'vencida'),
(4, 2, '2025-07-02', 83.33, 'pagada'),
(4, 3, '2025-08-01', 83.33, 'pagada'),
(4, 4, '2025-08-31', 83.33, 'pagada'),
(4, 5, '2025-09-30', 83.33, 'vencida'),
(4, 6, '2025-10-30', 83.33, 'pendiente'),
(4, 7, '2025-11-29', 83.33, 'vencida'),
(4, 8, '2025-12-29', 83.33, 'pendiente'),
(4, 9, '2026-01-28', 83.33, 'pagada'),
(4, 10, '2026-02-27', 83.33, 'pagada'),
(4, 11, '2026-03-29', 83.33, 'pagada'),
(4, 12, '2026-04-28', 83.33, 'pagada'),
(5, 1, '2025-05-05', 41.67, 'vencida'),
(5, 2, '2025-06-04', 41.67, 'pagada'),
(5, 3, '2025-07-04', 41.67, 'vencida'),
(5, 4, '2025-08-03', 41.67, 'pagada'),
(5, 5, '2025-09-02', 41.67, 'pendiente'),
(5, 6, '2025-10-02', 41.67, 'pagada'),
(5, 7, '2025-11-01', 41.67, 'pagada'),
(5, 8, '2025-12-01', 41.67, 'pagada'),
(5, 9, '2025-12-31', 41.67, 'pagada'),
(5, 10, '2026-01-30', 41.67, 'pagada'),
(5, 11, '2026-03-01', 41.67, 'pagada'),
(5, 12, '2026-03-31', 41.67, 'pendiente'),
(5, 13, '2026-04-30', 41.67, 'pagada'),
(5, 14, '2026-05-30', 41.67, 'pagada'),
(5, 15, '2026-06-29', 41.67, 'vencida'),
(5, 16, '2026-07-29', 41.67, 'pagada'),
(5, 17, '2026-08-28', 41.67, 'pagada'),
(5, 18, '2026-09-27', 41.67, 'vencida'),
(5, 19, '2026-10-27', 41.67, 'pagada'),
(5, 20, '2026-11-26', 41.67, 'pagada'),
(5, 21, '2026-12-26', 41.67, 'pendiente'),
(5, 22, '2027-01-25', 41.67, 'pagada'),
(5, 23, '2027-02-24', 41.67, 'pagada'),
(5, 24, '2027-03-26', 41.67, 'pagada'),
(6, 1, '2025-05-20', 666.67, 'pagada'),
(6, 2, '2025-06-19', 666.67, 'pagada'),
(6, 3, '2025-07-19', 666.67, 'pagada'),
(6, 4, '2025-08-18', 666.67, 'pagada'),
(6, 5, '2025-09-17', 666.67, 'pagada'),
(6, 6, '2025-10-17', 666.67, 'pagada'),
(6, 7, '2025-11-16', 666.67, 'pendiente'),
(6, 8, '2025-12-16', 666.67, 'pagada'),
(6, 9, '2026-01-15', 666.67, 'pagada'),
(6, 10, '2026-02-14', 666.67, 'pagada'),
(6, 11, '2026-03-16', 666.67, 'pendiente'),
(6, 12, '2026-04-15', 666.67, 'pendiente'),
(7, 1, '2025-06-05', 83.33, 'pagada'),
(7, 2, '2025-07-05', 83.33, 'pagada'),
(7, 3, '2025-08-04', 83.33, 'pagada'),
(7, 4, '2025-09-03', 83.33, 'pagada'),
(7, 5, '2025-10-03', 83.33, 'pagada'),
(7, 6, '2025-11-02', 83.33, 'vencida'),
(7, 7, '2025-12-02', 83.33, 'pagada'),
(7, 8, '2026-01-01', 83.33, 'pagada'),
(7, 9, '2026-01-31', 83.33, 'pagada'),
(7, 10, '2026-03-02', 83.33, 'pagada'),
(7, 11, '2026-04-01', 83.33, 'pagada'),
(7, 12, '2026-05-01', 83.33, 'pendiente'),
(8, 1, '2025-05-08', 250.0, 'vencida'),
(8, 2, '2025-06-07', 250.0, 'vencida'),
(8, 3, '2025-07-07', 250.0, 'pagada'),
(8, 4, '2025-08-06', 250.0, 'pendiente'),
(8, 5, '2025-09-05', 250.0, 'pagada'),
(8, 6, '2025-10-05', 250.0, 'vencida'),
(8, 7, '2025-11-04', 250.0, 'vencida'),
(8, 8, '2025-12-04', 250.0, 'pagada'),
(8, 9, '2026-01-03', 250.0, 'pagada'),
(8, 10, '2026-02-02', 250.0, 'pendiente'),
(8, 11, '2026-03-04', 250.0, 'vencida'),
(8, 12, '2026-04-03', 250.0, 'pagada'),
(9, 1, '2025-06-06', 500.0, 'pendiente'),
(9, 2, '2025-07-06', 500.0, 'pagada'),
(9, 3, '2025-08-05', 500.0, 'pagada'),
(9, 4, '2025-09-04', 500.0, 'pagada'),
(9, 5, '2025-10-04', 500.0, 'pagada'),
(9, 6, '2025-11-03', 500.0, 'pendiente'),
(10, 1, '2025-05-31', 333.33, 'pagada'),
(10, 2, '2025-06-30', 333.33, 'pagada'),
(10, 3, '2025-07-30', 333.33, 'vencida'),
(10, 4, '2025-08-29', 333.33, 'pagada'),
(10, 5, '2025-09-28', 333.33, 'pagada'),
(10, 6, '2025-10-28', 333.33, 'pagada'),
(10, 7, '2025-11-27', 333.33, 'pagada'),
(10, 8, '2025-12-27', 333.33, 'pagada'),
(10, 9, '2026-01-26', 333.33, 'pagada'),
(10, 10, '2026-02-25', 333.33, 'pagada'),
(10, 11, '2026-03-27', 333.33, 'pendiente'),
(10, 12, '2026-04-26', 333.33, 'pendiente'),
(10, 13, '2026-05-26', 333.33, 'pendiente'),
(10, 14, '2026-06-25', 333.33, 'pagada'),
(10, 15, '2026-07-25', 333.33, 'vencida'),
(10, 16, '2026-08-24', 333.33, 'pendiente'),
(10, 17, '2026-09-23', 333.33, 'pagada'),
(10, 18, '2026-10-23', 333.33, 'vencida'),
(10, 19, '2026-11-22', 333.33, 'pagada'),
(10, 20, '2026-12-22', 333.33, 'pagada'),
(10, 21, '2027-01-21', 333.33, 'pagada'),
(10, 22, '2027-02-20', 333.33, 'pagada'),
(10, 23, '2027-03-22', 333.33, 'pagada'),
(10, 24, '2027-04-21', 333.33, 'pagada'),
(11, 1, '2025-07-07', 41.67, 'pagada'),
(11, 2, '2025-08-06', 41.67, 'pendiente'),
(11, 3, '2025-09-05', 41.67, 'pagada'),
(11, 4, '2025-10-05', 41.67, 'pagada'),
(11, 5, '2025-11-04', 41.67, 'pagada'),
(11, 6, '2025-12-04', 41.67, 'pagada'),
(11, 7, '2026-01-03', 41.67, 'pagada'),
(11, 8, '2026-02-02', 41.67, 'pendiente'),
(11, 9, '2026-03-04', 41.67, 'pagada'),
(11, 10, '2026-04-03', 41.67, 'pagada'),
(11, 11, '2026-05-03', 41.67, 'pagada'),
(11, 12, '2026-06-02', 41.67, 'pagada'),
(11, 13, '2026-07-02', 41.67, 'pendiente'),
(11, 14, '2026-08-01', 41.67, 'pagada'),
(11, 15, '2026-08-31', 41.67, 'pagada'),
(11, 16, '2026-09-30', 41.67, 'pagada'),
(11, 17, '2026-10-30', 41.67, 'vencida'),
(11, 18, '2026-11-29', 41.67, 'pendiente'),
(11, 19, '2026-12-29', 41.67, 'pagada'),
(11, 20, '2027-01-28', 41.67, 'pagada'),
(11, 21, '2027-02-27', 41.67, 'pendiente'),
(11, 22, '2027-03-29', 41.67, 'pagada'),
(11, 23, '2027-04-28', 41.67, 'vencida'),
(11, 24, '2027-05-28', 41.67, 'vencida'),
(12, 1, '2025-07-01', 333.33, 'vencida'),
(12, 2, '2025-07-31', 333.33, 'vencida'),
(12, 3, '2025-08-30', 333.33, 'pagada'),
(12, 4, '2025-09-29', 333.33, 'pendiente'),
(12, 5, '2025-10-29', 333.33, 'pendiente'),
(12, 6, '2025-11-28', 333.33, 'pagada'),
(12, 7, '2025-12-28', 333.33, 'pendiente'),
(12, 8, '2026-01-27', 333.33, 'vencida'),
(12, 9, '2026-02-26', 333.33, 'vencida'),
(12, 10, '2026-03-28', 333.33, 'pagada'),
(12, 11, '2026-04-27', 333.33, 'pagada'),
(12, 12, '2026-05-27', 333.33, 'pagada'),
(12, 13, '2026-06-26', 333.33, 'pagada'),
(12, 14, '2026-07-26', 333.33, 'pagada'),
(12, 15, '2026-08-25', 333.33, 'vencida'),
(12, 16, '2026-09-24', 333.33, 'pendiente'),
(12, 17, '2026-10-24', 333.33, 'pagada'),
(12, 18, '2026-11-23', 333.33, 'pagada'),
(12, 19, '2026-12-23', 333.33, 'pendiente'),
(12, 20, '2027-01-22', 333.33, 'vencida'),
(12, 21, '2027-02-21', 333.33, 'pagada'),
(12, 22, '2027-03-23', 333.33, 'pagada'),
(12, 23, '2027-04-22', 333.33, 'vencida'),
(12, 24, '2027-05-22', 333.33, 'pagada'),
(13, 1, '2025-07-06', 833.33, 'vencida'),
(13, 2, '2025-08-05', 833.33, 'vencida'),
(13, 3, '2025-09-04', 833.33, 'pendiente'),
(13, 4, '2025-10-04', 833.33, 'pendiente'),
(13, 5, '2025-11-03', 833.33, 'vencida'),
(13, 6, '2025-12-03', 833.33, 'pendiente'),
(14, 1, '2025-06-09', 833.33, 'pagada'),
(14, 2, '2025-07-09', 833.33, 'pagada'),
(14, 3, '2025-08-08', 833.33, 'pendiente'),
(14, 4, '2025-09-07', 833.33, 'pagada'),
(14, 5, '2025-10-07', 833.33, 'pagada'),
(14, 6, '2025-11-06', 833.33, 'pendiente'),
(14, 7, '2025-12-06', 833.33, 'vencida'),
(14, 8, '2026-01-05', 833.33, 'pagada'),
(14, 9, '2026-02-04', 833.33, 'pagada'),
(14, 10, '2026-03-06', 833.33, 'pagada'),
(14, 11, '2026-04-05', 833.33, 'pagada'),
(14, 12, '2026-05-05', 833.33, 'pagada'),
(15, 1, '2025-05-06', 208.33, 'vencida'),
(15, 2, '2025-06-05', 208.33, 'pagada'),
(15, 3, '2025-07-05', 208.33, 'pagada'),
(15, 4, '2025-08-04', 208.33, 'pagada'),
(15, 5, '2025-09-03', 208.33, 'pendiente'),
(15, 6, '2025-10-03', 208.33, 'pagada'),
(15, 7, '2025-11-02', 208.33, 'pendiente'),
(15, 8, '2025-12-02', 208.33, 'vencida'),
(15, 9, '2026-01-01', 208.33, 'pagada'),
(15, 10, '2026-01-31', 208.33, 'pagada'),
(15, 11, '2026-03-02', 208.33, 'pagada'),
(15, 12, '2026-04-01', 208.33, 'pagada'),
(15, 13, '2026-05-01', 208.33, 'vencida'),
(15, 14, '2026-05-31', 208.33, 'pendiente'),
(15, 15, '2026-06-30', 208.33, 'pagada'),
(15, 16, '2026-07-30', 208.33, 'vencida'),
(15, 17, '2026-08-29', 208.33, 'pendiente'),
(15, 18, '2026-09-28', 208.33, 'pendiente'),
(15, 19, '2026-10-28', 208.33, 'pagada'),
(15, 20, '2026-11-27', 208.33, 'pagada'),
(15, 21, '2026-12-27', 208.33, 'pagada'),
(15, 22, '2027-01-26', 208.33, 'vencida'),
(15, 23, '2027-02-25', 208.33, 'pagada'),
(15, 24, '2027-03-27', 208.33, 'pagada');
GO

SELECT*FROM pagos;

INSERT INTO pagos (cuota_id, fecha_pago, monto_pagado, metodo_pago) 
VALUES

(3, '2025-07-31', 166.67, 'efectivo'),
(4, '2025-09-03', 83.33, 'tarjeta'),
(5, '2025-10-03', 166.67, 'transferencia'),
(6, '2025-11-03', 166.67, 'efectivo'),
(7, '2025-07-02', 250.0, 'transferencia'),
(8, '2025-08-05', 125.0, 'tarjeta'),
(9, '2025-08-30', 250.0, 'efectivo'),
(10, '2025-09-27', 250.0, 'transferencia'),
(11, '2025-10-31', 250.0, 'efectivo'),
(12, '2025-11-24', 250.0, 'transferencia'),
(13, '2025-12-29', 250.0, 'tarjeta'),
(15, '2026-02-23', 250.0, 'transferencia'),
(16, '2026-03-24', 125.0, 'tarjeta'),
(17, '2026-05-01', 125.0, 'transferencia'),
(18, '2026-05-28', 125.0, 'tarjeta'),
(19, '2025-07-01', 416.67, 'tarjeta'),
(20, '2025-08-05', 416.67, 'efectivo'),
(22, '2025-09-28', 208.34, 'tarjeta'),
(23, '2025-11-01', 416.67, 'efectivo'),
(24, '2025-11-25', 416.67, 'tarjeta'),
(25, '2025-12-25', 416.67, 'tarjeta'),
(30, '2026-05-22', 416.67, 'efectivo'),
(31, '2025-05-24', 41.66, 'efectivo'),
(32, '2025-06-22', 83.33, 'transferencia'),
(33, '2025-07-22', 83.33, 'tarjeta'),
(34, '2025-08-22', 83.33, 'efectivo'),
(35, '2025-09-23', 41.66, 'tarjeta'),
(37, '2025-11-23', 41.66, 'efectivo'),
(39, '2026-01-26', 83.33, 'efectivo'),
(40, '2026-02-27', 83.33, 'tarjeta'),
(41, '2026-03-24', 83.33, 'tarjeta'),
(42, '2026-04-24', 83.33, 'tarjeta'),
(43, '2025-04-26', 20.84, 'transferencia'),
(44, '2025-06-04', 41.67, 'efectivo'),
(45, '2025-06-24', 20.84, 'efectivo'),
(46, '2025-08-01', 41.67, 'efectivo'),
(48, '2025-09-23', 41.67, 'tarjeta'),
(49, '2025-10-30', 41.67, 'tarjeta'),
(50, '2025-11-27', 41.67, 'transferencia'),
(51, '2025-12-30', 41.67, 'transferencia'),
(52, '2026-01-21', 41.67, 'tarjeta'),
(53, '2026-02-25', 41.67, 'tarjeta'),
(55, '2026-04-21', 41.67, 'transferencia'),
(56, '2026-05-24', 41.67, 'transferencia'),
(57, '2026-06-24', 20.84, 'transferencia'),
(58, '2026-07-28', 41.67, 'tarjeta'),
(59, '2026-08-20', 41.67, 'tarjeta'),
(60, '2026-09-26', 20.84, 'transferencia'),
(61, '2026-10-27', 41.67, 'transferencia'),
(62, '2026-11-16', 41.67, 'tarjeta'),
(64, '2027-01-21', 41.67, 'transferencia'),
(65, '2027-02-22', 41.67, 'tarjeta'),
(66, '2027-03-19', 41.67, 'transferencia'),
(67, '2025-05-18', 666.67, 'tarjeta'),
(68, '2025-06-12', 666.67, 'tarjeta'),
(69, '2025-07-15', 666.67, 'efectivo'),
(70, '2025-08-13', 666.67, 'transferencia'),
(71, '2025-09-12', 666.67, 'tarjeta'),
(72, '2025-10-09', 666.67, 'efectivo'),
(74, '2025-12-06', 666.67, 'transferencia'),
(75, '2026-01-12', 666.67, 'transferencia'),
(76, '2026-02-11', 666.67, 'efectivo'),
(79, '2025-05-30', 83.33, 'transferencia'),
(80, '2025-07-01', 83.33, 'efectivo'),
(81, '2025-07-31', 83.33, 'tarjeta'),
(82, '2025-08-27', 83.33, 'tarjeta'),
(83, '2025-09-30', 83.33, 'tarjeta'),
(84, '2025-10-28', 41.66, 'efectivo'),
(85, '2025-12-01', 83.33, 'efectivo'),
(86, '2025-12-30', 83.33, 'efectivo'),
(87, '2026-01-28', 83.33, 'tarjeta'),
(88, '2026-02-24', 83.33, 'tarjeta'),
(89, '2026-03-24', 83.33, 'efectivo'),
(91, '2025-05-04', 125.0, 'efectivo'),
(92, '2025-06-05', 125.0, 'transferencia'),
(93, '2025-07-07', 250.0, 'efectivo'),
(95, '2025-08-27', 250.0, 'transferencia'),
(96, '2025-10-04', 125.0, 'tarjeta'),
(97, '2025-10-25', 125.0, 'efectivo'),
(98, '2025-12-04', 250.0, 'transferencia'),
(99, '2025-12-28', 250.0, 'tarjeta'),
(101, '2026-02-25', 125.0, 'efectivo'),
(102, '2026-03-30', 250.0, 'tarjeta'),
(104, '2025-06-30', 500.0, 'tarjeta'),
(105, '2025-08-01', 500.0, 'transferencia'),
(106, '2025-08-30', 500.0, 'efectivo'),
(107, '2025-09-27', 500.0, 'tarjeta'),
(109, '2025-05-22', 333.33, 'efectivo'),
(110, '2025-06-21', 333.33, 'efectivo'),
(111, '2025-07-24', 166.66, 'transferencia'),
(112, '2025-08-20', 333.33, 'efectivo'),
(113, '2025-09-24', 333.33, 'transferencia'),
(114, '2025-10-28', 333.33, 'efectivo'),
(115, '2025-11-24', 333.33, 'efectivo'),
(116, '2025-12-19', 333.33, 'efectivo'),
(117, '2026-01-20', 333.33, 'efectivo'),
(118, '2026-02-15', 333.33, 'efectivo'),
(122, '2026-06-19', 333.33, 'tarjeta'),
(123, '2026-07-21', 166.66, 'efectivo'),
(125, '2026-09-13', 333.33, 'transferencia'),
(126, '2026-10-16', 166.66, 'tarjeta'),
(127, '2026-11-18', 333.33, 'efectivo'),
(128, '2026-12-16', 333.33, 'tarjeta'),
(129, '2027-01-20', 333.33, 'efectivo'),
(130, '2027-02-12', 333.33, 'tarjeta'),
(131, '2027-03-14', 333.33, 'transferencia'),
(132, '2027-04-18', 333.33, 'tarjeta'),
(133, '2025-07-06', 41.67, 'efectivo'),
(135, '2025-08-29', 41.67, 'transferencia'),
(136, '2025-09-27', 41.67, 'efectivo'),
(137, '2025-10-28', 41.67, 'tarjeta'),
(138, '2025-11-24', 41.67, 'efectivo'),
(139, '2026-01-03', 41.67, 'transferencia'),
(141, '2026-03-03', 41.67, 'transferencia'),
(142, '2026-03-31', 41.67, 'tarjeta'),
(143, '2026-04-23', 41.67, 'transferencia'),
(144, '2026-05-24', 41.67, 'tarjeta'),
(146, '2026-07-27', 41.67, 'tarjeta'),
(147, '2026-08-28', 41.67, 'tarjeta'),
(148, '2026-09-28', 41.67, 'tarjeta'),
(149, '2026-10-20', 20.84, 'efectivo'),
(151, '2026-12-29', 41.67, 'efectivo'),
(152, '2027-01-22', 41.67, 'tarjeta'),
(154, '2027-03-20', 41.67, 'tarjeta'),
(155, '2027-04-26', 20.84, 'transferencia'),
(156, '2027-05-25', 20.84, 'efectivo'),
(157, '2025-06-28', 166.66, 'efectivo'),
(158, '2025-07-27', 166.66, 'efectivo'),
(159, '2025-08-28', 333.33, 'efectivo'),
(162, '2025-11-20', 333.33, 'efectivo'),
(164, '2026-01-19', 166.66, 'tarjeta'),
(165, '2026-02-25', 166.66, 'efectivo'),
(166, '2026-03-27', 333.33, 'transferencia'),
(167, '2026-04-20', 333.33, 'transferencia'),
(168, '2026-05-24', 333.33, 'efectivo'),
(169, '2026-06-20', 333.33, 'tarjeta'),
(170, '2026-07-19', 333.33, 'transferencia'),
(171, '2026-08-15', 166.66, 'tarjeta'),
(173, '2026-10-14', 333.33, 'efectivo'),
(174, '2026-11-23', 333.33, 'transferencia'),
(176, '2027-01-21', 166.66, 'tarjeta'),
(177, '2027-02-15', 333.33, 'efectivo'),
(178, '2027-03-19', 333.33, 'efectivo'),
(179, '2027-04-12', 166.66, 'transferencia'),
(180, '2027-05-14', 333.33, 'efectivo'),
(181, '2025-07-06', 416.67, 'efectivo'),
(182, '2025-08-03', 416.67, 'transferencia'),
(185, '2025-10-24', 416.67, 'tarjeta'),
(187, '2025-06-09', 833.33, 'tarjeta'),
(188, '2025-07-08', 833.33, 'transferencia'),
(190, '2025-09-06', 833.33, 'efectivo'),
(191, '2025-10-07', 833.33, 'transferencia'),
(193, '2025-12-06', 416.67, 'tarjeta'),
(194, '2026-01-03', 833.33, 'efectivo'),
(195, '2026-01-30', 833.33, 'tarjeta'),
(196, '2026-03-02', 833.33, 'tarjeta'),
(197, '2026-04-01', 833.33, 'efectivo'),
(198, '2026-04-25', 833.33, 'tarjeta'),
(199, '2025-05-04', 104.17, 'efectivo'),
(200, '2025-06-04', 208.33, 'efectivo'),
(201, '2025-06-29', 208.33, 'tarjeta'),
(202, '2025-08-04', 208.33, 'efectivo'),
(204, '2025-09-27', 208.33, 'tarjeta'),
(206, '2025-12-01', 104.17, 'tarjeta'),
(207, '2026-01-01', 208.33, 'efectivo'),
(208, '2026-01-31', 208.33, 'tarjeta'),
(209, '2026-02-24', 208.33, 'transferencia'),
(210, '2026-03-24', 208.33, 'tarjeta'),
(211, '2026-04-22', 104.17, 'transferencia'),
(213, '2026-06-20', 208.33, 'transferencia'),
(214, '2026-07-24', 104.17, 'tarjeta'),
(217, '2026-10-28', 208.33, 'tarjeta'),
(218, '2026-11-27', 208.33, 'efectivo'),
(219, '2026-12-22', 208.33, 'tarjeta'),
(220, '2027-01-18', 104.17, 'efectivo'),
(221, '2027-02-22', 208.33, 'tarjeta'),
(222, '2027-03-25', 208.33, 'efectivo');
GO

SELECT*FROM detalle_pagos

INSERT INTO detalle_pagos (cuota_id, pago_id, monto_afectado) 
VALUES 

(3, 1, 166.67),
(4, 2, 83.33),
(5, 3, 166.67),
(6, 4, 166.67),
(7, 5, 250.0),
(8, 6, 125.0),
(9, 7, 250.0),
(10, 8, 250.0),
(11, 9, 250.0),
(12, 10, 250.0),
(13, 11, 250.0),
(15, 12, 250.0),
(16, 13, 125.0),
(17, 14, 125.0),
(18, 15, 125.0),
(19, 16, 416.67),
(20, 17, 416.67),
(22, 18, 208.34),
(23, 19, 416.67),
(24, 20, 416.67),
(25, 21, 416.67),
(30, 22, 416.67),
(31, 23, 41.66),
(32, 24, 83.33),
(33, 25, 83.33),
(34, 26, 83.33),
(35, 27, 41.66),
(37, 28, 41.66),
(39, 29, 83.33),
(40, 30, 83.33),
(41, 31, 83.33),
(42, 32, 83.33),
(43, 33, 20.84),
(44, 34, 41.67),
(45, 35, 20.84),
(46, 36, 41.67),
(48, 37, 41.67),
(49, 38, 41.67),
(50, 39, 41.67),
(51, 40, 41.67),
(52, 41, 41.67),
(53, 42, 41.67),
(55, 43, 41.67),
(56, 44, 41.67),
(57, 45, 20.84),
(58, 46, 41.67),
(59, 47, 41.67),
(60, 48, 20.84),
(61, 49, 41.67),
(62, 50, 41.67),
(64, 51, 41.67),
(65, 52, 41.67),
(66, 53, 41.67),
(67, 54, 666.67),
(68, 55, 666.67),
(69, 56, 666.67),
(70, 57, 666.67),
(71, 58, 666.67),
(72, 59, 666.67),
(74, 60, 666.67),
(75, 61, 666.67),
(76, 62, 666.67),
(79, 63, 83.33),
(80, 64, 83.33),
(81, 65, 83.33),
(82, 66, 83.33),
(83, 67, 83.33),
(84, 68, 41.66),
(85, 69, 83.33),
(86, 70, 83.33),
(87, 71, 83.33),
(88, 72, 83.33),
(89, 73, 83.33),
(91, 74, 125.0),
(92, 75, 125.0),
(93, 76, 250.0),
(95, 77, 250.0),
(96, 78, 125.0),
(97, 79, 125.0),
(98, 80, 250.0),
(99, 81, 250.0),
(101, 82, 125.0),
(102, 83, 250.0),
(104, 84, 500.0),
(105, 85, 500.0),
(106, 86, 500.0),
(107, 87, 500.0),
(109, 88, 333.33),
(110, 89, 333.33),
(111, 90, 166.66),
(112, 91, 333.33),
(113, 92, 333.33),
(114, 93, 333.33),
(115, 94, 333.33),
(116, 95, 333.33),
(117, 96, 333.33),
(118, 97, 333.33),
(122, 98, 333.33),
(123, 99, 166.66),
(125, 100, 333.33),
(126, 101, 166.66),
(127, 102, 333.33),
(128, 103, 333.33),
(129, 104, 333.33),
(130, 105, 333.33),
(131, 106, 333.33),
(132, 107, 333.33),
(133, 108, 41.67),
(135, 109, 41.67),
(136, 110, 41.67),
(137, 111, 41.67),
(138, 112, 41.67),
(139, 113, 41.67),
(141, 114, 41.67),
(142, 115, 41.67),
(143, 116, 41.67),
(144, 117, 41.67),
(146, 118, 41.67),
(147, 119, 41.67),
(148, 120, 41.67),
(149, 121, 20.84),
(151, 122, 41.67),
(152, 123, 41.67),
(154, 124, 41.67),
(155, 125, 20.84),
(156, 126, 20.84),
(157, 127, 166.66),
(158, 128, 166.66),
(159, 129, 333.33),
(162, 130, 333.33),
(164, 131, 166.66),
(165, 132, 166.66),
(166, 133, 333.33),
(167, 134, 333.33),
(168, 135, 333.33),
(169, 136, 333.33),
(170, 137, 333.33),
(171, 138, 166.66),
(173, 139, 333.33),
(174, 140, 333.33),
(176, 141, 166.66),
(177, 142, 333.33),
(178, 143, 333.33),
(179, 144, 166.66),
(180, 145, 333.33),
(181, 146, 416.67),
(182, 147, 416.67),
(185, 148, 416.67),
(187, 149, 833.33),
(188, 150, 833.33),
(190, 151, 833.33),
(191, 152, 833.33),
(193, 153, 416.67),
(194, 154, 833.33),
(195, 155, 833.33),
(196, 156, 833.33),
(197, 157, 833.33),
(198, 158, 833.33),
(199, 159, 104.17),
(200, 160, 208.33),
(201, 161, 208.33),
(202, 162, 208.33),
(204, 163, 208.33),
(206, 164, 104.17),
(207, 165, 208.33),
(208, 166, 208.33),
(209, 167, 208.33),
(210, 168, 208.33),
(211, 169, 104.17),
(213, 170, 208.33),
(214, 171, 104.17),
(217, 172, 208.33),
(218, 173, 208.33),
(219, 174, 208.33),
(220, 175, 104.17),
(221, 176, 208.33),
(222, 177, 208.33);
GO

--- EJERCICIOS DE CONSULTA---

---1.- Identifica cuales son los prestamos que se encuentran morosos---

SELECT p.id AS prestamo_id, c.nombre AS cliente, p.estado, COUNT(*) AS cuotas_vencidas
FROM prestamos p
JOIN clientes c ON p.cliente_id = c.id
JOIN cuotas cu ON cu.prestamo_id = p.id
WHERE cu.estado_pago = 'vencida'
GROUP BY p.id, c.nombre, p.estado;

--- 2.- tipo de préstamos por tipo

SELECT tp.nombre_tipo, COUNT(*) AS cantidad_prestamos, SUM(p.monto_prestamo) AS monto_total
FROM prestamos p
JOIN tipo_de_prestamos tp ON p.tipo_de_prestamo_id = tp.id
GROUP BY tp.nombre_tipo;


---3.- cuales son las próximas cuotas a vencer en los últimos 30 días--

SELECT c.nombre AS cliente, p.id AS prestamo_id, cu.numero_cuota, cu.fecha_vencimiento
FROM cuotas cu
JOIN prestamos p ON cu.prestamo_id = p.id
JOIN clientes c ON p.cliente_id = c.id
WHERE cu.estado_pago = 'pendiente'
  AND cu.fecha_vencimiento BETWEEN CAST(GETDATE() AS DATE) AND DATEADD(DAY, 30, GETDATE());


--- 4.- Consultar el historial de pagos de un cliente: por ejemplo Ramón Nogués Carrera---

SELECT c.nombre AS cliente, cu.numero_cuota, cu.fecha_vencimiento,
       pa.fecha_pago, pa.monto_pagado, pa.metodo_pago
FROM pagos pa
JOIN cuotas cu ON pa.cuota_id = cu.id
JOIN prestamos p ON cu.prestamo_id = p.id
JOIN clientes c ON p.cliente_id = c.id
WHERE c.nombre = 'Ramón Nogués Carrera'
ORDER BY pa.fecha_pago;

---3.-  

CREATE VIEW vista_detalle_prestamos AS
SELECT p.id AS prestamo_id, c.nombre AS cliente, tp.nombre_tipo AS tipo_prestamo,
       p.monto_prestamo, p.tasa_interes, p.plazo, p.fecha_inicio, p.estado
FROM prestamos p
JOIN clientes c ON p.cliente_id = c.id
JOIN tipo_de_prestamos tp ON p.tipo_de_prestamo_id = tp.id;

DROP VIEW vista_detalle_prestamos;
GO

SELECT * FROM vista_saldos_pendientes;

--5.- préstamos activos con saldo pendiente mayor a 2000---

CREATE FUNCTION dbo.saldo_pendiente(@prestamo_id INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @total DECIMAL(10,2);
    DECLARE @pagado DECIMAL(10,2);

    SELECT @total = SUM(monto_cuota)
    FROM cuotas
    WHERE prestamo_id = @prestamo_id;

    SELECT @pagado = SUM(monto_pagado)
    FROM pagos
    WHERE cuota_id IN (
        SELECT id FROM cuotas WHERE prestamo_id = @prestamo_id
    );

    RETURN ISNULL(@total, 0) - ISNULL(@pagado, 0);
END;

SELECT p.id AS prestamo_id, c.nombre, 
       dbo.saldo_pendiente(p.id) AS saldo_pendiente
FROM prestamos p
JOIN clientes c ON p.cliente_id = c.id
WHERE p.estado = 'activo' AND dbo.saldo_pendiente(p.id) > 2000;

--- 6.- Visualiar el saldo pendiente de un solo préstamo por ID

SELECT dbo.saldo_pendiente(5) AS saldo_del_prestamo;

--- 7.- Top 5 clientes con mayor deuda pendiente---

SELECT TOP 5 c.nombre, dbo.saldo_pendiente(p.id) AS deuda_total
FROM prestamos p
JOIN clientes c ON p.cliente_id = c.id
WHERE p.estado = 'activo'
ORDER BY dbo.saldo_pendiente(p.id) DESC;

--- 8.- Total de pagos recibidos por sucursal---

SELECT s.nombre AS sucursal, SUM(pg.monto_pagado) AS total_pagado
FROM pagos pg
JOIN cuotas cu ON pg.cuota_id = cu.id
JOIN prestamos pr ON cu.prestamo_id = pr.id
JOIN sucursales s ON pr.sucursal_id = s.id
GROUP BY s.nombre;

--- 9.- Obten el pago total realizado por un cliente

CREATE FUNCTION dbo.total_pagado_por_cliente(@cliente_id INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @total_pagado DECIMAL(10,2)

    SELECT @total_pagado = SUM(pagos.monto_pagado)
    FROM pagos
    JOIN cuotas ON pagos.cuota_id = cuotas.id
    JOIN prestamos ON cuotas.prestamo_id = prestamos.id
    WHERE prestamos.cliente_id = @cliente_id;

    RETURN ISNULL(@total_pagado, 0);
END;

SELECT dbo.total_pagado_por_cliente(7) AS total_pagado;
