create or replace package alianzas_pkg as
    function generar_nombre_aliado return varchar2;
    procedure registro_de_un_aliado;
    procedure creacion_de_alianza (hoy date, sede_actual integer);
end alianzas_pkg;

create or replace package body alianzas_pkg as

    function generar_nombre_aliado return varchar2 is
        nombre varchar2 (3);
    begin
    nombre := CHR(utilities_pkg.get_random_integer(65,91))||
                CHR(utilities_pkg.get_random_integer(65,91))||
                CHR(utilities_pkg.get_random_integer(65,91));
        return nombre;
    end generar_nombre_aliado;

    procedure registro_de_un_aliado is
        id_aliado integer;
    begin
        id_aliado := utilities_pkg.get_random_integer(1,10);
        if id_aliado not in (select ao_id from aliado) then
            if (utilities_pkg.get_random_integer(0,5) < 2) then
                if (utilities_pkg.get_random_integer(0,2) < 1) then
                    DBMS_OUTPUT.PUT_LINE('Ha ingresado un dato incorrecto');
                    registro_de_un_aliado;
                else
                    DBMS_OUTPUT.PUT_LINE('Debe rellenar todos los campos obligatorios');
                    registro_de_un_aliado;
                end if;
            else
                insert into aliado values (id_aliado
                                            ,generar_nombre_aliado
                                            ,rawtohex('Foto'));
                DBMS_OUTPUT.PUT_LINE('El aliado se ha registrado exitosamente'); 
            end if;
        else
            DBMS_OUTPUT.PUT_LINE('El aliado ya existe');                            
            registro_de_un_aliado;
        end if;

    end registro_de_un_aliado;

    procedure creacion_de_alianza (hoy date, sede_actual integer) is
        num_dia integer;
        ctd_aliados integer;
        id_aliado integer;

        nom_aliado varchar2(50);
    begin
    select extract(day from hoy) into num_dia from dual;
        if (num_dia=28 or num_dia=10) then
            --probabilidad de 1 en 5 de que se cree 
            --una alianza en los dias especificados
            if (utilities_pkg.get_random_integer(0,5) < 1) then
                DBMS_OUTPUT.PUT_LINE('Se creara una alianza');
                --probabilidad de 1 en 2 de que 
                --el aliado ya esté registrado
                if (utilities_pkg.get_random_integer(0,2) < 1) then
                    DBMS_OUTPUT.PUT_LINE('El aliado es nuevo - sera registrado');
                    registro_de_un_aliado;
                    id_aliado := (select ao_id from aliado where rownum=1 order by ao_id desc);
                else
                    DBMS_OUTPUT.PUT_LINE('El aliado esta registrado');
                    select count(*) into ctd_aliados from aliado;
                    id_aliado := utilities_pkg.get_random_integer(1,ctd_aliados);
                end if;
                nom_aliado := (select ao_nombre from aliado where ao_id=id_aliado);
                --probabilidad de 1 en 3 de que no genere gastos
                if (utilities_pkg.get_random_integer(0,3) >= 1) then
                    --se comprueba que se disponga de los fondos
                    if (utilities_pkg.get_random_integer(0,3) >= 1) then  
                        insert into alianza values (default
                                                    ,periodo_duracion(hoy,hoy+utilities_pkg.get_random_integer(1,24)*30)
                                                    ,rawtohex('Alianza')
                                                    ,'No se como poner el tipo'
                                                    ,id_aliado
                                                    ,sede_actual);
                        DBMS_OUTPUT.PUT_LINE('Se creo una alianza con '||nom_aliado);
                    else   
                        DBMS_OUTPUT.PUT_LINE('No se dispone de los fondos para crear la alianza');
                    end if;
                else
                    insert into alianza values (default
                                                ,periodo_duracion(hoy,hoy+utilities_pkg.get_random_integer(1,24)*30)
                                                ,rawtohex('Alianza')
                                                ,'No se como poner el tipo'
                                                ,id_aliado
                                                ,sede_actual);
                    DBMS_OUTPUT.PUT_LINE('Se creo una alianza con '||nom_aliado);
                end if;
            else
                DBMS_OUTPUT.PUT_LINE('No se creara una alianza hoy');
            end if;
        end if;
    end creacion_de_alianza;