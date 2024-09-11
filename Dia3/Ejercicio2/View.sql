-- ###############################
-- ########### Views #############
-- ###############################

-- 1. Vista que muestra el listado de todos los alumnos con su nombre completo y sexo
create view vista_alumnos as
select id, nombre, apellido1, apellido2, sexo
from alumno;

-- 2. Vista que muestra todos los profesores con su nombre completo y el nombre de su departamento
create view vista_profesores_departamento as
select p.id_profesor, p.nombre, p.apellido1, p.apellido2, d.nombre as nombre_departamento
from profesor p
join departamento d on p.id_departamento = d.id;

-- 3. Vista que muestra todas las asignaturas con su nombre, créditos, tipo y el nombre del profesor que la imparte
create view vista_asignaturas as
select a.id, a.nombre, a.creditos, a.tipo, p.nombre as nombre_profesor, p.apellido1 as apellido1_profesor, p.apellido2 as apellido2_profesor
from asignatura a
left join profesor p on a.id_profesor = p.id_profesor;

-- 4. Vista que muestra todos los grados y el número de asignaturas que tiene cada uno
create view vista_grados_asignaturas as
select g.nombre as nombre_grado, count(a.id) as numero_asignaturas
from grado g
left join asignatura a on g.id = a.id_grado
group by g.nombre;

-- 5. Vista que muestra todos los alumnos matriculados en el curso escolar 2021/2022
create view vista_alumnos_matriculados_2021_2022 as
select distinct a.id, a.nombre, a.apellido1, a.apellido2
from alumno a
join alumno_se_matricula_asignatura am on a.id = am.id_alumno
join curso_escolar cs on am.id_curso_escolar = cs.id
where cs.anyo_inicio = 2021 and cs.anyo_fin = 2022;

-- 6. Vista que muestra los profesores que no tienen asignaturas asignadas
create view vista_profesores_sin_asignatura as
select p.id_profesor, p.nombre, p.apellido1, p.apellido2
from profesor p
left join asignatura a on p.id_profesor = a.id_profesor
where a.id is null;

-- 7. Vista que muestra los departamentos que no tienen profesores asignados
create view vista_departamentos_sin_profesor as
select d.id, d.nombre
from departamento d
left join profesor p on d.id = p.id_departamento
where p.id_profesor is null;

-- 8. Vista que muestra los alumnos que no han registrado su número de teléfono
create view vista_alumnos_sin_telefono as
select id, nombre, apellido1, apellido2
from alumno
where telefono is null;

-- 9. Vista que muestra el número de alumnos matriculados en cada curso escolar
create view vista_alumnos_por_curso_escolar as
select cs.anyo_inicio, cs.anyo_fin, count(distinct am.id_alumno) as numero_alumnos
from curso_escolar cs
join alumno_se_matricula_asignatura am on cs.id = am.id_curso_escolar
group by cs.anyo_inicio, cs.anyo_fin;

-- 10. Vista que muestra los profesores y el número de asignaturas que imparten
create view vista_profesores_con_numero_asignaturas as
select p.id_profesor, p.nombre, p.apellido1, p.apellido2, count(a.id) as numero_asignaturas
from profesor p
left join asignatura a on p.id_profesor = a.id_profesor
group by p.id_profesor, p.nombre, p.apellido1, p.apellido2;

