CREATE TABLE VEHICULO (
    PATENTE_COD_VEHICULO VARCHAR(20),
    MARCA VARCHAR(20),
    MODELO VARCHAR(20),
    COLOR VARCHAR(30),
    ANO INT,
    CONSTRAINT PK_VEHICULO PRIMARY KEY(PATENTE_COD_VEHICULO)
);


CREATE TABLE ROL_USUARIO (
    COD_ROL INT AUTO_INCREMENT,
    NOMBRE_ROL VARCHAR(30),
    CONSTRAINT PK_ROL_USUARIO PRIMARY KEY(COD_ROL)
);

CREATE TABLE USUARIOS (
    RUT_USUARIO VARCHAR(10),
    CONTRASEÑA VARCHAR(30),
    NOMBRE_USUARIO VARCHAR(30),
    APELLIDO1_USUARIO VARCHAR(30),
    APELLIDO2_USUARIO VARCHAR(30),
    COD_ROL INT,
    CONSTRAINT PK_USUARIO PRIMARY KEY(RUT_USUARIO),
    CONSTRAINT FK_USUARIO_PK_ROL_USUARIO FOREIGN KEY(COD_ROL) REFERENCES ROL_USUARIO(COD_ROL)
);

CREATE TABLE PRODUCTO(
    COD_PRODUCTO INT AUTO_INCREMENT,
    NOMBRE_PRODUCTO VARCHAR(30),
	IMAGEN_PRODUCTO VARCHAR(100),
    PRECIO_PRODUCTO INT,
    CANTIDAD_TOTAL INT,
    CANTIDAD_DISPONIBLE INT,
    IMAGEN VARCHAR(255),
    CONSTRAINT PK_PRODUCTO PRIMARY KEY(COD_PRODUCTO)
);


CREATE TABLE RESERVA(
	COD_RESERVA INT AUTO_INCREMENT,
	FECHA_CREACION DATE,
	ESTADO VARCHAR(20) DEFAULT 'Pendiente',
	TOTAL INT,
	CELULAR_CLIENTE VARCHAR(15),
	NOMBRE_CLIENTE VARCHAR(255),
	APELLIDO_CLIENTE VARCHAR(255),
	DIRECCION_CLIENTE VARCHAR(255),
	CIUDAD_CLIENTE VARCHAR(255),
    	CONSTRAINT PK_RESERVA PRIMARY KEY(COD_RESERVA)
);

CREATE TABLE DETALLE_RESERVA (
    COD_DETALLE_RESERVA INT AUTO_INCREMENT,
    COD_RESERVA INT,
    COD_PRODUCTO INT,
    CANTIDAD INT,
    SUBTOTAL INT,
    CONSTRAINT PK_DETALLE_RESERVA PRIMARY KEY(COD_DETALLE_RESERVA),
    CONSTRAINT FK_RESERVA_PK_RESERVA FOREIGN KEY (COD_RESERVA) REFERENCES RESERVA(COD_RESERVA),
    CONSTRAINT FK_RESERVA_PK_PRODUCTO FOREIGN KEY (COD_PRODUCTO) REFERENCES PRODUCTO(COD_PRODUCTO)
);

----------------------------------------------------------------
--------------------------NUEVAS TABLAS-------------------------
----------------------------------------------------------------

CREATE TABLE CARRITO (
    COD_CARRITO INT AUTO_INCREMENT,
    COD_PRODUCTO INT,
    COSTO_TOTAL INT,
    CONSTRAINT PK_CARRITO PRIMARY KEY(COD_CARRITO),
    CONSTRAINT FK_COD_PRODUCTO FOREIGN KEY (COD_PRODUCTO) REFERENCES PRODUCTO(COD_PRODUCTO)
);

CREATE TABLE DATOS_DE_TARJETA (
    NUMERO INT,
    FECHA_DE_VENCIMIENTO INT,
    CVC INT,
    CONSTRAINT PK_DATOS_DE_TARJETA PRIMARY KEY(NUMERO)
);

