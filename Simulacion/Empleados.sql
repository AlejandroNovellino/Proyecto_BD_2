create or replace package empleados_pkg as
    procedure contratacion (sede_actual integer);
    procedure salida_de_empleado (hoy date, sede_actual integer);
end empleados_pkg;
/

create or replace package body empleados_pkg as
    procedure contratacion (sede_actual integer) is

        --para verificar si la sede tiene número máximo de empleados
        ctd_emp_sede integer;
        emp_max_sede integer;
        
        --para la inserción en la tabla Empleado
        persona_actual persona%rowtype;
        
        --para imprimir en pantalla el nombre del empleado
        nombre varchar2(20);
        apellido varchar2(20);
    begin
        --probabilidad de 1 en 2 de que se haga una contratacion
        if (utilities_pkg.get_random_integer(0,2) < 1) then
            DBMS_OUTPUT.PUT_LINE('Se intentara una contratacion');
            select count(*) into ctd_emp_sede from empleado where sede_s_id=sede_actual;
            select s_cant_max_empleados into emp_max_sede from sede where s_id=sede_actual;
            if (ctd_emp_sede<emp_max_sede) then
                generador_data_aleatoria_pkg.generar_persona;
                select * into persona_actual from persona where rownum=1 order by p_id desc;
                insert into empleado values (default,persona_actual.ip,2400,sede_actual);
                /*insert into empleado values (default,informacion_personal(
    informacion_personal.verificar_cedula('V-30859685'),
    informacion_personal.verificar_nombre_apellido('Pedro'),
    informacion_personal.verificar_nombre_apellido('Alfonzo'),
    informacion_personal.verificar_nombre_apellido('Abdul'),
    informacion_personal.verificar_nombre_apellido('Witt'),
    informacion_personal.verificar_correo('pedro12@gmail.com'),
    informacion_personal.verificar_fecha_nacimiento('01-JAN-2000'),
    informacion_personal.verificar_sexo('M'),
    'Transilvania' 
),2400,sede_actual);*/
                DBMS_OUTPUT.PUT_LINE('Se ha contratado a '||nombre||' '||apellido);
            else
                DBMS_OUTPUT.PUT_LINE('Ya se posee la cantidad maxima de empleados');
            end if;
        end if;
    end contratacion;
    
    procedure salida_de_empleado (hoy date, sede_actual integer) is
        --verifica si es dia de ejecutar el proc.
        num_dia integer;
        
        ctd_emp_sede integer;
        nombre varchar2(20);
        apellido varchar2(20);
        
        cursor empleados is select e_id from empleado;
        empleado_actual integer;
    begin
        select extract(day from hoy) into num_dia from dual;
        if (num_dia=28) then
            --probabilidad de que se retire a un empleado
            if (utilities_pkg.get_random_integer(1,5) < 2) then
                DBMS_OUTPUT.PUT_LINE('Se va a intentar el retiro de un empleado');
                select count(*) into ctd_emp_sede from empleado where sede_s_id=sede_actual;
                if (ctd_emp_sede > 2) then
                    open empleados;
                    for i in 1..utilities_pkg.get_random_integer(1,ctd_emp_sede) loop
                        fetch empleados into empleado_actual;
                    end loop;
                    close empleados;
                    select e.e_informacion_personal.ip_primer_nombre into nombre from empleado e where e.e_id=empleado_actual;
                    select e.e_informacion_personal.ip_primer_apeliido into apellido from empleado e where e.e_id=empleado_actual;
                    DBMS_OUTPUT.PUT_LINE('Se ha retirado al empleado '||nombre||' '||apellido);
                    delete from empleado where e_id=empleado_actual;
                else
                    DBMS_OUTPUT.PUT_LINE('No se ha retirado empleado alguno ya que la sede tiene el minimo de empleados');
                end if;
            end if;
        end if;
    end salida_de_empleado;
end empleados_pkg;
/