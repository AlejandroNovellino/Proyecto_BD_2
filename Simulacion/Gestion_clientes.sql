create or replace package gestion_clientes_pkg as
    -- procedure para registrar una persona en el sistema
    procedure registro_cliente(persona_a_registrar persona%rowtype, cliente_registrado OUT cliente%rowtype, se_debe_imprimir boolean default true);
    
    -- ya el escenario 1 del paquete fue atendido por un trigger 

end gestion_clientes_pkg;
/

create or replace package body gestion_clientes_pkg as
    ----------------------------------------------------------------------------
    -- procedure para registrar una persona en el sistema
    procedure registro_cliente(persona_a_registrar persona%rowtype, cliente_registrado OUT cliente%rowtype, se_debe_imprimir boolean default true)
    is
        id_cliente_insertado number;        -- cedula del cliente recien insertado
        fecha_de_registro date := null;     -- fecha de registro 
    begin
        if (se_debe_imprimir) then
            -- se imprimen los datos de la persona a registrar
            DBMS_OUTPUT.PUT_LINE('  - Se registrara a:');
            utilities_pkg.print_persona(persona_a_registrar);
        end if;
        
        -- buscamos la fecha de hoy
        select SYSDATE into fecha_de_registro from dual;
        
        -- realizamos el registro de esta persona en la tabla cliente
        insert into cliente values(
            default,
            informacion_personal(
                persona_a_registrar.ip.IP_cedula,
                persona_a_registrar.ip.IP_Primer_Nombre,
                persona_a_registrar.ip.IP_Segundo_Nombre,
                persona_a_registrar.ip.IP_Primer_Apeliido,
                persona_a_registrar.ip.IP_Segundo_Apellido,
                persona_a_registrar.ip.IP_Correo,
                persona_a_registrar.ip.IP_Fecha_Nacimiento,
                persona_a_registrar.ip.IP_Sexo,
                persona_a_registrar.ip.IP_Direccion
            ),
            persona_a_registrar.foto,
            persona_a_registrar.ubicacion_mapa,
            persona_a_registrar.tipo_cliente,
            fecha_de_registro,
            persona_a_registrar.lugar
        ) RETURNING c_id INTO id_cliente_insertado;
        
        -- buscamos el cliente recien insertado
        select * into cliente_registrado from cliente c where c.c_id=id_cliente_insertado;
        
        -- borramos de la tabla persona a la persona que cabamos de registrar como cliente
        delete from persona p where p.ip.IP_cedula = cliente_registrado.c_informacion_personal.IP_cedula;
        
        if (se_debe_imprimir) then
            -- indicamos que la persona fue registrada satisfactoriamente en el sistema
            DBMS_OUTPUT.PUT_LINE('          La persona no estaba registradad como cliente');
            DBMS_OUTPUT.PUT_LINE('          Se ha registrado a la persona en el sisteam satisfactoriamente');
        end if;
        
    end registro_cliente;

end gestion_clientes_pkg;
/

-- esto es para probar las funciones -------------------------------------------

