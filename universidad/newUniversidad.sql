	\c template 1

	DROP DATABASE universidad IF EXISTS;
	CREATE DATABASE universidad;

	\c universidad

	\! cls

	CREATE TABLE facultad (
		id_facultad INTEGER PRIMARY KEY NOT NULL,
		nombre VARCHAR(20) NOT NULL,
		url VARCHAR(50) NOT NULL
	);

	CREATE TABLE universidad (
		id_anio_academico INTEGER PRIMARY KEY NOT NULL,
		id_facultad INTEGER REFERENCES facultad(id_facultad) NOT NULL,
		nombre VARCHAR(20) NOT NULL,
		bilingual BOOLEAN NOT NULL DEFAULT 'n',
		duracion INTEGER NOT NULL,
		capacidad INTEGER NOT NULL,
		CHECK (bilingual IN ('y', 'n')),
		CHECK (capacidad BETWEEN 0 AND 350) 
	);

	CREATE TABLE grado (
		id_anio_academico INTEGER PRIMARY KEY   REFERENCES universidad(id_anio_academico) NOT NULL,
		basicos INTEGER NOT NULL,
		obligatorios INTEGER NOT NULL,
		opcional INTEGER NOT NULL,
		CHECK ((obligatorios > basicos) AND (basicos > opcional))
	);

	CREATE TABLE master (
		id_anio_academico INTEGER PRIMARY KEY   REFERENCES universidad(id_anio_academico) NOT NULL,
		creditos INTEGER NOT NULL
	);

	CREATE TABLE lugar (
		id_lugar INTEGER NOT NULL,
		id_anio_academico INTEGER   REFERENCES master(id_anio_academico) NOT NULL,
		lugar VARCHAR(20) NOT NULL,
		PRIMARY KEY (id_lugar, id_anio_academico)
	);

	CREATE TABLE profesor (
		id_profesor INTEGER PRIMARY KEY NOT NULL,
		nombre VARCHAR(20) NOT NULL,
		apellidos VARCHAR(20) NOT NULL
	);

	CREATE TABLE empresa (
		id_empresa INTEGER PRIMARY KEY NOT NULL,
		nombre VARCHAR(20)
	);

	CREATE TABLE ensenia (
		id_profesor INTEGER NOT NULL REFERENCES profesor(id_profesor),
		id_anio_academico INTEGER NOT NULL REFERENCES grado(id_anio_academico),
		PRIMARY KEY(id_profesor, id_anio_academico),
		UNIQUE (id_profesor, id_anio_academico)	-- UNIQUE el combo
	);

	CREATE TABLE practica (
		id_anio_academico INTEGER NOT NULL,
		id_profesor INTEGER NOT NULL,
		id_empresa INTEGER NOT NULL REFERENCES empresa(id_empresa),
		PRIMARY KEY (id_anio_academico, id_profesor, id_empresa),
		FOREIGN KEY (id_anio_academico, id_profesor) REFERENCES ensenia(id_anio_academico, id_profesor)
	);
