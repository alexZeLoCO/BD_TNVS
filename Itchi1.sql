/* 
 * pcid, cpu_tipo, mem_tipo y precio de los PC
 * que tengan cpu Core2duo y precio inferior a 1050
 * ó capacidad de disco inferior a 400
 */
SELECT pcid, cpu_tipo, mem_tipo, precio
FROM pc LEFT JOIN cpu ON pc.cpu = cpu.cpu_id
LEFT JOIN memoria ON pc.memoria = memoria.mem_id
LEFT JOIN disco ON pc.disco = disco.disco_id
WHERE LOWER(cpu_tipo) LIKE 'core2duo' AND
precio < 1050 OR disco_capacidad < 400;

/*
 * Misma consulta que antes, pero usando un UNION
 */
SELECT pcid, cpu_tipo, mem_tipo, precio
FROM pc LEFT JOIN cpu ON pc.cpu = cpu.cpu_id
LEFT JOIN memoria ON pc.memoria = memoria.mem_id
WHERE LOWER(cpu_tipo) LIKE 'core2duo' AND
precio < 1050
UNION
SELECT pcid, cpu_tipo, mem_tipo, precio
FROM pc LEFT JOIN cpu ON pc.cpu = cpu.cpu_id
LEFT JOIN memoria ON pc.memoria = memoria.mem_id
LEFT JOIN disco ON pc.disco = disco.disco_id
WHERE disco_capacidad < 400;

/*
 * Ver todas las características de ordenadores
 * completos que tengan memoria del tipo 'DDR3 SDRAM'
 * ó que sólo le falte la memoria.
 * Ordenar de menor a mayor en función del precio.
 */
/* Opción 1 */
SELECT pcid, mem_tipo, mem_capacidad, cpu_fabricante, cpu_tipo, disco_fabricante, disco_capacidad, tgraf_fabricante, precio
FROM pc INNER JOIN cpu ON pc.cpu = cpu.cpu_id
INNER JOIN disco ON pc.disco = disco.disco_id
INNER JOIN tgrafica ON pc.tgrafica = tgrafica.tgraf_id
INNER JOIN memoria ON pc.memoria = memoria.mem_id
WHERE UPPER(mem_tipo) LIKE 'DDR3SDRAM'
UNION
SELECT pcid, mem_tipo, mem_capacidad, cpu_fabricante, cpu_tipo, disco_fabricante, disco_capacidad, tgraf_fabricante, precio
FROM pc LEFT JOIN memoria ON pc.memoria = memoria.mem_id
INNER JOIN cpu ON pc.cpu = cpu.cpu_id
INNER JOIN disco ON pc.disco = disco.disco_id
INNER JOIN tgrafica ON pc.tgrafica = tgrafica.tgraf_id
WHERE mem_id IS NULL;

/* Opción 2 */
SELECT pcid, mem_tipo, mem_capacidad, cpu_fabricante, cpu_tipo, disco_fabricante, disco_capacidad, tgraf_fabricante, precio
FROM pc INNER JOIN cpu ON pc.cpu = cpu.cpu_id
INNER JOIN disco ON pc.disco = disco.disco_id
INNER JOIN tgrafica ON pc.tgrafica = tgrafica.tgraf_id
LEFT JOIN memoria ON pc.memoria = memoria.mem_id
WHERE UPPER(mem_tipo) LIKE 'DDR3SDRAM' OR
mem_id IS NULL;

/* Opción Except */
SELECT pcid, mem_tipo, mem_capacidad, cpu_fabricante, cpu_tipo, disco_fabricante, disco_capacidad, tgraf_fabricante, precio
FROM pc INNER JOIN cpu ON pc.cpu = cpu.cpu_id
INNER JOIN disco ON pc.disco = disco.disco_id
INNER JOIN tgrafica ON pc.tgrafica = tgrafica.tgraf_id
LEFT JOIN memoria ON pc.memoria = memoria.mem_id
EXCEPT
SELECT pcid, mem_tipo, mem_capacidad, cpu_fabricante, cpu_tipo, disco_fabricante, disco_capacidad, tgraf_fabricante, precio
FROM pc INNER JOIN cpu ON pc.cpu = cpu.cpu_id
INNER JOIN disco ON pc.disco = disco.disco_id
INNER JOIN tgrafica ON pc.tgrafica = tgrafica.tgraf_id
LEFT JOIN memoria ON pc.memoria = memoria.mem_id
WHERE UPPER(mem_tipo) NOT LIKE 'DDR3SDRAM' AND 
mem_id IS NOT NULL;
