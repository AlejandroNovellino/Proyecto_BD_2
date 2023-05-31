create or replace package utilities_pkg as
    -- funcion para retornar un entero aleatorio dentro del rango dado
    function get_random_integer(limite_inferior number, limite_superior number) return number;
    -- funcion para retornar una persona aleatoria que no se encuentre registrada en el sistema
    function get_persona_random return persona%rowtype;
    -- funcion para retornar un cliente aleatorio que ya se encuentre registrado en el sistema
    function get_cliente_random return cliente%rowtype;
    -- procedure para imprimir una persona
    procedure print_persona(persona_imprimir pesona%rowtype, msg varchar2 DEFAULT '');
    -- procedure para imprimir un cliente
    procedure print_cliente(cliente_imprimir cliente%rowtype, msg varchar2 DEFAULT '');
    -- function para devolcer un periodo aleatorio
    function get_random_periodo(dia_actual date, fecha_fin_simulacion date) return periodo_duracion;

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
        random_index := get_random_integer(0, cantidad_clientes);
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
        cursor personas is select * from cliente;
        persona_row persona%rowtype;
        -- variable para retornar
        persona_to_return pesona%rowtype;
    begin
        -- contamos la cantidad de clientes
        select count(*) into cantidad_personas from cliente;
        -- tomamos un index aleatorio
        random_index := get_random_integer(0, cantidad_personas);
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
    -- procedure para imprimir una persona
    procedure print_persona(persona_imprimir pesona%rowtype, msg varchar2 DEFAULT '')
    is
    begin
        DBMS_OUTPUT.PUT_LINE('Persona: ');
        DBMS_OUTPUT.PUT_LINE(
            '   ' 
            || persona_imprimir.ip.IP_Primer_Nombre || ' '
            || persona_imprimir.ip.IP_Segundo_Nombre || ', '
            || persona_imprimir.ip.IP_Primer_Apeliido || ' '
            || persona_imprimir.ip.IP_Segundo_Apellido || ' '
            || 'C.I. ' || persona_imprimir.ip.IP_cedula
        );
        DBMS_OUTPUT.PUT_LINE('  ' || msg);
    end print_cliente;
    ----------------------------------------------------------------------------
    -- procedure para imprimir un cliente
    procedure print_cliente(cliente_imprimir cliente%rowtype, msg varchar2 DEFAULT '')
    is
    begin
        DBMS_OUTPUT.PUT_LINE('Cliente: ');
        DBMS_OUTPUT.PUT_LINE(
            '   ' 
            || cliente_imprimir.c_informacion_personal.IP_Primer_Nombre || ' '
            || cliente_imprimir.c_informacion_personal.IP_Segundo_Nombre || ', '
            || cliente_imprimir.c_informacion_personal.IP_Primer_Apeliido || ' '
            || cliente_imprimir.c_informacion_personal.IP_Segundo_Apellido || ' '
            || 'C.I. ' || cliente_imprimir.c_informacion_personal.IP_cedula
        );
        DBMS_OUTPUT.PUT_LINE('  ' || msg);
    end print_cliente;
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
        --periodo_retornar.P_Fecha_Inicio := fecha_inicio;
        --periodo_retornar.P_Fecha_Fin := fecha_fin;
        
        return periodo_retornar;
    
    end get_random_periodo;

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
