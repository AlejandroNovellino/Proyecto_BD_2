create or replace package mantenimiento_pkg as

    --TYPE lista_talleres IS TABLE OF integer
    --INDEX BY PLS_INTEGER;

    --M3AN5: Realización de mantenimiento
    procedure realizacion_de_mantenimiento (hoy date);
    --M3AN6: Finalización de mantenimiento
    procedure finalizacion_de_mantenimiento (hoy date);
    --M3E1: Taller sin disponibilidad para realizar mantenimiento
    procedure taller_sin_disponibilidad (mto_hoy mantenimiento_vehiculo%rowtype, hoy date);
    --M3E2: Siguiente mantenimiento durante alquiler
    procedure siguiente_mantenimiento_durante_alquiler(fecha_inicio date, fecha_fin date, placa varchar2);

end mantenimiento_pkg;
/

create or replace package body mantenimiento_pkg as

    procedure realizacion_de_mantenimiento (hoy date) is

    cursor mtos_hoy is select * from mantenimiento_vehiculo where man_fecha_proximo_man=hoy;
    mto_hoy mantenimiento_vehiculo%rowtype;

    hay_mtos integer;
    status_de_vehiculo integer;

    begin
      select count(*) into hay_mtos from mantenimiento_vehiculo where man_fecha_proximo_man=hoy;
      if (hay_mtos>0) then
        open mtos_hoy;
        fetch mtos_hoy into mto_hoy;
        while mtos_hoy%found loop
          select status_vehiculo_sv_id into status_de_vehiculo from vehiculo where v_placa=mto_hoy.vehiculo_v_placa;
          if (status_de_vehiculo=1) then
            taller_sin_disponibilidad(mto_hoy,hoy);
          end if;
          fetch mtos_hoy into mto_hoy;
        end loop;
        close mtos_hoy;
      end if;
    end realizacion_de_mantenimiento;

    procedure finalizacion_de_mantenimiento (hoy date) is

        cursor mtos_fin_hoy is (select * from mantenimiento_vehiculo m where m.man_periodo_duracion.p_fecha_fin=hoy);
        mto_fin_hoy mantenimiento_vehiculo%rowtype;

        hay_mtos_fin integer;

    begin
      select count(*) into hay_mtos_fin from mantenimiento_vehiculo m where m.man_periodo_duracion.p_fecha_fin=hoy;
      if (hay_mtos_fin>0) then
        open mtos_fin_hoy;
        fetch mtos_fin_hoy into mto_fin_hoy;
        while mtos_fin_hoy%FOUND loop
            update vehiculo
               set status_vehiculo_sv_id=(select sv_id from status_vehiculo where sv_nombre='Disponible')
             where v_placa=mto_fin_hoy.vehiculo_v_placa;
             update mantenimiento_vehiculo m
                set m.status_mantenimiento_s_id=(select s_id from status_mantenimiento where s_nombre='Finalizado')
              where m.man_id=mto_fin_hoy.man_id;
            insert into gasto values (default,mto_fin_hoy.man_precio,hoy,rawtohex('Mantenimiento en el vehiculo de placa '||mto_fin_hoy.vehiculo_v_placa),(select tg_id from tipo_gasto where tg_nombre='Operacionales'),(select sede_s_id from vehiculo where v_placa=mto_fin_hoy.vehiculo_v_placa));
          fetch mtos_fin_hoy into mto_fin_hoy;
        end loop;
        close mtos_fin_hoy;
      end if;
    end finalizacion_de_mantenimiento;

    procedure taller_sin_disponibilidad (mto_hoy mantenimiento_vehiculo%rowtype, hoy date) is

        cursor talleres is select taller_t_id from mantenimiento_taller where mantenimiento_m_id=(SELECT mantenimiento_m_id from mantenimiento_taller where mt_id=mto_hoy.mantenimiento_taller_mt_id);
        taller_actual integer;

        disponible integer;
        salir integer := 0;
        taller_encontrado integer := 0;
        fecha_busqueda date := hoy;

    begin
        while (salir=0) loop
            open talleres;
            fetch talleres into taller_actual;
            while ((talleres%found) and (taller_encontrado=0)) loop
                --logica para determinar si el taller tiene disponibilidad
                disponible := utilities_pkg.get_random_integer(1,11);
                if (disponible<2) then
                    if (fecha_busqueda <> hoy) then
                        update mantenimiento_vehiculo set man_fecha_proximo_man=fecha_busqueda where man_id=mto_hoy.man_id;
                    else
                    insert into mantenimiento_vehiculo values (default
                                                                ,periodo_duracion(fecha_busqueda,fecha_busqueda+1)
                                                                ,fecha_busqueda+90
                                                                ,mto_hoy.man_precio
                                                                ,mto_hoy.vehiculo_v_placa
                                                                ,(SELECT s_id from status_mantenimiento where s_nombre='Operativo')
                                                                ,(SELECT mt_id 
                                                                    from mantenimiento_taller 
                                                                   where mantenimiento_m_id=(SELECT mantenimiento_m_id from mantenimiento_taller where mt_id=mto_hoy.mantenimiento_taller_mt_id)
                                                                     and taller_t_id=taller_actual
                                                                ));
                    update vehiculo
                       set status_vehiculo_sv_id=(select sv_id from status_vehiculo where sv_nombre='En mantenimiento')
                     where v_placa=mto_hoy.vehiculo_v_placa;
                    end if;
                    DBMS_OUTPUT.PUT_LINE('Se encontro otro taller para el mantenimiento en el dia '||TO_CHAR(fecha_busqueda,'dd-MM-yyyy'));
                    taller_encontrado := 1;
                end if;
                fetch talleres into taller_actual;
            end loop;
            close talleres;
            if taller_encontrado=0 then
                DBMS_OUTPUT.PUT_LINE('No se encontro otro taller para el mantenimiento en el dia '||TO_CHAR(fecha_busqueda,'dd-MM-yyyy'));
                fecha_busqueda := fecha_busqueda+1;
            else
                salir :=1 ;
            end if;
        end loop;
    end taller_sin_disponibilidad;

    procedure siguiente_mantenimiento_durante_alquiler (fecha_inicio date, fecha_fin date, placa varchar2) is

        ult_mto mantenimiento_vehiculo%rowtype;
        
        taller_actual integer;

        disponible integer;

        begin
        select * into ult_mto from mantenimiento_vehiculo where vehiculo_v_placa=placa and rownum=1 order by man_periodo_duracion.p_fecha_inicio desc;
        if ult_mto.man_fecha_proximo_man >= fecha_inicio and ult_mto.man_fecha_proximo_man <= fecha_fin then
            DBMS_OUTPUT.PUT_LINE('El siguiente mantenimiento del vehiculo esta programado para');
            DBMS_OUTPUT.PUT_LINE('el '||TO_CHAR(ult_mto.man_fecha_proximo_man,'dd/MM/yyyy')||', que esta dentro del periodo de alquiler.');
            DBMS_OUTPUT.PUT_LINE('Se va a reprogramar.');
            select taller_t_id into taller_actual from mantenimiento_taller where mt_id=ult_mto.mantenimiento_taller_mt_id;
            --logica para determinar si el taller tiene disponibilidad
            disponible := utilities_pkg.get_random_integer(1,11);
            if (disponible<2) then
                update mantenimiento_vehiculo 
                    set man_fecha_proximo_man=fecha_fin+2 
                    where man_id=ult_mto.man_id;
               DBMS_OUTPUT.PUT_LINE('Se reprogramo el siguiente mantenimiento del vehiculo.');     
            else
                taller_sin_disponibilidad (ult_mto, fecha_fin+2);
            end if;
        end if;
        end siguiente_mantenimiento_durante_alquiler;
  
end mantenimiento_pkg;
/

--insert into vehiculo values(generar_placa,extract(year from sysdate),rawtohex('Test'),0,utilities_pkg.get_random_integer(10,51)*1000,id_modelo,id_marca,1,utilities_pkg.get_random_integer(1,15),1,num_sede);
--https://oracle-base.com/articles/8i/import-blob