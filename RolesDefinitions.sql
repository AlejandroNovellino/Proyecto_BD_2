-- (ESTO DEBE CORRERSE DESDE EL USUARIO DUENO DE LAS TABLAS EN ESTE CASO C##NOV)

-- Creacion de los roles que se trabajaran en el sistema
--------------------------------------------------------------------------------
-- Rol para el Gerente General de Concesionario (GGC)
create role C##GerenteGeneralConcesionario;
/
-- Rol para el Gerente General de Sede (GGS)
create role C##GerenteGeneralSede;
/
-- Rol para el Supervisor del Area de Inventario (SAI)
create role C##SupervisorAreaInventario;
/
-- Rol para el Supervisor del Area de Mercadeo (SAM)
create role C##SupervisorAreaMercadeo;
/
-- Rol para el Supervisor del Area de Alquileres y Reservas (SAAR)
create role C##SupervisorAreaAlquileresReservas;
/

-- Permisos para los roles
--------------------------------------------------------------------------------

-- Permisos para el rol de Gerente de Concesionario ----------------------------
--------------------------------------------------------------------------------
grant select,update on C##NOV.CONSESIONARIO to C##GerenteGeneralConcesionario;
/
grant insert,select,update on C##NOV.SEDE to C##GerenteGeneralConcesionario;
/
grant insert,select,update on C##NOV.CLIENTE to C##GerenteGeneralConcesionario;
/
grant insert,select on C##NOV.GASTO to C##GerenteGeneralConcesionario;
/
grant insert,select on C##NOV.INGRESO to C##GerenteGeneralConcesionario;
/
grant insert,select,update on C##NOV.EMPLEADO to C##GerenteGeneralConcesionario;
/
grant insert,select,update on C##NOV.ALIADO to C##GerenteGeneralConcesionario;
/
grant insert,select,update on C##NOV.ALIANZA to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.COMPRA to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.DETALLE_COMPRA to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.MANTENIMIENTO_VEHICULO to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.TALLER to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.MANTENIMIENTO to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.MANTENIMIENTO_TALLER to C##GerenteGeneralConcesionario;
/
grant insert,select,update on C##NOV.VEHICULO to C##GerenteGeneralConcesionario;
/
grant insert,select,update on C##NOV.MODELO to C##GerenteGeneralConcesionario;
/
grant insert,select,update on C##NOV.MARCA to C##GerenteGeneralConcesionario;
/
grant insert,select,update on C##NOV.COLOR to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.PROMOCION to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.HISTORICO_PROMOCION to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.RESERVA to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.ALQUILER to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.ENTREGA to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.DENUNCIA to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.DETALLE_ALQUILER to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.DETALLE_PAGO to C##GerenteGeneralConcesionario;
/
-- Tablas de solo select para todos los roles
grant select on C##NOV.TIPO_GASTO to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.TIPO_MANTENIMIENTO to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.STATUS_MANTENIMIENTO to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.STATUS_VEHICULO to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.TIPO_VEHICULO to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.FORMA_PAGO to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.RATING to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.OBSERVACION to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.LUGAR to C##GerenteGeneralConcesionario;
/
grant select on C##NOV.TIPO_CLIENTE to C##GerenteGeneralConcesionario;
/
-- Permisos sobre los ADT
grant execute on C##NOV.informacion_personal to C##GerenteGeneralConcesionario;
/
grant execute on C##NOV.ubicacion_geografica to C##GerenteGeneralConcesionario;
/
grant execute on C##NOV.periodo_duracion to C##GerenteGeneralConcesionario;
/
--------------------------------------------------------------------------------

-- Permisos para el rol de Gerente de General de Sede --------------------------
--------------------------------------------------------------------------------
grant select on C##NOV.CONSESIONARIO to C##GerenteGeneralSede;
/
grant select on C##NOV.SEDE to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.CLIENTE to C##GerenteGeneralSede;
/
grant insert,select on C##NOV.GASTO to C##GerenteGeneralSede;
/
grant insert,select on C##NOV.INGRESO to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.EMPLEADO to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.ALIADO to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.ALIANZA to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.COMPRA to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.DETALLE_COMPRA to C##GerenteGeneralSede;
/
grant select on C##NOV.MANTENIMIENTO_VEHICULO to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.TALLER to C##GerenteGeneralSede;
/
grant select on C##NOV.MANTENIMIENTO to C##GerenteGeneralSede;
/
grant select on C##NOV.MANTENIMIENTO_TALLER to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.VEHICULO to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.MODELO to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.MARCA to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.COLOR to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.PROMOCION to C##GerenteGeneralSede;
/
grant select on C##NOV.HISTORICO_PROMOCION to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.RESERVA to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.ALQUILER to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.ENTREGA to C##GerenteGeneralSede;
/
grant insert,select on C##NOV.DENUNCIA to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.DETALLE_ALQUILER to C##GerenteGeneralSede;
/
grant insert,select,update on C##NOV.DETALLE_PAGO to C##GerenteGeneralSede;
/
-- Tablas de solo select para todos los roles
grant select on C##NOV.TIPO_GASTO to C##GerenteGeneralSede;
/
grant select on C##NOV.TIPO_MANTENIMIENTO to C##GerenteGeneralSede;
/
grant select on C##NOV.STATUS_MANTENIMIENTO to C##GerenteGeneralSede;
/
grant select on C##NOV.STATUS_VEHICULO to C##GerenteGeneralSede;
/
grant select on C##NOV.TIPO_VEHICULO to C##GerenteGeneralSede;
/
grant select on C##NOV.FORMA_PAGO to C##GerenteGeneralSede;
/
grant select on C##NOV.RATING to C##GerenteGeneralSede;
/
grant select on C##NOV.OBSERVACION to C##GerenteGeneralSede;
/
grant select on C##NOV.LUGAR to C##GerenteGeneralSede;
/
grant select on C##NOV.TIPO_CLIENTE to C##GerenteGeneralSede;
/
-- Permisos sobre los ADT
grant execute on C##NOV.informacion_personal to C##GerenteGeneralSede;
/
grant execute on C##NOV.ubicacion_geografica to C##GerenteGeneralSede;
/
grant execute on C##NOV.periodo_duracion to C##GerenteGeneralSede;
/
--------------------------------------------------------------------------------

-- Permisos para el rol de Supervisor Area Inventario --------------------------
--------------------------------------------------------------------------------
grant select on C##NOV.CONSESIONARIO to C##SupervisorAreaInventario;
/
grant select on C##NOV.SEDE to C##SupervisorAreaInventario;
/
grant select on C##NOV.CLIENTE to C##SupervisorAreaInventario;
/
grant insert,select on C##NOV.GASTO to C##SupervisorAreaInventario;
/
grant insert,select on C##NOV.INGRESO to C##SupervisorAreaInventario;
/
grant select on C##NOV.EMPLEADO to C##SupervisorAreaInventario;
/
grant select on C##NOV.ALIADO to C##SupervisorAreaInventario;
/
grant select on C##NOV.ALIANZA to C##SupervisorAreaInventario;
/
grant insert,select,update on C##NOV.COMPRA to C##SupervisorAreaInventario;
/
grant insert,select,update on C##NOV.DETALLE_COMPRA to C##SupervisorAreaInventario;
/
grant insert,select,update on C##NOV.MANTENIMIENTO_VEHICULO to C##SupervisorAreaInventario;
/
grant insert,select,update on C##NOV.TALLER to C##SupervisorAreaInventario;
/
grant insert,select,update on C##NOV.MANTENIMIENTO to C##SupervisorAreaInventario;
/
grant insert,select,update on C##NOV.MANTENIMIENTO_TALLER to C##SupervisorAreaInventario;
/
grant insert,select,update on C##NOV.VEHICULO to C##SupervisorAreaInventario;
/
grant insert,select,update on C##NOV.MODELO to C##SupervisorAreaInventario;
/
grant insert,select,update on C##NOV.MARCA to C##SupervisorAreaInventario;
/
grant insert,select,update on C##NOV.COLOR to C##SupervisorAreaInventario;
/
grant select on C##NOV.PROMOCION to C##SupervisorAreaInventario;
/
grant select on C##NOV.HISTORICO_PROMOCION to C##SupervisorAreaInventario;
/
grant select on C##NOV.RESERVA to C##SupervisorAreaInventario;
/
grant select on C##NOV.ALQUILER to C##SupervisorAreaInventario;
/
grant select on C##NOV.ENTREGA to C##SupervisorAreaInventario;
/
grant select on C##NOV.DENUNCIA to C##SupervisorAreaInventario;
/
grant select on C##NOV.DETALLE_ALQUILER to C##SupervisorAreaInventario;
/
grant select on C##NOV.DETALLE_PAGO to C##SupervisorAreaInventario;
/
-- Tablas de solo select para todos los roles
grant select on C##NOV.TIPO_GASTO to C##SupervisorAreaInventario;
/
grant select on C##NOV.TIPO_MANTENIMIENTO to C##SupervisorAreaInventario;
/
grant select on C##NOV.STATUS_MANTENIMIENTO to C##SupervisorAreaInventario;
/
grant select on C##NOV.STATUS_VEHICULO to C##SupervisorAreaInventario;
/
grant select on C##NOV.TIPO_VEHICULO to C##SupervisorAreaInventario;
/
grant select on C##NOV.FORMA_PAGO to C##SupervisorAreaInventario;
/
grant select on C##NOV.RATING to C##SupervisorAreaInventario;
/
grant select on C##NOV.OBSERVACION to C##SupervisorAreaInventario;
/
grant select on C##NOV.LUGAR to C##SupervisorAreaInventario;
/
grant select on C##NOV.TIPO_CLIENTE to C##SupervisorAreaInventario;
/
-- Permisos sobre los ADT
grant execute on C##NOV.informacion_personal to C##SupervisorAreaInventario;
/
grant execute on C##NOV.ubicacion_geografica to C##SupervisorAreaInventario;
/
grant execute on C##NOV.periodo_duracion to C##SupervisorAreaInventario;
/
--------------------------------------------------------------------------------

-- Permisos para el rol de Supervisor Area Mercadeo ----------------------------
--------------------------------------------------------------------------------
grant select on C##NOV.CONSESIONARIO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.SEDE to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.CLIENTE to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.GASTO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.INGRESO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.EMPLEADO to C##SupervisorAreaMercadeo;
/
grant insert,select,update on C##NOV.ALIADO to C##SupervisorAreaMercadeo;
/
grant insert,select,update on C##NOV.ALIANZA to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.COMPRA to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.DETALLE_COMPRA to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.MANTENIMIENTO_VEHICULO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.TALLER to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.MANTENIMIENTO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.MANTENIMIENTO_TALLER to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.VEHICULO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.MODELO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.MARCA to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.COLOR to C##SupervisorAreaMercadeo;
/
grant insert,select,update on C##NOV.PROMOCION to C##SupervisorAreaMercadeo;
/
grant insert,select,update on C##NOV.HISTORICO_PROMOCION to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.RESERVA to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.ALQUILER to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.ENTREGA to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.DENUNCIA to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.DETALLE_ALQUILER to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.DETALLE_PAGO to C##SupervisorAreaMercadeo;
/
-- Tablas de solo select para todos los roles
grant select on C##NOV.TIPO_GASTO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.TIPO_MANTENIMIENTO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.STATUS_MANTENIMIENTO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.STATUS_VEHICULO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.TIPO_VEHICULO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.FORMA_PAGO to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.RATING to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.OBSERVACION to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.LUGAR to C##SupervisorAreaMercadeo;
/
grant select on C##NOV.TIPO_CLIENTE to C##SupervisorAreaMercadeo;
/
-- Permisos sobre los ADT
grant execute on C##NOV.informacion_personal to C##SupervisorAreaMercadeo;
/
grant execute on C##NOV.ubicacion_geografica to C##SupervisorAreaMercadeo;
/
grant execute on C##NOV.periodo_duracion to C##SupervisorAreaMercadeo;
/
--------------------------------------------------------------------------------

-- Permisos para el rol de Supervisor Area Reservas y Alquileres ---------------
--------------------------------------------------------------------------------
grant select on C##NOV.CONSESIONARIO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.SEDE to C##SupervisorAreaAlquileresReservas;
/
grant insert,select,update on C##NOV.CLIENTE to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.GASTO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.INGRESO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.EMPLEADO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.ALIADO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.ALIANZA to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.COMPRA to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.DETALLE_COMPRA to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.MANTENIMIENTO_VEHICULO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.TALLER to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.MANTENIMIENTO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.MANTENIMIENTO_TALLER to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.VEHICULO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.MODELO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.MARCA to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.COLOR to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.PROMOCION to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.HISTORICO_PROMOCION to C##SupervisorAreaAlquileresReservas;
/
grant insert,select,update on C##NOV.RESERVA to C##SupervisorAreaAlquileresReservas;
/
grant insert,select,update on C##NOV.ALQUILER to C##SupervisorAreaAlquileresReservas;
/
grant insert,select,update on C##NOV.ENTREGA to C##SupervisorAreaAlquileresReservas;
/
grant insert,select on C##NOV.DENUNCIA to C##SupervisorAreaAlquileresReservas;
/
grant insert,select,update on C##NOV.DETALLE_ALQUILER to C##SupervisorAreaAlquileresReservas;
/
grant insert,select on C##NOV.DETALLE_PAGO to C##SupervisorAreaAlquileresReservas;
/
-- Tablas de solo select para todos los roles
grant select on C##NOV.TIPO_GASTO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.TIPO_MANTENIMIENTO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.STATUS_MANTENIMIENTO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.STATUS_VEHICULO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.TIPO_VEHICULO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.FORMA_PAGO to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.RATING to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.OBSERVACION to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.LUGAR to C##SupervisorAreaAlquileresReservas;
/
grant select on C##NOV.TIPO_CLIENTE to C##SupervisorAreaAlquileresReservas;
/
-- Permisos sobre los ADT
grant execute on C##NOV.informacion_personal to C##SupervisorAreaAlquileresReservas;
/
grant execute on C##NOV.ubicacion_geografica to C##SupervisorAreaAlquileresReservas;
/
grant execute on C##NOV.periodo_duracion to C##SupervisorAreaAlquileresReservas;
/
--------------------------------------------------------------------------------

-- Grant de los roles a las cuentas creadas
--------------------------------------------------------------------------------
-- Roles a la cuenta C##Pedro_GGC
grant C##GerenteGeneralConcesionario to C##PEDRO_GGC;
/
-- Roles a la cuenta C##Martha_GGS
grant C##GerenteGeneralSede to C##MARTHA_GGS;
/
-- Roles a la cuenta C##Carlos_SAI
grant C##SupervisorAreaInventario to C##CARLOS_SAI;
/
-- Roles a la cuenta C##Vanesa_SAM
grant C##SupervisorAreaMercadeo to C##VANESA_SAM;
/
-- Roles a la cuenta C##Rodrigo_SAAR
grant C##SupervisorAreaAlquileresReservas to C##RODRIGO_SAAR;
/
