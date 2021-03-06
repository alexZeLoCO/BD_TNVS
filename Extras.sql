-- Consulta 1: Cuántos pc tienen un precio superior a 1000
SELECT COUNT(*)
FROM pc
WHERE pc.precio > 1000;

-- Consulta 2: Mostrar identifiadores de discos con los pc que los incorporan
SELECT disco, COUNT(pcid)
FROM pc
WHERE pc.disco IS NOT NULL
GROUP BY disco;

-- Consulta 3: Mostrar precio promedio de los pc que tengan la gpu 'ati001'
SELECT AVG(precio)
FROM PC
WHERE tgrafica = 'ati001';

-- Consulta 4: Mostrar precio promedio de los pc que tengan la gpu 'ati*'
SELECT AVG(precio)
FROM PC
LEFT JOIN tgrafica ON pc.tgrafica = tgrafica.tgraf_id
WHERE tgrafica.tgraf_fabricante = 'ati';

-- Consulta 5: Mostrar para cada fabricante de disco, la capacidad mínima y máxima que fabrican
SELECT disco_fabricante, MIN(disco_capacidad), MAX(disco_capacidad)
FROM disco
GROUP BY disco_fabricante;

-- Consulta 6: Mostar para cada combinación mem+cpu cuántos discos hay montados en los pc 
SELECT memoria, cpu, COUNT(disco)
FROM pc
GROUP BY memoria, cpu;

-- Consulta 7: Mostrar cuántos fabricantes de discos son barajados para montar ordenadores que tengan cpu de intel
SELECT COUNT(DISTINCT disco_fabricante)
FROM disco
INNER JOIN pc ON disco.disco_id = pc.disco
INNER JOIN cpu ON pc.cpu = cpu.cpu_id
WHERE cpu.cpu_fabricante = 'intel'
GROUP BY disco_fabricante;

-- Consulta 8: Mostar el pcid, el tipo de cpu y el precio de los 2 ordenadores más caros. Usar limit
SELECT 	pcid, cpu_tipo, precio
FROM pc
JOIN cpu ON pc.cpu = cpu.cpu_id
ORDER BY precio DESC
LIMIT 2;

-- Consulta 9: Mostrar los tipos de memoria más utilizados.
SELECT mem_tipo, COUNT(pc.pcid)
FROM pc
JOIN memoria ON memoria.mem_id = pc.memoria
GROUP BY mem_tipo
ORDER BY count(pc.pcid) DESC;

-- Cosulta 10: Mostar a los fabricantes de cpu que fabrican más de un tipo de cpu. Indicando cuántos tipos fabrican.
SELECT cpu_fabricante, COUNT(cpu_tipo)
FROM cpu
GROUP BY cpu_fabricante
HAVING COUNT(cpu_tipo) > 1;

