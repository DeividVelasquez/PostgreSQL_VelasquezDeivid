-- #######################################
-- ########### Procedimiento #############
-- #######################################

-- 1. Procedimiento para crear un nuevo alumno
create or replace procedure crear_alumno(
    p_nif varchar(9),
    p_nombre varchar(25),
    p_apellido1 varchar(50),
    p_apellido2 varchar(50),
    p_ciudad varchar(25),
    p_direccion varchar(50),
    p_telefono varchar(9),
    p_fecha_nacimiento date,
    p_sexo sexo
)
language plpgsql
as $$
begin
    insert into alumno(nif, nombre, apellido1, apellido2, ciudad, direccion, telefono, fecha_nacimiento, sexo)
    values (p_nif, p_nombre, p_apellido1, p_apellido2, p_ciudad, p_direccion, p_telefono, p_fecha_nacimiento, p_sexo);
end $$;

-- 2. Procedimiento para actualizar el teléfono de un alumno
create or replace procedure actualizar_telefono_alumno(
    p_id_alumno int,
    p_telefono varchar(9)
)
language plpgsql
as $$
begin
    update alumno
    set telefono = p_telefono
    where id = p_id_alumno;
end $$;

-- 3. Procedimiento para eliminar un alumno por su ID
create or replace procedure eliminar_alumno(
    p_id_alumno int
)
language plpgsql
as $$
begin
    delete from alumno
    where id = p_id_alumno;
end $$;

-- 4. Procedimiento para buscar un alumno por su NIF
create or replace procedure buscar_alumno_por_nif(
    p_nif varchar(9)
)
language plpgsql
as $$
begin
    select * from alumno
    where nif = p_nif;
end $$;

-- 5. Procedimiento para crear un nuevo profesor
create or replace procedure crear_profesor(
    p_nif varchar(25),
    p_nombre varchar(25),
    p_apellido1 varchar(50),
    p_apellido2 varchar(50),
    p_ciudad varchar(25),
    p_direccion varchar(50),
    p_telefono varchar(9),
    p_fecha_nacimiento date,
    p_sexo sexo,
    p_id_departamento int
)
language plpgsql
as $$
begin
    insert into profesor(nif, nombre, apellido1, apellido2, ciudad, direccion, telefono, fecha_nacimiento, sexo, id_departamento)
    values (p_nif, p_nombre, p_apellido1, p_apellido2, p_ciudad, p_direccion, p_telefono, p_fecha_nacimiento, p_sexo, p_id_departamento);
end $$;

-- 6. Procedimiento para actualizar el departamento de un profesor
create or replace procedure actualizar_departamento_profesor(
    p_id_profesor int,
    p_id_departamento int
)
language plpgsql
as $$
begin
    update profesor
    set id_departamento = p_id_departamento
    where id_profesor = p_id_profesor;
end $$;

-- 7. Procedimiento para eliminar un profesor por su ID
create or replace procedure eliminar_profesor(
    p_id_profesor int
)
language plpgsql
as $$
begin
    delete from profesor
    where id_profesor = p_id_profesor;
end $$;

-- 8. Procedimiento para buscar un profesor por su NIF
create or replace procedure buscar_profesor_por_nif(
    p_nif varchar(25)
)
language plpgsql
as $$
begin
    select * from profesor
    where nif = p_nif;
end $$;

-- 9. Procedimiento para crear una nueva asignatura
create or replace procedure crear_asignatura(
    p_nombre varchar(100),
    p_creditos float,
    p_tipo tipo_asignatura3,
    p_curso smallint,
    p_cuatrimestre smallint,
    p_id_profesor int,
    p_id_grado int
)
language plpgsql
as $$
begin
    insert into asignatura(nombre, creditos, tipo, curso, cuatrimestre, id_profesor, id_grado)
    values (p_nombre, p_creditos, p_tipo, p_curso, p_cuatrimestre, p_id_profesor, p_id_grado);
end $$;

-- 10. Procedimiento para eliminar una asignatura por su ID
create or replace procedure eliminar_asignatura(
    p_id_asignatura int
)
language plpgsql
as $$
begin
    delete from asignatura
    where id = p_id_asignatura;
end $$;
