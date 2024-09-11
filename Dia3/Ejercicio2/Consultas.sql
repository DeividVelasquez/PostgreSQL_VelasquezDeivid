-- ###################################
-- ########### Consultas #############
-- ###################################


-- 1. devuelve un listado con el primer apellido, segundo apellido y el nombre de
-- todos los alumnos. el listado deberá estar ordenado alfabéticamente de
-- menor a mayor por el primer apellido, segundo apellido y nombre.

select apellido1, apellido2, nombre
from alumno
order by apellido1, apellido2, nombre;

-- 2. averigua el nombre y los dos apellidos de los alumnos que no han dado de
-- alta su número de teléfono en la base de datos.

select nombre, apellido1, apellido2
from alumno
where telefono is null;

-- 3. devuelve el listado de los alumnos que nacieron en 1999.

select nombre, apellido1, apellido2
from alumno
where extract(year from fecha_nacimiento) = 1999;

-- 4. devuelve el listado de profesores que no han dado de alta su número de
-- teléfono en la base de datos y además su nif termina en k.

select nombre, apellido1, apellido2
from profesor
where telefono is null and nif like '%k';

-- 5. devuelve el listado de las asignaturas que se imparten en el primer
-- cuatrimestre, en el tercer curso del grado que tiene el identificador 7.

select nombre
from asignatura
where cuatrimestre = 1 and curso = 3 and id_grado = 7;

-- ##############################################################
-- ######## consultas multitabla (composición interna) ##########
-- ##############################################################

-- 1. devuelve un listado con los datos de todas las alumnas que se han
-- matriculado alguna vez en el grado en ingeniería informática (plan 2015).

select distinct a.*
from alumno a
join alumno_se_matricula_asignatura am on a.id = am.id_alumno
join asignatura asig on am.id_asignatura = asig.id
join grado g on asig.id_grado = g.id
where g.nombre = 'grado en ingeniería informática (plan 2015)' and a.sexo = 'M';

-- 2. devuelve un listado con todas las asignaturas ofertadas en el grado en
-- ingeniería informática (plan 2015).

select asig.nombre
from asignatura asig
join grado g on asig.id_grado = g.id
where g.nombre = 'grado en ingeniería informática (plan 2015)';

-- 3. devuelve un listado de los profesores junto con el nombre del
-- departamento al que están vinculados. el listado debe devolver cuatro
-- columnas, primer apellido, segundo apellido, nombre y nombre del
-- departamento. el resultado estará ordenado alfabéticamente de menor a
-- mayor por los apellidos y el nombre.

select p.apellido1, p.apellido2, p.nombre, d.nombre as nombre_departamento
from profesor p
join departamento d on p.id_departamento = d.id
order by p.apellido1, p.apellido2, p.nombre;

-- 4. devuelve un listado con el nombre de las asignaturas, año de inicio y año de
-- fin del curso escolar del alumno con nif 26902806m.

select asig.nombre, cs.anyo_inicio, cs.anyo_fin
from alumno_se_matricula_asignatura am
join asignatura asig on am.id_asignatura = asig.id
join curso_escolar cs on am.id_curso_escolar = cs.id
join alumno a on am.id_alumno = a.id
where a.nif = '26902806m';

-- 5. devuelve un listado con el nombre de todos los departamentos que tienen
-- profesores que imparten alguna asignatura en el grado en ingeniería
-- informática (plan 2015).

select distinct d.nombre
from departamento d
join profesor p on d.id = p.id_departamento
join asignatura asig on p.id_profesor = asig.id_profesor
join grado g on asig.id_grado = g.id
where g.nombre = 'grado en ingeniería informática (plan 2015)';

-- 6. devuelve un listado con todos los alumnos que se han matriculado en
-- alguna asignatura durante el curso escolar 2018/2019.

select distinct a.*
from alumno a
join alumno_se_matricula_asignatura am on a.id = am.id_alumno
join curso_escolar cs on am.id_curso_escolar = cs.id
where cs.anyo_inicio = 2018 and cs.anyo_fin = 2019;

