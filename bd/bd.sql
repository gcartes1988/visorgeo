-- 🧾 ENUMS
CREATE TYPE estado_proyecto_enum AS ENUM ('pendiente', 'aprobado', 'rechazado');

-- 🌍 Tablas geográficas
CREATE TABLE region (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL
);

CREATE TABLE provincia (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  codigo VARCHAR,
  region_id INT REFERENCES region(id)
);

CREATE TABLE comuna (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  codigo VARCHAR,
  provincia_id INT REFERENCES provincia(id)
);

-- 👥 Usuarios
CREATE TABLE usuario (
  id SERIAL PRIMARY KEY,
  firebase_uid VARCHAR UNIQUE NOT NULL,
  nombre_usuario VARCHAR NOT NULL,
  rol VARCHAR NOT NULL CHECK (rol IN ('admin', 'editor'))
);


-- 📚 Tablas de referencia
CREATE TABLE categoria (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  descripcion TEXT
);

CREATE TABLE estado_avance (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL
);

CREATE TABLE tipo_ciclovia (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL
);

CREATE TABLE tipo_calzada (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL
);

CREATE TABLE tipo_pavimento (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL
);

CREATE TABLE contratista (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL
);

CREATE TABLE fuente_financiamiento (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL
);

-- 📦 Proyecto general
CREATE TABLE proyecto (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  descripcion TEXT NOT NULL,
  categoria_id INT REFERENCES categoria(id),
  estado_proyecto estado_proyecto_enum NOT NULL,
  elim_pendiente BOOLEAN DEFAULT FALSE,
  fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_aprobacion TIMESTAMP,
  creado_por_id INT REFERENCES usuario(id),
  aprobado_por_id INT REFERENCES usuario(id),
  proyecto_padre_id INT REFERENCES proyecto(id)
);

-- 📝 Documento
CREATE TABLE documento (
  id SERIAL PRIMARY KEY,
  proyecto_id INT REFERENCES proyecto(id),
  tipo_documento VARCHAR NOT NULL,
  nombre_archivo VARCHAR NOT NULL,
  url_archivo TEXT NOT NULL
);

-- 🧾 Log de cambios
CREATE TABLE log_cambios (
  id SERIAL PRIMARY KEY,
  proyecto_id INT REFERENCES proyecto(id),
  usuario_id INT REFERENCES usuario(id),
  accion VARCHAR NOT NULL,
  campo_modificado VARCHAR NOT NULL,
  valor_anterior TEXT,
  valor_nuevo TEXT,
  fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 🚧 Pavimento
CREATE TABLE pavimento (
  id SERIAL PRIMARY KEY,
  proyecto_id INT NOT NULL REFERENCES proyecto(id),
  comuna_id INT NOT NULL REFERENCES comuna(id),
  sector VARCHAR NOT NULL,
  ficha VARCHAR,
  origen_pos VARCHAR,
  cantidad INT,
  via_postulacion VARCHAR,
  tramo VARCHAR,
  longitud_metros FLOAT NOT NULL,
  ancho_metros FLOAT,
  superficie_m2 FLOAT,
  aceras_long FLOAT,
  aceras_ancho FLOAT,
  aceras_superficie FLOAT,
  tipo_calzada_id INT REFERENCES tipo_calzada(id),
  cantidad_viviendas INT,
  tipo_accion VARCHAR,
  tipo_pavimento_id INT REFERENCES tipo_pavimento(id),
  inversion_obra INT,
  aporte_municipal INT,
  aporte_comunidad INT,
  aporte_sectorial INT,
  proyecto_ingenieria VARCHAR,
  id_licitacion VARCHAR,
  contratista_id INT REFERENCES contratista(id),
  monto_contrato INT,
  plazo_dias INT,
  fecha_termino DATE,
  codigo_bip VARCHAR,
  resolucion_contrato VARCHAR,
  llamado VARCHAR,
  estado_avance_id INT REFERENCES estado_avance(id),
  geometria geometry
);


-- 🧱 Relación muchos a muchos de tipos de pavimento
CREATE TABLE pavimento_tipo_pavimento (
  pavimento_id INT REFERENCES pavimento(id),
  tipo_pavimento_id INT REFERENCES tipo_pavimento(id),
  PRIMARY KEY (pavimento_id, tipo_pavimento_id)
);

-- 🚲 Ciclovía
CREATE TABLE ciclovia (
  id SERIAL PRIMARY KEY,
  proyecto_id INT UNIQUE REFERENCES proyecto(id),
  comuna_id INT NOT NULL REFERENCES comuna(id),
  nombre_tramo VARCHAR NOT NULL,
  longitud_metros FLOAT NOT NULL,
  ancho_metros FLOAT,
  tipo_ciclovia_id INT REFERENCES tipo_ciclovia(id),
  estado_avance_id INT REFERENCES estado_avance(id),
  superficie_m2 FLOAT,
  codigo_bip VARCHAR,
  contratista_id INT REFERENCES contratista(id),
  monto_contrato INT,
  plazo_dias INT,
  fecha_termino DATE,
  beneficiarios_hombres INT,
  beneficiarios_mujeres INT,
  observaciones TEXT,
  geometria geometry
);

-- 🌳 Parque
CREATE TABLE parque (
  id SERIAL PRIMARY KEY,
  proyecto_id INT UNIQUE REFERENCES proyecto(id),
  comuna_id INT NOT NULL REFERENCES comuna(id),
  direccion VARCHAR,
  superficie_ha FLOAT,
  propiedad VARCHAR,
  administracion VARCHAR,
  costo_construccion INT,
  costo_anual INT,
  fuente_financiamiento_id INT REFERENCES fuente_financiamiento(id),
  equipamiento JSON,
  suministro_basico BOOLEAN,
  conexion_red BOOLEAN,
  viviendas_impactadas INT,
  poblacion_beneficiada INT,
  geometria geometry
);
