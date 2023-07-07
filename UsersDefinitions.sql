-- Creacion de los usuarios a utilizar en el sistema
-- (ESTO DEBE CORRERSE DESDE EL USUARIO DUENO DE LAS TABLAS EN ESTE CASO C##NOV)

--------------------------------------------------------------------------------
-- Usuario Pedro que sera Gerente General de Concesionario
create user C##Pedro_GGC 
    identified by abc123 
    default tablespace USERS;
/
--------------------------------------------------------------------------------
-- Usuario Pedro que sera Gerente General de Concesionario
create user C##Martha_GGS 
    identified by abc123 
    default tablespace USERS;
/
--------------------------------------------------------------------------------
-- Usuario Pedro que sera Gerente General de Concesionario
create user C##Carlos_SAI 
    identified by abc123 
    default tablespace USERS;
/
--------------------------------------------------------------------------------
-- Usuario Pedro que sera Gerente General de Concesionario
create user C##Vanesa_SAM 
    identified by abc123 
    default tablespace USERS;
/
--------------------------------------------------------------------------------
-- Usuario Pedro que sera Gerente General de Concesionario
create user C##Rodrigo_SAAR 
    identified by abc123 
    default tablespace USERS;
/

-- Permisos otorgados a nivel de cuenta opara las cuentas anteriormente creadas
--------------------------------------------------------------------------------
-- Permisos de inicio de sesion
grant create session to C##Pedro_GGC;
/
grant create session to C##Martha_GGS;
/
grant create session to C##Carlos_SAI;
/
grant create session to C##Vanesa_SAM;
/
grant create session to C##Rodrigo_SAAR;
/
