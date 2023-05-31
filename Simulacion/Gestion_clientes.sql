create or replace package gestion_clientes_pkg as
    -- procedure para registrar una persona en el sistema
    procedure registro_cliente(persona_a_registrar persona%rowtype, liente_registrado OUT cliente%rowtype);
    
    -- ya el escenario 1 del paquete fue atendido por un trigger 

end gestion_clientes_pkg;
/

create or replace package body gestion_clientes_pkg as
    ----------------------------------------------------------------------------
    -- procedure para registrar una persona en el sistema
    procedure registro_cliente(persona_a_registrar persona%rowtype, cliente_registrado OUT cliente%rowtype)
    is
        id_cliente_insertado number;                -- cedula del cliente recien insertado
        pk_tipo_cliente_cliente_a_registrar number; -- pk del tipo de cliente para las personas recien insertadas en el sistema
    begin
        -- se imprimen los datos de la persona a registrar
        DBMS_OUTPUT.PUT_LINE('Se registrara a:');
        utilities_pkg.print_persona(persona_a_registrar);
        
        -- buscamos el pk del tipo de cliente 'ocasional'
        select tc.tc_id into pk_tipo_cliente_cliente_a_registrar from tipo_cliente where tc_nombre = 'ocasional';
        
        -- realizamos el registro de esta persona en la tabla cliente
        insert into cliente values(
            default,
            persona_registrar.c_foto,
            persona_registrar.lugar_l_id,
            pk_tipo_cliente_cliente_a_registrar,
            informacion_personal(
                persona_registrar.ip.IP_cedula,
                persona_registrar.ip.IP_Primer_Nombre,
                persona_registrar.ip.IP_Segundo_Nombre,
                persona_registrar.ip.IP_Primer_Apellido,
                persona_registrar.ip.IP_Segundo_Apellido,
                persona_registrar.ip.IP_Correo,
                persona_registrar.ip.IP_Fecha_Nacimiento,
                persona_registrar.ip.IP_Sexo,
                persona_registrar.ip.IP_Direccion
            )
        ) RETURNING c_id INTO id_cliente_insertado;
        
        -- buscamos el cliente recien insertado
        select * into cliente_registrado from cliente where c_id=id_cliente_insertado;
        
        -- borramos de la tabla persona a la persona que cabamos de registrar como cliente
        delete from persona p where p.ip.IP_cedula = cedula_cliente;
        
        -- indicamos que la persona fue registrada satisfactoriamente en el sistema
        DBMS_OUTPUT.PUT_LINE('Se ha registrado a la persona en el sisteam satisfactoriamente.');
        
    end registro_cliente;

end gestion_clientes_pkg;
/

-- esto es para probar las funciones -------------------------------------------

