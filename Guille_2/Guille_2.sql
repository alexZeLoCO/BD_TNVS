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
RETURN NULL;
END IF;

INSERT INTO operation_inventor_log VALUES (LEFT(tg_op, 1), now(), new.inventor_name, new.occupation);
RETURN NULL;
END;
$$ language plpgsql;


CREATE TRIGGER tg_operation_inventor_log AFTER
INSERT
OR
DELETE
OR
UPDATE ON inventor
FOR EACH ROW EXECUTE function operation_log();