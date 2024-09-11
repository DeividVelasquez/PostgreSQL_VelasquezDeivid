-- ###############################
-- ########### Views #############
-- ###############################

-- 1. Vista que muestra los clientes que no han realizado ningún pago
create view clientes_sin_pagos as
select c.*
from cliente c
left join pago p on c.codigo_cliente = p.codigo_cliente
where p.codigo_cliente is null;

-- 2. Vista que muestra los clientes que no han realizado ningún pedido
create view clientes_sin_pedidos as
select c.*
from cliente c
left join pedido pd on c.codigo_cliente = pd.codigo_cliente
where pd.codigo_pedido is null;

-- 3. Vista que muestra los empleados que no tienen una oficina asociada
create view empleados_sin_oficina as
select e.*
from empleado e
left join oficina o on e.codigo_oficina = o.codigo_oficina
where o.codigo_oficina is null;

-- 4. Vista que muestra los empleados que no tienen un cliente asociado
create view empleados_sin_clientes as
select e.*
from empleado e
left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
where c.codigo_cliente is null;

-- 5. Vista que muestra los productos que nunca han aparecido en un pedido
create view productos_sin_pedidos as
select p.*
from producto p
left join detalle_pedido dp on p.codigo_producto = dp.codigo_producto
where dp.codigo_producto is null;

-- 6. Vista que muestra el nombre y cantidad total de productos vendidos
create view productos_mas_vendidos as
select d.codigo_producto, p.nombre, sum(d.cantidad) as unidades_vendidas
from detalle_pedido d
inner join producto p on d.codigo_producto = p.codigo_producto
group by d.codigo_producto, p.nombre
order by unidades_vendidas desc;

-- 7. Vista que muestra el total de pagos realizados por año
create view pagos_por_anio as
select extract(year from fecha_pago) as anio, sum(total) as suma_pagos
from pago
group by extract(year from fecha_pago);

-- 8. Vista que muestra el total de empleados por ciudad
create view empleados_por_ciudad as
select o.ciudad, count(e.codigo_empleado) as total_empleados
from oficina o
left join empleado e on o.codigo_oficina = e.codigo_oficina
group by o.ciudad;

-- 9. Vista que muestra los clientes con su límite de crédito mayor que sus pagos
create view clientes_credito_mayor_que_pagos as
select nombre_cliente
from cliente
where limite_credito > all (
    select total
    from pago
    where cliente.codigo_cliente = pago.codigo_cliente
);

-- 10. Vista que muestra el número de pedidos que ha realizado cada cliente
create view pedidos_por_cliente as
select c.nombre_cliente,
       (select count(*) from pedido p where p.codigo_cliente = c.codigo_cliente) as total_pedidos
from cliente c;
