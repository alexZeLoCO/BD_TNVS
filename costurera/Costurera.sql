-- Completar en este mismo fichero las cuestiones
 -- Es recomendable el ir realizando las consultas en el PostgreSQL, una a una, y a medida que funcionen correctamente
-- pegarlas en este fichero
-- El examen ya resuelto se guardará en un fichero '.sql' con el nombre del numero de DNI del alumno/a, por ejemplo:
--  xxxxxxxxxxx.sql
 -- borrar la base de datos costurera por si existe
\c template1
DROP DATABASE IF EXISTS costurera;

-- crear la base de datos costurera

CREATE DATABASE costurera;

-- conectarse a la base de datos costurera
\c costurera /*
Nombre de la tabla: PRENDAS
Campos:
	1. id_prenda: entero, es la clave primaria
	2. nom_prenda: cadena de hasta 20 caracteres, no admite valores nulos y no se puede repetir
	3. anios: entero entre 0 y 30
*/
CREATE TABLE prendas (id_prenda INTEGER PRIMARY KEY,
																							nom_prenda VARCHAR(20) NOT NULL UNIQUE,
																							anios INTEGER CHECK (anios BETWEEN 0 AND 30));

/*
Nombre de la tabla: arreglos
Campos:
	1. id_arreglos: entero
	2. desc_arreglos: cadena de hasta 10 caracteres

Restricciones:
	1. La clave primaria es id_arreglos
 */
CREATE TABLE arreglos (id_arreglos INTEGER PRIMARY KEY,
																								desc_arreglos VARCHAR(10));

-- Otra opción: PRIMARY KEY (id_arreglos)
 /*
Nombre de la tabla: TAREAS
Campos:
	1. id_tarea: entero, clave primaria
	2. desc_tarea: cadena de 20 caracteres maximo

 */
CREATE TABLE tareas (id_tarea INTEGER PRIMARY KEY,
																						desc_tarea VARCHAR(20));

/*
Nombre de la tabla: PRENDAS_arreglos
Campos:
	1. id_prenda: entero positivo
	2. id_arreglos: entero positivo
	3. estado:  cadena de hasta 12 caracteres con solo 4
                                    valores posibles: 'FACIL', 'DIFICIL'y 'REGULAR'
                                    que admita cualquier combinacion de mayusculas o minusculas

Observaciones:
	1. La clave primaria es id_prenda+ id_arreglos
	2. Una clave ajena id_arreglos relacionada con la tabla arreglos (ESTABLECER LAS CONDICIONES DE ON DELETE Y ON UPDATE la accion es CASCADE)
 */
CREATE TABLE prendas_arreglos
				(id_prenda INTEGER CHECK (id_prenda > 0), id_arreglos INTEGER CHECK (id_prenda > 0), estado VARCHAR(12) CHECK (UPPER(estado) IN ('FACIL',
																																																																																																																																						'DIFICIL' 'REGULAR')), PRIMARY KEY (id_prenda,
																																																																																																																																																																											id_arreglos),
					FOREIGN KEY (id_arreglos) REFERENCES arreglos (id_arreglos) ON DELETE CASCADE ON UPDATE CASCADE);

/*																																																																																																																																												 )Nombre de la tabla: PRENDAS_arreglos_TAREAS
Nombre de la tabla: PRENDAS_arreglos_TAREAS
Campos:
	1. id_prenda: entero
	2. id_arreglos: entero
	3. id_tarea: entero
	4. importe: decimal con 6 digitos 1 de ellos para los decimales
Restricciones:
	1. La clave primaria es (id_prenda+id_arreglos+id_tarea)
	2. Una clave ajena es (id_prenda + id_arreglos) a la tabla prendas_arreglos (ON DELETE y ON UPDATE la accion es CASCADE)
        3. Otra clave ajena es (id_tarea) a la tabla tareas (ON DELETE y ON UPDATE la accion es CASCADE)
*/
CREATE TABLE prendas_arreglos_tareas
				(id_prenda INTEGER, id_arreglos INTEGER, id_tarea INTEGER, importe DECIMAL (6, 1),
						PRIMARY KEY (id_prenda,
																				id_arreglos,
																				id_tarea),
					FOREIGN KEY (id_prenda,
																			id_arreglos) REFERENCES prendas_arreglos (id_prenda, id_arreglos) ON DELETE CASCADE ON UPDATE CASCADE,
					FOREIGN KEY (id_tarea) REFERENCES tareas (id_tarea) ON DELETE CASCADE ON UPDATE CASCADE);

----------------------------- INSERTS ----------------------

delete
from prendas_arreglos_tareas;


delete
from prendas_arreglos;


delete
from arreglos;


delete
from tareas;


delete
from prendas;


INSERT INTO prendas (id_prenda, nom_prenda, anios)
VALUES(1,
								'Americana',
								2);


INSERT INTO prendas (id_prenda, nom_prenda, anios)
VALUES(2,
								'FAlda',
								5);