CREATE TABLE METODOS_DE_PAGO (
    COD_METODO_DE_PAGO INT AUTO_INCREMENT,
    TIPO VARCHAR(255),
    DERTALLE VARCHAR(255),
    CONSTRAINT PK_METODO_DE_PAGO PRIMARY KEY (COD_METODO_DE_PAGO)
);

CREATE TABLE DEPOSITO (
    COD_BANCO INT AUTO_INCREMENT,
    NOMBRE_BANCO VARCHAR(255),
    NUMERO_DE_CUENTA INT,
    CONSTRAINT PK_DEPOSITO PRIMARY KEY (COD_BANCO)
);

CREATE TABLE CLIENTE (
    COD_CLIENTE INT AUTO_INCREMENT,
    CORREO_CLIENTE INT,
    CELULAR_CLIENTE VARCHAR(15),
	COD_ROL INT,
	NOMBRE_CLIENTE VARCHAR(255),
	APELLIDO_CLIENTE VARCHAR(255),
	DIRECCION_CLIENTE VARCHAR(255),
    CONSTRAINT PK_CLIENTE PRIMARY KEY(COD_CLIENTE),
	CONSTRAINT FK_CLIENTE_PK_ROL FOREIGN KEY(COD_ROL) REFERENCES ROL_USUARIO(COD_ROL)
);

CREATE TABLE FACTURAS (
    COD_FACTURA INT AUTO_INCREMENT,
    COD_CLIENTE INT,
    FECHA_EMISION INT,
    FECHA_VENCIMIENTO INT,
    MONTO_TOTAL INT,
    ESTADO VARCHAR(255),
    CONSTRAINT PK_FACTURAS PRIMARY KEY(COD_FACTURA),
    CONSTRAINT FK_CLIENTE_PK_FACTURAS FOREIGN KEY (COD_CLIENTE) REFERENCES CLIENTE(COD_CLIENTE)
);

CREATE TABLE PAGOS (
    COD_PAGO INT AUTO_INCREMENT,
    COD_FACTURA INT,
    COD_METODO_DE_PAGO INT,
    COD_BANCO INT,
    FECHA_DE_PAGO DATE,
    MONTO_PAGADO INT,
    METODO_PAGO VARCHAR(255),
    CONFIRMACION_PAGO VARCHAR(255),
    CONSTRAINT PK_PAGOS PRIMARY KEY (COD_PAGO),
    CONSTRAINT FK_PAGOS_PK_FACTURA FOREIGN KEY (COD_FACTURA) REFERENCES FACTURAS(COD_FACTURA),
    CONSTRAINT FK_PAGOS_PK_METODO_DE_PAGO FOREIGN KEY (COD_METODO_DE_PAGO) REFERENCES METODOS_DE_PAGO(COD_METODO_DE_PAGO),
    CONSTRAINT FK_PAGOS_PK_DEPOSITO FOREIGN KEY (COD_BANCO) REFERENCES DEPOSITO(COD_BANCO)
);

CREATE TABLE TRANSACCION(
    COD_TRANSACCION INT AUTO_INCREMENT,
    COD_PAGO INT,
    FECHA_PAGO DATE,
    ESTADO_TRANSACCION VARCHAR(255),
    CONSTRAINT PK_TRANSACCION PRIMARY KEY (COD_TRANSACCION),
    CONSTRAINT FK_TRANSACCION_PK_PAGOS FOREIGN KEY (COD_PAGO) REFERENCES PAGOS(COD_PAGO)
);

CREATE TABLE DETALLE_FACTURA (
    COD_DETALLE_FACTURA INT AUTO_INCREMENT,
    COD_FACTURA INT,
    CANTIDAD INT,
    SUBTOTAL INT,
    CONSTRAINT PK_DETALLE_FACTURA PRIMARY KEY(COD_DETALLE_FACTURA),
    CONSTRAINT FK_FACTURA_PK_DETALLE FOREIGN KEY(COD_FACTURA) REFERENCES FACTURAS(COD_FACTURA)
);

