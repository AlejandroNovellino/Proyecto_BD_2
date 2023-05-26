create or replace package reserva_and_alquiler_pkg as
    -- procedure para alquiler
    procedure reserva(cliente_reservar cliente%rowtype, dia_actual date, fecha_fin_simulacion date);
    -- procedure para alquiler
    procedure simulacion_reservas;
end reserva_and_alquiler_pkg;
/

create or replace package body reserva_and_alquiler_pkg as
    ----------------------------------------------------------------------------
    -- procedure para alquiler
    procedure reserva(cliente_reservar cliente%rowtype, dia_actual date, fecha_fin_simulacion date)
    is 
        tipo_cliente_actual tipo_cliente%rowtype; -- tipo de cliente del cliente actual
        periodo_duracion_reserva periodo_duracion; -- periodo durante el cual sera el alquiler a reservar
        
    begin
        -- buscamos el tipo de cliente
        select * into tipo_cliente_actual from tipo_cliente where tc_id=cliente_reservar.tipo_cliente_tc_id;
        -- verificamos si es un cliente no deseado
        if (tipo_cliente_actual = 'no deseado') then 
            -- imprimimos que el cliente es no deseado
            utilities_pkg.print_cliente(cliente_reservar, 'Tipo de cliente no deseado');
            return; -- finaliza el procedure
        end if;
        -- se selecciona el periodo durante el que sera el alquiler
        periodo_duracion_reserva := utilities_pkg.get_random_periodo(
            dia_actual, 
            fecha_fin_simulacion
        );
        -- se traen todos los carros para aquiler (esten o no dispoibles para el periodo)
        
        -- se selecciona un vehiculo de las lista
        
        -- se valida si esta disponible
        
        -- 
        
        
        --- SEGUIR CON EL DESARROLLO
    end reserva;
    ----------------------------------------------------------------------------
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
