-- #######################################
-- ########### Procedimiento #############
-- #######################################

-- 1. Procedimiento para crear un nuevo producto
create or replace procedure crear_producto(
    p_codigo_producto varchar(15),
    p_nombre varchar(70),
    p_gama varchar(50),
    p_dimensiones varchar(25),
    p_proveedor varchar(50),
    p_descripcion text,
    p_cantidad_en_stock smallint,
    p_precio_venta decimal(15, 2),
    p_precio_proveedor decimal(15, 2)
)
language plpgsql
as $$
begin
    insert into producto(codigo_producto, nombre, gama, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor)
    values (p_codigo_producto, p_nombre, p_gama, p_dimensiones, p_proveedor, p_descripcion, p_cantidad_en_stock, p_precio_venta, p_precio_proveedor);
end $$;

-- 2. Procedimiento para actualizar la cantidad en stock de un producto
create or replace procedure actualizar_cantidad_producto(
    p_codigo_producto varchar(15),
    p_cantidad_en_stock smallint
)
language plpgsql
as $$
begin
    update producto
    set cantidad_en_stock = p_cantidad_en_stock
    where codigo_producto = p_codigo_producto;
end $$;

-- 3. Procedimiento para eliminar un producto por su código
create or replace procedure eliminar_producto(
    p_codigo_producto varchar(15)
)
language plpgsql
as $$
begin
    delete from producto
    where codigo_producto = p_codigo_producto;
end $$;

-- 4. Procedimiento para buscar un producto por su nombre
create or replace procedure buscar_producto_por_nombre(
    p_nombre varchar(70)
)
language plpgsql
as $$
begin
    select * from producto
    where nombre like '%' || p_nombre || '%';
end $$;

-- 5. Procedimiento para crear un nuevo cliente
create or replace procedure crear_cliente(
    p_codigo_cliente int,
    p_nombre_cliente varchar(50),
    p_nombre_contacto varchar(30),
    p_apellido_contacto varchar(30),
    p_telefono varchar(15),
    p_fax varchar(15),
    p_linea_direccion1 varchar(50),
    p_linea_direccion2 varchar(50),
    p_ciudad varchar(50),
    p_region varchar(50),
    p_pais varchar(50),
    p_codigo_postal varchar(10),
    p_codigo_empleado_rep_ventas int,
    p_limite_credito decimal(15, 2)
)
language plpgsql
as $$
begin
    insert into cliente(codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal, codigo_empleado_rep_ventas, limite_credito)
    values (p_codigo_cliente, p_nombre_cliente, p_nombre_contacto, p_apellido_contacto, p_telefono, p_fax, p_linea_direccion1, p_linea_direccion2, p_ciudad, p_region, p_pais, p_codigo_postal, p_codigo_empleado_rep_ventas, p_limite_credito);
end $$;

-- 6. Procedimiento para actualizar el límite de crédito de un cliente
create or replace procedure actualizar_limite_credito_cliente(
    p_codigo_cliente int,
    p_limite_credito decimal(15, 2)
)
language plpgsql
as $$
begin
    update cliente
    set limite_credito = p_limite_credito
    where codigo_cliente = p_codigo_cliente;
end $$;

-- 7. Procedimiento para eliminar un cliente por su código
create or replace procedure eliminar_cliente(
    p_codigo_cliente int
)
language plpgsql
as $$
begin
    delete from cliente
    where codigo_cliente = p_codigo_cliente;
end $$;

-- 8. Procedimiento para buscar un cliente por su nombre
create or replace procedure buscar_cliente_por_nombre(
    p_nombre_cliente varchar(50)
)
language plpgsql
as $$
begin
    select * from cliente
    where nombre_cliente like '%' || p_nombre_cliente || '%';
end $$;

-- 9. Procedimiento para crear un nuevo pedido
create or replace procedure crear_pedido(
    p_codigo_pedido int,
    p_fecha_pedido date,
    p_fecha_esperada date,
    p_fecha_entrega date,
    p_estado varchar(15),
    p_comentarios text,
    p_codigo_cliente int
)
language plpgsql
as $$
begin
    insert into pedido(codigo_pedido, fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, codigo_cliente)
    values (p_codigo_pedido, p_fecha_pedido, p_fecha_esperada, p_fecha_entrega, p_estado, p_comentarios, p_codigo_cliente);
end $$;

-- 10. Procedimiento para actualizar el estado de un pedido
create or replace procedure actualizar_estado_pedido(
    p_codigo_pedido int,
    p_estado varchar(15)
)
language plpgsql
as $$
begin
    update pedido
    set estado = p_estado
    where codigo_pedido = p_codigo_pedido;
end $$;
