-- Poblar tabla categoria
INSERT INTO categoria (nombre, descripcion) VALUES 
('Pavimentos de vías locales', 'Proyectos de pavimentación de calles y pasajes'),
('Red de ciclovías', 'Proyectos de ciclovías urbanas'),
('Parques Urbanos', 'Proyectos de parques administrados por el MINVU');

-- Poblar tipo_calzada
INSERT INTO tipo_calzada (nombre) VALUES
('Calle'),
('Pasaje'),
('Acera'),
('Senda'),
('Calle y pasaje'),
('Calle y ciclovía'),
('Calle, pasaje y ciclovía'),
('Calle, pasaje y vereda'),
('Desconocido');

-- Poblar tipo_pavimento
INSERT INTO tipo_pavimento (nombre) VALUES 
('Hormigón'), ('Asfalto'), ('Adocreto'), ('Estabilizado');

-- Poblar contratista
INSERT INTO contratista (nombre) VALUES 
('Constructora BioSur'), 
('Obras Civiles del Sur'), 
('Pavimentos del Biobío');

-- Poblar fuente_financiamiento
INSERT INTO fuente_financiamiento (nombre) VALUES 
('FNDR'), ('MINVU'), ('Municipalidad');

-- Poblar estado_avance
INSERT INTO estado_avance (nombre) VALUES 
('Proyectada'), ('En ejecución'), ('Terminada');

-- Poblar región del Biobío
INSERT INTO region (id, nombre) VALUES (8, 'Biobío');

-- Poblar provincias de la región del Biobío
INSERT INTO provincia (id, nombre, codigo, region_id) VALUES 
(1, 'Concepción', '081', 8),
(2, 'Arauco', '082', 8),
(3, 'Biobío', '083', 8);

-- Poblar comunas (ejemplo con algunas, puedes extender)
INSERT INTO comuna (nombre, codigo, provincia_id) VALUES 
('Concepción', '08101', 1),
('Coronel', '08102', 1),
('Talcahuano', '08103', 1),
('San Pedro de la Paz', '08104', 1),
('Hualpén', '08105', 1),
('Chiguayante', '08106', 1),
('Penco', '08107', 1),
('Tomé', '08108', 1),
('Lota', '08109', 1),
('Arauco', '08201', 2),
('Curanilahue', '08202', 2),
('Cañete', '08203', 2),
('Los Álamos', '08204', 2),
('Lebu', '08205', 2),
('Nacimiento', '08301', 3),
('Los Ángeles', '08302', 3),
('Mulchén', '08303', 3),
('Santa Bárbara', '08304', 3);

-- Poblar usuarios 

INSERT INTO usuario (firebase_uid, nombre_usuario, rol)
VALUES
('LCTPXFR8C1aqVqwuf9GafeV7ghI3', 'Gustavo Cartes', 'admin');
