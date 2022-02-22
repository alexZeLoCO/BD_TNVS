/* 
 *Consula 1: Codigo y edificio de aulas
 * con menos de 100 puestos y menos de 100 nºs ?*/
SELECT codigo, edificio
FROM aulas
WHERE numero<160 AND numeroPuestos<100;

/* Consulta 1: Forma con EXCEPT */
SELECT codigo, edificio
FROM aulas
WHERE numero<160
EXCEPT 
SELECT codigo, edificio
FROM aulas
WHERE numeroPuestos>100;

/* 
 *Consulta 2: Nombres y apellidos de estudiantes
 * Cuyos nombres no acaben por A
 * Ordenar alfabeticamente en función del nombre y apellido.
 */
SELECT nombre, apellido
FROM estudiantes
WHERE LOWER(nombre) NOT LIKE '%a'
ORDER BY nombre, apellido;

/* Cosulta 2: Forma con CONCAT */
SELECT CONCAT(nombre, ' ', apellido)
FROM estudiantes
WHERE LOWER(nombre) NOT LIKE '%a'
ORDER BY nombre, apellido;

/* 
 *Consulta 3: Obtener estudiantes cuyas especialidades
 * sean Aprendizaje Automatico ó Metaheurísticas.
 */
SELECT nombre, apellido
FROM estudiantes
WHERE LOWER(nombreespecialidad) LIKE 'aprendizaje automatico'
OR LOWER(nombreespecialidad) LIKE 'metaheurísticas';

/* Cosulta 3: Forma UNION */
SELECT nombre, apellido
FROM estudiantes
WHERE LOWER(nombreespecialidad) LIKE 'aprendizaje automatico'
UNION
SELECT nombre, apellido
FROM estudiantes
WHERE LOWER(nombreespecialidad) LIKE 'metaheurísticas';

/* 
 *Consulta 4: Obtener nombre y créditos de las asignaturas que
 * no no tengan nigún alumno matriculado
 */
SELECT nombre, numcreditos
FROM asignaturas
WHERE nombre NOT IN (
SELECT nombreAsignatura
FROM matricula);

/* Consulta 4: Forma JOIN */
SELECT nombre, numcreditos
FROM asignaturas LEFT JOIN matricula
ON asignatura.nombre = matricula.nombreAsignatura
WHERE nmatestudiante IS NULL;

/* 
 * Consulta 5: Nombre y número de créditos de asignaturas
 * de tercero que no tengan ningún alumno matriculado
 */
SELECT nombre, numcreditos
FROM asignaturas
WHERE curso = 3
AND nombre NOT IN (
SELECT nombreAsignatura
FROM matricula);

/* Consulta 5: Forma EXCEPT */
SELECT nombre, numcreditos
FROM asignaturas
WHERE curso = 3
EXCEPT
SELECT nombre, numcreditos
FROM asignaturas
WHERE nombre IN (
SELECT nombreAsignatura
FROM matricula);

/* 
 *Consulta 6: Obtener aulas vacías, que no imparten asignaturas
 */
SELECT *
FROM aulas
LEFT JOIN asignaturas
ON asignaturas.codigoAula = aulas.codigo
WHERE asignaturas.codigoAula IS NULL;

/* Consulta 6: Formato sin columnas vacías. */
SELECT aulas.*
FROM aulas
LEFT JOIN asignaturas
ON asignaturas.codigoAula = aulas.codigo
WHERE asignaturas.codigoAula IS NULL;

/* 
 * Consulta 7: Obtener asignaturas del aula de CCIA
 * que se imparen en el edificio 6.
 */
SELECT nombre
FROM aulas JOIN asignaturas
ON asignaturas.codigoAula = aulas.codigo
WHERE areaConocimiento LIKE 'CCIA'
AND edificio LIKE 'Edificio 6';

/* Consulta 7: Formato con EXCEPT */
SELECT nombre
FROM aulas JOIN asignaturas
ON asignaturas.codigoAula = aulas.codigo
WHERE areaConocimiento LIKE 'CCIA'
EXCEPT
SELECT nombre
FROM aulas JOIN asignaturas
ON asignaturas.codigoAula = aulas.codigo
WHERE edificio NOT LIKE 'Edificio 6';

/* 
 * Consulta 8: Obtener para cada asignatura del edificio 6
 * el código y el número de puestos junto con el nombre y el área
 * de conocimiento de las asignaturas de segundo curso que
 * se imparten en ella.
 */
SELECT aulas.codigo, numeroPuestos, nombre, areaConocimiento
FROM asignaturas JOIN aulas
ON asignaturas.codigoAula = aulas.codigo
WHERE edificio LIKE 'Edificio 6'
AND asignaturas.curso = 2;

/* Consulta 8: Formato EXCEPT */
SELECT aulas.codigo, numeroPuestos, nombre, areaConocimiento
FROM asignaturas JOIN aulas
ON asignaturas.codigoAula = aulas.codigo
WHERE edificio LIKE 'Edificio 6'
EXCEPT
SELECT aulas.codigo, numeroPuestos, nombre, areaConocimiento
FROM asignaturas JOIN aulas
ON asignaturas.codigoAula = aulas.codigo
WHERE asignaturas.curso != 2;

/* 
 * Consulta 9: Obtener para cada asignatura su nombre y el
 * número de créditos y número de matrícula de los estudiantes
 * matriculados en ellas sólo para las asignaturas que tienen
 * estudiantes matriculados.
 */
SELECT nombre, numcreditos, nmatestudiante
FROM asignaturas JOIN matricula
ON asignaturas.nombre = matricula.nombreAsignatura;

/* 
 * Consulta 10: Obtener para cada asignatura el nombre, el
 * número de créditos y el número de matricula de los estudiantes.
 */
SELECT nombre, numcreditos, matricula.nmatestudiante
FROM asignaturas LEFT JOIN matricula
ON asignaturas.nombre = matricula.nombreAsignatura; 

/*
 * Consulta 11: Obtener para cada asignatura el nombre, el 
 * número de créditos, el número de matrícula y el número de
 * estudiantes matriculados en ella. Sólo para asignaturas con 
 * estudiantes matriculados.
 */
SELECT A.nombre, A.numcreditos, M.nmatestudiante, E.nombre
FROM asignaturas AS A
JOIN matricula AS M
ON A.nombre = M.nombreAsignatura
JOIN estudiantes AS E
ON M.nmatestudiante = E.nmat;

/*
 * Consulta 12: Obtener para cada asignatura nombre,
 * número de créditos, el número de matrícula y el número de
 * estudiantes matriculados en ella.
 */
SELECT A.nombre, A.numcreditos, M.nmatestudiante, E.nombre
FROM asignaturas AS A
LEFT JOIN matricula AS M
ON A.nombre = M.nombreAsignatura
LEFT JOIN estudiantes AS E
ON M.nmatestudiante = E.nmat;