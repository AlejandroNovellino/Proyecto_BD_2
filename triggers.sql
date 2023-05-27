create or replace trigger status_mantenimiento AFTER insert on mantenimiento_vehiculo FOR EACH ROW
declare

 begin
    Update vehiculo2 set status_vehiculo_sv_id= (SELECT sv_id From status_vehiculo where sv_nombre ='En mantenimiento')
    where v_placa=:new.vehiculo_V_ID;
 end;
 
create or replace trigger status_mantenimiento_disponible AFTER update on mantenimiento_vehiculo FOR EACH ROW
declare

 begin
    Update vehiculo2 set status_vehiculo_sv_id= (SELECT sv_id From status_vehiculo where sv_nombre ='Disponible')
    where v_placa=:new.vehiculo_V_ID;
 end; 
 
 create or replace trigger cambio_status_alquiler AFTER insert on alquiler5 FOR EACH ROW
declare
  id VARCHAR2(12) ;
 begin
   Select DA_FK_vehiculo into id from detalle_alquiler2 where DA_ID= :new.Detalle_alquiler_DA_ID;
    Update vehiculo2 set status_vehiculo_sv_id= (SELECT sv_id From status_vehiculo where sv_nombre ='En alquiler')
    where v_placa=id;
 end;
 
 create or replace trigger cambio_status_alquiler_disponible AFTER UPDATE on alquiler5 FOR EACH ROW
declare
  id VARCHAR2(12) ;
 begin
   Select DA_FK_vehiculo into id from detalle_alquiler2 where DA_ID= :new.Detalle_alquiler_DA_ID;
    Update vehiculo2 set status_vehiculo_sv_id= (SELECT sv_id From status_vehiculo where sv_nombre ='Disponible')
    where v_placa=id;
 end;
 
 create or replace trigger ingreso_alquiler AFTER insert on alquiler5 FOR EACH ROW
declare
  id VARCHAR2(12) ;
 begin
   Select DA_FK_vehiculo into id from detalle_alquiler2 where DA_ID= :new.Detalle_alquiler_DA_ID;
   insert into ingreso values (default,:new.A_monto_total,:new.A_fecha_inicio,'Alquiler del vehiculo'||' '|| id ,1); 
 end;

 create or replace trigger gasto_mantenimiento AFTER insert on mantenimiento_vehiculo FOR EACH ROW
declare

 begin
    insert into gasto values (default,
    :new.man_precio,:new.man_fechaI,'Gasto por mantenimiento del vehiculo'||' '||:new.Vehiculo_v_id ,
    (select tg_id from tipo_gasto where tg_nombre='Operacionales'),
    (SELECT s_id From sede where  s_numerosede  =1));
 end;
 
