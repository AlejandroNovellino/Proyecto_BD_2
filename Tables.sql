 -- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2023-05-12 11:49:29 VET
--   site:      Oracle Database 21c
--   type:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE


---- Create tabbles  -----------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE aliado (
    ao_id     number generated by default on null as identity,
    ao_nombre VARCHAR2(50 CHAR) NOT NULL,
    ao_logo   BLOB NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (ao_id)
);
/
CREATE TABLE alianza (
    aa_id               number generated by default on null as identity,
    aa_periodo_duracion DATE NOT NULL,
    aa_descripcion      CLOB NOT NULL,
    aa_tipo             VARCHAR2(40) NOT NULL,
    aliado_ao_id        number NOT NULL,
    sede_s_id           number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (aa_id, aliado_ao_id, sede_s_id)
);
/
CREATE TABLE alquiler (
    a_id                            number generated by default on null as identity,
    a_monto_total                   NUMBER(4, 10) NOT NULL,
    a_periodo_duracion              periodo_duracion NOT NULL,
    detalle_alquiler_vehiculo_v_id  number NOT NULL,
    detalle_alquiler_vehiculo_m_id  number NOT NULL,
    detalle_alquiler_vehiculo_ma_id number NOT NULL,
    reserva_re_id                   number NOT NULL,
    detalle_alquiler_da_id          number NOT NULL,
    cliente_c_id                    number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (a_id, cliente_c_id)
);
/
CREATE TABLE cliente (
    c_id                   number generated by default on null as identity,
    c_direccion            VARCHAR2(50 CHAR) NOT NULL,
    c_foto                 BLOB,
    lugar_l_id             number NOT NULL,
    tipo_cliente_tc_id     number NOT NULL,
    c_informacion_personal informacion_personal NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (c_id)
);
/
CREATE TABLE color (
    c_id     number generated by default on null as identity,
    c_nombre VARCHAR2(50 CHAR) NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (c_id)
);
/
CREATE TABLE compra (
    c_id                                number generated by default on null as identity,
    c_monto_total                       NUMBER(4, 10),
    c_fecha                             DATE NOT NULL,
    "DETALLE-COMPRA_DC_ID"              number,
    "DETALLE-COMPRA_V_ID"               number,
    "DETALLE-COMPRA_M_ID"               number,
    "DETALLE-COMPRA_MA_ID"              number,
    sede_s_id                           number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (c_id)
);
/
CREATE TABLE consesionario (
    c_id              number generated by default on null as identity,
    c_numero_telefono VARCHAR2(12 CHAR) NOT NULL,
    c_direccion       CLOB NOT NULL,
    lugar_l_id        number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (c_id)
);
/
CREATE TABLE denuncia (
    d_id                  number generated by default on null as identity,
    d_fecha_denuncia      DATE NOT NULL,
    d_descripcion         CLOB,
    alquiler_a_id         number NOT NULL,
    alquiler_cliente_c_id number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (d_id)
);
/
CREATE TABLE detalle_alquiler (
    da_id                 number generated by default on null as identity,
    da_precio_diario      NUMBER(4, 10) NOT NULL,
    da_km_inicial         number NOT NULL,
    da_km_final           number NOT NULL,
    da_cantidad_dia       number NOT NULL,
    alquiler_a_id         number NOT NULL,
    alquiler_cliente_c_id number NOT NULL,
    vehiculo_v_id         number NOT NULL,
    vehiculo_m_id         number NOT NULL,
    vehiculo_ma_id        number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (da_id, vehiculo_v_id, vehiculo_m_id, vehiculo_ma_id)
);
/
CREATE TABLE detalle_pago (
    forma_pago_fp_id number NOT NULL,
    dp_monto         NUMBER(4, 10) NOT NULL,
    alquiler_a_id    number NOT NULL,
    alquiler_c_id    number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (forma_pago_fp_id, alquiler_a_id, alquiler_c_id)
);
/
CREATE TABLE "DETALLE-COMPRA" (
    dc_id              number generated by default on null as identity,
    dc_cantidad        number NOT NULL,
    dc_precio_unitario NUMBER NOT NULL,
    compra_c_id        number NOT NULL,
    vehiculo_v_id      number NOT NULL,
    vehiculo_m_id      number NOT NULL,
    vehiculo_ma_id     number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (dc_id, vehiculo_v_id, vehiculo_m_id, vehiculo_ma_id)
);
/
CREATE TABLE empleado (
    e_id                   number generated by default on null as identity,
    e_informacion_personal informacion_personal NOT NULL,
    e_sueldo               NUMBER NOT NULL,
    sede_s_id              number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (e_id)
);
/
CREATE TABLE entrega (
    e_id                          number generated by default on null as identity,
    e_hora                        TIMESTAMP(4) NOT NULL,
    e_ubicacion_geografica_retiro ubicacion_geografica NOT NULL,
    e_descripcion                 CLOB NOT NULL,
    reserva_re_id                 number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (e_id)
);
/
CREATE TABLE forma_pago (
    fp_id     number generated by default on null as identity,
    fp_nombre VARCHAR2(50 CHAR) NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (fp_id)
);
/
CREATE TABLE gasto (
    g_id               number generated by default on null as identity,
    g_precio           NUMBER(4, 10) NOT NULL,
    g_fecha            DATE NOT NULL,
    g_descripcion      CLOB NOT NULL,
    "TIPO-GASTO_TG_ID" number NOT NULL,
    sede_s_id          number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (g_id)
);
/
CREATE TABLE historico_promocion (
    hp_id               number generated by default on null as identity,
    hp_periodo_duracion periodo_duracion NOT NULL,
    promocion_p_id      number NOT NULL,
    vehiculo_v_id       number NOT NULL,
    vehiculo_m_id       number NOT NULL,
    vehiculo_ma_id      number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (hp_id, promocion_p_id, vehiculo_v_id, vehiculo_m_id, vehiculo_ma_id)
);
/
CREATE TABLE ingreso (
    i_id          number generated by default on null as identity,
    i_cantidad    number NOT NULL,
    i_fecha       DATE NOT NULL,
    i_descripcion CLOB NOT NULL,
    sede_s_id     number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (i_id)
);
/
CREATE TABLE lugar ( ---- ATENCION CON ESTA TABLA Y LAS FK QUE APUNTAN A ELLA
    l_id       number generated by default on null as identity,
    l_nombre   VARCHAR2(50) NOT NULL,
    l_tipo     VARCHAR2(50 CHAR) NOT NULL,
    l_tipo1    VARCHAR2(50),--- ATENCION CON ESTE ERROR
--  ERROR: VARCHAR2 size not specified 
    lugar_l_id number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (l_id)
);
/
CREATE TABLE mantenimiento (
    m_id                     number generated by default on null as identity,
    m_descripcion            CLOB NOT NULL,
    tipo_mantenimiento_tm_id number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (m_id, tipo_mantenimiento_tm_id)
);
/
CREATE TABLE mantenimiento_taller (
    mantenimiento_m_id                     number NOT NULL,
    mantenimiento_tipo_mantenimiento_tm_id number NOT NULL,
    taller_t_id                            number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (mantenimiento_m_id, mantenimiento_tipo_mantenimiento_tm_id, taller_t_id)
);
/
CREATE TABLE mantenimiento_vehiculo (
    man_id                    number generated by default on null as identity,
    man_periodo_duracion      periodo_duracion NOT NULL,
    man_fecha_proximo_man     DATE NOT NULL,
    man_precio                NUMBER(2, 10) NOT NULL,
    vehiculo_v_id             number NOT NULL,
    vehiculo_m_id             number NOT NULL,
    vehiculo_ma_id            number NOT NULL,
    status_mantenimiento_s_id number NOT NULL,
    mantenimiento_m_id        number NOT NULL,
    mantenimiento_tm_id       number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (man_id, vehiculo_v_id, vehiculo_m_id, vehiculo_ma_id, mantenimiento_m_id, mantenimiento_tm_id)
);
/
CREATE TABLE marca (
    ma_id     number generated by default on null as identity,
    ma_nombre VARCHAR2(50 CHAR) NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (ma_id)
);
/
CREATE TABLE modelo (
    m_id        number generated by default on null as identity,
    m_nombre    VARCHAR2(50 CHAR) NOT NULL,
    marca_ma_id number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (m_id, marca_ma_id)
);
/
CREATE TABLE observacion (
    o_id          number generated by default on null as identity,
    o_descripcion CLOB NOT NULL,
    rating_r_id   number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (o_id)
);
/
CREATE TABLE promocion (
    p_id                   number generated by default on null as identity,
    p_porcentaje_descuento NUMBER(4, 7) NOT NULL,
    p_descripcion          CLOB,
    -- claves primarias de la tabla
    PRIMARY KEY (p_id)
);
/
CREATE TABLE rating (
    r_id                  number generated by default on null as identity,
    r_fecha               DATE NOT NULL,
    r_escala_satisfaccion number NOT NULL,
    r_rating_promocion    number NOT NULL,
    r_observacion         CLOB,
    alquiler_a_id         number NOT NULL,
    alquiler_cliente_c_id number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (r_id)
);
/
CREATE TABLE reserva (
    re_id                number generated by default on null as identity,
    re_fecha_realizacion DATE NOT NULL,
    re_estatus           VARCHAR2(50 CHAR) NOT NULL,
    cliente_c_id         number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (re_id)
);
/
CREATE TABLE sede (
    s_id                 number generated by default on null as identity,
    s_direccion          CLOB NOT NULL,
    s_telefono           VARCHAR2(12 CHAR) NOT NULL,
    s_numerosede         number NOT NULL,
    s_cant_max_empleados number NOT NULL,
    s_negocio_propio     NUMBER NOT NULL,
    consesionario_c_id   number NOT NULL,
    lugar_l_id           number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (s_id)
);
/
CREATE TABLE status_mantenimiento (
    s_id     number generated by default on null as identity,
    s_nombre VARCHAR2(50 CHAR) NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (s_id)
);
/
CREATE TABLE status_vehiculo (
    sv_id     number generated by default on null as identity,
    sv_nombre VARCHAR2(50 CHAR) NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (sv_id)
);
/
CREATE TABLE taller (
    t_id                   number generated by default on null as identity,
    t_nombre               VARCHAR2(50 CHAR) NOT NULL,
    t_telefono             VARCHAR2(12 CHAR) NOT NULL,
    t_ubicacion_geografica ubicacion_geografica NOT NULL,
    t_num_vehiculo_dia     number NOT NULL,
    lugar_l_id             number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (t_id)
);
/
CREATE TABLE tipo_cliente (
    tc_id     number generated by default on null as identity,
    tc_nombre VARCHAR2(50) NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (tc_id)
);
/
CREATE TABLE tipo_mantenimiento (
    tm_id     number generated by default on null as identity,
    tm_nombre VARCHAR2(50 CHAR) NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (tm_id)
);
/
CREATE TABLE tipo_vehiculo (
    tv_id     number generated by default on null as identity,
    tv_nombre VARCHAR2(50 CHAR) NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (tv_id)
);
/
CREATE TABLE "TIPO-GASTO" (
    tg_id     number generated by default on null as identity,
    tg_nombre VARCHAR2(50 CHAR) NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (tg_id)
);
/
CREATE TABLE vehiculo (
    v_anno                number NOT NULL,
    v_placa               VARCHAR2(7 CHAR) NOT NULL,
    v_foto                BLOB NOT NULL,
    v_km                  number NOT NULL,
    v_precio              NUMBER(4, 10) NOT NULL,
    modelo_m_id           number NOT NULL,
    status_vehiculo_sv_id number NOT NULL,
    color_c_id            number NOT NULL,
    tipo_vehiculo_tv_id   number NOT NULL,
    sede_s_id             number NOT NULL,
    -- claves primarias de la tabla
    PRIMARY KEY (v_placa, modelo_m_id)
);

