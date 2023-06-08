create or replace package empleados_pkg as
    procedure contratacion (sede_actual integer);
    procedure salida_de_empleado (hoy date, sede_actual integer);
end empleados_pkg;
/

create or replace package body empleados_pkg as
    procedure contratacion (sede_actual integer) is

        ctd_emp_sede integer;
        emp_max_sede integer;
    begin
        --probabilidad de 1 en 2 de que se haga una contratacion
        if (utilities_pkg.get_random_integer(0,2) < 1) then
            DBMS_OUTPUT.PUT_LINE('Se intentara una contratacion');
            select count(*) into ctd_emp_sede from empleado where sede_s_id=sede_actual;
            select s_cant_max_empleados into emp_max_sede from sede where s_id=sede_actual;
            if (ctd_emp_sede<emp_max_sede) then
                generar_persona;
                --meter empleado a
            else
                DBMS_OUTPUT.PUT_LINE('Ya se posee la cantidad maxima de empleados');
            end if;
        end if;
    end contratacion;
    
end empleados_pkg;
/