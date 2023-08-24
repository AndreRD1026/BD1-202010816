-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-08-23 22:25:18 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g


CREATE SCHEMA bd1_practica1 DEFAULT CHARACTER SET utf8;

USE bd1_practica1;

-- Creación Tablas

-- Biblioteca usuarios
CREATE TABLE biblioteca_juego (
    id_biblioteca INTEGER NOT NULL,
    id_compra     INTEGER NOT NULL,
    id_usuario    INTEGER NOT NULL,
    id_juego      INTEGER NOT NULL
);

-- Llave primaria biblioteca_juego
ALTER TABLE biblioteca_juego
    ADD CONSTRAINT biblioteca_juego_pk PRIMARY KEY ( id_biblioteca,
                                                     id_usuario,
                                                     id_juego );

-- Calificación Juego
CREATE TABLE calificacion (
    id_calificacion INTEGER NOT NULL,
    nota_juego      INTEGER,
    id_biblioteca   INTEGER NOT NULL,
    id_usuario      INTEGER NOT NULL,
    id_juego        INTEGER NOT NULL
);

-- Llave primaria calificación
ALTER TABLE calificacion ADD CONSTRAINT calificacion_pk PRIMARY KEY ( id_calificacion );

-- Clasificación
CREATE TABLE clasificacion (
    tipo                      VARCHAR(1) NOT NULL,
    nombre_clasificacion      VARCHAR(20) NOT NULL,
    descripción_clasificacion VARCHAR(50) NOT NULL
);

-- Llave primaria clasificación
ALTER TABLE clasificacion ADD CONSTRAINT clasificacion_pk PRIMARY KEY ( tipo );

-- Compra
CREATE TABLE compra (
    id_compra      INTEGER NOT NULL,
    valor_compra   FLOAT NOT NULL,
    fecha_compra   DATE NOT NULL,
    id_lista       INTEGER NOT NULL,
    id_juego       INTEGER NOT NULL,
    id_usuario     INTEGER NOT NULL,
    numero_tarjeta INTEGER NOT NULL
);

-- Llave primaria compra
ALTER TABLE compra
    ADD CONSTRAINT compra_pk PRIMARY KEY ( id_compra,
                                           id_usuario,
                                           id_juego );

-- Desarrollador
CREATE TABLE desarrollador (
    id_desarrollador INTEGER NOT NULL,
    nombre           VARCHAR(50) NOT NULL,
    alias            VARCHAR(20) NOT NULL,
    juego_id_juego   INTEGER NOT NULL
);

-- Llave primaria desarrollador
ALTER TABLE desarrollador ADD CONSTRAINT desarrollador_pk PRIMARY KEY ( id_desarrollador );

-- Juego
CREATE TABLE juego (
    id_juego               INTEGER NOT NULL,
    nombre_juego           VARCHAR(100) NOT NULL,
    descripcion_corta      VARCHAR(50) NOT NULL,
    descripción_juego      VARCHAR(100) NOT NULL,
    fecha_lanzamiento      DATE NOT NULL,
    precio                 FLOAT NOT NULL,
    genero                 VARCHAR(20) NOT NULL,
    clasificacion_tipo     VARCHAR(1) NOT NULL,
    promocion_id_promocion INTEGER NOT NULL
);

-- Llave primaria juego
ALTER TABLE juego ADD CONSTRAINT juego_pk PRIMARY KEY ( id_juego );

-- Lista de deseo
CREATE TABLE lista_deseo (
    id_lista           INTEGER NOT NULL,
    usuario_id_usuario INTEGER NOT NULL,
    juego_id_juego     INTEGER NOT NULL
);

CREATE UNIQUE INDEX lista_deseo__idx ON
    lista_deseo (
        usuario_id_usuario
    ASC );

-- Llave primaria lista de deseo
ALTER TABLE lista_deseo
    ADD CONSTRAINT lista_deseo_pk PRIMARY KEY ( id_lista,
                                                juego_id_juego,
                                                usuario_id_usuario );

-- Pais
CREATE TABLE pais (
    codigo_país    VARCHAR(10) NOT NULL,
    nombre_país    VARCHAR(50) NOT NULL,
    juego_id_juego INTEGER NOT NULL
);

-- Llave primaria pais
ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( codigo_país );

-- Promoción
CREATE TABLE promocion (
    id_promocion INTEGER NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin    DATE NOT NULL,
    porcentaje   FLOAT NOT NULL,
    estado       VARCHAR(20) NOT NULL
);

