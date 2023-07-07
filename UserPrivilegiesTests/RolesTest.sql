-- Pruebas tabla CONSESIONARIO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.CONSESIONARIO values(
                default,
                'Prueba insert',
                '04141234567',
                'Direccion de prueba',
                1    
            ); 
-- Read (select)
select * from C##NOV.CONSESIONARIO;
-- Update (update)
update C##NOV.CONSESIONARIO set c_nombre='Cambio nombre' where c_id=1; 
-- Delete (delete)
delete from C##NOV.CONSESIONARIO where c_id=6;

-- Pruebas tabla SEDE
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.SEDE values(
                default,
                'Direccion de prueba',
                '04141234567',
                5,
                5,
                0,
                1,
                1    
            ); 
-- Read (select)
select * from C##NOV.SEDE;
-- Update (update)
update C##NOV.SEDE set s_direccion='Cambio de direccion' where s_id=1; 
-- Delete (delete)
delete from C##NOV.SEDE where s_id=1;

-- Pruebas tabla CLIENTE
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.CLIENTE values(
                default,
                C##NOV.informacion_personal(
                    '123456',
                    'Nombre 1',
                    'Nombre 2',
                    'Apellido 1',
                    'Apellido 2',
                    'abc@gmail.com',
                    TO_DATE('01/01/2000','MM/DD/YYYY'),
                    'O',
                    'Direccion de prueba'
                ),
                EMPTY_BLOB(),
                C##NOV.ubicacion_geografica(
                    '150',
                    '150',
                    null
                ),
                (select tc_id from C##NOV.TIPO_CLIENTE where tc_id=1),
                TO_DATE('06/01/2010','MM/DD/YYYY'),
                (select l_id from C##NOV.LUGAR where l_id=1)
            ); 
-- Read (select)
select * from C##NOV.CLIENTE;
-- Update (update)
update C##NOV.CLIENTE set fecha_registro=TO_DATE('06/01/2003','MM/DD/YYYY') where c_id=1; 
-- Delete (delete)
delete from C##NOV.CLIENTE where c_id=1;

-- Pruebas tabla GASTO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.GASTO values(
                default,
                100,
                TO_DATE('06/01/2023','MM/DD/YYYY'),
                'Gasto de prueba',
                (select tg_id from C##NOV.TIPO_GASTO where tg_nombre like 'Operacionales'),
                (select s_id from C##NOV.SEDE where s_numerosede=1)
            ); 
-- Read (select)
select * from C##NOV.GASTO;
-- Update (update)
update C##NOV.GASTO set g_fecha=TO_DATE('06/01/2023','MM/DD/YYYY') where g_id=1; 
-- Delete (delete)
delete from C##NOV.GASTO where g_id=1;

-- Pruebas tabla INGRESO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.INGRESO values(
                default,
                100,
                TO_DATE('06/01/2023','MM/DD/YYYY'),
                'Ingreso de prueba',
                (select s_id from C##NOV.SEDE where s_numerosede=1)
            ); 
-- Read (select)
select * from C##NOV.INGRESO;
-- Update (update)
update C##NOV.INGRESO set i_fecha=TO_DATE('06/01/2023','MM/DD/YYYY') where i_id=1; 
-- Delete (delete)
delete from C##NOV.INGRESO where i_id=1;

-- Pruebas tabla EMPLEADO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.EMPLEADO values(
                default,
                C##NOV.informacion_personal(
                    '123456',
                    'Nombre 1',
                    'Nombre 2',
                    'Apellido 1',
                    'Apellido 2',
                    'abc@gmail.com',
                    TO_DATE('01/01/2000','MM/DD/YYYY'),
                    'O',
                    'Direccion de prueba'
                ),
                1000,
                (select s_id from C##NOV.SEDE where s_numerosede=1)
            ); 
-- Read (select)
select * from C##NOV.EMPLEADO;
-- Update (update)
update C##NOV.EMPLEADO set e_sueldo=5000 where e_id=1; 
-- Delete (delete)
delete from C##NOV.EMPLEADO where e_id=1;

-- Pruebas tabla ALIADO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.ALIADO values(
                default,
                'Aliado de prueba',
                EMPTY_BLOB()
            ); 
-- Read (select)
select * from C##NOV.ALIADO;
-- Update (update)
update C##NOV.ALIADO set ao_nombre='Nombre cambiado' where ao_id=3; 
-- Delete (delete)
delete from C##NOV.ALIADO where ao_id=1;

-- Pruebas tabla ALIANZA
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.ALIANZA values(
                default,
                C##NOV.periodo_duracion(
                    TO_DATE('01/01/2023','MM/DD/YYYY'),
                    TO_DATE('02/01/2023','MM/DD/YYYY')
                ),
                'Alianza de prueba',
                'Prueba',
                (select ao_id from C##NOV.ALIADO fetch first 1 row only),
                (select s_id from C##NOV.SEDE fetch first 1 row only)
            ); 
-- Read (select)
select * from C##NOV.ALIANZA;
-- Update (update)
update C##NOV.ALIANZA set aa_descripcion='Se modifico la descripcion' where aa_id=1; 
-- Delete (delete)
delete from C##NOV.ALIANZA where aa_id=1;

-- Pruebas tabla COMPRA
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.COMPRA values(
                default,
                2000,
                TO_DATE('01/01/2023','MM/DD/YYYY'),
                (select dc_id from C##NOV.detalle_compra fetch first 1 row only),
                (select s_id from C##NOV.SEDE fetch first 1 row only)
            ); 
-- Read (select)
select * from C##NOV.COMPRA;
-- Update (update)
update C##NOV.COMPRA set c_monto_total=6500 where c_id=1; 
-- Delete (delete)
delete from C##NOV.COMPRA where c_id=1;

-- Pruebas tabla DETALLE_COMPRA
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.DETALLE_COMPRA values (
    default,
    1,
    3500,
    (select v_placa from C##NOV.VEHICULO fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.DETALLE_COMPRA;
-- Update (update)
update C##NOV.DETALLE_COMPRA set dc_precio_unitario=6500 where dc_id=1; 
-- Delete (delete)
delete from C##NOV.DETALLE_COMPRA where dc_id=1;

-- Pruebas tabla MANTENIMIENTO_VEHICULO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.MANTENIMIENTO_VEHICULO values (
    default,
    C##NOV.periodo_duracion(
        TO_DATE('01/01/2023','MM/DD/YYYY'),
        TO_DATE('02/01/2023','MM/DD/YYYY')
    ),
    TO_DATE('03/01/2023','MM/DD/YYYY'),
    500,
    (select v_placa from C##NOV.VEHICULO fetch first 1 row only),
    (select sv_id from C##NOV.STATUS_VEHICULO fetch first 1 row only),
    (select mt_id from C##NOV.MANTENIMIENTO_TALLER fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.MANTENIMIENTO_VEHICULO;
-- Update (update)
update C##NOV.MANTENIMIENTO_VEHICULO set man_precio=6500 
    where man_id=(select man_id from C##NOV.MANTENIMIENTO_VEHICULO fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.MANTENIMIENTO_VEHICULO 
    where man_id=(select man_id from C##NOV.MANTENIMIENTO_VEHICULO fetch first 1 row only);

-- Pruebas tabla TALLER
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.TALLER values (
    default,
    'Taller de prueba',
    '123456',
    C##NOV.ubicacion_geografica(
        '150',
        '150',
        null
    ),
    10,
    (select l_id from C##NOV.LUGAR fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.TALLER;
-- Update (update)
update C##NOV.TALLER set t_nombre='Cambio de nombre'
    where t_id=(select t_id from C##NOV.TALLER fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.TALLER 
    where t_id=(select t_id from C##NOV.TALLER fetch first 1 row only);
    
-- Pruebas tabla MANTENIMIENTO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.MANTENIMIENTO values (
    default,
    'Matenimiento nuevo creado',
    (select tm_id from C##NOV.TIPO_MANTENIMIENTO fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.MANTENIMIENTO;
-- Update (update)
update C##NOV.MANTENIMIENTO set m_descripcion='Cambio de nombre'
    where m_id=(select m_id from C##NOV.MANTENIMIENTO fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.MANTENIMIENTO 
    where m_id=(select m_id from C##NOV.MANTENIMIENTO fetch first 1 row only);
    
-- Pruebas tabla MANTENIMIENTO_TALLER
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.MANTENIMIENTO_TALLER values (
    default,
    (select m_id from C##NOV.MANTENIMIENTO fetch first 1 row only),
    (select t_id from C##NOV.TALLER fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.MANTENIMIENTO_TALLER;
-- Update (update)
update C##NOV.MANTENIMIENTO_TALLER 
    set taller_t_id=(select t_id from C##NOV.TALLER fetch first 1 row only)
    where mt_id=(select mt_id from C##NOV.MANTENIMIENTO_TALLER fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.MANTENIMIENTO_TALLER 
    where mt_id=(select mt_id from C##NOV.MANTENIMIENTO_TALLER fetch first 1 row only);

-- Pruebas tabla VEHICULO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.VEHICULO values (
    'A009',
    2002,
    EMPTY_BLOB(),
    0,
    1200,
    (select m_id from C##NOV.modelo fetch first 1 row only),
    (select marca_ma_id from C##NOV.modelo fetch first 1 row only),
    (select sv_id from C##NOV.STATUS_VEHICULO fetch first 1 row only),
    (select c_id from C##NOV.COLOR fetch first 1 row only),
    (select tv_id from C##NOV.TIPO_VEHICULO fetch first 1 row only),
    (select s_id from C##NOV.SEDE fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.VEHICULO;
-- Update (update)
update C##NOV.VEHICULO 
    set v_precio=0
    where v_placa=(select v_placa from C##NOV.VEHICULO fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.VEHICULO 
    where v_placa=(select v_placa from C##NOV.VEHICULO fetch first 1 row only);
    
-- Pruebas tabla MODELO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.MODELO values (
    default,
    'Modelo nuevo',
    (select ma_id from C##NOV.MARCA fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.MODELO;
-- Update (update)
update C##NOV.MODELO 
    set m_nombre='Nombre nuevo'
    where m_id=(select m_id from C##NOV.MODELO fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.MODELO 
    where m_id=(select m_id from C##NOV.MODELO fetch first 1 row only);

-- Pruebas tabla MARCA
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.MARCA values (
    default,
    'Marca nueva'
);
-- Read (select)
select * from C##NOV.MARCA;
-- Update (update)
update C##NOV.MARCA 
    set ma_nombre='Nombre nuevo'
    where ma_id=(select ma_id from C##NOV.MARCA fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.MARCA 
    where ma_id=(select ma_id from C##NOV.MARCA fetch first 1 row only);
    
-- Pruebas tabla COLOR
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.COLOR values (
    default,
    'Color nuevo'
);
-- Read (select)
select * from C##NOV.COLOR;
-- Update (update)
update C##NOV.COLOR 
    set c_nombre='Nombre nuevo de color'
    where c_id=(select c_id from C##NOV.COLOR fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.COLOR 
    where c_id=(select c_id from C##NOV.COLOR fetch first 1 row only);
    
-- Pruebas tabla PROMOCION
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.PROMOCION values (
    default,
    20,
    'Nueva promocion'
);
-- Read (select)
select * from C##NOV.PROMOCION;
-- Update (update)
update C##NOV.PROMOCION 
    set p_descripcion='Descripcion nueva'
    where p_id=(select p_id from C##NOV.PROMOCION fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.PROMOCION 
    where p_id=(select p_id from C##NOV.PROMOCION fetch first 1 row only);
    
-- Pruebas tabla HISTORICO_PROMOCION
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.HISTORICO_PROMOCION values (
    default,
    C##NOV.periodo_duracion(
        TO_DATE('2023-05-20','yyyy-MM-dd'),
        TO_DATE('2023-06-20','yyyy-MM-dd')
    ),
    1,
    'AB169DA'
);
-- Read (select)
select * from C##NOV.HISTORICO_PROMOCION;
-- Update (update)
update C##NOV.HISTORICO_PROMOCION 
    set vehiculo_v_placa=(select v_placa from C##NOV.VEHICULO fetch first 1 row only)
    where hp_id=(select hp_id from C##NOV.HISTORICO_PROMOCION fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.HISTORICO_PROMOCION 
    where hp_id=(select hp_id from C##NOV.HISTORICO_PROMOCION fetch first 1 row only);

-- Pruebas tabla RESERVA
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.RESERVA values (
    default,
    TO_DATE('2023-05-20','yyyy-MM-dd'),
    'HECHA',
    (select c_id from C##NOV.CLIENTE fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.RESERVA;
-- Update (update)
update C##NOV.RESERVA 
    set re_estatus='CAMBIO STATUS'
    where re_id=(select re_id from C##NOV.RESERVA fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.RESERVA 
    where re_id=(select re_id from C##NOV.RESERVA fetch first 1 row only);

-- Pruebas tabla ALQUILER
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.ALQUILER values (
    default,
    1000,
    C##NOV.periodo_duracion(
        TO_DATE('2023-05-20','yyyy-MM-dd'),
        TO_DATE('2023-06-20','yyyy-MM-dd')
    ),
    NULL,
    (select da_id from C##NOV.DETALLE_ALQUILER fetch first 1 row only),
    (select c_id from C##NOV.CLIENTE fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.ALQUILER;
-- Update (update)
update C##NOV.ALQUILER 
    set a_monto_total=10000
    where a_id=(select a_id from C##NOV.ALQUILER fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.ALQUILER 
    where a_id=(select a_id from C##NOV.ALQUILER fetch first 1 row only);
    
-- Pruebas tabla ENTREGA
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.ENTREGA values (
    default,
    TO_TIMESTAMP ('21-mar-23 11:20:10.123000','DD-Mon-RR HH24:MI:SS.FF'),
    C##NOV.ubicacion_geografica(
        '150',
        '150',
        null
    ),
    'Descripcion entrega nueva',
    (select re_id from C##NOV.RESERVA fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.ENTREGA;
-- Update (update)
update C##NOV.ENTREGA 
    set e_hora=TO_TIMESTAMP ('01-mar-20 11:20:10.123000','DD-Mon-RR HH24:MI:SS.FF')
    where e_id=(select e_id from C##NOV.ENTREGA fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.ENTREGA 
    where e_id=(select e_id from C##NOV.ENTREGA fetch first 1 row only);
    
-- Pruebas tabla DENUNCIA
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.DENUNCIA values (
    default,
    TO_DATE('2023-06-20','yyyy-MM-dd'),
    'Descripcion denuncia nueva',
    (select a_id from C##NOV.ALQUILER fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.DENUNCIA;
-- Update (update)
update C##NOV.DENUNCIA 
    set d_descripcion='Nueva descripcion'
    where d_id=(select d_id from C##NOV.DENUNCIA fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.DENUNCIA 
    where d_id=(select d_id from C##NOV.DENUNCIA fetch first 1 row only);
    
-- Pruebas tabla DETALLE_ALQUILER
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.DETALLE_ALQUILER values (
    default,
    100,
    0,
    50,
    3,
    TO_DATE('2023-06-20','yyyy-MM-dd'),
    (select v_placa from C##NOV.VEHICULO fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.DETALLE_ALQUILER;
-- Update (update)
update C##NOV.DETALLE_ALQUILER 
    set da_km_final=250
    where da_id=(select da_id from C##NOV.DETALLE_ALQUILER fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.DETALLE_ALQUILER 
    where da_id=(select da_id from C##NOV.DETALLE_ALQUILER fetch first 1 row only);
    
-- Pruebas tabla DETALLE_PAGO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.DETALLE_PAGO values (
    default,
    (select fp_id from C##NOV.FORMA_PAGO fetch first 1 row only),
    100,
    (select a_id from C##NOV.ALQUILER fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.DETALLE_PAGO;
-- Update (update)
update C##NOV.DETALLE_PAGO 
    set dp_monto=2500
    where dtpg_id=(select dtpg_id from C##NOV.DETALLE_PAGO fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.DETALLE_PAGO 
    where dtpg_id=(select dtpg_id from C##NOV.DETALLE_PAGO fetch first 1 row only);
    
-- Pruebas a las tablas de solo lectura

-- Pruebas tabla TIPO_GASTO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.TIPO_GASTO values (
    default,
    'Nuevo tipo gasto'
);
-- Read (select)
select * from C##NOV.TIPO_GASTO;
-- Update (update)
update C##NOV.TIPO_GASTO 
    set tg_nombre='Modificacion'
    where tg_id=(select tg_id from C##NOV.TIPO_GASTO fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.TIPO_GASTO 
    where tg_id=(select tg_id from C##NOV.TIPO_GASTO fetch first 1 row only);
    
-- Pruebas tabla TIPO_MANTENIMIENTO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.TIPO_MANTENIMIENTO values (
    default,
    'Nuevo tipo mantenimiento'
);
-- Read (select)
select * from C##NOV.TIPO_MANTENIMIENTO;
-- Update (update)
update C##NOV.TIPO_MANTENIMIENTO 
    set tm_nombre='Modificacion'
    where tm_id=(select tm_id from C##NOV.TIPO_MANTENIMIENTO fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.TIPO_MANTENIMIENTO 
    where tm_id=(select tm_id from C##NOV.TIPO_MANTENIMIENTO fetch first 1 row only);
    
-- Pruebas tabla STATUS_MANTENIMIENTO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.STATUS_MANTENIMIENTO values (
    default,
    'Nuevo status mantenimiento'
);
-- Read (select)
select * from C##NOV.STATUS_MANTENIMIENTO;
-- Update (update)
update C##NOV.STATUS_MANTENIMIENTO 
    set s_nombre='Modificacion'
    where s_id=(select s_id from C##NOV.STATUS_MANTENIMIENTO fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.STATUS_MANTENIMIENTO 
    where s_id=(select s_id from C##NOV.STATUS_MANTENIMIENTO fetch first 1 row only);
    
-- Pruebas tabla STATUS_MANTENIMIENTO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.STATUS_VEHICULO values (
    default,
    'Nuevo status vehiculo'
);
-- Read (select)
select * from C##NOV.STATUS_VEHICULO;
-- Update (update)
update C##NOV.STATUS_VEHICULO 
    set sv_nombre='Modificacion'
    where sv_id=(select sv_id from C##NOV.STATUS_VEHICULO fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.STATUS_VEHICULO 
    where sv_id=(select sv_id from C##NOV.STATUS_VEHICULO fetch first 1 row only);
    
-- Pruebas tabla TIPO_VEHICULO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.TIPO_VEHICULO values (
    default,
    'Nuevo tipo vehiculo'
);
-- Read (select)
select * from C##NOV.TIPO_VEHICULO;
-- Update (update)
update C##NOV.TIPO_VEHICULO 
    set tv_nombre='Modificacion'
    where tv_id=(select tv_id from C##NOV.TIPO_VEHICULO fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.TIPO_VEHICULO 
    where tv_id=(select tv_id from C##NOV.TIPO_VEHICULO fetch first 1 row only);
    
-- Pruebas tabla FORMA_PAGO
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.FORMA_PAGO values (
    default,
    'Nueva forma pago'
);
-- Read (select)
select * from C##NOV.FORMA_PAGO;
-- Update (update)
update C##NOV.FORMA_PAGO 
    set fp_nombre='Modificacion'
    where fp_id=(select fp_id from C##NOV.FORMA_PAGO fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.FORMA_PAGO 
    where fp_id=(select fp_id from C##NOV.FORMA_PAGO fetch first 1 row only);
    
-- Pruebas tabla RATING
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.RATING values (
    default,
    TO_DATE('2023-06-20','yyyy-MM-dd'),
    5,
    5,
    (select a_id from C##NOV.ALQUILER fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.RATING;
-- Update (update)
update C##NOV.RATING 
    set r_escala_satisfaccion=0
    where r_id=(select r_id from C##NOV.RATING fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.RATING 
    where r_id=(select r_id from C##NOV.RATING fetch first 1 row only);
    
-- Pruebas tabla OBSERVACION
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.OBSERVACION values (
    default,
    'Descripcion de prueba',
    (select r_id from C##NOV.RATING fetch first 1 row only)
);
-- Read (select)
select * from C##NOV.OBSERVACION;
-- Update (update)
update C##NOV.OBSERVACION 
    set o_descripcion='Desc modificada'
    where o_id=(select o_id from C##NOV.OBSERVACION fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.OBSERVACION 
    where o_id=(select o_id from C##NOV.OBSERVACION fetch first 1 row only);
    
-- Pruebas tabla LUGAR
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.LUGAR values (
    default,
    'Lugar de prueba',
    'Estado',
    NULL
);
-- Read (select)
select * from C##NOV.LUGAR;
-- Update (update)
update C##NOV.LUGAR 
    set l_nombre='Nombre modificado'
    where l_id=(select l_id from C##NOV.LUGAR fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.LUGAR 
    where l_id=(select l_id from C##NOV.LUGAR fetch first 1 row only);
    
-- Pruebas tabla TIPO_CLIENTE
--------------------------------------------------------------------------------
-- Create (insert)
insert into C##NOV.TIPO_CLIENTE values (
    default,
    'Tipo cliente de prueba'
);
-- Read (select)
select * from C##NOV.TIPO_CLIENTE;
-- Update (update)
update C##NOV.TIPO_CLIENTE 
    set tc_nombre='Nombre modificado'
    where tc_id=(select tc_id from C##NOV.TIPO_CLIENTE fetch first 1 row only); 
-- Delete (delete)
delete from C##NOV.TIPO_CLIENTE 
    where tc_id=(select tc_id from C##NOV.TIPO_CLIENTE fetch first 1 row only);
    
--------------------------------------------------------------------------------
-- Prueba de funciones de sistema
--------------------------------------------------------------------------------
-- Users
--------------------------------------------------------------------------------
-- Create user
create user C##PruebaUsuario 
    identified by abc123 
    default tablespace USERS;
-- Grant a privilege
grant insert,select,update,delete on 
    C##NOV.TIPO_CLIENTE to C##GerenteGeneralConcesionario;
grant insert,select,update,delete on 
    C##NOV.TIPO_CLIENTE to C##GerenteGeneralSede;
grant insert,select,update,delete on 
    C##NOV.TIPO_CLIENTE to C##SupervisorAreaInventario;
grant insert,select,update,delete on 
    C##NOV.TIPO_CLIENTE to C##SupervisorAreaMercadeo;
grant insert,select,update,delete on 
    C##NOV.TIPO_CLIENTE to C##SupervisorAreaAlquileresReservas;
-- Revoke a privilege
revoke insert,select,update,delete on 
    C##NOV.TIPO_CLIENTE from C##GerenteGeneralConcesionario;
revoke insert,select,update,delete on 
    C##NOV.TIPO_CLIENTE from C##GerenteGeneralSede;
revoke insert,select,update,delete on 
    C##NOV.TIPO_CLIENTE from C##SupervisorAreaInventario;
revoke insert,select,update,delete on 
    C##NOV.TIPO_CLIENTE from C##SupervisorAreaMercadeo;
revoke insert,select,update,delete on 
    C##NOV.TIPO_CLIENTE from C##SupervisorAreaAlquileresReservas;
-- DML
--------------------------------------------------------------------------------
-- Create table
create table tabla_prueba (
    id      number,
    nombre  varchar2(50)
);
-- Alter table
alter table C##NOV.TIPO_CLIENTE add columna_prueba varchar2(50);
-- Drop table
drop table C##NOV.TIPO_CLIENTE;
-- Create view
create view vista_prueba as select tc_nombre from C##NOV.TIPO_CLIENTE;
-- Create a TDA 
create or replace type tda_prueba as object (
    -- atributos del objeto
    UG_Latitud      varchar2(12), -- dada como 180.623215 o -180.102456
    UG_Longitud     varchar2(12), -- dada como 180.623215 o -180.102456   
    UG_Time_Stamp   timestamp,
    -- metodos static del objeto
    static FUNCTION verificar_latitud (latitud varchar2) return varchar2
); 
-- stored procedure
create or replace package test_pkg as
    FUNCTION get_intervalo_fechas(fecha_inicio date, fecha_fin date) RETURN fechas_associative_array;
    PROCEDURE main_simulacion(fecha_inicio varchar2, fecha_fin varchar2);
end test_pkg;

