-- 1 Componentes con Magnesio o Galio en orden descendente
SELECT componente.nombre
FROM componente
JOIN componenteMaterial ON componente.id=componenteMaterial.id_componente
JOIN material ON componenteMaterial.id_material=material.id
WHERE lower(material.nombre) IN ('magnesio', 'galio')
ORDER BY material.nombre DESC;

-- 2 Mostrar nombre de componentes y cantidad de aquellos que tienen mas de 2 componentes que empiezan por n
SELECT C.nombre, COUNT(m.nombre)
FROM componente AS C
JOIN componenteMaterial AS cm ON c.id=cm.id_componente
JOIN material AS m ON cm.id_material=m.id
WHERE LOWER(m.nombre) LIKE 'n%'
GROUP BY c.nombre
HAVING COUNT(m.nombre) >= 2;

-- 3 Mostrar materiales de origen desconocido
SELECT nombre
FROM material
LEFT JOIN materialOrigen ON material.id=materialOrigen.id_material
WHERE materialOrigen.id_origen IS NULL;

-- 4 Materiales que provengan de 2 sitios diferentes y de Rusia
SELECT material.nombre, material.id
FROM material
JOIN materialOrigen ON material.id=materialOrigen.id_material
JOIN origen ON materialOrigen.id_origen=origen.id
WHERE UPPER(origen.lugar)='RUSIA'
UNION
SELECT material.nombre, material.id
FROM material
JOIN materialOrigen ON material.id=materialOrigen.id_material
GROUP BY (material.id)
HAVING COUNT(materialOrigen.id_material)=2;

-- 5 Nombre de todos aquellos componentes que contengan el material niquel
SELECT componente.nombre
FROM componente
JOIN componenteMaterial ON componente.id=componenteMaterial.id_componente
JOIN material ON componenteMaterial.id_material=material.id
WHERE lower(material.nombre)='niquel';
