create or replace package reserva_and_alquiler_pkg as
    -- procedure para alquiler
    procedure reserva(cliente_reservar cliente%rowtype);
    -- procedure para alquiler
    procedure simulacion_reservas;
end reserva_and_alquiler_pkg;
/

create or replace package body reserva_and_alquiler_pkg as
    -- procedure para alquiler
    procedure reserva(cliente_reservar cliente%rowtype)
    is 
        tipo_cliente_actual tipo_cliente%rowtype; -- tipo de cliente del cliente actual
        
    begin
        -- buscamos el tipo de cliente
        select * into tipo_cliente_actual from tipo_cliente where tc_id=cliente_reservar.tipo_cliente_tc_id;
        -- verificamos si es un cliente no deseado
        if (tipo_cliente_actual = 'no deseado') then 
            -- imprimimos que el cliente es no deseado
            utilities_pkg.print_cliente(cliente_reservar, 'Tipo de cliente no deseado');
            return; -- finaliza el procedure
        end if;
        --- SEGUIR CON EL DESARROLLO
    end reserva;
    -- procedure para alquiler
    procedure simulacion_reservas 
    is
        numero_reservas number;
        cliente_actual cliente%rowtype;
    begin
        -- numero de reservas a realizar
        numero_reservas := utilities_pkg.get_random_integer();
        -- iteramos para cada reserva
        for i in 0..numero_reservas loop
            -- seleccionamos un cliente registrado de forma aleatoria
            cliente_actual := utilities_pkg.get_cliente_random();
            -- realizamos una reserva para el cliente
            reserva(cliente_actual);
        end loop;
        
    end simulacion_reservas;
end reserva_and_alquiler_pkg;
