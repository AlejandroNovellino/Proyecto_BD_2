create or replace package inventario_pkg as

    --genera placa
    function generar_placa return varchar2;

    --M2E1: Compra de vehículo para añadir a la flota
    procedure compra_de_vehiculo (hoy date, num_sede integer);
    --M2E2: Vehículo termine su vida útil
    procedure fin_de_vida_util (num_sede integer, placa varchar2 /*, marca integer, modelo integer*/);

end inventario_pkg;
/

create or replace package body inventario_pkg as

    function generar_placa return varchar2 is
        placa varchar2 (7);
    begin
    placa := 'A'||CHR(utilities_pkg.get_random_integer(65,91))
                ||utilities_pkg.get_random_integer(100,1000)||
                CHR(utilities_pkg.get_random_integer(65,91))||
                CHR(utilities_pkg.get_random_integer(65,91));
        return placa;
    end generar_placa;

    --------------------------------------------------------

    procedure compra_de_vehiculo (hoy date, num_sede integer) is

        num_dia integer;
        salir integer := 0;

        ctd_marcas integer;
        id_marca integer;
        ctd_modelos integer;
        id_1er_modelo integer;
        id_modelo integer;
        ctd_colores integer;
        
        nom_marca varchar2(15);
        nom_modelo varchar2(15);

        modelo_disponible integer;

    begin
        --valida que sea el día 28 del mes
        select extract(day from hoy) into num_dia from dual;
        if (num_dia=28) then
            DBMS_OUTPUT.PUT_LINE('Es el 28 del mes, se intentara una compra de vehiculo');
            loop
            --selecciona modelo de carro
            select count(*) into ctd_marcas from marca;
            id_marca := utilities_pkg.get_random_integer(1,ctd_marcas+1);
            select ma_nombre into nom_marca from marca where ma_id=id_marca;
            select count(*) into ctd_modelos from modelo 
                where marca_ma_id = id_marca;
            select m_id into id_1er_modelo from modelo
               where marca_ma_id = id_marca
                  and rownum = 1;
            id_modelo := utilities_pkg.get_random_integer(id_1er_modelo, 
                                            id_1er_modelo+ctd_modelos+1);
            select m_nombre into nom_modelo from modelo where m_id=id_modelo;                                            
            --verifica si el proveedor tiene ese modelo
            modelo_disponible := utilities_pkg.get_random_integer(1,6);
            if (modelo_disponible <= 4) then
                DBMS_OUTPUT.PUT_LINE('Esta disponible un '
                                    ||nom_marca||' '
                                    ||nom_modelo
                                    ||' para la compra');
                --verifica si hay fondos suficientes
                salir := utilities_pkg.get_random_integer(0,2);
                if (salir = 0) then
                    DBMS_OUTPUT.PUT_LINE('Se procede con la compra, ya que se dispone de los fondos');
                    select count(*) into ctd_colores from color;
                    insert into vehiculo values(generar_placa
                                                ,extract(year from hoy)
                                                ,rawtohex('Test')
                                                ,0
                                                ,utilities_pkg.get_random_integer(45,150)
                                                ,id_modelo
                                                ,id_marca
                                                ,1
                                                ,utilities_pkg.get_random_integer(1,ctd_colores)
                                                ,1
                                                ,num_sede);
                     /*insert into gasto values (default
                                                ,utilities_pkg.get_random_integer(20,60)*1000
                                                ,hoy
                                                ,rawtohex('Compra de vehiculo')
                                                ,(select tg_id from tipo_gasto where tg_nombre='Operacionales')
                                                ,sede_actual);*/
                    salir := 1;
                end if;
            else
                --valida si el usuario desea seleccionar otro
                --modelo de carro. Si es 1, sale del módulo.
                salir := utilities_pkg.get_random_integer(0,2);
            end if;
            exit when salir=1;
            end loop;
        end if;
    end compra_de_vehiculo;

    procedure fin_de_vida_util (num_sede integer, placa varchar2) is

        vender_vehiculo integer;

        marca integer;
        v_a_vender varchar2;

    begin
      update vehiculo set v_km = v_km + utilities_pkg.get_random_integer(10,2000) where v_placa = placa;
      if v_km<=50000 then
        vender_vehiculo := utilities_pkg.get_random_integer(0,2);
        if (vender_vehiculo=1) then
            insert into ingreso values (default
                                        ,utilities_pkg.get_random_integer(60,180)*10
                                        ,(select sysdate from dual)
                                        ,rawtohex('Venta del vehiculo de placa'||placa)
                                        ,num_sede);
            DBMS_OUTPUT.PUT_LINE('Se realizo la venta del vehiculo');
            update vehiculo 
                set status_vehiculo_sv_id = (select sv_id from status_vehiculo where sv_nombre='Vendido') 
                where v_placa = placa;
        else
            select marca_ma_id into marca from vehiculo where v_placa = placa;
            if exists (select * from vehiculo 
                                where marca_ma_id=marca 
                                and status_vehiculo_sv_id = (select sv_id from status_vehiculo where sv_nombre='Inhabilitado'))
                                then
                select v_placa into v_a_vender from vehiculo 
                    where marca_ma_id=marca 
                    and status_vehiculo_sv_id = (select sv_id from status_vehiculo where sv_nombre='Inhabilitado')
                    and rownum = 1;
                insert into ingreso values (default
                                            ,utilities_pkg.get_random_integer(60,180)*10
                                            ,(select sysdate from dual)
                                            ,rawtohex('Venta del vehiculo de placa'||v_a_vender)
                                            ,num_sede);
                DBMS_OUTPUT.PUT_LINE('Se realizo la venta del vehiculo');
                update vehiculo 
                    set status_vehiculo_sv_id = (select sv_id from status_vehiculo where sv_nombre='Vendido') 
                    where v_placa = v_a_vender;
            end if;
            update vehiculo 
                set status_vehiculo_sv_id = (select sv_id from status_vehiculo where sv_nombre='Inhabilitado') 
                where v_placa = placa;
            
        end if;
      else
        DBMS_OUTPUT.PUT_LINE('El vehiculo todavia posee vida util');
      end if;
    end fin_de_vida_util;

end inventario_pkg;
/
