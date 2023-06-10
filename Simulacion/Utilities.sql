create or replace package utilities_pkg as
    ----------------------------------------------------------------------------
     -- funciones para tomar tipos de datos aleatorios (incluyendo TDAs)
    -- funcion para retornar un entero aleatorio dentro del rango dado
    function get_random_integer(limite_inferior number, limite_superior number) return number;
    -- function para devolcer un periodo aleatorio
    function get_random_periodo(dia_actual date, fecha_fin_simulacion date) return periodo_duracion;
    -- function para devolcer una ubicacion geografica aleatoria
    function get_random_ubicacion_geografica return ubicacion_geografica;
    ----------------------------------------------------------------------------
    -- funciones para tomar un elemento aleatorio de una tabla
    -- funcion para retornar una persona aleatoria que no se encuentre registrada en el sistema
    function get_persona_random return persona%rowtype;
    -- funcion para retornar un cliente aleatorio que ya se encuentre registrado en el sistema
    function get_cliente_random return cliente%rowtype;
    -- function para elegir un vehiculo de forma aleatoria
    function get_vehiculo_random(pk_sede number) return vehiculo%rowtype;
    -- function para elegir un lugar de forma aleatoria
    function get_lugar_random return lugar%rowtype;
    ----------------------------------------------------------------------------
    -- funciones para impirmir
    -- procedure para imprimir una persona
    procedure print_persona(persona_imprimir persona%rowtype, msg varchar2 DEFAULT '');
    -- procedure para imprimir un cliente
    procedure print_cliente(cliente_imprimir cliente%rowtype, msg varchar2 DEFAULT '');
    -- procedure para imprimir un vehiculo
    procedure print_vehiculo(vehiculo_imprimir vehiculo%rowtype, msg varchar2 DEFAULT '');
    

end utilities_pkg;
/