/

---- Alters para las claves foraneas -------------------------------------------
--------------------------------------------------------------------------------

ALTER TABLE alianza
    ADD CONSTRAINT alianza_aliado_fk FOREIGN KEY ( aliado_ao_id )
        REFERENCES aliado ( ao_id );
/
ALTER TABLE alianza
    ADD CONSTRAINT alianza_sede_fk FOREIGN KEY ( sede_s_id )
        REFERENCES sede ( s_id );
/
ALTER TABLE alquiler
    ADD CONSTRAINT alquiler_cliente_fk FOREIGN KEY ( cliente_c_id )
        REFERENCES cliente ( c_id );
/
ALTER TABLE alquiler
    ADD CONSTRAINT alquiler_detalle_alquiler_fk FOREIGN KEY ( detalle_alquiler_vehiculo_v_id,
                                                              detalle_alquiler_vehiculo_m_id,
                                                              detalle_alquiler_vehiculo_ma_id,
                                                              detalle_alquiler_da_id )
        REFERENCES detalle_alquiler ( vehiculo_v_id,
                                      vehiculo_m_id,
                                      vehiculo_ma_id,
                                      da_id );
/
ALTER TABLE alquiler
    ADD CONSTRAINT alquiler_reserva_fk FOREIGN KEY ( reserva_re_id )
        REFERENCES reserva ( re_id );
