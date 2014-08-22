ALTER SESSION SET nls_date_format = 'yyyy-mm-dd';

CREATE TABLE ciudades (
	cod_ciudad NUMBER(8) NOT NULL, 
	nombre VARCHAR(30) NOT NULL,
	activa NUMBER(1) NOT NULL,
	PRIMARY KEY (cod_ciudad)
);

CREATE SEQUENCE ciudad_seq;

CREATE OR REPLACE TRIGGER ciudad_fire
BEFORE INSERT ON ciudades
FOR EACH ROW
BEGIN
  SELECT ciudad_seq.NEXTVAL
  INTO   :new.cod_ciudad
  FROM   dual;
END;
/

INSERT INTO ciudades (nombre, activa) VALUES ('SANTIAGO DE CALI', 1);

CREATE TABLE afiliaciones (
	nro_afiliacion NUMBER(8) NOT NULL, 
	nombre VARCHAR(50) NOT NULL,
	identificacion NUMBER(12) NOT NULL,
	telefono VARCHAR(10),
	ciudad NUMBER(8) NOT NULL CONSTRAINT ciudad_fk REFERENCES ciudades(cod_ciudad),
	fecha_afiliación DATE NOT NULL,
	PRIMARY KEY (nro_afiliacion)
);

CREATE SEQUENCE afiliacion_seq;

CREATE OR REPLACE TRIGGER afiliacion_fire
BEFORE INSERT ON afiliaciones
FOR EACH ROW
BEGIN
  SELECT afiliacion_seq.NEXTVAL
  INTO   :new.nro_afiliacion
  FROM   dual;
END;
/

INSERT INTO afiliaciones (nombre, identificacion, telefono, ciudad, fecha_afiliación)
VALUES ('Betty Swam y Familia', 66541214, 4447854, 21, TO_DATE('1990-05-05','yyyy-mm-dd'));

INSERT INTO afiliaciones (nombre, identificacion, telefono, ciudad, fecha_afiliación)
VALUES ('Alex Roldán y Familia', 94375295, 3975383, 21, '2011-04-22');

CREATE TABLE socios(
	identificación NUMBER(8) NOT NULL,
	nro_afiliacion NUMBER(8) NOT NULL CONSTRAINT afiliacion_fk REFERENCES afiliaciones(nro_afiliacion),
	cedula NUMBER(12) NOT NULL,
	nombres VARCHAR2(30) NOT NULL,
	apellidos VARCHAR2(30) NOT NULL,
	telefono NUMBER(10),
	empresa VARCHAR2(30),
	aficiones VARCHAR2(200),
	fecha_afiliación DATE NOT NULL,
	PRIMARY KEY (identificación)
);

CREATE TABLE visitas (
	cons_visita NUMBER(10) NOT NULL,
	id_socio NUMBER(8) NOT NULL CONSTRAINT socio_fk REFERENCES socios(identificación),
	fecha_hora_ingreso TIMESTAMP NOT NULL,
	fecha_hora_salida TIMESTAMP,
	cantidad_acompañantes NUMBER(2),
	PRIMARY KEY (cons_visita),
	CHECK (fecha_hora_salida>=fecha_hora_ingreso),
	CHECK (cantidad_acompañantes>=0)
);

CREATE SEQUENCE visita_seq;

CREATE OR REPLACE TRIGGER visita_fire
BEFORE INSERT ON visitas
FOR EACH ROW
BEGIN
  SELECT visita_seq.NEXTVAL
  INTO   :new.cons_visita
  FROM   dual;
END;
/

CREATE TABLE acompañantes_visita (
	cons_acompañamiento NUMBER(10) NOT NULL,
	cons_visita NUMBER(10) NOT NULL CONSTRAINT visita_fk REFERENCES visitas(cons_visita),
	nombres VARCHAR2(25) NOT NULL,
	apellidos VARCHAR2(25) NOT NULL,
	PRIMARY KEY (cons_acompañamiento)
);

CREATE SEQUENCE acompañantes_visita_seq;

CREATE OR REPLACE TRIGGER acompañantes_visita_fire
BEFORE INSERT ON acompañantes_visita
FOR EACH ROW
BEGIN
  SELECT acompañantes_visita_seq.NEXTVAL
  INTO   :new.cons_acompañamiento
  FROM   dual;
END;
/

CREATE TABLE tipos_producto(
	codigo NUMBER(2) NOT NULL,
	nombre VARCHAR2(10) NOT NULL,
	PRIMARY KEY (codigo)
);

CREATE TABLE productos (
	codigo NUMBER(5) NOT NULL,
	tipo NUMBER(2) NOT NULL CONSTRAINT tipos_producto_fk REFERENCES tipos_producto(codigo),
	nombre VARCHAR2(50) NOT NULL,
	precio NUMBER(8,2) NOT NULL,
	PRIMARY KEY (codigo)
);

CREATE TABLE consumos (
	consecutivo NUMBER(6) NOT NULL,
	cons_visita NUMBER(10) NOT NULL CONSTRAINT visita_fk2 REFERENCES visitas(cons_visita),
	cod_producto NUMBER(5) NOT NULL CONSTRAINT producto_fk REFERENCES productos(codigo),
	cantidad NUMBER(4,2) NOT NULL,
	observacion VARCHAR2(50),
	PRIMARY KEY (consecutivo)
);

CREATE SEQUENCE consumo_seq;

CREATE OR REPLACE TRIGGER consumo_fire
BEFORE INSERT ON consumos
FOR EACH ROW
BEGIN
  SELECT consumo_seq.NEXTVAL
  INTO   :new.consecutivo
  FROM   dual;
END;
/

CREATE TABLE deportes(
	codigo NUMBER(3) NOT NULL,
	nombre VARCHAR2(50) NOT NULL,
	PRIMARY KEY (codigo)
);

CREATE TABLE deportes_socios (
	consecutivo NUMBER(6) NOT NULL,
	id_socio NUMBER(8) NOT NULL CONSTRAINT socio_fk2 REFERENCES socios(identificación),
	cod_deporte NUMBER(3) NOT NULL CONSTRAINT deporte_fk REFERENCES deportes(codigo),
	PRIMARY KEY (consecutivo)
);

CREATE SEQUENCE deportes_socio_seq;

CREATE OR REPLACE TRIGGER deportes_socio_fire
BEFORE INSERT ON deportes_socios
FOR EACH ROW
BEGIN
  SELECT deportes_socio_seq.NEXTVAL
  INTO   :new.consecutivo
  FROM   dual;
END;
/
