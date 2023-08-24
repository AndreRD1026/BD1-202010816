CREATE SCHEMA bd1_practica1 DEFAULT CHARACTER SET utf8;

USE bd1_practica1;

-- Usuarios
CREATE TABLE usuario (
    id_usuario     INT NOT NULL AUTO_INCREMENT,
    tipo           VARCHAR(20) NOT NULL,
    nombre_usuario VARCHAR(50) NOT NULL,
    apodo          VARCHAR(20) NOT NULL,
    edad           INT NOT NULL,
    correo         VARCHAR(30) NOT NULL,
    teléfono       INT NOT NULL,
    dirección      VARCHAR(50) NOT NULL,
    país           VARCHAR(20) NOT NULL,
    contraseña     VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_usuario)
);

-- Desarrolladores
CREATE TABLE desarrollador (
    id_desarrollador INT NOT NULL AUTO_INCREMENT,
    nombre           VARCHAR(50) NOT NULL,
    alias            VARCHAR(20) NOT NULL,
    juego_id_juego   INT NOT NULL,
    PRIMARY KEY (id_desarrollador)
);

-- Clasificación
CREATE TABLE clasificación (
    tipo                      VARCHAR(1) NOT NULL,
    nombre_clasificación      VARCHAR(20) NOT NULL,
    descripción_clasificación VARCHAR(50) NOT NULL,
    PRIMARY KEY (tipo)
);

-- Promoción
CREATE TABLE promoción (
    id_promoción INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin    DATE NOT NULL,
    porcentaje   FLOAT NOT NULL,
    estado       VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_promoción)
);

-- País
CREATE TABLE pais (
    código_país    VARCHAR(10) NOT NULL,
    nombre_país    VARCHAR(50) NOT NULL,
    juego_id_juego INT NOT NULL,
    PRIMARY KEY (código_país)
);

-- Juego
CREATE TABLE juego (
    id_juego               INT NOT NULL AUTO_INCREMENT,
    nombre_juego           VARCHAR(100) NOT NULL,
    descripción_corta      VARCHAR(50) NOT NULL,
    descripción_juego      VARCHAR(100) NOT NULL,
    fecha_lanzamiento      DATE NOT NULL,
    precio                 FLOAT NOT NULL,
    género                 VARCHAR(20) NOT NULL,
    calificación           INT NOT NULL,
    clasificación_tipo     VARCHAR(1) NOT NULL,
    promoción_id_promoción INT NOT NULL,
    PRIMARY KEY (id_juego)
);

-- Tarjeta de Crédito
CREATE TABLE tarjeta_crédito (
    número_tarjeta     INT NOT NULL,
    nombre_tarjeta     INT NOT NULL,
    marca              VARCHAR(20) NOT NULL,
    fecha_vencimiento  DATE NOT NULL,
    usuario_id_usuario INT NOT NULL,
    PRIMARY KEY (número_tarjeta)
);

-- Lista de Deseo
CREATE TABLE lista_deseo (
    id_lista           INT NOT NULL AUTO_INCREMENT,
    usuario_id_usuario INT NOT NULL,
    juego_id_juego     INT NOT NULL,
    PRIMARY KEY (id_lista, juego_id_juego, usuario_id_usuario)
);

-- Compra
CREATE TABLE compra (
    id_compra      INT NOT NULL AUTO_INCREMENT,
    valor_compra   FLOAT NOT NULL,
    fecha_compra   DATE NOT NULL,
    id_lista       INT NOT NULL,
    id_juego       INT NOT NULL,
    id_usuario     INT NOT NULL,
    número_tarjeta INT NOT NULL,
    PRIMARY KEY (id_compra, id_usuario, id_juego)
);


-- Biblioteca
CREATE TABLE biblioteca_juego (
    id_biblioteca INT NOT NULL AUTO_INCREMENT,
    id_compra     INT NOT NULL,
    id_usuario    INT NOT NULL,
    id_juego      INT NOT NULL,
    PRIMARY KEY (id_biblioteca)
);


-- Agregar clave externa a desarrollador
ALTER TABLE desarrollador
    ADD CONSTRAINT desarrollador_juego_fk FOREIGN KEY (juego_id_juego)
        REFERENCES juego (id_juego);

-- Agregar clave externa a juego
ALTER TABLE juego
    ADD CONSTRAINT juego_clasificación_fk FOREIGN KEY (clasificación_tipo)
        REFERENCES clasificación (tipo);

ALTER TABLE juego
    ADD CONSTRAINT juego_promoción_fk FOREIGN KEY (promoción_id_promoción)
        REFERENCES promoción (id_promoción);

-- Agregar clave externa a país
ALTER TABLE pais
    ADD CONSTRAINT pais_juego_fk FOREIGN KEY (juego_id_juego)
        REFERENCES juego (id_juego);

-- Agregar clave externa a tarjeta_crédito
ALTER TABLE tarjeta_crédito
    ADD CONSTRAINT tarjeta_crédito_usuario_fk FOREIGN KEY (usuario_id_usuario)
        REFERENCES usuario (id_usuario);

-- Agregar clave externa a compra
ALTER TABLE compra
    ADD CONSTRAINT compra_lista_deseo_fk FOREIGN KEY (id_lista, id_juego, id_usuario)
        REFERENCES lista_deseo (id_lista, juego_id_juego, usuario_id_usuario);

ALTER TABLE compra
    ADD CONSTRAINT compra_tarjeta_crédito_fk FOREIGN KEY (número_tarjeta)
        REFERENCES tarjeta_crédito (número_tarjeta);

-- Agregar clave externa a biblioteca_juego
ALTER TABLE biblioteca_juego
    ADD CONSTRAINT biblioteca_juego_compra_fk FOREIGN KEY (id_compra, id_usuario, id_juego)
        REFERENCES compra (id_compra, id_usuario, id_juego);