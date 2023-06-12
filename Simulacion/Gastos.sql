create or replace package gastos_pkg as
    procedure gasto_de_nomina (hoy date, sede_actual integer);
    procedure gasto_de_operacion (hoy date, sede_actual integer);
end gastos_pkg;
/

create or replace package body gastos_pkg as

    procedure gasto_de_nomina (hoy date, sede_actual integer) is

        cursor empleados is select * from empleado where sede_s_id=sede_actual;
        empleado_actual empleado%rowtype;

        nombre varchar2(20);
        apellido varchar2(20);
        num_dia integer;

    begin
    select extract(day from hoy) into num_dia from dual;
    if (num_dia=28) then
        DBMS_OUTPUT.PUT_LINE('Se realizaran los pagos de la nomina');
        open empleados;
        fetch empleados into empleado_actual;
        while empleados%found
        loop
            nombre := empleado_actual.e_informacion_personal.IP_Primer_Nombre;
            apellido := empleado_actual.e_informacion_personal.IP_Primer_Apeliido;
            insert into gasto values (default,empleado_actual.e_sueldo,hoy,rawtohex('Pago de sueldo a '||nombre||' '||apellido),(select tg_id from tipo_gasto where tg_nombre='Operacionales'),sede_actual);
            DBMS_OUTPUT.PUT_LINE('Se pago el sueldo de '||nombre||' '||apellido);
            fetch empleados into empleado_actual;
        end loop;
        close empleados;
    end if;
    end gasto_de_nomina;

    procedure gasto_de_operacion (hoy date, sede_actual integer) is

        propio number;
        num_dia integer;

    begin
    select extract(day from hoy) into num_dia from dual;
    if (num_dia=28) then
        insert into gasto values (default,utilities_pkg.get_random_integer(10,30),hoy,rawtohex('Servicio de agua'),(select tg_id from tipo_gasto where tg_nombre='No operacionales'),sede_actual);
        insert into gasto values (default,utilities_pkg.get_random_integer(10,30),hoy,rawtohex('Servicio de luz'),(select tg_id from tipo_gasto where tg_nombre='No operacionales'),sede_actual);
        insert into gasto values (default,utilities_pkg.get_random_integer(40,60),hoy,rawtohex('Servicio de internet'),(select tg_id from tipo_gasto where tg_nombre='No operacionales'),sede_actual);
        insert into gasto values (default,utilities_pkg.get_random_integer(10,20),hoy,rawtohex('Servicio de telefonia'),(select tg_id from tipo_gasto where tg_nombre='No operacionales'),sede_actual);
        DBMS_OUTPUT.PUT_LINE('Se pagaron los servicios');
        select s_negocio_propio into propio from sede where s_id=sede_actual;
        if (propio = 0) then
            insert into gasto values (default,utilities_pkg.get_random_integer(60,65),hoy,rawtohex('Alquiler del local'),(select tg_id from tipo_gasto where tg_nombre='No operacionales'),sede_actual);
        end if;
        DBMS_OUTPUT.PUT_LINE('Se ha pagado el alquiler del local');
        --La compra de mobiliario es opcional
        if (utilities_pkg.get_random_integer(0,2)>=1) then
            insert into gasto values (default,utilities_pkg.get_random_integer(10,700),hoy,rawtohex('Compra de mobiliario'),(select tg_id from tipo_gasto where tg_nombre='No operacionales'),sede_actual);
        end if;
        DBMS_OUTPUT.PUT_LINE('Se hizo compra de mobiliario');
    end if;
    end gasto_de_operacion;
end gastos_pkg;
/