-- ##############################################################
-- ######## consultas multitabla (composición externa) ##########
-- ##############################################################

-- resuelva todas las consultas utilizando las cláusulas left join y right join.

-- 1. devuelve un listado con los nombres de todos los profesores y los
-- departamentos que tienen vinculados. el listado también debe mostrar
-- aquellos profesores que no tienen ningún departamento asociado. el listado
-- debe devolver cuatro columnas, nombre del departamento, primer apellido,
-- segundo apellido y nombre del profesor. el resultado estará ordenado
-- alfabéticamente de menor a mayor por el nombre del departamento,
---apellidos y el nombre.

select d.nombre as nombre_departamento, p.apellido1, p.apellido2, p.nombre
from profesor p
left join departamento d on p.id_departamento = d.id
order by d.nombre, p.apellido1, p.apellido2, p.nombre;

-- 2. devuelve un listado con los profesores que no están asociados a un
-- departamento.

select p.*
from profesor p
left join departamento d on p.id_departamento = d.id
where d.id is null;

-- 3. devuelve un listado con los departamentos que no tienen profesores
-- asociados.

select d.*
from departamento d
left join profesor p on d.id = p.id_departamento
where p.id_profesor is null;

-- 4. devuelve un listado con los profesores que no imparten ninguna asignatura.

select p.*
from profesor p
left join asignatura a on p.id_profesor = a.id_profesor
where a.id is null;

-- 5. devuelve un listado con las asignaturas que no tienen un profesor asignado.

select a.*
from asignatura a
left join profesor p on a.id_profesor = p.id_profesor
where p.id_profesor is null;

-- 6. devuelve un listado con todos los departamentos que tienen alguna
-- asignatura que no se haya impartido en ningún curso escolar. el resultado
-- debe mostrar el nombre del departamento y el nombre de la asignatura que
-- no se haya impartido nunca.

select distinct d.nombre as nombre_departamento, a.nombre as nombre_asignatura
from departamento d
join profesor p on d.id = p.id_departamento
join asignatura a on p.id_profesor = a.id_profesor
left join alumno_se_matricula_asignatura am on a.id = am.id_asignatura
where am.id_curso_escolar is null;

-- #####################################
-- ######## consultas resumen ##########
-- #####################################
-- 1. devuelve el número total de alumnas que hay.

select count(*) as total_alumnas
from alumno
where sexo = 'M';

-- 2. calcula cuántos alumnos nacieron en 1999.

select count(*) as total_alumnos_1999
from alumno
where extract(year from fecha_nacimiento) = 1999;

-- 3. calcula cuántos profesores hay en cada departamento. el resultado sólo
-- debe mostrar dos columnas, una con el nombre del departamento y otra
-- con el número de profesores que hay en ese departamento. el resultado
-- sólo debe incluir los departamentos que tienen profesores asociados y
-- deberá estar ordenado de mayor a menor por el número de profesores.

select d.nombre as nombre_departamento, count(p.id_profesor) as numero_profesores
from departamento d
join profesor p on d.id = p.id_departamento
group by d.nombre
order by numero_profesores desc;

-- 4. devuelve un listado con todos los departamentos y el número de profesores
-- que hay en cada uno de ellos. tenga en cuenta que pueden existir
-- departamentos que no tienen profesores asociados. estos departamentos
-- también tienen que aparecer en el listado.

select d.nombre as nombre_departamento, count(p.id_profesor) as numero_profesores
from departamento d
left join profesor p on d.id = p.id_departamento
group by d.nombre
order by numero_profesores desc;

-- 5. devuelve un listado con el nombre de todos los grados existentes en la base
-- de datos y el número de asignaturas que tiene cada uno. tenga en cuenta
-- que pueden existir grados que no tienen asignaturas asociadas. estos grados
-- también tienen que aparecer en el listado. el resultado deberá estar
-- ordenado de mayor a menor por el número de asignaturas.

