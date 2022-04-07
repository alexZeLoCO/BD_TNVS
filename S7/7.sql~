-- 1
CREATE OR REPLACE function presenta_insercion () returns trigger as $$
begin
if tg_op = 'INSERT' then
	raise notice 'Se ha realizado una insercion';
	return new;
end if;
return null;
end;
$$ language plpgsql;

create trigger tg_presenta_insercion
after insert on estudiante_grado_modulo
for each row execute procedure presenta_insercion();

-- 2
create or replace function presenta_cosas ()  returns trigger as $$
begin
if tg_op = 'INSERT' then
	raise notice 'Se ha realizado una insercion';
	return new;
elsif tg_op = 'DELETE' then
	raise notice 'Se ha realizado un borrado';
elsif tg_op = 'UPDATE' then
	raise notice 'Se ha realizado una actualizacion';	
end if;
return null;
end;
$$ language plpgsql;

create trigger tg_presenta_cosas
after insert or delete or update on estudiante_grado_modulo
for each row execute procedure presenta_cosas();

-- 3
ALTER TABLE estudiante_grado_modulo ADD COLUMN nota int DEFAULT 0;

ALTER TABLE estudiante_grado_modulo ADD COLUMN grado varchar(10) DEFAULT 'indefinido';

-- 4
CREATE TABLE operacion_notas_log (
	operacion char(1),
	hora timestamp,
	estudianteId int,
	moduloId int,
	nota int
);

create or replace function operacion_log () returns trigger as $$
begin
	if tg_op = 'UPDATE' then
		INSERT INTO operacion_notas_log VALUES ('U', now(), estudiante_id, new.modulo_id, new.nota);
		return new;
	end if;
	return null;
end;
$$ language plpgsql;

--7
create or  replace function operacion_log() returns trigger as $$
begin
	if tg_op = 'UPDATE' then
		INSERT INTO operacion_notas_log VALUES ('U', now(), estudiante_id, new.modulo_id, new.nota);
		return new;
	elsif tg_op = 'INSERT' then
		INSERT INTO operacion_notas_log VALUES ('I', now(), estudiante_id, new.modulo_id, new.nota);
		return new;
	elsif tg_op = 'DELETE' then
		INSERT INTO operacion_notas_log VALUES ('D', now(), estudiante_id, new.modulo_id, new.nota);
		return new;
	end if;
	return null;
end;
$$ language plpgsql;

-- 9
CREATE TABLE operacion_calificacion_log (
	operacion char(1),
	stamp timestamp,
	estudianteid int,
	moduloid int,
	nota int,
	calificacion varchar(10)
);

-- FIXME :(
create or  replace function operacion_log() returns trigger as $$
declare
	calificacion varchar(10);
begin
	if new.nota<4 then 
		calificacion = 'Pobre';
	elsif new.nota<5 then
		calificacion = 'No buena';
	elsif new.nota<7 then
		calificacion = 'Buena';
	elsif new.nota<9 then
		calificacion = 'Muy buena';
	else
		calificacion = 'Excelente';
	end if;

	if tg_op = 'UPADTE' OR tg_op = 'INSERT' then
		INSERT INTO operacion_calificacion_log VALUES (LEFT(tg_op, 1), now(), new.estudiante_id, new.modulo_id, new.nota, calificacion);
		return new;
		/*
	if tg_op = 'UPDATE' then
		INSERT INTO operacion_calificacion_log VALUES ('U', now(), new.estudiante_id, new.modulo_id, new.nota, calificacion);
		return new;
	elsif tg_op = 'INSERT' then
		INSERT INTO operacion_calificacion_log VALUES ('I', now(), new.estudiante_id, new.modulo_id, new.nota, calificacion);
		return new;
*/
	end if;
	return null;
end;
$$ language plpgsql;


