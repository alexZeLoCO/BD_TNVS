-- Consulta 1: Nombre y noseque de profesores catedraticos (catgoria = C) o titulares (categoria = T)
SELECT nombre
FROM profesores
WHERE UPPER(categoria)='C'
OR UPPER(categoria)='T';

-- Consulta 2: Codigo y nombre de profesores que imparten asignaturas de tercer curso
SELECT codigo, p.nombre
FROM profesores AS p
INNER JOIN docencia ON docencia.codigoProfesor = profesor.codigo
INNER JOIN asignaturas ON asignatura.nombre = docencia.nombreAsignatura
WHERE asignaturas.curso = 3;

/* 
 * Consulta 3:  Codigo, nombre y categoria de los profesores que no imparten ninguna asignatura de
 * CCIA
 */
SELECT codigo, p.nombre, categoria
FROM profesores AS p
INNER JOIN docencia ON p.codigo = docencia.codigoProfesor
INNER JOIN asignaturas ON docencia.nombreAsignatura = asignaturas.nombre
WHERE UPPER(asiganturas.areaConocimiento) != 'CCIA';

-- Consulta 4: nombre y numero de creditos de asignaturas que tienen ayudantes
SELECT nombre, numCreditos
FROM asignaturas
INNER JOIN docencia ON docencia.nombreAsignatura = asignatura.nombre
WHERE docencia.

-- Consulta 5: nombre y numero de creditos que no tienen profesores del departamento de informatica
SELECT a.nombre, numCreditos
FROM asignaturas AS a
INNER JOIN docencia ON docencia.nombreAsignatura = a.nombre
WHERE docencia.codigoProfesor NOT IN (
	SELECT codigo
	FROM profesores
	WHERE UPPPER(departamento) = 'INFORMATICA'
);

/*
 * Consulta 6: nombre y creditos de todas las asignaturas y en caso que tengan algun profesor,
 * obtener tambien el codigo y nombre de los profesores que las imparten
 */
SELECT a.nombre, numCreditos
FROM asignaturas AS a
LEFT JOIN docencia ON docencia.nombreAsignatura = a.nombre
LEFT JOIN profesores ON profesores.codigoProfesor = docencia.codigo;

/*
 *Consulta 7: codigo y nombre de profesores, y en caso de tener docencia asignada, obtener
 *el nombre y el numero de creditos de las asignaturas que imparten
 */

-- Consulta 8: asignaturas con el menor numero de creditos
SELECT *
FROM asignaturas
WHERE numCreditos = (
	SELECT min(numCreditos)
	FROM asignaturas
);

/*
 * Consulta 9: Para cada asignatura el nombre, creditos, num profesores titulares o catedraticos
 * que la imparten siempre y cuando se trate de mas de un profesor o catedratico
 */
SELECT a.nombre, a.numCreditos, COUNT(p.codigo)
FROM asignaturas AS a
JOIN docencia AS d ON a.nombre = d.codigoAsignatura
JOIN profesores AS p ON d.codigoProfesor = p.codigo
WHERE UPPER(p.categoria) = 'C' 
OR UPPER(p.categoria) = 'T'
GROUP BY a.nombre, a.numCreditos
HAVING COUNT(p.codigo) > 1;
