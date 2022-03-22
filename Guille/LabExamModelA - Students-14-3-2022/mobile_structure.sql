\c template1
drop database mobile;
create database mobile;
\c mobile

create table mobile (
	id integer unique primary key,
	name varchar(20)
);

create table component(
    id integer unique primary key,
	name varchar(20)
);

create table mobilecomponent(
    id_mobile integer,
	id_component integer,
	primary key(id_mobile, id_component),
	foreign key (id_mobile) references mobile(id),
	foreign key (id_component) references component(id)
);

create table material(
    id integer unique primary key,
	name varchar(20)
);

create table componentmaterial(
    id_component integer,
	id_material integer,
	primary key(id_component, id_material),
	foreign key (id_component) references component(id),
	foreign key (id_material) references material(id)
);

create table origin(
    id integer unique primary key,
	location varchar(20)
);

create table materialorigin(
	id_material integer,
	id_origin integer,
	primary key(id_material, id_origin),
	foreign key (id_material) references material(id),
	foreign key (id_origin) references origin(id)
);