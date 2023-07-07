-- Consutla para verificar todos los usuarios dentro de la base de datos
select * from dba_users;
-- Consulta para ver los roles que se han otorgado a usuarios
select * from dba_role_privs;
-- Consulta para ver que roles se le han otorgado al ususario = 'C##PEDRO_GCC'
select * from dba_role_privs where grantee='C##PEDRO_GGC';
--  Consulta para verificar que privilegios de sistema tiene cada usuario
select * from dba_sys_privs;
--  Consulta para verificar que privilegios sobre objetos tiene el usuario que ocrre el query
select * from user_tab_privs;
-- Consulta para verificar los privilegios de un usuario sobre objetos que no son tablas
select grantee, owner, privilege, table_name from dba_tab_privs where grantee='C##NOV';

-- Consulta para obtener todos los permisos de un usuario
select
  lpad(' ', 2*level) || granted_role "User, his roles and system privileges"
from
  (
  /* THE USERS */
    select 
      null     grantee, 
      username granted_role
    from 
      dba_users
    where
      username like upper('C##PEDRO_GGC')
  /* THE ROLES TO ROLES RELATIONS */ 
  union
    select 
      grantee,
      granted_role
    from
      dba_role_privs
  /* THE ROLES TO PRIVILEGE RELATIONS */ 
  union
    select
      grantee,
      privilege
    from
      dba_sys_privs
  )
start with grantee is null
connect by grantee = prior granted_role;

-- Probamos los selects que en teoria tiene permiso el usuario 
--      Para hacerlo se cambia de conexion a la del usuario que se desea probar
--      y se realizan las querys indicadas
select * from C##NOV.CONSESIONARIO;
delete from C##NOV.CONSESIONARIO where C_ID=22;
insert into CONSESIONARIO values(
                default,
                'Prueba',
                '04141234567',
                'Direccion de prueba',
                1    
            ); 
select * from VEHICULO;