INSERT INTO prendas (id_prenda, nom_prenda, anios)
VALUES(3,
								'Vestido',
								1);


INSERT INTO prendas (id_prenda, nom_prenda, anios)
VALUES(4,
								'PantaloN',
								2);


INSERT INTO prendas (id_prenda, nom_prenda, anios)
VALUES(5,
								'JErsey',
								2);


INSERT INTO tareas (id_tarea, desc_tarea)
VALUES (1,
									'Descoser');


INSERT INTO tareas (id_tarea, desc_tarea)
VALUES (2,
									'Coser');


INSERT INTO tareas (id_tarea, desc_tarea)
VALUES (3,
									'Cortar');


INSERT INTO tareas (id_tarea, desc_tarea)
VALUES (4,
									'Crear plantilla');


INSERT INTO tareas (id_tarea, desc_tarea)
VALUES (5,
									'Probar');


INSERT INTO arreglos (id_arreglos, desc_arreglos)
VALUES(1,
								'Alargar');


INSERT INTO arreglos (id_arreglos, desc_arreglos)
VALUES(2,
								'Disminuir');


INSERT INTO arreglos (id_arreglos, desc_arreglos)
VALUES(3,
								'Agrandar');


INSERT INTO prendas_arreglos (id_prenda, id_arreglos)
VALUES (1,
									1);


INSERT INTO prendas_arreglos (id_prenda, id_arreglos)
VALUES (1,
									2);


INSERT INTO prendas_arreglos (id_prenda, id_arreglos)
VALUES (1,
									3);


INSERT INTO prendas_arreglos (id_prenda, id_arreglos)
VALUES (5,
									1);


INSERT INTO prendas_arreglos (id_prenda, id_arreglos)
VALUES (4,
									1);


INSERT INTO prendas_arreglos (id_prenda, id_arreglos)
VALUES (4,
									3);


INSERT INTO prendas_arreglos_tareas (id_prenda, id_arreglos, id_tarea, importe)
VALUES (1,
									1,
									1,
									3.00);


INSERT INTO prendas_arreglos_tareas (id_prenda, id_arreglos, id_tarea, importe)
VALUES (1,
									1,
									2,
									5.00);


INSERT INTO prendas_arreglos_tareas (id_prenda, id_arreglos, id_tarea, importe)
VALUES (1,
									1,
									3,
									6.00);


INSERT INTO prendas_arreglos_tareas (id_prenda, id_arreglos, id_tarea, importe)
VALUES (1,
									1,
									4,
									6.00);


INSERT INTO prendas_arreglos_tareas (id_prenda, id_arreglos, id_tarea, importe)
VALUES (1,
									1,
									5,
									6.00);


INSERT INTO prendas_arreglos_tareas (id_prenda, id_arreglos, id_tarea, importe)
VALUES (1,
									2,
									3,
									8.00);


INSERT INTO prendas_arreglos_tareas (id_prenda, id_arreglos, id_tarea, importe)
VALUES (1,
									3,
									3,
									6.00);


INSERT INTO prendas_arreglos_tareas (id_prenda, id_arreglos, id_tarea, importe)
VALUES (5,
									1,
									1,
									5.00);


INSERT INTO prendas_arreglos_tareas (id_prenda, id_arreglos, id_tarea, importe)
VALUES (5,
									1,
									2,
									7.00);


INSERT INTO prendas_arreglos_tareas (id_prenda, id_arreglos, id_tarea, importe)
VALUES (4,
									1,
									1,
									3.00);


INSERT INTO prendas_arreglos_tareas (id_prenda, id_arreglos, id_tarea, importe)
VALUES (4,
									3,
									2,
									5.0);

------------------  MODIFICACIONES DE LA DEFINICION DE TABLAS --------------------------------
 -- Anadir el campo 'atributo1' de tipo integer entero a la tabla arreglos
 -- Hacer que 'atributo1' haga integridad referencial a id_arreglos de la tabla arreglos
 -- Imponer la restriccion atributo1_unico para que atributo1 no se repita en la tabla arreglos
 -- Borrar la restriccion atributo1_unico
 ----------------------------- CONSULTAS --------------------
 --1)
-- Mostrar las columnas
--	nom_prenda: nombre de la prenda
--	desc_arreglos: descripcion del arreglos
-- para todas las prendas cuyo nombre contenga una 'A' o una 'a'

SELECT nom_prenda,
	desc_arreglos
FROM prendas_arreglos
NATURAL JOIN arreglos
NATURAL JOIN prendas
WHERE UPPER(nom_prenda) LIKE '%A%';

--2)
-- Descripciones de los arreglos que aun no han sido realizados en alguna prenda

SELECT desc_arreglos
FROM arreglos
WHERE arreglos.id_arreglos NOT IN
								(SELECT id_arreglos
									FROM prendas_arreglos);

--3)
-- Mostrar los identificadores de las prendas que aun no han tenido ningun arreglos (estan en buen estado)

