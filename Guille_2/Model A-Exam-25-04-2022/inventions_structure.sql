
create database inventions;
\c inventions

create table invention (
     id_invention integer not null primary key,
	 invention_name varchar(50) not null,
	 invention_year integer not null,
	 description varchar(100) not null,
	 use varchar(100) not null
);

create table inventor (
	id_inventor integer not null primary key,
	inventor_name varchar(50) not null,
	birth_place varchar(50) not null,
	birth_year integer not null,
	occupation varchar(100) not null
);

create table inventioninventor(
	id_invention integer not null,
	id_inventor integer not null,
	primary key (id_invention, id_inventor),
	foreign key (id_invention) references invention(id_invention),
	foreign key (id_inventor) references inventor(id_inventor)
);

create table workplace (
	id_workplace integer not null primary key,
	workplace_name varchar(100) not null,
	workplace_city varchar(50) not null,
	workplace_country varchar(50) not null
);

create table inventorworkplace(
	id_inventor integer not null,
	id_workplace integer not null,
	primary key(id_inventor, id_workplace),
	foreign key (id_inventor) references inventor(id_inventor),
	foreign key (id_workplace) references workplace(id_workplace)
);

create table formation(
	id_formation integer not null primary key,
	formation_name varchar(100) not null,
	centre_name varchar(100),
	tutor_name varchar(50) ,
	formation_city varchar(50) not null,
	formation_country varchar(50) not null
);

create table inventorformation(
	id_inventor integer not null,
	id_formation integer not null,
	primary key(id_inventor, id_formation),
	foreign key (id_inventor) references inventor(id_inventor),
	foreign key (id_formation) references formation(id_formation)
);