/
ALTER TABLE cliente
    ADD CONSTRAINT cliente_lugar_fk FOREIGN KEY ( lugar_l_id )
        REFERENCES lugar ( l_id );
/
ALTER TABLE cliente
    ADD CONSTRAINT cliente_tipo_cliente_fk FOREIGN KEY ( tipo_cliente_tc_id )
        REFERENCES tipo_cliente ( tc_id );
/
ALTER TABLE compra
    ADD CONSTRAINT "COMPRA_DETALLE-COMPRA_FK" FOREIGN KEY ( "DETALLE-COMPRA_DC_ID",
                                                            "DETALLE-COMPRA_V_ID",
                                                            "DETALLE-COMPRA_M_ID",
                                                            "DETALLE-COMPRA_MA_ID" )
        REFERENCES "DETALLE-COMPRA" ( dc_id,
                                      vehiculo_v_id,
                                      vehiculo_m_id,
                                      vehiculo_ma_id );
/
ALTER TABLE compra
    ADD CONSTRAINT compra_sede_fk FOREIGN KEY ( sede_s_id )
        REFERENCES sede ( s_id );
/
ALTER TABLE consesionario
    ADD CONSTRAINT consesionario_lugar_fk FOREIGN KEY ( lugar_l_id )
        REFERENCES lugar ( l_id );
