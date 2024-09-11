-- ################################
-- ########### Tablas #############
-- ################################

CREATE TABLE gama_producto (
    gama VARCHAR(50) PRIMARY KEY,
    descripcion_texto TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(256)
);

CREATE TABLE producto (
    codigo_producto VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(70) NOT NULL,
    gama VARCHAR(50) NOT NULL,
    CONSTRAINT fk_gama FOREIGN KEY (gama) REFERENCES gama_producto(gama),
    dimensiones VARCHAR(25),
    proveedor VARCHAR(50),
    descripcion TEXT,
    cantidad_en_stock SMALLINT NOT NULL,
    precio_venta DECIMAL(15, 2) NOT NULL,
    precio_proveedor DECIMAL(15, 2)
);

CREATE TABLE oficina (
    codigo_oficina VARCHAR(10) PRIMARY KEY,
    ciudad VARCHAR(30) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    region VARCHAR(50),
    codigo_postal VARCHAR(10) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR(50)
);

CREATE TABLE empleado (
    codigo_empleado INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    codigo_oficina VARCHAR(10) NOT NULL,
    CONSTRAINT fk_oficina FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina),
    codigo_jefe INT,
    CONSTRAINT fk_jefe FOREIGN KEY (codigo_jefe) REFERENCES empleado(codigo_empleado),
    puesto VARCHAR(50)
);

CREATE TABLE cliente (
    codigo_cliente INT PRIMARY KEY,
    nombre_cliente VARCHAR(50) NOT NULL,
    nombre_contacto VARCHAR(30),
    apellido_contacto VARCHAR(30),
    telefono VARCHAR(15) NOT NULL,
    fax VARCHAR(15),
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR(50),
    ciudad VARCHAR(50) NOT NULL,
    region VARCHAR(50),
    pais VARCHAR(50),
    codigo_postal VARCHAR(10),
    codigo_empleado_rep_ventas INT,
    CONSTRAINT fk_empleado_rep FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado(codigo_empleado),
    limite_credito DECIMAL(15, 2)
);

CREATE TABLE pago (
    codigo_cliente INT NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente),
    forma_pago VARCHAR(40) NOT NULL,
    id_transaccion VARCHAR(50) PRIMARY KEY,
    fecha_pago DATE NOT NULL,
    total DECIMAL(15, 2) NOT NULL
);

CREATE TABLE pedido (
    codigo_pedido INT PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    fecha_esperada DATE NOT NULL,
    fecha_entrega DATE,
    estado VARCHAR(15) NOT NULL,
    comentarios TEXT,
    codigo_cliente INT NOT NULL,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente)
);

CREATE TABLE detalle_pedido (
    codigo_pedido INT NOT NULL,
    FOREIGN KEY (codigo_pedido) REFERENCES pedido(codigo_pedido),
    codigo_producto VARCHAR(15) NOT NULL,
    FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto),
    cantidad INT NOT NULL,
    precio_unidad DECIMAL(15, 2) NOT NULL,
    numero_linea SMALLINT NOT NULL
);




