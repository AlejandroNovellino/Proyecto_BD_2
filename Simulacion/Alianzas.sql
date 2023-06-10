create or replace package alianzas_pkg as
    function generar_nombre_aliado return varchar2;
    function generar_tipo_alianza return varchar2;
    procedure registro_de_un_aliado;
    procedure creacion_de_alianza (hoy date, sede_actual integer);
end alianzas_pkg;
/
create or replace package body alianzas_pkg as

    function generar_nombre_aliado return varchar2 is
        nombre varchar2 (3);
    begin
    nombre := CHR(utilities_pkg.get_random_integer(65,91))||
                CHR(utilities_pkg.get_random_integer(65,91))||
                CHR(utilities_pkg.get_random_integer(65,91));
        return nombre;
    end generar_nombre_aliado;
    
    function generar_tipo_alianza return varchar2 is
        tipo varchar2(12);
        type  tipos_alianza_array IS VARRAY(3) OF VARCHAR2(12);
        tipos tipos_alianza_array := tipos_alianza_array(
                                         'fallo'
                                        ,'choque'
                                        ,'fallo_choque');
    begin
        tipo:=tipos(utilities_pkg.get_random_integer(1,4));
        return tipo;
    end generar_tipo_alianza;
    
    procedure registro_de_un_aliado is
        id_aliado integer;
        ctd_aliados integer;
    begin
        --genera un numero aleatorio para luego determinar si existe o no
        id_aliado := utilities_pkg.get_random_integer(1,10);
        select count(*) into ctd_aliados from aliado;
        if (id_aliado > ctd_aliados) then
            --probabilidad de que haya un error en los datos proveidos
            if (utilities_pkg.get_random_integer(0,5) < 2) then
                --probabilidad de que un dato haya sido ingresado incorrectamente
                if (utilities_pkg.get_random_integer(0,2) < 1) then
                    DBMS_OUTPUT.PUT_LINE('Ha ingresado un dato incorrecto');
                    registro_de_un_aliado;
                else
                    DBMS_OUTPUT.PUT_LINE('Debe rellenar todos los campos obligatorios');
                    registro_de_un_aliado;
                end if;
            else
                pk_alianza.i_aliado('descarga.png',generar_nombre_aliado);
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
        
        cursor aliados is select ao_id from aliado;
        aliado_actual integer;
        salir integer;
        i integer := 0;
        
    begin
            DBMS_OUTPUT.PUT_LINE('FR!');
    select extract(day from hoy) into num_dia from dual;
        if (num_dia=28 or num_dia=10) then
            DBMS_OUTPUT.PUT_LINE('FR!');
            --probabilidad de 1 en 5 de que se cree 
            --una alianza en los dias especificados
            if (utilities_pkg.get_random_integer(0,5) >= 1) then
                DBMS_OUTPUT.PUT_LINE('Se creara una alianza');
                --probabilidad de 1 en 2 de que 
                --el aliado ya esté registrado
                if (utilities_pkg.get_random_integer(0,2) < 1) then
                    DBMS_OUTPUT.PUT_LINE('El aliado es nuevo - sera registrado');
                    registro_de_un_aliado;
                    select ao_id into id_aliado from aliado where rownum=1 order by ao_id desc;
                else
                    DBMS_OUTPUT.PUT_LINE('El aliado esta registrado');
                    select count(*) into ctd_aliados from aliado;
                    open aliados;
                    fetch aliados into aliado_actual;
                    salir := utilities_pkg.get_random_integer(1,ctd_aliados);
                    while (i<salir) loop
                        id_aliado := aliado_actual;
                        fetch aliados into aliado_actual;
                        i := i+1;
                    end loop;
                    close aliados;
                end if;
                select ao_nombre into nom_aliado from aliado where ao_id=id_aliado;
                --probabilidad de 1 en 3 de que no genere gastos
                if (utilities_pkg.get_random_integer(0,3) >= 1) then
                    --se comprueba que se disponga de los fondos
                    if (utilities_pkg.get_random_integer(0,3) >= 1) then  
                        insert into alianza values (default
                                                    --,periodo_duracion(hoy,hoy+utilities_pkg.get_random_integer(1,24)*30)
                                                    ,hoy
                                                    ,rawtohex('Alianza')
                                                    ,generar_tipo_alianza
                                                    ,id_aliado
                                                    ,sede_actual);
                        DBMS_OUTPUT.PUT_LINE('Se creo una alianza con '||nom_aliado);
                    else   
                        DBMS_OUTPUT.PUT_LINE('No se dispone de los fondos para crear la alianza');
                    end if;
                else
                    insert into alianza values (default
                                                --,periodo_duracion(hoy,hoy+utilities_pkg.get_random_integer(1,24)*30)
                                                ,hoy
                                                ,rawtohex('Alianza')
                                                ,generar_tipo_alianza
                                                ,id_aliado
                                                ,sede_actual);
                    DBMS_OUTPUT.PUT_LINE('Se creo una alianza con '||nom_aliado);
                end if;
            else
                DBMS_OUTPUT.PUT_LINE('No se creara una alianza hoy');
            end if;
        end if;
    end creacion_de_alianza;
end alianzas_pkg;
/