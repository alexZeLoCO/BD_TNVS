-- 1

CREATE OR REPLACE FUNCTION getFirstInvention () RETURNS TABLE (invention_name VARCHAR(50),
                                                                              invention_year INTEGER, _description VARCHAR(100),
                                                                                                                   inventor_name VARCHAR(50)) AS $$ BEGIN RETURN QUERY
SELECT invention.invention_name,
       invention.invention_year,
       invention.description,
       inventor.inventor_name
FROM invention
INNER JOIN inventioninventor USING (id_invention)
INNER JOIN inventor USING (id_inventor)
WHERE invention.invention_year =
(SELECT min(i.invention_year)
FROM invention i);

END;

$$ language plpgsql;

-- 2

CREATE OR REPLACE FUNCTION getInventorsCentre (centre VARCHAR(50)) RETURNS TABLE (inventor_name VARCHAR(50),
                                                                                                occupation VARCHAR(100)) AS $$

BEGIN

RETURN QUERY SELECT inventor.inventor_name,
inventor.occupation
FROM inventor
INNER JOIN inventorformation USING (id_inventor)
INNER JOIN formation USING (id_formation)
WHERE UPPER(formation.centre_name) = UPPER(centre);

IF NOT FOUND
    THEN RAISE EXCEPTION 'There is no inventor from %.', $1;
END IF;

END;

$$ language plpgsql;

-- 3

CREATE OR REPLACE PROCEDURE misco (year1 INTEGER, year2 INTEGER) AS $$
DECLARE
    r RECORD;
BEGIN
for r in
SELECT invention.invention_name,
       invention.invention_year,
       inventor.inventor_name
FROM invention
INNER JOIN inventioninventor USING (id_invention)
INNER JOIN inventor USING (id_inventor)
WHERE invention.invention_year BETWEEN year1 AND year2

LOOP
    RAISE NOTICE '(%, %, %)', r.invention_name, r.invention_year, r.inventor_name;
END LOOP;

END;

$$ language plpgsql;

-- 4

CREATE TABLE operation_inventor_log (operation VARCHAR(1),
                                               stamp TIMESTAMP,
                                                     inventor_name VARCHAR(50),
                                                                   occupation VARCHAR(100));

-- 5

CREATE OR REPLACE FUNCTION operation_log () RETURNS TRIGGER AS $$

BEGIN

IF tg_op = 'DELETE'
THEN
INSERT INTO operation_inventor_log VALUES (LEFT(tg_op, 1), now(), old.inventor_name, old.occupation);
RETURN new;
END IF;

INSERT INTO operation_inventor_log VALUES (LEFT(tg_op, 1), now(), new.inventor_name, new.occupation);
RETURN new;
END;
$$ language plpgsql;


CREATE TRIGGER tg_operation_inventor_log AFTER
INSERT
OR
DELETE
OR
UPDATE ON inventor
FOR EACH ROW EXECUTE function operation_log();

-- 7

SELECT id_inventor,
       count(id_invention)
FROM invention
JOIN inventioninventor A USING (id_invention)
WHERE invention_year >= 1945
GROUP BY (id_inventor)
HAVING count(id_invention) =
    (SELECT count(id_invention)
     FROM invention
     JOIN inventioninventor USING (id_invention)
     WHERE id_inventor = A.id_inventor );


SELECT *
FROM inventor
WHERE id_inventor NOT IN
        (SELECT id_inventor
         FROM inventor
         EXCEPT SELECT id_inventor
         FROM inventor
         WHERE id_inventor IN
                 (SELECT id_inventor
                  FROM inventor
                  EXCEPT SELECT id_inventor
                  FROM inventioninventor
                  JOIN invention USING (id_invention)
                  WHERE invention_year < 1945 ));


SELECT id_inventor,
       inventor_name,
       birth_place,
       birth_year,
       occupation
FROM (inventor
      JOIN inventioninventor USING (id_inventor)
      JOIN invention USING (id_invention)) AS A
WHERE NOT EXISTS -- Si la consulta siguiente es null se incluye la entrada

        (SELECT id_invention
         FROM (invention
               JOIN inventioninventor USING (id_invention)
               JOIN inventor USING (id_inventor)) AS B
         WHERE A.id_inventor = B.id_inventor -- los inventos del actual (A)

         EXCEPT SELECT id_invention
         FROM (invention
               JOIN inventioninventor USING (id_invention)
               JOIN inventor USING (id_inventor)) AS C
         WHERE invention_year> 1945 -- filtrar los inventos del actual (A) que son despues del '45

             AND A.id_inventor = C.id_inventor );