select g.nombre as nombre_grado, count(a.id) as numero_asignaturas
from grado g
left join asignatura a on g.id = a.id_grado
group by g.nombre
order by numero_asignaturas desc;

-- 6. devuelve un listado con el nombre de todos los grados existentes en la base
-- de datos y el número de asignaturas que tiene cada uno, de los grados que
-- tengan más de 40 asignaturas asociadas.

select g.nombre as nombre_grado, count(a.id) as numero_asignaturas
from grado g
join asignatura a on g.id = a.id_grado
group by g.nombre
having count(a.id) > 40
order by numero_asignaturas desc;

-- 7. devuelve un listado que muestre el nombre de los grados y la suma del
-- número total de créditos que hay para cada tipo de asignatura. el resultado
-- debe tener tres columnas: nombre del grado, tipo de asignatura y la suma
-- de los créditos de todas las asignaturas que hay de ese tipo. ordene el
-- resultado de mayor a menor por el número total de crédidos.

select g.nombre as nombre_grado, a.tipo as tipo_asignatura, sum(a.creditos) as suma_creditos
from grado g
join asignatura a on g.id = a.id_grado
group by g.nombre, a.tipo
order by suma_creditos desc;

-- 8. devuelve un listado que muestre cuántos alumnos se han matriculado de
-- alguna asignatura en cada uno de los cursos escolares. el resultado deberá
-- mostrar dos columnas, una columna con el año de inicio del curso escolar y
-- otra con el número de alumnos matriculados.

select cs.anyo_inicio, count(distinct am.id_alumno) as numero_alumnos
from curso_escolar cs
join alumno_se_matricula_asignatura am on cs.id = am.id_curso_escolar
group by cs.anyo_inicio;

-- 9. devuelve un listado con el número de asignaturas que imparte cada
-- profesor. el listado debe tener en cuenta aquellos profesores que no
-- imparten ninguna asignatura. el resultado mostrará cinco columnas: id,
-- nombre, primer apellido, segundo apellido y número de asignaturas. el
-- resultado estará ordenado de mayor a menor por el número de asignaturas.

select p.id_profesor, p.nombre, p.apellido1, p.apellido2, count(a.id) as numero_asignaturas
from profesor p
left join asignatura a on p.id_profesor = a.id_profesor
group by p.id_profesor, p.nombre, p.apellido1, p.apellido2
order by numero_asignaturas desc;

-- ##############################
-- ######## subconsultas ########
-- ##############################

-- 1. devuelve todos los datos del alumno más joven.

select *
from alumno
where fecha_nacimiento = (select max(fecha_nacimiento) from alumno);

-- 2. devuelve un listado con los profesores que no están asociados a un
-- departamento.

select p.*
from profesor p
left join departamento d on p.id_departamento = d.id
where d.id is null;

-- 3. devuelve un listado con los departamentos que no tienen profesores
-- asociados.

select d.*
from departamento d
left join profesor p on d.id = p.id_departamento
where p.id_profesor is null;

-- 4. devuelve un listado con los profesores que tienen un departamento
-- asociado y que no imparten ninguna asignatura.

select p.*
from profesor p
left join asignatura a on p.id_profesor = a.id_profesor
where a.id is null and p.id_departamento is not null;

-- 5. devuelve un listado con las asignaturas que no tienen un profesor asignado.

select a.*
from asignatura a
left join profesor p on a.id_profesor = p.id_profesor
where p.id_profesor is null;

-- 6. devuelve un listado con todos los departamentos que no han impartido
-- asignaturas en ningún curso escolar.

select d.nombre as nombre_departamento
from departamento d
left join profesor p on d.id = p.id_departamento
left join asignatura a on p.id_profesor = a.id_profesor
left join alumno_se_matricula_asignatura am on a.id = am.id_asignatura
where am.id_curso_escolar is null
group by d.nombre;