create or replace package body utilities_pkg as
    ----------------------------------------------------------------------------
    -- funcion para retornar un numero aleatorio dentro del rango dado
    function get_random_integer(limite_inferior number, limite_superior number) return number 
    is
        random_number number;
    begin
        -- toma el valor random dentro del rango
        select TRUNC(dbms_random.value(limite_inferior, limite_superior)) num INTO random_number from dual;
        return random_number;
        
    end get_random_integer;
    ----------------------------------------------------------------------------
    -- function para devolver un periodo aleatorio
    function get_random_periodo(dia_actual date, fecha_fin_simulacion date) return periodo_duracion
    is
        periodo_retornar periodo_duracion;      -- periodo de duracion a retornar
        fecha_inicio date;                      -- fecha de inicio del periodo
        fecha_fin date;                         -- fecha de fin del periodo
    begin 
        -- se selecciona la fecha de inicio de forma aleatoria
        SELECT TO_DATE(
              TRUNC(
                     DBMS_RANDOM.VALUE (to_number(to_char(dia_actual, 'j')), to_number(to_char(fecha_fin_simulacion, 'j'))) 
                    )
                , 'J')  into fecha_inicio
        FROM DUAL;
        -- se selecciona la fecha de fin
        -- por ahora se coloca como maximo 2 meses para esa reserva
        SELECT TO_DATE(
              TRUNC(
                     DBMS_RANDOM.VALUE (to_number(to_char(fecha_inicio, 'j')), to_number(to_char(ADD_MONTHS(fecha_inicio, 2), 'j'))) 
                    )
                , 'J')  into fecha_fin
        FROM DUAL;
        
        -- creamos el periodo
        periodo_retornar := periodo_duracion(
            fecha_inicio,
            fecha_fin
        );
        
        return periodo_retornar;
    
    end get_random_periodo;
    ----------------------------------------------------------------------------
    -- funcion para retornar un cliente aleatorio que ya se encuentre registrado en el sistema
    function get_cliente_random return cliente%rowtype
    is
        random_index number;        -- index aleatorio
        cantidad_clientes number;   -- cantidad de clientes
        -- variables para el cursor
        cursor clientes is select * from cliente;
        cliente_row cliente%rowtype;
        -- variable para retornar
        cliente_to_return cliente%rowtype;
    begin
        -- contamos la cantidad de clientes
        select count(*) into cantidad_clientes from cliente;
        -- tomamos un index aleatorio
        random_index := get_random_integer(1, cantidad_clientes+1);
        -- abrimos el cursor e iteramos sobre el 
        open clientes;
        loop 
            fetch clientes into cliente_row;
            exit when clientes%notfound;
            -- se verifica si se llego al index deseado
            if (random_index = clientes%rowcount) then
                cliente_to_return := cliente_row;
            end if;
        end loop;
        -- cerramos el cursor
        close clientes;
        
        return cliente_to_return;
    end get_cliente_random;
    ----------------------------------------------------------------------------
    -- funcion para retornar una persona aleatoria que no se encuentre registrada en el sistema
    function get_persona_random return persona%rowtype
    is
        random_index number;        -- index aleatorio
        cantidad_personas number;   -- cantidad de clientes
        -- variables para el cursor
        cursor personas is select * from persona;
        persona_row persona%rowtype;
        -- variable para retornar
        persona_to_return persona%rowtype;
    begin
        -- contamos la cantidad de clientes
        select count(*) into cantidad_personas from persona;
        -- tomamos un index aleatorio
        random_index := get_random_integer(1, cantidad_personas+1);
        -- abrimos el cursor e iteramos sobre el 
        open personas;
        loop 
            fetch personas into persona_row;
            exit when personas%notfound;
            -- se verifica si se llego al index deseado
            if (random_index = personas%rowcount) then
                persona_to_return := persona_row;
            end if;
        end loop;
        -- cerramos el cursor
        close personas;
        
        return persona_to_return;
    end get_persona_random;
    ----------------------------------------------------------------------------
    -- function para devolcer una ubicacion geografica aleatoria
    function get_random_ubicacion_geografica return ubicacion_geografica
    is 
        ubicacion_geografica_random ubicacion_geografica;   -- ubicacion a retornar
        latitud_random      varchar2(12);                   -- longittud random
        longitud_random     varchar2(12);                   -- latitud random
        time_stamp_actual   timestamp;                      -- timestamp actual
    begin
        -- generamos la latitud y longitud de forma aleatoria
        latitud_random := to_char(get_random_integer(-90, 90));
        longitud_random := to_char(get_random_integer(-180, 180));
        -- tomamos el time stamp
        select CURRENT_TIMESTAMP into time_stamp_actual from DUAL;
        -- colocamos los valores en la ubicacion geografica
        ubicacion_geografica_random := ubicacion_geografica(
            latitud_random,
            longitud_random,
            time_stamp_actual
        );
        
        return ubicacion_geografica_random;
    end get_random_ubicacion_geografica;
    ----------------------------------------------------------------------------
    -- function para elegir un vehiculo de forma aleatoria (simular desear un vehciulo con caracteristicas especificas)
    function get_vehiculo_random(pk_sede number) return vehiculo%rowtype
    is
        random_index number;        -- index aleatorio
        cantidad_vehiculos number;   -- cantidad de clientes
        -- variables para el cursor
        cursor vehiculos is select * from vehiculo where sede_s_id=pk_sede;
        vehiculo_row vehiculo%rowtype;
        -- variable para retornar
        vehiculo_to_return vehiculo%rowtype;
    begin
        -- contamos la cantidad de clientes
        select count(*) into cantidad_vehiculos from vehiculo where sede_s_id=pk_sede;
        -- tomamos un index aleatorio
        random_index := get_random_integer(1, cantidad_vehiculos+1);
        -- abrimos el cursor e iteramos sobre el 
        open vehiculos;
        loop 
            fetch vehiculos into vehiculo_row;
            exit when vehiculos%notfound;
            -- se verifica si se llego al index deseado
            if (random_index = vehiculos%rowcount) then
                vehiculo_to_return := vehiculo_row;
            end if;
        end loop;
        -- cerramos el cursor
        close vehiculos;
        
        return vehiculo_to_return;
    end get_vehiculo_random;
    ----------------------------------------------------------------------------
    -- function para elegir un lugar de forma aleatoria
    function get_lugar_random return lugar%rowtype
    is
        random_index number;        -- index aleatorio
        cantidad_lugares number;    -- cantidad de lugares
        -- variables para el cursor
        cursor lugares is select * from lugar;
        lugar_row lugar%rowtype;
        -- variable para retornar
        lugar_to_return lugar%rowtype;
    begin
        -- contamos la cantidad de lugares
        select count(*) into cantidad_lugares from lugar;
        -- tomamos un index aleatorio
        random_index := get_random_integer(1, cantidad_lugares+1);
        -- abrimos el cursor e iteramos sobre el 
        open lugares;
        loop 
            fetch lugares into lugar_row;
            exit when lugares%notfound;
            -- se verifica si se llego al index deseado
            if (random_index = lugares%rowcount) then
                lugar_to_return := lugar_row;
            end if;
        end loop;
        -- cerramos el cursor
        close lugares;
        
        return lugar_to_return;
    end get_lugar_random;
    ----------------------------------------------------------------------------
    -- procedure para imprimir una persona
    procedure print_persona(persona_imprimir persona%rowtype, msg varchar2 DEFAULT '')
    is
    begin
        DBMS_OUTPUT.PUT_LINE('  Persona: ');
        DBMS_OUTPUT.PUT_LINE(
            '       ' 
            || persona_imprimir.ip.IP_Primer_Nombre || ' '
            || persona_imprimir.ip.IP_Segundo_Nombre || ', '
            || persona_imprimir.ip.IP_Primer_Apeliido || ' '
            || persona_imprimir.ip.IP_Segundo_Apellido || ' '
            || 'C.I. ' || persona_imprimir.ip.IP_cedula
        );
        DBMS_OUTPUT.PUT_LINE('  ' || msg);
    end print_persona;
    ----------------------------------------------------------------------------
    -- procedure para imprimir un cliente
    procedure print_cliente(cliente_imprimir cliente%rowtype, msg varchar2 DEFAULT '')
    is
    begin
        DBMS_OUTPUT.PUT_LINE('  Cliente: ');
        DBMS_OUTPUT.PUT_LINE(
            '       ' 
            || cliente_imprimir.c_informacion_personal.IP_Primer_Nombre || ' '
            || cliente_imprimir.c_informacion_personal.IP_Segundo_Nombre || ', '
            || cliente_imprimir.c_informacion_personal.IP_Primer_Apeliido || ' '
            || cliente_imprimir.c_informacion_personal.IP_Segundo_Apellido || ' '
            || 'C.I. ' || cliente_imprimir.c_informacion_personal.IP_cedula
        );
        DBMS_OUTPUT.PUT_LINE('  ' || msg);
    end print_cliente;
    ----------------------------------------------------------------------------
    -- procedure para imprimir un vehiculo
    procedure print_vehiculo(vehiculo_imprimir vehiculo%rowtype, msg varchar2 DEFAULT '')
    is
        modelo_vehiculo varchar2(50);
        marca_vehiculo varchar2(50);
    begin
        select mo.m_nombre into modelo_vehiculo 
            from modelo mo
            where mo.m_id=vehiculo_imprimir.modelo_m_id;
            
        select ma.ma_nombre into modelo_vehiculo 
            from marca ma
            where ma.ma_id=vehiculo_imprimir.modelo_marca_ma_id;
        
        DBMS_OUTPUT.PUT_LINE('  Vehiculo: ');
        DBMS_OUTPUT.PUT_LINE(
            '       ' 
            || 'Placa: ' || vehiculo_imprimir.v_placa || ' '
            || modelo_vehiculo || ', '
            || marca_vehiculo || ' '
            || vehiculo_imprimir.color_c_id || ' '
            || 'Km: ' || vehiculo_imprimir.v_km
        );
        DBMS_OUTPUT.PUT_LINE('  ' || msg);
    end print_vehiculo;

end utilities_pkg;
/

-- esto es para probar las funciones -------------------------------------------
declare
    dta_prueba periodo_duracion;
    
    fecha_inicio_simulacion date;                     -- fecha de inicio de la simulacion
    fecha_fin_simulacion date;                        -- fecha de fin de la simulacion
begin 
    DBMS_Output.PUT_LINE('Numero ' || to_char(utilities_pkg.get_random_integer(1,8)));
    DBMS_Output.PUT_LINE('Numero ' || to_char(utilities_pkg.get_random_integer(1,3)));
    
    fecha_inicio_simulacion := TO_DATE('04/20/2013','MM/DD/YYYY');
    fecha_fin_simulacion := TO_DATE('05/25/2013','MM/DD/YYYY'); 
    dta_prueba := utilities_pkg.get_random_periodo(
        fecha_inicio_simulacion, 
        fecha_fin_simulacion
    );
    DBMS_Output.PUT_LINE('Fecha inicio ' || to_char(dta_prueba.P_Fecha_Inicio, 'yyyy-MM-dd'));
    DBMS_Output.PUT_LINE('Fecha fin ' || to_char(dta_prueba.P_Fecha_Fin, 'yyyy-MM-dd'));
end;
/
