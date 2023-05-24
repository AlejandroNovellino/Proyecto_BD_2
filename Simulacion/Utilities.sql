create or replace package utilities_pkg as
    -- funcion para retornar un numero aleatorio dentro del rango dado
    function get_random_integer(limite_inferior number, limite_superior number) return number;
    -- funcion para retornar un cliente aleatorio que ya se encuentre registrado en el sistema
    function get_cliente_random return cliente%rowtype;
    -- procedure para imprimir un cliente
    procedure print_cliente(cliente_imprimir cliente%rowtype, msg varchar2);

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
            if (random_index = cliente_row%rowcount) then
                cliente_to_return := cliente_row;
            end if;
        end loop;
        -- cerramos el cursor
        close clientes;
        
        return cliente_to_return;
    end get_cliente_random;
    ----------------------------------------------------------------------------
    -- procedure para imprimir un cliente
    procedure print_cliente(cliente_imprimir cliente%rowtype, msg varchar2)
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

end utilities_pkg;
/

begin 
    DBMS_Output.PUT_LINE('Numero ' || to_char(utilities_pkg.get_random_integer(1,8)));
end;
/
