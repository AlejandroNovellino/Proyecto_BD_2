create or replace package reserva_and_alquiler_pkg as
    -- procedure para alquiler
    procedure alquiler(cliente_reservar cliente%rowtype, dia_actual date, fecha_fin_simulacion date);
    -- procedure para reserva
    procedure reserva(cliente_reservar cliente%rowtype, dia_actual date, fecha_fin_simulacion date);
    -- procedure para simular el modulo de reservas
    procedure simulacion_reservas(pk_sede number);
    -- procedure para simular el modulo de alquileres
    procedure simulacion_alquileres(pk_sede number, dia_actual date, fecha_fin_simulacion date);
end reserva_and_alquiler_pkg;
/

create or replace package body reserva_and_alquiler_pkg as
    ----------------------------------------------------------------------------
    -- procedure para alquilar
    procedure alquiler(dia_actual date, fecha_fin_simulacion date, cliente_a_alquilar cliente%rowtype DEFAULT NULL, persona_a_alquilar persona%rowtype DEFAULT NULL)
    is
        
    begin
        
        
        
    end alquiler;
    ----------------------------------------------------------------------------
    -- procedure para reserva
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
        numero_reservas number;                 -- numero de reservas a realizar
        
        prob_cliente number := 75;              -- probabilidad en % de que se seleccione un cliente para realizar el proceso de alquiler
        cliente_seleccionado cliente%rowtype;   -- variable para guardar si se selecciono un cliente
        persona_seleccionada persona%rowtype;   -- variable para guardar si se selecciono un cliente
        
    begin
        -- numero de reservas a realizar
        numero_reservas := utilities_pkg.get_random_integer();
        -- iteramos para cada reserva
        for i in 0..numero_reservas loop
            -- verificamos si la reserva la hara una persona o un cliente basado en la probabilidad establecida
            if(utilities_pkg.get_random_integer(0, 101) <= 75) then
                -- si la hace un cliente 
                cliente_seleccionado := utilities_pkg.get_persona_random();
            else
                -- si la hace una persona no resgitrada
                persona_seleccionada := utilities_pkg.get_cliente_random();
            end if;
            
            -- realizamos una reserva para el cliente
            reserva(cliente_seleccionado);
            --
        end loop;
        
    end simulacion_reservas;
    ----------------------------------------------------------------------------
    -- procedure para simular el modulo de alquileres
    procedure simulacion_alquileres(pk_sede number, dia_actual date, fecha_fin_simulacion date) 
    is
        numero_alquileres number;                 -- numero de alquileres a realizar
        
        prob_cliente number := 75;                -- probabilidad en % de que se seleccione un cliente para realizar el proceso de alquiler
        cliente_seleccionado cliente%rowtype;     -- variable para guardar si se selecciono un cliente
        persona_seleccionada persona%rowtype;     -- variable para guardar si se selecciono un cliente
        
        tipo_cliente_actual tipo_cliente%rowtype; -- tipo de cliente del cliente actual seleccionado
    begin
        -- indicamos que dio inicio el modulo
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('INICIA LA SIMULACION DE ALQUILERES');
        -- numero de alquileres a realizar
        numero_alquileres := utilities_pkg.get_random_integer(0,16);
        -- iteramos para cada reserva
        for i in 0..numero_alquileres loop
            -- verificamos si la reserva la hara una persona o un cliente basado en la probabilidad establecida
            if(utilities_pkg.get_random_integer(0, 101) <= 75) then
                -- si la hace un cliente 
                cliente_seleccionado := utilities_pkg.get_cliente_random();
            else
                -- si la hace una persona no registrada
                persona_seleccionada := utilities_pkg.get_persona_random();
                -- registramos la persona en el sistema
                -- para ello se llama al modulo 4(paquete: gestion_clientes_pkg)
                gestion_clientes_pkg.registro_cliente(persona_seleccionada, cliente_seleccionado);
            end if;
            
            -- buscamos el tipo del cliente
            select * into tipo_cliente_actual from tipo_cliente where tc_id=cliente_reservar.tipo_cliente_tc_id;
            
            -- se verifica si el cliente es del tipo no deseado
            if(tipo_cliente_actual.tc_nombre = 'no deseado') then
                -- imprimimos mensaje de error y el cliente
                DBMS_OUTPUT.PUT_LINE('ALERTA: este cliente no puede realizar alquileres debido a que es NO DESEADO');
                utilities_pkg.print_persona(cliente_seleccionado, 'NO DESEADO');
                continue;
            end if;
            
            -- se seleccionan al azar un vehiculo de la sede, este o no disponible
            
            -- se selecciona un periodo de forma aleatoria
            
            -- establecemos los valores de la persona seleccionada y el cliente a nulos
            cliente_seleccionado := NULL;
            persona_seleccionada := NULL;
        end loop;
        
    end simulacion_alquileres;
    
end reserva_and_alquiler_pkg;
