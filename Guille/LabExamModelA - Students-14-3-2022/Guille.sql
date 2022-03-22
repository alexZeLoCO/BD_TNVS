-- 1 Create new table
CREATE TABLE country (
	id INTEGER UNIQUE PRIMARY KEY,
	name VARCHAR(20),
       	id_mobile INTEGER REFERENCES mobile(id)
);

-- 2 Rename 'name' column to 'countryName'
ALTER TABLE country RENAME COLUMN name TO countryName;

-- 3 Add new column 'numberOffices' to store the number of offices in the country
ALTER TABLE country ADD numberOffices INTEGER;

-- 4 Modify the table to check that the number of offices is positive and lower than 99
ALTER TABLE country ADD CHECK (numberOffices BETWEEN 0 AND 99);

-- 5 Remove the column numberOffices
ALTER TABLE country DROP COLUMN numberOffices;

-- 6 Oppo from Dongguan and Fairphone from Netherlands.
INSERT INTO country VALUES (1, 'Dongguan', 5);
INSERT INTO country VALUES (2, 'Netherlands', 2);

-- 7 Display name of mobiles and country where they are manufactured
SELECT name, countryname
FROM mobile
LEFT JOIN country ON mobile.id=country.id_mobile;

-- 8 Display only once the name of the components which do not have 'magnesium' or 'nickel'
SELECT DISTINCT component.name
FROM component
JOIN componentMaterial on component.id=componentMaterial.id_component
JOIN material ON componentMaterial.id_material=material.id 
WHERE material.name != 'magnesium'
AND material.name != 'nickel'
ORDER BY component.name ASC;

-- 9 Display the name of components made of at least one material where the first letter is 'g'
SELECT component.name, count(material.name) AS number_Materials
FROM component
JOIN componentMaterial ON component.id=componentMaterial.id_component
JOIN material ON componentMaterial.id_material=material.id
WHERE LOWER(material.name) LIKE 'g%'
GROUP BY component.name;

-- 10 Display the name of the materials whose origin is known and are not from Argentina
SELECT name
FROM material
INNER JOIN materialOrigin ON material.id=materialOrigin.id_material
EXCEPT
SELECT name
FROM material
INNER JOIN materialOrigin ON material.id=materialOrigin.id_material
INNER JOIN origin ON materialOrigin.id_origin=origin.id
WHERE LOWER(origin.location)='argentina';

-- 11 Display the name of the materials that come from two locations and those with unknown origin
SELECT id, name
FROM material
LEFT JOIN materialOrigin ON material.id=materialOrigin.id_material
WHERE materialOrigin.id_origin IS NULL
UNION
SELECT id, name
FROM material
JOIN materialOrigin ON material.id=materialOrigin.id_material
GROUP BY material.id
HAVING (COUNT(materialOrigin.id_Material)=2);

-- 12 Display the id and name of mobiles that have more than 4 components
SELECT id, name, COUNT(mobileComponent.id_component)
FROM mobile
JOIN mobileComponent ON mobile.id=mobileComponent.id_mobile
GROUP BY id_mobile
HAVING (COUNT(id_component)>4);
