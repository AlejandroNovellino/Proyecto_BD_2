create or replace trigger status_mantenimiento AFTER insert on mantenimiento_vehiculo FOR EACH ROW
declare

 begin
    Update vehiculo set status_vehiculo_sv_id= (SELECT sv_id From status_vehiculo where sv_nombre ='En mantenimiento')
    where v_placa=:new.vehiculo_v_placa;
 end;
/
create or replace trigger status_mantenimiento_disponible AFTER update on mantenimiento_vehiculo FOR EACH ROW
declare

 begin
    Update vehiculo set status_vehiculo_sv_id= (SELECT sv_id From status_vehiculo where sv_nombre ='Disponible')
    where v_placa=:new.vehiculo_v_placa;
 end; 
 /
--create or replace trigger cambio_status_alquileres AFTER insert on alquiler FOR EACH ROW -- Creo que este trigger tenemos que eliminarlo porque que se inserte un alquiler no significa que un auto este ya durante un alquiler, porque por el caso de las reservas ingresar un alquiler no significa que inicie
--declare
    -- id VARCHAR2(12) ;
--begin
   -- Select vehiculo_v_placa into id from detalle_alquiler where DA_ID= :new.Detalle_alquiler_DA_ID;
   -- Update vehiculo set status_vehiculo_sv_id= (SELECT sv_id From status_vehiculo where sv_nombre ='En alquiler')
   -- where v_placa=id;
-- end;
 
--create or replace trigger cambio_status_alquiler_disponibles AFTER UPDATE on alquiler FOR EACH ROW
--declare
    --id VARCHAR2(12) ;
--begin
    --Select vehiculo_v_placa into id from detalle_alquiler where DA_ID= :new.Detalle_alquiler_DA_ID;
    --Update vehiculo set status_vehiculo_sv_id= (SELECT sv_id From status_vehiculo where sv_nombre ='Disponible')
            --where v_placa=id;
--end;
 
--------------------------------------------------------------------------------
-- triggers de alquiler
--------------------------------------------------------------------------------

-- trigger para los ingresos por alquiler 
create or replace trigger ingresos_alquiler AFTER insert on alquiler FOR EACH ROW
declare
  id VARCHAR2(12) ;
  id_sede number;
 begin
   Select vehiculo_v_placa into id from detalle_alquiler where DA_ID= :new.Detalle_alquiler_DA_ID;
   select sede_s_id into id_sede  from vehiculo where v_placa= id;
   insert into ingreso values (default,:new.A_monto_total,:new.a_periodo_duracion.P_Fecha_Inicio,'Alquiler del vehiculo'||' '|| id ,id_sede); 
 end;
 /
-- trigger para eliminar el detalle alquiler cuando se elimina un alquiler
create or replace trigger eliminacion_detalle_alquiler_al_eliminar_alquiler after delete on alquiler for each row
declare
begin
    -- eliminamos el detalle alquiler del alquiler que ya fue elminado
    delete from detalle_alquiler
        where da_id = :old.detalle_alquiler_da_id;

end eliminacion_detalle_alquiler_al_eliminar_alquiler;
/
--------------------------------------------------------------------------------
-- triggers de mantenimiento_vehiculo
--------------------------------------------------------------------------------

create or replace trigger gasto_mantenimiento AFTER insert on mantenimiento_vehiculo FOR EACH ROW
declare
  id_sede number;
 begin
    select sede_s_id into id_sede  from vehiculo where v_placa= :new.Vehiculo_v_placa;
    insert into gasto values (default,:new.man_precio,:new.man_periodo_duracion.P_Fecha_Inicio,'Gasto por mantenimiento del vehiculo'||' '||:new.Vehiculo_v_placa ,(select tg_id from tipo_gasto where tg_nombre='Operacionales'), id_sede);
 end;
/
--------------------------------------------------------------------------------
-- triggers de mantenimiento_vehiculo
--------------------------------------------------------------------------------
 
create or replace trigger gasto_compra AFTER insert on compra FOR EACH ROW
declare
begin
    insert into gasto values (default,
        :new.c_monto_total,:new.c_fecha,'Gasto por compra de vehiculo',
        (select tg_id from tipo_gasto where tg_nombre='Operacionales'),
        (SELECT s_id From sede where  s_numerosede  =:new.sede_S_ID));
end;
/

--------------------------------------------------------------------------------
-- triggers de detalle_alquiler
--------------------------------------------------------------------------------

-- trigger para actualizar un vehiculo al finalizar un alquiler
create or replace trigger actualizacion_vehiculo_al_finalizar_alquiler AFTER UPDATE on detalle_alquiler FOR EACH ROW
declare
    pk_nuevo_status_vehiculo number;
begin        
    -- se verifica el km del vehiculo
    if (:new.DA_km_final > 50000) then
        -- si es mayor a 50.000 se coloca como inhabilitado
        select sv_id into pk_nuevo_status_vehiculo from status_vehiculo where sv_nombre = 'Inhabilitado';
                
    else 
        -- si no lo es, se coloca como disponible
        select sv_id into pk_nuevo_status_vehiculo from status_vehiculo where sv_nombre = 'Disponible';
    end if ; 
    
    -- se actualiza el vehiculo
    Update vehiculo 
            set v_km = :new.da_km_final,
                status_vehiculo_sv_id = pk_nuevo_status_vehiculo
            where v_placa= :new.vehiculo_v_placa;
end;
/
--------------------------------------------------------------------------------
-- triggers de denuncia
--------------------------------------------------------------------------------

-- trigger para actualizar el estado del cliente al insertar una denuncia
create or replace trigger cambio_status_cliente_por_robo AFTER insert on denuncia FOR EACH ROW
declare
    alquiler_de_la_denuncia alquiler%rowtype;
begin
    -- buscamos el alquiler del que viene la denuncia para tener el id del cliente
    select * into alquiler_de_la_denuncia 
            from alquiler
            where a_id = :new.alquiler_a_id;
    -- actualizamos el cliente
    Update cliente set tipo_cliente_tc_id = (select TC_ID from tipo_cliente where TC_NOMBRE = 'No deseado')
            where c_id = alquiler_de_la_denuncia.cliente_c_id; 
end;
/
-- trigger para actualizar el estado del vechiculo al ser robado
create or replace trigger cambio_status_vehiculo_por_robo  AFTER insert on denuncia FOR EACH ROW
declare
    id_vehiculo varchar2(12);
    id_detalle_alquiler number;
begin
    select detalle_alquiler_da_id into id_detalle_alquiler from alquiler where a_id= :new.Alquiler_a_id;
    select vehiculo_v_placa into id_vehiculo from detalle_alquiler where da_id=id_detalle_alquiler; 
    
    Update vehiculo set status_vehiculo_SV_ID =(select sv_id from status_vehiculo where SV_NOMBRE='Inhabilitado')
        where v_placa= id_vehiculo;
end;  
/  
