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

END;

$$ language plpgsql;