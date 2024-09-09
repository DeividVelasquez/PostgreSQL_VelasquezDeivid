create table Persona(
	id serial,
	nombre varchar(225),
	apellido varchar(225),
	municipio_nacimiento varchar(225),
	municipio_domicilio varchar(225),
	primary key (id)
);

create table Region(
    id SERIAL primary key not null,
    region varchar(250),
    departamento varchar(250),
    codigo_departamento varchar(250),
    municipio varchar(250),
    codigo_municipio varchar(250)
);

-- Ejercicio 1

create view vista_regiones_departamentos as
select r.region, r.departamento, coalesce(dc.cantidad_municipios, 0) as cantidad_municipios
from Region r
left join (select departamento, COUNT(municipio) as cantidad_municipios from Region group by departamento) dc on r.departamento = dc.departamento
group by r.region, r.departamento, dc.cantidad_municipios
order by  r.region, r.departamento;

select * from vista_regiones_departamentos;

-- Ejercicio 2

create view vista_departamentos_municipios as
select departamento,municipio, concat(codigo_departamento, codigo_municipio) as codigo_completo
from Region;

select * from vista_departamentos_municipios;

-- Ejercicio 3

create or replace function actualizar_conteos_municipios() 
returns trigger as $$
begin

    update Region
    set conteo_viven = (
        select count(*)
        from Persona
        where municipio_domicilio = region.codigo_municipio
    )
    where codigo_municipio = old.municipio_domicilio;

    update Region
    set conteo_trabajan = (
        select count(*)
        from Persona
        where municipio_nacimiento = region.codigo_municipio
    )
    where codigo_municipio = old.municipio_nacimiento;

    return new;
end;
$$ language plpgsql;



create trigger trigger_actualizar_conteos
after insert or update or delete on Persona
for each row
execute function actualizar_conteos_municipios();

-- Ejercicio 4

drop view if exists vista_departamentos_municipios;

create view vista_departamentos_municipios as
select departamento, municipio, concat(codigo_departamento, codigo_municipio) as codigo_completo, r.conteo_viven, r.conteo_trabajan
from region r;

select * from vista_departamentos_municipios;
