-- Llave primaria promoción
ALTER TABLE promocion ADD CONSTRAINT promocion_pk PRIMARY KEY ( id_promocion );

-- Tarjeta de credito
CREATE TABLE tarjeta_credito (
    numero_tarjeta     INTEGER NOT NULL,
    nombre_tarjeta     INTEGER NOT NULL,
    marca              VARCHAR(20) NOT NULL,
    fecha_vencimiento  DATE NOT NULL,
    usuario_id_usuario INTEGER NOT NULL
);

-- Llave primaria tarjeta de credito
ALTER TABLE tarjeta_credito ADD CONSTRAINT tarjeta_credito_pk PRIMARY KEY ( numero_tarjeta );

-- Usuario
CREATE TABLE usuario (
    id_usuario     INTEGER NOT NULL,
    tipo           VARCHAR(20) NOT NULL,
    nombre_usuario VARCHAR(50) NOT NULL,
    apodo          VARCHAR(20) NOT NULL,
    edad           INTEGER NOT NULL,
    correo         VARCHAR(30) NOT NULL,
    telefono       INTEGER NOT NULL,
    direccion      VARCHAR(50) NOT NULL,
    pais           VARCHAR(20) NOT NULL,
    contraseña     VARCHAR(20) NOT NULL
);

-- Llave primaria usuario
ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id_usuario );

-- Creación llaves foraneas

-- Agregar llave foranea a desarrollador
ALTER TABLE desarrollador
    ADD CONSTRAINT desarrollador_juego_fk FOREIGN KEY ( juego_id_juego )
        REFERENCES juego ( id_juego );

-- Agregar llave foranea a juego
ALTER TABLE juego
    ADD CONSTRAINT juego_clasificacion_fk FOREIGN KEY ( clasificacion_tipo )
        REFERENCES clasificacion ( tipo );

-- Agregar llave foranea a juego
ALTER TABLE juego
    ADD CONSTRAINT juego_promocion_fk FOREIGN KEY ( promocion_id_promocion )
        REFERENCES promocion ( id_promocion );

-- Agregar llave foranea a pais
ALTER TABLE pais
    ADD CONSTRAINT pais_juego_fk FOREIGN KEY ( juego_id_juego )
        REFERENCES juego ( id_juego );

-- Agregar llave foranea a tarjeta de credito
ALTER TABLE tarjeta_credito
    ADD CONSTRAINT tarjeta_credito_usuario_fk FOREIGN KEY ( usuario_id_usuario )
        REFERENCES usuario ( id_usuario );

-- Agregar llave foranea a lista de deseo
ALTER TABLE lista_deseo
    ADD CONSTRAINT lista_deseo_juego_fk FOREIGN KEY ( juego_id_juego )
        REFERENCES juego ( id_juego );

-- Agregar llave foranea a lista de deseo
ALTER TABLE lista_deseo
    ADD CONSTRAINT lista_deseo_usuario_fk FOREIGN KEY ( usuario_id_usuario )
        REFERENCES usuario ( id_usuario );

-- Agregar llave foranea a compra
ALTER TABLE compra
    ADD CONSTRAINT compra_lista_deseo_fk FOREIGN KEY ( id_lista,
                                                       id_juego,
                                                       id_usuario )
        REFERENCES lista_deseo ( id_lista,
                                 juego_id_juego,
                                 usuario_id_usuario );

-- Agregar llave foranea a compra
ALTER TABLE compra
    ADD CONSTRAINT compra_tarjeta_credito_fk FOREIGN KEY ( numero_tarjeta )
        REFERENCES tarjeta_credito ( numero_tarjeta );


-- Agregar llave foranea a biblioteca juego
ALTER TABLE biblioteca_juego
    ADD CONSTRAINT biblioteca_juego_compra_fk FOREIGN KEY ( id_compra,
                                                            id_usuario,
                                                            id_juego )
        REFERENCES compra ( id_compra,
                            id_usuario,
                            id_juego );

-- Agregar llave foranea a calificacion
ALTER TABLE calificacion
    ADD CONSTRAINT calificacion_biblioteca_fk FOREIGN KEY ( id_biblioteca,
                                                            id_usuario,
                                                            id_juego )
        REFERENCES biblioteca_juego ( id_biblioteca,
                                      id_usuario,
                                      id_juego );


-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             1
-- ALTER TABLE                             22
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