SELECT id_prenda
FROM prendas
WHERE prendas.id_prenda NOT IN
								(SELECT id_prenda
									FROM prendas_arreglos);


SELECT id_prenda
FROM prendas
LEFT JOIN prendas_arreglos USING (id_prenda)
WHERE id_arreglos IS NULL;

--4)
-- Mostrar los id_prenda, id_arreglos, id_tarea,
-- cuyo importe coincida con el mayor de los importes

SELECT id_prenda,
	id_arreglos,
	id_tarea
FROM prendas_arreglos_tareas
WHERE importe =
								(SELECT max(importe)
									FROM prendas_arreglos_tareas);

--5)
-- Mostrar los id_prenda, id_arreglos, id_tarea,
-- cuyo importe coincida con algun importe de alguna tarea de algun arreglos
-- de la id_prenda=1

SELECT id_prenda,
	id_arreglos,
	id_tarea
FROM prendas_arreglos_tareas
WHERE importe IN
								(SELECT importe
									FROM prendas_arreglos_tareas
									WHERE id_prenda=1);

--6)
-- Identificador de los arreglos que para la misma tarea
-- tienen distinto importe dependiendo de la prenda

SELECT a.id_arreglos,
	b.id_arreglos
FROM prendas_arreglos_tareas a,
	prendas_arreglos_tareas b
WHERE a.id_tarea = b.id_tarea
				AND a.id_prenda != b.id_prenda
				AND a.importe != b.importe
				AND a.id_arreglos != b.id_arreglos;

--7)
-- Nombres de las prendas que para algun arreglos se le han aplicado todas las tareas

SELECT nom_prenda
FROM prendas AS a
INNER JOIN
				(SELECT DISTINCT id_prenda
					FROM prendas_arreglos_tareas AS a1
					WHERE NOT EXISTS (
																											(SELECT id_arreglos
																												FROM arreglos)
																							EXCEPT
																											(SELECT id_arreglos
																												FROM prendas_arreglos_tareas AS a2
																												WHERE a1.id_prenda = a2.id_prenda))
									AND EXISTS
													(SELECT id_arreglos
														FROM arreglos) ) AS b ON (a.id_prenda=b.id_prenda);

-- Nombres de las prendas que han tenido el mismo numero de arreglos

SELECT a.nom_prenda,
	COUNT(b.id_arreglos) AS cuenta_arreglos
FROM prendas AS a
NATURAL JOIN prendas_arreglos AS b
GROUP BY a.id_prenda
HAVING COUNT(b.id_arreglos) IN
				( SELECT COUNT (b.id_arreglos)
					FROM prendas AS c
					NATURAL JOIN prendas_arreglos AS d
					WHERE a.id_prenda != c.id_prenda );

--------------------------- ACTUALIZACIONES --------------------------
 -- Actualizar el importe de la id_prenda=1, id_arreglos=1, id_tarea=1 de la tabla prendas_arreglos_tareas
-- con el importe de  id_prenda=1, id_arreglos=3, id_tarea=3 de dicha tabla
 --------------------------- ANADIR UN CAMPO ----------------------------
 -- En primer lugar añadir un campo IMPORTE_TOTAL en la tabla PRENDAS_arreglos
-- y establecer como valor por defecto de este campo el 0
 --------------------------- ACTUALIZACION DE TABLAS ----------------------------
 -- Actualizar a traves de un UPDATE TABLE todos los valores de IMPORTE_TOTAL en la tabla PRENDAS_arreglos
-- UPDATE prendas_arreglos SET importe_total= ..................
 ------------------------------- TRIGGERS -----------------------------------
 -- Actualizar dinamicamente el campo IMPORTE_TOTAL cada vez que se anada
-- (INSERT) una tupla a la tabla PRENDAS_arreglos_TAREAS a traves de un trigger 'after_insert_prendas_arreglos_tareas'
-- primero: crear el lenguaje
 -- Borrar el trigger (si ya no existe da un mensaje de aviso en lugar de
-- error con la expresión opcional IF EXISTS).
-- Con la palabra opcional CASCADE se borran
-- tambien todos los objetos que dependen del trigger
 -- crear la funcion 'actualiza_importe_total_after_insert()'  del trigger que actualiza el nuevo campo IMPORTE_TOTAL en la tabla PRENDAS_arreglos
-- cada vez que se inserta una tupla en la tabla PRENDAS_arreglos_TAREAS
 -- crear el trigger 'after_insert_prendas_arreglos_tareas'
 -- Ahora anadir una nueva tupla a la tabla PRENDAS_arreglos_TAREAS:    id_prenda=4, id_arreglos=1, id_tarea= 2, importe=4
 -- comprobar con un SELECT que el campo IMPORTE_TOTAL de  id_prenda=4, id_arreglos= 1 ha aumentado en 4 su valor en la tabla PRENDAS_arreglos.
 ----------------------------- BORRAR LA BD  COSTURERA ------------------
