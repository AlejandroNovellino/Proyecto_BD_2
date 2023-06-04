create or replace package inventario_pkg as

    --genera placa
    function generar_placa return varchar2;

    --M2E1: Compra de vehículo para añadir a la flota
    procedure compra_de_vehiculo (num_sede integer);
    --M2E2: Vehículo termine su vida útil
    --procedure fin_de_vida_util (placa varchar2);

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

    procedure compra_de_vehiculo (num_sede integer) is

        num_dia integer;
        salir integer := 0;

        ctd_marcas integer;
        id_marca integer;
        ctd_modelos integer;
        id_1er_modelo integer;
        id_modelo integer;
        
        nom_marca varchar2(15);
        nom_modelo varchar2(15);

        modelo_disponible integer;

    begin
        --valida que sea el día 28 del mes
        select extract(day from sysdate) into num_dia from dual;
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
                --OJO: seria chevere poder implementarlo con
                --base en el precio del modelo y los fondos
                salir := utilities_pkg.get_random_integer(0,2);
                if (salir = 0) then
                    DBMS_OUTPUT.PUT_LINE('Se procede con la compra, ya que se dispone de los fondos');
                    insert into vehiculo values
                    (generar_placa,
                     extract(year from sysdate),
                     rawtohex('Test'),
                     0,
                     utilities_pkg.get_random_integer(10,51)*1000,
                     id_modelo,
                     id_marca,
                     1,
                    --automatizar para que escoja de cuantas
                    --filas de Color haya
                     utilities_pkg.get_random_integer(1,15),
                     1,
                     num_sede);
                    salir := 1;
                end if;
            else
                --valida si el usuario desea seleccionar otro
                --modelo de carro. Si no, sale del módulo.
                salir := utilities_pkg.get_random_integer(0,2);
            end if;
            exit when salir=1;
            end loop;
        end if;
    end compra_de_vehiculo;
end inventario_pkg;
/
