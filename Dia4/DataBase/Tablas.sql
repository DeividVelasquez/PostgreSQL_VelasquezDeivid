create table Persona(
	id serial primary key,
	documento int not null,
	nombre varchar(300) not null,
	apellido varchar(300) not null,
	genero varchar(300)
);

create table Departamentos(
	id serial primary key,
	ciudad varchar(300),
	pais varchar(300)
);

create table Departamento_Ventas(
	id serial primary key,
	id_departamento int,
	foreign key (id_departamento) references Departamentos(id)
);

create table Departamento_Servicio(
	id serial primary key,
	id_departamento int,
	foreign key (id) references Departamentos(id)
);

create table Cliente(
	id serial primary key,
	id_persona int,
	foreign key (id_persona) references Persona(id)
);

create table Empleado(
	id serial primary key,
	id_persona int,
	rol varchar(300),
	fecha_contratacion date,
	id_departamento int,
	foreign key (id_persona) references Persona(id),
	foreign key (id_departamento) references Departamentos(id)
);

create table Proveedor(
	id serial primary key,
	id_persona int,
	foreign key (id_persona) references Persona(id)
);

create table Vehiculo(
	id serial primary key,
	marca varchar(300),
	modelo varchar(300),
	anyo int,
	estado varchar(300),
	precio int
);

create table Cliente_Potencial(
	id serial primary key,
	id_cliente int,
	empleado_registra int,
	id_vehiculo int,
	foreign key (id_cliente) references Cliente(id),
	foreign key (empleado_registra) references Empleado(id),
	foreign key (id_vehiculo) references Vehiculo(id) 
);

create table Ventas(
	id serial primary key,
	id_cliente int,
	fecha date,
	id_empleado int,
	costo int,
	foreign key (id_cliente) references Cliente(id),
	foreign key (id_empleado) references Empleado(id)
);

create table Ventas_Vehiculos(
	id_venta int primary key,
	id_vehiculo int,
	foreign key (id_venta) references Ventas(id),
	foreign key (id_vehiculo) references Vehiculo(id)
);

create table Historial_Servicio(
	id serial primary key,
	id_vehiculo int,
	id_empleado int,
	id_proveedor int,
	id_cliente int,
	fecha date,
	costo int,
	foreign key (id_vehiculo) references Vehiculo(id),
	foreign key (id_empleado) references Empleado(id),
	foreign key (id_proveedor) references Proveedor(id),
	foreign key (id_cliente) references Cliente(id)
);