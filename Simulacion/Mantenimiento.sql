create or replace package mantenimiento_pkg as

    --TYPE lista_talleres IS TABLE OF integer
    --INDEX BY PLS_INTEGER;

    --M3AN5: Realización de mantenimiento
    procedure realizacion_de_mantenimiento (hoy date);
    --M3AN6: Finalización de mantenimiento
    procedure finalizacion_de_mantenimiento (hoy date);
    --M3E1: Taller sin disponibilidad para realizar mantenimiento
    procedure taller_sin_disponibilidad (mto_hoy mantenimiento_vehiculo%rowtype);
    --M3E2: Siguiente mantenimiento durante alquiler
    procedure siguiente_mantenimiento_durante_alquiler;

end mantenimiento_pkg;
/

create or replace package body mantenimiento_pkg as

    procedure realizacion_de_mantenimiento (hoy date) is

    cursor mtos_hoy is select * from mantenimiento_vehiculo where man_fecha_proximo_man=hoy;
    mto_hoy mantenimiento_vehiculo%rowtype;

    hay_mtos integer;

    begin
      select count(*) into hay_mtos from mantenimiento_vehiculo where man_fecha_proximo_man=hoy;
      if (hay_mtos>0) then
        open mtos_hoy;
        fetch mtos_hoy into mto_hoy;
        while mtos_hoy%found loop
          taller_sin_disponibilidad(mto_hoy);
          fetch mtos_hoy into mto_hoy;
        end loop
        close mtos_hoy;
      end if;
    end realizacion_de_mantenimiento;

    procedure finalizacion_de_mantenimiento (hoy date) is

        cursor mtos_fin_hoy is select * from mantenimiento_vehiculo where man_periodo_duracion.p_fecha_fin=hoy;
        mto_fin_hoy mantenimiento_vehiculo%rowtype;

        hay_mtos_fin integer;

    begin
      select count(*) into hay_mtos_fin from mantenimiento_vehiculo where man_periodo_duracion.p_fecha_fin=hoy;
      if (hay_mtos_fin>0) then
        open mtos_fin_hoy;
        fetch mtos_fin_hoy into mto_fin_hoy;
        while mtos_fin_hoy%FOUND loop
            update vehiculo
               set status_vehiculo_sv_id=(select sv_id from status_vehiculo where sv_nombre='Disponible')
             where v_placa=mto_fin_hoy.vehiculo_v_placa;
             update mantenimiento_vehiculo
                set status_mantenimiento_s_id=(select s_id from status_mantenimiento where s_nombre='Finalizado')
              where man.id=mto_fin_hoy.man_id;
          fetch mtos_fin_hoy into mto_fin_hoy;
        end loop
      end if;
    end finalizacion_de_mantenimiento;

    procedure taller_sin_disponibilidad (mto_hoy mantenimiento_vehiculo%rowtype, hoy date) is

        --talleres lista_talleres;
        --indice PLS_INTEGER;

        cursor talleres is select taller_t_id from mantenimiento_taller where mantenimiento_m_id=mto_hoy.mantenimiento_m_id;
        taller_actual integer;

        disponible integer;
        fecha_busqueda date := hoy;
        salir integer := 0;

    begin
        while (salir = 0) loop
            open talleres;
            fetch talleres into taller_actual;
            while ((talleres%found) and (salir=0)) loop
                --logica para determinar si el taller tiene disponibilidad
                disponible := utilities_pkg.get_random_integer(1,11);
                if (disponible<8) then    
                    if (fecha_busqueda <> hoy) then
                        update mantenimiento_vehiculo set man_fecha_proximo_man=fecha_busqueda where man_id=mto_hoy.man_id;
                    else
                        insert into mantenimiento_vehiculo values (default
                                                                    ,periodo_duracion(hoy,hoy+2)
                                                                    ,hoy+90
                                                                    ,mto_hoy.man_precio
                                                                    ,mto_hoy.vehiculo_v_placa
                                                                    ,(SELECT modelo_m_id from vehiculo where v_placa=mto_hoy.vehiculo_v_placa)
                                                                    ,(SELECT modelo_marca_ma_id from vehiculo where v_placa=mto_hoy.vehiculo_v_placa)
                                                                    ,(SELECT s_id from status_mantenimiento where s_nombre='Operativo')
                                                                    ,mto_hoy.mantenimiento_m_id);
                        update vehiculo
                           set status_vehiculo_sv_id=(select sv_id from status_vehiculo where sv_nombre='En mantenimiento')
                         where v_placa=mto_hoy.vehiculo_v_placa;
                    end if;
                    salir := 1;
                end if;
                fetch talleres into taller_actual;
            end loop;
        end loop;
    end taller_sin_disponibilidad;

    procedure siguiente_mantenimiento_durante_alquiler (hoy date) is

        ult_mto mantenimiento_vehiculo%rowtype;
        
        taller_actual integer;

        disponible integer;

        begin
        select * into ult_mto from mantenimiento_vehiculo where rownum=1 order by man_periodo_duracion.p_fecha_inicio desc;
        if ult_mto.man_fecha_proximo_man between ult_mto.man_periodo_duracion.p_fecha_inicio and ult_mto.man_periodo_duracion.p_fecha_fin then
            select taller_t_id into taller_actual from mantenimiento_taller where mantenimiento_m_id=ult_mto.mantenimiento_m_id;
            --logica para determinar si el taller tiene disponibilidad
            disponible := utilities_pkg.get_random_integer(1,11);
            if (disponible<8) then
                update mantenimiento_vehiculo 
                    set man_fecha_proximo_man=ult_mto.man_fecha_proximo_man+2 
                    where man_id=ult_mto.man_id;
            else
                taller_sin_disponibilidad (ult_mto, ult_mto.man_fecha_proximo_man+2);
            end if;
        end if;
        end siguiente_mantenimiento_durante_alquiler;
  
end mantenimiento_pkg;
/

--insert into vehiculo values(generar_placa,extract(year from sysdate),rawtohex('Test'),0,utilities_pkg.get_random_integer(10,51)*1000,id_modelo,id_marca,1,utilities_pkg.get_random_integer(1,15),1,num_sede);
--https://oracle-base.com/articles/8i/import-blob