/
ALTER TABLE denuncia
    ADD CONSTRAINT denuncia_alquiler_fk FOREIGN KEY ( alquiler_a_id,
                                                      alquiler_cliente_c_id )
        REFERENCES alquiler ( a_id,
                              cliente_c_id );
/
ALTER TABLE detalle_alquiler
    ADD CONSTRAINT detalle_alquiler_alquiler_fk FOREIGN KEY ( alquiler_a_id,
                                                              alquiler_cliente_c_id )
        REFERENCES alquiler ( a_id,
                              cliente_c_id );
/
ALTER TABLE detalle_alquiler
    ADD CONSTRAINT detalle_alquiler_vehiculo_fk FOREIGN KEY ( vehiculo_v_id,
                                                              vehiculo_m_id,
                                                              vehiculo_ma_id )
        REFERENCES vehiculo ( v_id,
                              modelo_m_id,
                              modelo_marca_ma_id );
/
ALTER TABLE detalle_pago
    ADD CONSTRAINT detalle_pago_alquiler_fk FOREIGN KEY ( alquiler_a_id,
                                                          alquiler_c_id )
        REFERENCES alquiler ( a_id,
                              cliente_c_id );
/
ALTER TABLE detalle_pago
    ADD CONSTRAINT detalle_pago_forma_pago_fk FOREIGN KEY ( forma_pago_fp_id )
        REFERENCES forma_pago ( fp_id );
/
ALTER TABLE "DETALLE-COMPRA"
    ADD CONSTRAINT "DETALLE-COMPRA_COMPRA_FK" FOREIGN KEY ( compra_c_id )
        REFERENCES compra ( c_id );
/
ALTER TABLE "DETALLE-COMPRA"
    ADD CONSTRAINT "DETALLE-COMPRA_VEHICULO_FK" FOREIGN KEY ( vehiculo_v_id,
                                                              vehiculo_m_id,
                                                              vehiculo_ma_id )
        REFERENCES vehiculo ( v_id,
                              modelo_m_id,
                              modelo_marca_ma_id );
/
ALTER TABLE empleado
    ADD CONSTRAINT empleado_sede_fk FOREIGN KEY ( sede_s_id )
        REFERENCES sede ( s_id );
/
ALTER TABLE entrega
    ADD CONSTRAINT entrega_reserva_fk FOREIGN KEY ( reserva_re_id )
        REFERENCES reserva ( re_id );
/
ALTER TABLE gasto
    ADD CONSTRAINT gasto_sede_fk FOREIGN KEY ( sede_s_id )
        REFERENCES sede ( s_id );
/
ALTER TABLE gasto
    ADD CONSTRAINT "GASTO_TIPO-GASTO_FK" FOREIGN KEY ( "TIPO-GASTO_TG_ID" )
        REFERENCES "TIPO-GASTO" ( tg_id );
/
ALTER TABLE historico_promocion
    ADD CONSTRAINT historico_promocion_promocion_fk FOREIGN KEY ( promocion_p_id )
        REFERENCES promocion ( p_id );
/
ALTER TABLE historico_promocion
    ADD CONSTRAINT historico_promocion_vehiculo_fk FOREIGN KEY ( vehiculo_v_id,
                                                                 vehiculo_m_id,
                                                                 vehiculo_ma_id )
        REFERENCES vehiculo ( v_id,
                              modelo_m_id,
                              modelo_marca_ma_id );
/
ALTER TABLE ingreso
    ADD CONSTRAINT ingreso_sede_fk FOREIGN KEY ( sede_s_id )
        REFERENCES sede ( s_id );
