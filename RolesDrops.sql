-- (ESTO DEBE CORRERSE DESDE EL USUARIO DUENO DE LAS TABLAS EN ESTE CASO C##NOV)

--Revokes de los roles
--------------------------------------------------------------------------------
-- Roles de la cuenta C##Pedro_GGC
revoke C##GerenteGeneralConcesionario from C##Pedro_GGC;
-- Roles de la cuenta C##Martha_GGS
revoke C##GerenteGeneralSede from C##Martha_GGS;
-- Roles de la cuenta C##Carlos_SAI
revoke C##SupervisorAreaInventario from C##Carlos_SAI;
-- Roles de la cuenta C##Vanesa_SAM
revoke C##SupervisorAreaMercadeo from C##Vanesa_SAM;
-- Roles de la cuenta C##Rodrigo_SAAR
revoke C##SupervisorAreaAlquileresReservas from C##Rodrigo_SAAR;

--Eliminacion de los Roles
--------------------------------------------------------------------------------
drop role C##GerenteGeneralConcesionario;
/
drop role C##GerenteGeneralSede;
/
drop role C##SupervisorAreaInventario;
/
drop role C##SupervisorAreaMercadeo;
/
drop role C##SupervisorAreaAlquileresReservas;
/



