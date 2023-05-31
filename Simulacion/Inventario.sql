create or replace package inventario_pkg as

    --genera placa
    function generar_placa return varchar2(7);

    --M2E1: Compra de vehículo para añadir a la flota
    procedure compra_de_vehiculo (num_sede integer);
    --M2E2: Vehículo termine su vida útil
    procedure fin_de_vida_util (placa varchar2);

end inventario_pkg;
/

create or replace package body inventario_pkg as

    function generar_placa return varchar2(7) is;
        placa varchar2(7);
    begin
    placa := 'A'||CHR(get_random_integer(65,91))
                ||get_random_integer(100,1000)||
                CHR(get_random_integer(65,91))||
                CHR(get_random_integer(65,91));
        return placa;
    end generar_placa;

    --------------------------------------------------------

    procedure compra_de_vehiculo (num_sede integer) is
        declare

        num_dia integer;
        salir integer := 0;

        ctd_marcas integer;
        id_marca integer;
        ctd_modelos integer;
        id_1er_modelo integer;
        id_modelo integer;

        modelo_disponible integer;

    begin
        --valida que sea el día 28 del mes
        select extract(day from sysdate) into num_dia from dual;
        if (num_dia=28) then
            loop
            --selecciona modelo de carro
            select count(*) into ctd_marcas from marca;
            id_marca := get_random_integer(1,ctd_marcas);
            select count(*) into ctd_modelos from modelo 
                where marca_ma_id = id_marca;
            select m_id into id_1er_modelo from modelo
            |   where marca_ma_id = id_marca
                  and rownum = 1;
            id_modelo := get_random_integer(id_1er_modelo, 
                                            id_1er_modelo+ctd_modelos);
            --verifica si el proveedor tiene ese modelo
            modelo_disponible := get_random_integer(1,6);
            if (modelo_disponible <= 3) then
                --verifica si hay fondos suficientes
                --OJO: seria chevere poder implementarlo con
                --base en el precio del modelo y los fondos
                salir := get_random_integer(0,2);
                if (salir = 0) then
                    insert into vehiculo values
                    (generar_placa,extract(year from sysdate),
                    hextoraw('e67672a'),0,
                    get_random_integer(10,51)*1000,
                    id_modelo,id_marca,1,
                    --automatizar para que escoja de cuantas
                    --filas de Color haya
                    get_random_integer(1,15),1,num_sede);
                    salir := 1
                end if;
            else
                --valida si el usuario desea seleccionar otro
                --modelo de carro. Si no, sale del módulo.
                salir := get_random_integer(0,2);
            end if;
            exit when salir=1;
            end loop;
        end if;
    end;