/
ALTER TABLE lugar
    ADD CONSTRAINT lugar_lugar_fk FOREIGN KEY ( lugar_l_id )
        REFERENCES lugar ( l_id );
/
ALTER TABLE mantenimiento_taller
    ADD CONSTRAINT mantenimiento_taller_mantenimiento_fk FOREIGN KEY ( mantenimiento_m_id,
                                                                       mantenimiento_tipo_mantenimiento_tm_id )
        REFERENCES mantenimiento ( m_id,
                                   tipo_mantenimiento_tm_id );
/
ALTER TABLE mantenimiento_taller
    ADD CONSTRAINT mantenimiento_taller_taller_fk FOREIGN KEY ( taller_t_id )
        REFERENCES taller ( t_id );
/
ALTER TABLE mantenimiento
    ADD CONSTRAINT mantenimiento_tipo_mantenimiento_fk FOREIGN KEY ( tipo_mantenimiento_tm_id )
        REFERENCES tipo_mantenimiento ( tm_id );
/
ALTER TABLE mantenimiento_vehiculo
    ADD CONSTRAINT mantenimiento_vehiculo_mantenimiento_fk FOREIGN KEY ( mantenimiento_m_id,
                                                                         mantenimiento_tm_id )
        REFERENCES mantenimiento ( m_id,
                                   tipo_mantenimiento_tm_id );
/
ALTER TABLE mantenimiento_vehiculo
    ADD CONSTRAINT mantenimiento_vehiculo_status_mantenimiento_fk FOREIGN KEY ( status_mantenimiento_s_id )
        REFERENCES status_mantenimiento ( s_id );
/
ALTER TABLE mantenimiento_vehiculo
    ADD CONSTRAINT mantenimiento_vehiculo_vehiculo_fk FOREIGN KEY ( vehiculo_v_id,
                                                                    vehiculo_m_id,
                                                                    vehiculo_ma_id )
        REFERENCES vehiculo ( v_id,
                              modelo_m_id,
                              modelo_marca_ma_id );
/
ALTER TABLE modelo
    ADD CONSTRAINT modelo_marca_fk FOREIGN KEY ( marca_ma_id )
        REFERENCES marca ( ma_id );
/
ALTER TABLE observacion
    ADD CONSTRAINT observacion_rating_fk FOREIGN KEY ( rating_r_id )
        REFERENCES rating ( r_id );
/
ALTER TABLE rating
    ADD CONSTRAINT rating_alquiler_fk FOREIGN KEY ( alquiler_a_id,
                                                    alquiler_cliente_c_id )
        REFERENCES alquiler ( a_id,
                              cliente_c_id );
/
ALTER TABLE reserva
    ADD CONSTRAINT reserva_cliente_fk FOREIGN KEY ( cliente_c_id )
        REFERENCES cliente ( c_id );
/
ALTER TABLE sede
    ADD CONSTRAINT sede_consesionario_fk FOREIGN KEY ( consesionario_c_id )
        REFERENCES consesionario ( c_id );
/
ALTER TABLE sede
    ADD CONSTRAINT sede_lugar_fk FOREIGN KEY ( lugar_l_id )
        REFERENCES lugar ( l_id );
/
ALTER TABLE taller
    ADD CONSTRAINT taller_lugar_fk FOREIGN KEY ( lugar_l_id )
        REFERENCES lugar ( l_id );
/
ALTER TABLE vehiculo
    ADD CONSTRAINT vehiculo_color_fk FOREIGN KEY ( color_c_id )
        REFERENCES color ( c_id );
/
ALTER TABLE vehiculo
    ADD CONSTRAINT vehiculo_modelo_fk FOREIGN KEY ( modelo_m_id,
                                                    modelo_marca_ma_id )
        REFERENCES modelo ( m_id,
                            marca_ma_id );
/

ALTER TABLE vehiculo
    ADD CONSTRAINT vehiculo_sede_fk FOREIGN KEY ( sede_s_id )
        REFERENCES sede ( s_id );
/
ALTER TABLE vehiculo
    ADD CONSTRAINT vehiculo_status_vehiculo_fk FOREIGN KEY ( status_vehiculo_sv_id )
        REFERENCES status_vehiculo ( sv_id );
/
ALTER TABLE vehiculo
    ADD CONSTRAINT vehiculo_tipo_vehiculo_fk FOREIGN KEY ( tipo_vehiculo_tv_id )
        REFERENCES tipo_vehiculo ( tv_id );
/


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            36
-- ALTER TABLE                             79

