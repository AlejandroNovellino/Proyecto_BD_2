--Creacion de un directorio para guardar imagenes
CREATE OR REPLACE DIRECTORY OBJETOS_LOB AS 'C:\IMAGENES\';

CREATE OR REPLACE PACKAGE PK_Vehiculo AS
TYPE RESULT_SET IS REF CURSOR;

PROCEDURE  I_Vehiculo(V_Nombre_foto varchar2,v_placa Varchar2,v_anno number,v_km number,v_precio number, modelos varchar2,status varchar2, colorv varchar2,tipo varchar2,sedes number);
END PK_Vehiculo;
  

  CREATE OR REPLACE PACKAGE PK_Cliente AS
TYPE RESULT_SET IS REF CURSOR;
 
PROCEDURE BUSCAR_Cliente(o_result_set OUT RESULT_SET,  fecha_I varchar2, fecha_F varchar2,tipo varchar2);
PROCEDURE I_Cliente(V_Nombre_foto varchar2,p_nombre Varchar2,s_nombre Varchar2, p_apellido varchar2, s_apellido varchar2, ci varchar2,correo varchar2,nac date,sexo varchar2,latitud varchar2, longitud varchar2, direccion varchar2, tipo varchar2, lugar varchar2);
END PK_Cliente;


CREATE OR REPLACE PACKAGE BODY PK_Cliente IS
 
PROCEDURE BUSCAR_Cliente( o_result_set OUT RESULT_SET, fecha_I varchar2, fecha_F varchar2, tipo varchar2) 
  AS 
  BEGIN
  
  if ((fecha_I is null) and (fecha_F is null) and (tipo is null)) then
    OPEN o_result_set FOR SELECT  c.c_id,
    c.c_informacion_personal.IP_cedula cedula,
     CONCAT (c.c_informacion_personal.IP_Primer_Nombre, c.c_informacion_personal.IP_Segundo_Nombre) as full_name,
    CONCAT(  c.c_informacion_personal.IP_Primer_Apeliido , c.c_informacion_personal.IP_Segundo_Apellido)full_ape,
    c.c_informacion_personal.IP_Correo correo,
    c.c_informacion_personal.IP_Fecha_Nacimiento fnac,
   CASE c.c_informacion_personal.IP_Sexo WHEN 'M' THEN 'Masculino' When 'F' THEN 'Femenino'  END AS sexo,
    c.ubicacion_mapa.UG_Latitud lat,
    c.ubicacion_mapa.UG_Longitud lon,
    CASE c. tipo_cliente_tc_id WHEN 1 THEN 'Ocasional' WHEN 2 THEN 'Frecuente' when 3 then 'VIP ' when 4 then 'No deseado' END AS Tipo_cliente ,
    c.c_foto, c.fecha_registro
    FROM  cliente c;
    
    else 
         OPEN o_result_set FOR SELECT  c.c_id,
    c.c_informacion_personal.IP_cedula cedula,
     CONCAT (c.c_informacion_personal.IP_Primer_Nombre, c.c_informacion_personal.IP_Segundo_Nombre) as full_name,
    CONCAT(  c.c_informacion_personal.IP_Primer_Apeliido , c.c_informacion_personal.IP_Segundo_Apellido)full_ape,
    c.c_informacion_personal.IP_Correo correo,
    c.c_informacion_personal.IP_Fecha_Nacimiento fnac,
   CASE c.c_informacion_personal.IP_Sexo WHEN 'M' THEN 'Masculino' When 'F' THEN 'Femenino'  END AS sexo,
    c.ubicacion_mapa.UG_Latitud lat,
    c.ubicacion_mapa.UG_Longitud lon,
    CASE c. tipo_cliente_tc_id WHEN 1 THEN 'Ocasional' WHEN 2 THEN 'Frecuente' when 3 then 'VIP ' when 4 then 'No deseado' END AS Tipo_cliente ,
    c.c_foto
    FROM  cliente c
    where ((fecha_registro>= TO_DATE(fecha_I,'dd/mm/yy') or fecha_registro<= TO_DATE(fecha_F,'dd/mm/yy') ) or tipo_cliente_tc_id= (select tc_id from tipo_cliente where tc_nombre= tipo));
   end if;
  END BUSCAR_Cliente;
  

 PROCEDURE I_Cliente(V_Nombre_foto varchar2,p_nombre Varchar2,s_nombre Varchar2, p_apellido varchar2, s_apellido varchar2, ci varchar2,correo varchar2,nac date,sexo varchar2,latitud varchar2, longitud varchar2, direccion varchar2, tipo varchar2, lugar VARCHAR2)
is 
 temp blob;
fle bfile;
  BEGIN
    INSERT INTO empleado values (DEFAULT, informacion_personal(
    informacion_personal.verificar_cedula(ci),
    informacion_personal.verificar_nombre_apellido(p_nombre),
    informacion_personal.verificar_nombre_apellido(s_nombre),
    informacion_personal.verificar_nombre_apellido(p_apellido),
    informacion_personal.verificar_nombre_apellido(s_apellido),
    informacion_personal.verificar_correo(correo),
    informacion_personal.verificar_fecha_nacimiento(nac),
    informacion_personal.verificar_sexo(sexo),
    direccion) ,EMPTY_BLOB(), ubicacion_geografica(
    ubicacion_geografica.verificar_latitud(latitud),
    ubicacion_geografica.verificar_longitud(longitud),
    ubicacion_geografica.verificar_timestamp(TO_TIMESTAMP('2003/12/13 10:13:18', 'YYYY/MM/DD HH:MI:SS'))),
    (select TC_ID from tipo_cliente where TC_NOMBRE=Tipo), (select SYSDATE  from dual),(select l_id from lugar where l_nombre= lugar )) returning c_foto INTO temp;
    
    
   fle:= BFILENAME ('OBJETOS_LOB', V_Nombre_foto);
   DBMS_LOB.open (fle,DBMS_LOB.lob_readonly);
   DBMS_LOB.loadfromfile (temp,fle,DBMS_LOB.getlength (fle));
   DBMS_LOB.close (fle);
   COMMIT;
  END I_Cliente;


END PK_Cliente;


----Creacion del paquete para alquiler----
CREATE OR REPLACE PACKAGE PK_Alquiler AS
TYPE RESULT_SET IS REF CURSOR;
 
PROCEDURE BUSCAR_Vehiculo(o_result_set OUT RESULT_SET,  fecha_I varchar2, fecha_F varchar2,tipo varchar2,marca varchar2, modelo varchar2, annio number);
PROCEDURE BUSCAR_Vehiculo_Mes(o_result_set OUT RESULT_SET, tipo varchar2, marca varchar2,modelo varchar2, mes number, anno number);
PROCEDURE BUSCAR_Vehiculo_Porcentaje(o_result_set OUT RESULT_SET, tipo varchar2, marca varchar2, mes number, fechaI varchar2, fechaF varchar2);
PROCEDURE BUSCAR_Formas_Pago(o_result_set OUT RESULT_SET,fechaI varchar2, fechaF varchar2,tipo varchar2);
PROCEDURE BUSCAR_Alquileres(o_result_set OUT RESULT_SET,fechaI varchar2, fechaF varchar2,tipo varchar2, status varchar2);
procedure satisfaccion_del_cliente(o_result_set OUT RESULT_SET, fecha_inicio date, fecha_fin date, tipo_vehiculo_param varchar2, marca_param varchar2, modelo_param varchar2, placa_param varchar2);
procedure cantidad_alquileres_por_dia_de_semana(o_result_set OUT RESULT_SET, fecha_inicio_semana date, fecha_fin_semana date);
END PK_Alquiler;
---Creacion del body del paquete
CREATE OR REPLACE PACKAGE BODY PK_Alquiler IS
----Precedimiento para el reporte 1----
Procedure Buscar_Vehiculo( O_Result_Set Out Result_Set, Fecha_I Varchar2, Fecha_F Varchar2,tipo varchar2,marca varchar2, modelo varchar2, annio number) 
  As 
  Begin
  
       if ((marca is null)and (tipo is null)and (modelo is null) and ( Fecha_I is null) and (Fecha_F is null) and (annio is null))then 
        Open O_Result_Set For Select V_Foto,Anno,Modelo,tipo,Ma_nombre,Cant
                        From (Select Count(M.m_nombre) As Cant, V.V_Anno As Anno,V.V_Placa As Placa,M.marca_ma_id as marca , M.m_nombre as modelo,M.m_id as id, t.tv_nombre as tipo
                              From   Detalle_Alquiler D, Alquiler A , Vehiculo V, Tipo_vehiculo T,Modelo M
                             Where V.V_Placa=D.vehiculo_v_placa
                                  and V.Modelo_M_Id= M.m_id
                                  and V.Tipo_Vehiculo_Tv_Id=t.tv_id
                                  And A.Detalle_Alquiler_Da_Id=D.Da_Id
                             -- And D.Da_Fecha Between To_Date(Fecha_I,'dd/mm/yy')And To_Date(Fecha_F,'dd/mm/yy')
                              Group By V.V_placa, V.V_Anno,V.Modelo_M_Id,M.m_id,M.marca_ma_id , M.m_nombre,t.tv_nombre,M.m_id,t.tv_nombre
                              Order By 1 Desc) ,vehiculo, modelo, marca
                        Where Placa=V_Placa
                       -- and placa =vehiculo_v_placa
                        --and aa.Detalle_Alquiler_Da_Id=Da_Id
                        and Modelo_M_Id= id
                        and M_id =id
                        and marca_ma_id=marca
                        and ma_id = marca
                        Order By cant Desc;
                       
 else 
    Open O_Result_Set For Select V_Foto,Anno,Modelo,tipo,Ma_nombre,Cant
                        From (Select Count(M.m_nombre) As Cant, V.V_Anno As Anno,V.V_Placa As Placa,M.marca_ma_id as marca , M.m_nombre as modelo,M.m_id as id, t.tv_nombre as tipo
                              From   Detalle_Alquiler D, Alquiler A , Vehiculo V, Tipo_vehiculo T,Modelo M
                             Where V.V_Placa=D.vehiculo_v_placa
                                  and V.Modelo_M_Id= M.m_id
                                  and V.Tipo_Vehiculo_Tv_Id=t.tv_id
                                  And A.Detalle_Alquiler_Da_Id=D.Da_Id
                                  and ((V.Modelo_M_Id=(select m_id from modelo where m_nombre =modelo) )
                                  or V.Tipo_Vehiculo_Tv_Id=(select tv_id from tipo_vehiculo where tv_nombre = tipo)
                                  or (m.marca_ma_id=(select ma_id from marca where ma_nombre = marca))
                                  or (a.a_periodo_duracion.P_Fecha_Inicio >= TO_DATE(Fecha_I,'dd/mm/yy')
                                  or a.a_periodo_duracion.P_Fecha_Fin <= TO_DATE(Fecha_F,'dd/mm/yy'))
                                  or v.V_anno=annio)
                             -- And D.Da_Fecha Between To_Date(Fecha_I,'dd/mm/yy')And To_Date(Fecha_F,'dd/mm/yy')
                              Group By V.V_placa, V.V_Anno,V.Modelo_M_Id,M.m_id,M.marca_ma_id , M.m_nombre,t.tv_nombre
                              Order By 1 Desc) ,vehiculo, modelo, marca
                        Where Placa=V_Placa
                        and Modelo_M_Id= id
                        and M_id =id
                        and marca_ma_id=marca
                        and ma_id = marca
                        Order By cant Desc;
  end if ;
  End Buscar_Vehiculo;
  ----Precedimiento para el reporte 3----
  Procedure Buscar_Vehiculo_Mes( O_Result_Set Out Result_Set,tipo varchar2, marca varchar2,modelo varchar2, mes number, anno number) 
  As
  Begin
  if ((marca is null)and (tipo is null)and (modelo is null) and (mes is null) and (anno is null))then 
     Open O_Result_Set For Select V_Foto,Anno,Modelo,Ma_nombre,Placa,tipo,Case  MO When 1 Then 'Enero' When 2 Then 'Febrero'When 3 Then 'Marzo' When 4 Then 'Abril' When 5 Then 'Mayo' When 6 Then 'Junio' When 7 Then 'Julio'When 8 Then 'Agosto' When 9 Then 'Septiembre' When 10 Then 'Octubre' When 11 Then 'Noviembre' When 12 Then 'Diciembre'End,An, Cant
                          From(Select Count(V_Placa)As Cant,Extract(Month From a.a_periodo_duracion.P_Fecha_Inicio  ) As Mo
                          ,Extract(Year From a.a_periodo_duracion.P_Fecha_Inicio  ) As An, V_Placa As Placa ,V.V_Anno As Anno, M.marca_ma_id as marca , M.m_nombre as modelo,M.m_id as id, t.tv_nombre as tipo
                                  From    Detalle_Alquiler D, alquiler A , Vehiculo V, Modelo M, Tipo_vehiculo T
                                  Where V.V_Placa=D.vehiculo_v_placa
                                  and V.Modelo_M_Id= M.m_id
                                  and V.Tipo_Vehiculo_Tv_Id=t.tv_id
                                  And A.Detalle_Alquiler_Da_Id=D.Da_Id
                              Group By Extract(Month From a.a_periodo_duracion.P_Fecha_Inicio ), Extract(Year From a.a_periodo_duracion.P_Fecha_Inicio),V_Placa,V.V_Anno, V.Modelo_M_Id,M.m_id,M.marca_ma_id , M.m_nombre,t.tv_nombre
                              Order By 2 asc,3 desc,1 desc
                               ) ,Vehiculo, modelo, marca
                        Where Placa=V_Placa
                        and Modelo_M_Id= id
                        and M_id =id
                        and marca_ma_id=marca
                        and ma_id = marca
                        Order By cant Desc;
     else 
     Open O_Result_Set For Select V_Foto,Anno,Modelo,Ma_nombre,Placa,tipo,Case  MO When 1 Then 'Enero' When 2 Then 'Febrero'When 3 Then 'Marzo' When 4 Then 'Abril' When 5 Then 'Mayo' When 6 Then 'Junio' When 7 Then 'Julio'When 8 Then 'Agosto' When 9 Then 'Septiembre' When 10 Then 'Octubre' When 11 Then 'Noviembre' When 12 Then 'Diciembre'End,An, Cant
                          From(Select Count(V_Placa)As Cant,Extract(Month From a.a_periodo_duracion.P_Fecha_Inicio  ) As Mo
                          ,Extract(Year From a.a_periodo_duracion.P_Fecha_Inicio  ) As An, V_Placa As Placa ,V.V_Anno As Anno, M.marca_ma_id as marca , M.m_nombre as modelo,M.m_id as id, t.tv_nombre as tipo
                                  From    Detalle_Alquiler D, alquiler A , Vehiculo V, Modelo M, Tipo_vehiculo T
                                  Where V.V_Placa=D.vehiculo_v_placa
                                  and V.Modelo_M_Id= M.m_id
                                  and V.Tipo_Vehiculo_Tv_Id=t.tv_id
                                  And A.Detalle_Alquiler_Da_Id=D.Da_Id
                                  and ((V.Modelo_M_Id=(select m_id from modelo where m_nombre =modelo) )
                                  or V.Tipo_Vehiculo_Tv_Id=(select tv_id from tipo_vehiculo where tv_nombre = tipo)
                                  or Extract(Month From a.a_periodo_duracion.P_Fecha_Inicio  )=mes
                                  or Extract(Year From a.a_periodo_duracion.P_Fecha_Inicio  )= anno
                                  or (m.marca_ma_id=(select ma_id from marca where ma_nombre = marca)))
                              Group By Extract(Month From a.a_periodo_duracion.P_Fecha_Inicio ), Extract(Year From a.a_periodo_duracion.P_Fecha_Inicio),V_Placa,V.V_Anno, V.Modelo_M_Id,M.m_id,M.marca_ma_id , M.m_nombre,t.tv_nombre
                              Order By 2 asc,3 desc,1 desc
                               ) ,Vehiculo, modelo, marca
                        Where Placa=V_Placa
                        and Modelo_M_Id= id
                        and M_id =id
                        and marca_ma_id=marca
                        and ma_id = marca
                        Order By cant Desc;
  end if ;                         
  End Buscar_Vehiculo_Mes;
 ---reporte 8----
 Procedure Buscar_Vehiculo_Porcentaje(o_result_set OUT RESULT_SET, tipo varchar2, marca varchar2, mes number, fechaI varchar2, fechaF varchar2) 
  As
  Begin
  if ((marca is null)and (tipo is null)and (fechaI is null) and (mes is null) and (fechaF is null))then 
     Open O_Result_Set For 
                         Select Count(M.m_nombre)As Cant, M.m_nombre as modelo, M.m_id as id, Extract(Month From a.a_periodo_duracion.P_Fecha_Inicio)
                        From Detalle_Alquiler D, alquiler A , Vehiculo V, Modelo M, Tipo_vehiculo T
                         Where V.V_Placa=D.vehiculo_v_placa
                        and V.Modelo_M_Id= M.m_id
                        and V.Tipo_Vehiculo_Tv_Id=t.tv_id
                        And A.Detalle_Alquiler_Da_Id=D.Da_Id
                        Group By  M.m_nombre, M.m_id,M.marca_ma_id,Extract(Month From a.a_periodo_duracion.P_Fecha_Inicio)
                        Order By  4,1 desc;
                                  
                                           
     else 
     Open O_Result_Set For Select Count(M.m_nombre)As Cant, M.m_nombre as modelo, M.m_id as id,Extract(Month From a.a_periodo_duracion.P_Fecha_Inicio)
                                  From Detalle_Alquiler D, alquiler A , Vehiculo V, Modelo M, Tipo_vehiculo T
                                  Where V.V_Placa=D.vehiculo_v_placa
                                  and V.Modelo_M_Id= M.m_id
                                  and V.Tipo_Vehiculo_Tv_Id=t.tv_id
                                  And A.Detalle_Alquiler_Da_Id=D.Da_Id
                                  and 
                                 (m.marca_ma_id=(select ma_id from marca where ma_nombre =marca)or
                                 V.Tipo_Vehiculo_Tv_Id=(select tv_id from tipo_vehiculo where tv_nombre = tipo)
                                  or Extract(Month From a.a_periodo_duracion.P_Fecha_Inicio  )=mes
                                  or (a.a_periodo_duracion.P_Fecha_Inicio >= TO_DATE(fechaI,'dd/mm/yy')
                                  or a.a_periodo_duracion.P_Fecha_Fin <= TO_DATE(fechaF,'dd/mm/yy')))
                              Group By  M.m_nombre, M.m_id,Extract(Month From a.a_periodo_duracion.P_Fecha_Inicio)
                              Order By 4,1 desc;
                              
  end if ;                         
  End Buscar_Vehiculo_Porcentaje;
 
PROCEDURE BUSCAR_Formas_Pago(o_result_set OUT RESULT_SET,fechaI varchar2, fechaF varchar2,tipo varchar2)
    As
  Begin 
 
  if ( (tipo is null)and (fechaI is null) and (fechaF is null))then 
     
     Open O_Result_Set For 
                          select  e.nombre||':'||' '||'$'||' '||e.total,e.nombre,e.total, f.total
                          from (SELECT sum (d.DP_monto) as total, f.fp_nombre as nombre
                           FROM detalle_pago d, forma_pago f, alquiler a , vehiculo v, tipo_vehiculo t, detalle_alquiler da
                           WHERE  d.forma_pago_fp_id=f.fp_id
                           and d.alquiler_a_id=a.a_id
                           and da.vehiculo_v_placa=v.v_placa
                           and a.detalle_alquiler_da_id=da.da_id
                           and v.tipo_vehiculo_tv_id= t.tv_id
                           group by f.fp_nombre) e,(SELECT sum (d.DP_monto) as total
                                                     FROM detalle_pago d, forma_pago f, alquiler a , vehiculo v, tipo_vehiculo t, detalle_alquiler da
                                                     WHERE  d.forma_pago_fp_id=f.fp_id
                                                     and d.alquiler_a_id=a.a_id
                                                     and da.vehiculo_v_placa=v.v_placa
                                                     and a.detalle_alquiler_da_id=da.da_id
                                                     and v.tipo_vehiculo_tv_id= t.tv_id) f;
                         
    else
        Open O_Result_Set For 
                          select  e.nombre||':'||' '||'$'||' '||e.total,e.nombre,e.total, f.total
                          from (SELECT sum (d.DP_monto) as total, f.fp_nombre as nombre
                           FROM detalle_pago d, forma_pago f, alquiler a , vehiculo v, tipo_vehiculo t, detalle_alquiler da
                           WHERE  d.forma_pago_fp_id=f.fp_id
                           and d.alquiler_a_id=a.a_id
                           and da.vehiculo_v_placa=v.v_placa
                           and a.detalle_alquiler_da_id=da.da_id
                           and v.tipo_vehiculo_tv_id= t.tv_id
                           and (v.tipo_vehiculo_tv_id=(select tv_id from tipo_vehiculo where tv_nombre = tipo)or
                           a.a_periodo_duracion.P_Fecha_Inicio >= TO_DATE(FechaI,'dd/mm/yy')
                                  or a.a_periodo_duracion.P_Fecha_Fin <= TO_DATE(FechaF,'dd/mm/yy'))
                           group by f.fp_nombre) e, (SELECT sum (d.DP_monto) as total
                                                     FROM detalle_pago d, forma_pago f, alquiler a , vehiculo v, tipo_vehiculo t, detalle_alquiler da
                                                     WHERE  d.forma_pago_fp_id=f.fp_id
                                                     and d.alquiler_a_id=a.a_id
                                                     and da.vehiculo_v_placa=v.v_placa
                                                     and a.detalle_alquiler_da_id=da.da_id
                                                     and v.tipo_vehiculo_tv_id= t.tv_id and (v.tipo_vehiculo_tv_id=(select tv_id from tipo_vehiculo where tv_nombre = tipo)or
                           a.a_periodo_duracion.P_Fecha_Inicio >= TO_DATE(FechaI,'dd/mm/yy')
                                  or a.a_periodo_duracion.P_Fecha_Fin <= TO_DATE(FechaF,'dd/mm/yy'))) f;
    
      end if;
End BUSCAR_Formas_Pago;

PROCEDURE BUSCAR_Alquileres(o_result_set OUT RESULT_SET,fechaI varchar2, fechaF varchar2,tipo varchar2, status varchar2)
  As
  Begin
     if ((tipo is null)and (fechaI is null) and (fechaF is null) and (status is null))then 
      Open O_Result_Set For   SELECT v.v_placa, v.v_anno, v.v_foto, m.m_nombre, ma.ma_nombre, t.tv_nombre, s.sv_nombre,  c.c_informacion_personal.IP_cedula ,a.a_periodo_duracion.P_Fecha_Inicio, a.a_periodo_duracion.P_Fecha_Fin, c.c_informacion_personal.IP_Primer_Nombre||' '||c.c_informacion_personal.IP_Primer_Apeliido, e.e_descripcion,  CASE  When e.e_ubicacion_geografica_retiro.UG_Latitud is null then 0 end as  lat, CASE  When e.e_ubicacion_geografica_retiro.UG_Longitud is null then 0 end as lon
         FROM vehiculo v left join detalle_alquiler d on v.v_placa=d.vehiculo_v_placa 
         left join alquiler a on d.da_id= a.detalle_alquiler_da_id
         left join cliente c on a.cliente_c_id= c.c_id
         left join reserva r on a.reserva_re_id=r.re_id
         left join entrega e on e.reserva_re_id=r.re_id,
         modelo m, marca ma, tipo_vehiculo t, status_vehiculo s
         Where v.modelo_m_id = m.m_id
         and v.modelo_marca_ma_id=ma.ma_id
         and v.tipo_vehiculo_tv_id= t.tv_id
         and v.status_vehiculo_sv_id= s.sv_id;
        else
          Open O_Result_Set For    SELECT v.v_placa, v.v_anno, v.v_foto, m.m_nombre, ma.ma_nombre, t.tv_nombre, s.sv_nombre,  c.c_informacion_personal.IP_cedula ,a.a_periodo_duracion.P_Fecha_Inicio, a.a_periodo_duracion.P_Fecha_Fin, c.c_informacion_personal.IP_Primer_Nombre||' '||c.c_informacion_personal.IP_Primer_Apeliido, e.e_descripcion, CASE  When e.e_ubicacion_geografica_retiro.UG_Latitud is null then 0 end as  lat, CASE  When e.e_ubicacion_geografica_retiro.UG_Longitud is null then 0 end as lon
                 FROM vehiculo v left join detalle_alquiler d on v.v_placa=d.vehiculo_v_placa 
                 left join alquiler a on d.da_id= a.detalle_alquiler_da_id
                 left join cliente c on a.cliente_c_id= c.c_id
                 left join reserva r on a.reserva_re_id=r.re_id
                 left join entrega e on e.reserva_re_id=r.re_id,
                  modelo m, marca ma, tipo_vehiculo t, status_vehiculo s
                 Where v.modelo_m_id = m.m_id
                 and v.modelo_marca_ma_id=ma.ma_id
                 and v.tipo_vehiculo_tv_id= t.tv_id
                 and v.status_vehiculo_sv_id= s.sv_id
                 and ( a.a_periodo_duracion.P_Fecha_Inicio >= TO_DATE(fechaI,'dd/mm/yy')
                    or a.a_periodo_duracion.P_Fecha_Fin <= TO_DATE(fechaF,'dd/mm/yy')
                    or v.tipo_vehiculo_tv_id=(select tv_id from tipo_vehiculo where tv_nombre = tipo)
                    or v.status_vehiculo_sv_id=(select sv_id from status_vehiculo where sv_nombre = status
                   ));
       end if;
       end BUSCAR_Alquileres;
       
-- Procedure para el reporte numero 12
    procedure satisfaccion_del_cliente(o_result_set OUT RESULT_SET, fecha_inicio date, fecha_fin date, tipo_vehiculo_param varchar2, marca_param varchar2, modelo_param varchar2, placa_param varchar2)
    is
    begin
        -- Verificamos que los parametros valgan null todos
        if (fecha_inicio is null) and (fecha_fin is null) and (tipo_vehiculo_param is null) and (marca_param is null) and (modelo_param is null) and (placa_param is null) then
            -- todos los parametros son null
            open o_result_set for 
                select tp_veh.tv_nombre tipo_vehiculo_r, marca.ma_nombre marca_vehiculo, modelo.m_nombre modelo_vehiculo, veh.v_anno anno_vehiculo, veh.v_placa placa_vehiculo, veh.v_foto foto_vehiculo, ra.r_escala_satisfaccion escala, (
                    select XMLAGG(XMLELEMENT(E,obs.o_descripcion||' ')).EXTRACT('//text()').getstringval()
                    from observacion obs
                    where   obs.rating_r_id = ra.r_id
                ) observaciones
                from alquiler alq, detalle_alquiler det_alq, vehiculo veh, tipo_vehiculo tp_veh, marca, modelo, rating ra
                where   alq.detalle_alquiler_da_id = det_alq.da_id  and
                        det_alq.vehiculo_v_placa = veh.v_placa      and
                        veh.tipo_vehiculo_tv_id = tp_veh.tv_id      and
                        veh.modelo_m_id = modelo.m_id               and
                        veh.modelo_marca_ma_id = marca.ma_id        and
                        ra.alquiler_a_id = alq.a_id
            ;
        else 
            -- no todos los parametros son null
            -- funciona de forma que en lo que se cumpla alguna de las codicones ya regresa, es decir
                -- si se desea un Kia, Sportage, AG25LK65 en lo que se cumpla una de estas ya traera al vehiculo,
                -- usa or no and, para que obligue a que se cumplan todas las condiciones
            open o_result_set for 
                select tp_veh.tv_nombre tipo_vehiculo_r, marca.ma_nombre marca_vehiculo, modelo.m_nombre modelo_vehiculo, veh.v_anno anno_vehiculo, veh.v_placa placa_vehiculo, veh.v_foto foto_vehiculo, ra.r_escala_satisfaccion escala, (
                    select XMLAGG(XMLELEMENT(E,obs.o_descripcion||' ')).EXTRACT('//text()').getstringval()
                    from observacion obs
                    where   obs.rating_r_id = ra.r_id
                ) observaciones
                from (
                        select *
                        from alquiler a_aux
                        where   fecha_inicio <= a_aux.a_periodo_duracion.P_Fecha_Inicio   or 
                                fecha_fin  >= a_aux.a_periodo_duracion.P_Fecha_Fin
                    ) alq, 
                    (
                        select *
                        from vehiculo
                        where   tipo_vehiculo_tv_id = (select tv_id from tipo_vehiculo where tv_nombre = tipo_vehiculo_param)   or
                                modelo_marca_ma_id = (select ma_id from marca where ma_nombre = marca_param)                    or
                                modelo_m_id = (select m_id from modelo where m_nombre = modelo_param)                           or
                                v_placa = placa_param
                    ) veh,
                    detalle_alquiler det_alq, 
                    rating ra,
                    tipo_vehiculo tp_veh,
                    marca, 
                    modelo
                where   alq.detalle_alquiler_da_id = det_alq.da_id  and
                        det_alq.vehiculo_v_placa = veh.v_placa      and
                        veh.tipo_vehiculo_tv_id = tp_veh.tv_id      and
                        veh.modelo_m_id = modelo.m_id               and
                        veh.modelo_marca_ma_id = marca.ma_id        and
                        ra.alquiler_a_id = alq.a_id
            ;
        end if;
    end satisfaccion_del_cliente;
  
  -- Procedure para el reporte numero 13
    procedure cantidad_alquileres_por_dia_de_semana(o_result_set OUT RESULT_SET, fecha_inicio_semana date, fecha_fin_semana date)
    is
        -- variables para los dias 
        fecha_lunes date := fecha_inicio_semana;
        fecha_martes date := fecha_inicio_semana + 1;
        fecha_miercoles date := fecha_inicio_semana + 2;
        fecha_jueves date := fecha_inicio_semana + 3;
        fecha_viernes date := fecha_inicio_semana + 4;
        fecha_sabado date := fecha_inicio_semana + 5;
        fecha_domingo date := fecha_fin_semana;
    begin
        -- Verificamos si se dieron todos los parametros para el query
        if ((fecha_inicio_semana is not NULL) and (fecha_fin_semana is not NULL)) then
            -- Realizamos el query
            -- es necesario que la data retorne de la forma (cant, dia) para tener una serie de cantidades y de dias
            -- se puede hacer de dos formas:
                -- se hace que la fecha inicio sea el inico de una semana y la fecha de fin seria el fin de la semana (esta es la opcion que se trabajara)
                -- se cuentan los dias de la semana entre las fechas dadas
            open o_result_set for 
                select count(alq.a_id) cantidades,  dia_semana.dia 
                    from alquiler alq, (select to_char(fecha_lunes, 'DAY') dia FROM dual) dia_semana
                    where fecha_lunes between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin
                    group by dia_semana.dia
                union all
                select count(alq.a_id) cantidades,  dia_semana.dia 
                    from alquiler alq, (select to_char(fecha_martes, 'DAY') dia FROM dual) dia_semana
                    where fecha_martes between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin
                    group by dia_semana.dia
                union all
                select count(alq.a_id) cantidades,  dia_semana.dia 
                    from alquiler alq, (select to_char(fecha_miercoles, 'DAY') dia FROM dual) dia_semana
                    where fecha_miercoles between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin
                    group by dia_semana.dia
                union all
                select count(alq.a_id) cantidades,  dia_semana.dia 
                    from alquiler alq, (select to_char(fecha_jueves, 'DAY') dia FROM dual) dia_semana
                    where fecha_jueves between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin
                    group by dia_semana.dia
                union all
                select count(alq.a_id) cantidades,  dia_semana.dia 
                    from alquiler alq, (select to_char(fecha_viernes, 'DAY') dia FROM dual) dia_semana
                    where fecha_viernes between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin
                    group by dia_semana.dia
                union all
                select count(alq.a_id) cantidades,  dia_semana.dia 
                    from alquiler alq, (select to_char(fecha_sabado, 'DAY') dia FROM dual) dia_semana
                    where fecha_sabado between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin
                    group by dia_semana.dia
                union all
                select count(alq.a_id) cantidades,  dia_semana.dia 
                    from alquiler alq, (select to_char(fecha_domingo, 'DAY') dia FROM dual) dia_semana
                    where fecha_domingo between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin
                    group by dia_semana.dia
            ;
        else 
            -- Como no se dieron los parametros entonces se busca para todos los dias de la semana
            -- del anno
            open o_result_set for
                -- Query para los lunes
                select count(alq.a_id) cantidades, to_char(dias.dia, 'Day') dia
                from    (
                            select trunc(to_date(concat('01/01/',to_char(extract(year from SYSDATE)+1)),'dd/mm/yyyy') - rownum) dia
                            from DUAL 
                            connect by rownum < 366
                        ) dias,
                        alquiler alq
                where   to_char(dias.dia, 'Day') like to_char(to_date('19/06/2023','dd/mm/yyyy'), 'Day') and
                        dias.dia between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin   
                group by to_char(dias.dia, 'Day')
                union all
                -- Query para los martes
                select count(alq.a_id) cantidades, to_char(dias.dia, 'Day') dia
                from    (
                            select trunc(to_date(concat('01/01/',to_char(extract(year from SYSDATE)+1)),'dd/mm/yyyy') - rownum) dia
                            from DUAL 
                            connect by rownum < 366
                        ) dias,
                        alquiler alq
                where   to_char(dias.dia, 'Day') like to_char(to_date('20/06/2023','dd/mm/yyyy'), 'Day') and
                        dias.dia between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin   
                group by to_char(dias.dia, 'Day')
                union all
                -- Query para los miercoles
                select count(alq.a_id) cantidades, to_char(dias.dia, 'Day') dia
                from    (
                            select trunc(to_date(concat('01/01/',to_char(extract(year from SYSDATE)+1)),'dd/mm/yyyy') - rownum) dia
                            from DUAL 
                            connect by rownum < 366
                        ) dias,
                        alquiler alq
                where   to_char(dias.dia, 'Day') like to_char(to_date('21/06/2023','dd/mm/yyyy'), 'Day') and
                        dias.dia between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin   
                group by to_char(dias.dia, 'Day')
                union all
                -- Query para los jueves
                select count(alq.a_id) cantidades, to_char(dias.dia, 'Day') dia
                from    (
                            select trunc(to_date(concat('01/01/',to_char(extract(year from SYSDATE)+1)),'dd/mm/yyyy') - rownum) dia
                            from DUAL 
                            connect by rownum < 366
                        ) dias,
                        alquiler alq
                where   to_char(dias.dia, 'Day') like to_char(to_date('22/06/2023','dd/mm/yyyy'), 'Day') and
                        dias.dia between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin   
                group by to_char(dias.dia, 'Day')
                union all
                -- Query para los viernes
                select count(alq.a_id) cantidades, to_char(dias.dia, 'Day') dia
                from    (
                            select trunc(to_date(concat('01/01/',to_char(extract(year from SYSDATE)+1)),'dd/mm/yyyy') - rownum) dia
                            from DUAL 
                            connect by rownum < 366
                        ) dias,
                        alquiler alq
                where   to_char(dias.dia, 'Day') like to_char(to_date('23/06/2023','dd/mm/yyyy'), 'Day') and
                        dias.dia between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin   
                group by to_char(dias.dia, 'Day')
                union all
                -- Query para los sabado
                select count(alq.a_id) cantidades, to_char(dias.dia, 'Day') dia
                from    (
                            select trunc(to_date(concat('01/01/',to_char(extract(year from SYSDATE)+1)),'dd/mm/yyyy') - rownum) dia
                            from DUAL 
                            connect by rownum < 366
                        ) dias,
                        alquiler alq
                where   to_char(dias.dia, 'Day') like to_char(to_date('24/06/2023','dd/mm/yyyy'), 'Day') and
                        dias.dia between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin   
                group by to_char(dias.dia, 'Day')
                union all
                -- Query para los domingo
                select count(alq.a_id) cantidades, to_char(dias.dia, 'Day') dia
                from    (
                            select trunc(to_date(concat('01/01/',to_char(extract(year from SYSDATE)+1)),'dd/mm/yyyy') - rownum) dia
                            from DUAL 
                            connect by rownum < 366
                        ) dias,
                        alquiler alq
                where   to_char(dias.dia, 'Day') like to_char(to_date('25/06/2023','dd/mm/yyyy'), 'Day') and
                        dias.dia between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin   
                group by to_char(dias.dia, 'Day')
            ;
        
        end if;
    end cantidad_alquileres_por_dia_de_semana;

end PK_Alquiler;


----  paquete pk_promocions-----
CREATE OR REPLACE PACKAGE PK_Promocion AS
TYPE RESULT_SET IS REF CURSOR;

PROCEDURE BUSCAR_Promocion(o_result_set OUT RESULT_SET,  fecha_I varchar2, fecha_F varchar2);
END PK_Promocion;

----create body package------
CREATE OR REPLACE PACKAGE BODY PK_Promocion IS
PROCEDURE BUSCAR_Promocion( o_result_set OUT RESULT_SET, fecha_I varchar2, fecha_F varchar2) 
  AS 
  BEGIN
        if ((fecha_I is null) and (fecha_F is null) ) then
    OPEN o_result_set FOR SELECT p.p_descripcion,v.v_precio, v.v_precio-((v.v_precio* p.p_porcentaje_descuento)),m.m_nombre,n.ma_nombre, v.v_foto,v_anno,h.hp_periodo_duracion.P_Fecha_Inicio,h.hp_periodo_duracion.P_Fecha_Fin
                          from  marca n , modelo m,historico_promocion  h, Promocion p , vehiculo v
                          where v.modelo_M_ID=m.m_id  
                          and n.ma_id=m.marca_ma_id
                          and p.p_id =h.promocion_p_id 
                          and h.vehiculo_v_placa=v.v_placa;
                         -- or((h.hp_periodo_duracion.P_Fecha_Inicio>= TO_DATE('','dd/mm/yy'))or (h.hp_periodo_duracion.P_Fecha_Fin<= TO_DATE('','dd/mm/yy'))); 
        else 
            OPEN o_result_set FOR SELECT p.p_descripcion,v.v_precio, v.v_precio-((v.v_precio* p.p_porcentaje_descuento)),m.m_nombre,n.ma_nombre, v.v_foto,v_anno,h.hp_periodo_duracion.P_Fecha_Inicio,h.hp_periodo_duracion.P_Fecha_Fin
                          from  marca n , modelo m,historico_promocion  h, Promocion p , vehiculo v
                          where v.modelo_M_ID=m.m_id  
                          and n.ma_id=m.marca_ma_id
                          and p.p_id =h.promocion_p_id 
                          and h.vehiculo_v_placa=v.v_placa
                          and((h.hp_periodo_duracion.P_Fecha_Inicio>= TO_DATE(fecha_I,'dd/mm/yy'))or (h.hp_periodo_duracion.P_Fecha_Fin<= TO_DATE(fecha_F,'dd/mm/yy'))); 
           end if;               
                           
  END BUSCAR_Promocion;
  END PK_Promocion;


CREATE OR REPLACE PACKAGE PK_Alianza AS
TYPE RESULT_SET IS REF CURSOR;
 
PROCEDURE BUSCAR_Alianza(o_result_set OUT RESULT_SET, fecha_I varchar2, fecha_F varchar2);
PROCEDURE I_Aliado(V_Nombre_foto varchar2,nombre Varchar2);
END PK_Alianza;


CREATE OR REPLACE PACKAGE BODY  PK_Alianza IS
PROCEDURE BUSCAR_alianza( o_result_set OUT RESULT_SET,fecha_I varchar2, fecha_F varchar2) 
  AS
  BEGIN
  if (fecha_I is null and fecha_F is null) then
    OPEN o_result_set FOR SELECT a.aa_periodo_duracion.P_Fecha_Inicio,a.aa_periodo_duracion.P_Fecha_Fin,a.aa_descripcion,ao_nombre,ao_logo
                          from  alianza a, aliado
                          where aliado_ao_id=ao_id
                          order by 1,2;
                        
   else 
     OPEN o_result_set FOR SELECT a.aa_periodo_duracion.P_Fecha_Inicio,a.aa_periodo_duracion.P_Fecha_Fin,a.aa_descripcion,ao_nombre,ao_logo
                          from  alianza a, aliado
                          where aliado_ao_id=ao_id
                          and (a.aa_periodo_duracion.P_Fecha_Inicio>= TO_DATE(fecha_I,'dd/mm/yy')or
                             a.aa_periodo_duracion.P_Fecha_Fin<= TO_DATE(fecha_F,'dd/mm/yy'))
                              order by 1,2;
                             
  end if;
  END BUSCAR_alianza;

  PROCEDURE I_Aliado(V_Nombre_foto varchar2,nombre Varchar2)
is 
 temp blob;
   fle bfile;
   
  BEGIN
    INSERT INTO aliado values (DEFAULT,nombre, EMPTY_BLOB()) returning ao_logo INTO temp;
   fle:= BFILENAME ('OBJETOS_LOB', V_Nombre_foto);
   DBMS_LOB.open (fle,DBMS_LOB.lob_readonly);
   DBMS_LOB.loadfromfile (temp,fle,DBMS_LOB.getlength (fle));
   DBMS_LOB.close (fle);
   COMMIT;
  END I_Aliado; 
  END PK_Alianza;

 
CREATE OR REPLACE PACKAGE PK_Mantenimiento AS
TYPE RESULT_SET IS REF CURSOR;
 
PROCEDURE BUSCAR_Mantenimiento(o_result_set OUT RESULT_SET,fecha_I varchar2, fecha_F varchar2, tipo varchar2, marca varchar2, modelo varchar2, placa varchar2);
END PK_Mantenimiento; 
 

CREATE OR REPLACE PACKAGE BODY PK_Mantenimiento IS
PROCEDURE BUSCAR_Mantenimiento( o_result_set OUT RESULT_SET,fecha_I varchar2, fecha_F varchar2,tipo varchar2, marca varchar2, modelo varchar2, placa varchar2) 
  AS 
  BEGIN


         if ((fecha_I is null) and (fecha_F is null) and (tipo is null) and (marca is null) and (modelo is null) and (placa is null) ) then
    OPEN o_result_set FOR SELECT v.v_placa,v.v_anno ,v.v_foto,m.m_nombre,n.ma_nombre ,ma.m_descripcion,t.tm_nombre,s.s_nombre,ta.t_ubicacion_geografica.UG_Latitud,ta.t_ubicacion_geografica.UG_Longitud,mv.man_fecha_proximo_man,mv.man_periodo_duracion.P_Fecha_Inicio,ta.T_nombre
                          FROM vehiculo v, marca n , modelo m, mantenimiento ma,taller ta,mantenimiento_vehiculo mv, mantenimiento_taller mt, status_mantenimiento s, tipo_mantenimiento t
                          WHERE v.v_placa=mv.vehiculo_v_placa
                          and n.ma_id=m.marca_ma_id
                          and v.modelo_M_ID=m.m_id 
                          and s.s_id= mv.status_mantenimiento_s_id
                          and ma.tipo_mantenimiento_TM_ID= t.tm_id
                          and mt.mantenimiento_m_id  =ma.m_id  
                          and mt.taller_t_id=ta.t_id
                          and mv.mantenimiento_taller_mt_id =mt.mt_id ;
                        
         else  
    OPEN o_result_set FOR SELECT v.v_placa,v.v_anno ,v.v_foto,m.m_nombre,n.ma_nombre ,ma.m_descripcion,t.tm_nombre,s.s_nombre,ta.t_ubicacion_geografica.UG_Latitud,ta.t_ubicacion_geografica.UG_Longitud,mv.man_fecha_proximo_man,ta.T_nombre,mv.man_periodo_duracion.P_Fecha_Inicio,mv.man_periodo_duracion.P_Fecha_Fin, mv.man_id
                          FROM vehiculo v, marca n , modelo m, mantenimiento ma,taller ta,mantenimiento_vehiculo mv, mantenimiento_taller mt, status_mantenimiento s, tipo_mantenimiento t
                          WHERE v.v_placa=mv.vehiculo_v_placa
                          and n.ma_id=m.marca_ma_id
                          and v.modelo_M_ID=m.m_id 
                          and s.s_id= mv.status_mantenimiento_s_id
                          and ma.tipo_mantenimiento_TM_ID= t.tm_id
                          and mt.mantenimiento_m_id  =ma.m_id  
                          and mt.taller_t_id=ta.t_id
                          and mv.mantenimiento_taller_mt_id =mt.mt_id 
                         and( mv.man_periodo_duracion.P_Fecha_Inicio>= TO_DATE(fecha_I,'dd/mm/yy')or
                             mv.man_periodo_duracion.P_Fecha_Fin<= TO_DATE(fecha_F,'dd/mm/yy')
                             or ma.tipo_mantenimiento_TM_ID=(select tm_id from tipo_mantenimiento where tm_nombre=tipo)
                             or v.modelo_M_ID= (select m_id from modelo where m_nombre=modelo)
                             or v.v_placa= placa 
                             or m.marca_ma_id=(select ma_id from marca where ma_nombre = marca));        
                         
         end if;
                         
  END BUSCAR_Mantenimiento;
  END PK_Mantenimiento;
 
CREATE OR REPLACE PACKAGE PK_Ingreso_Egreso AS
TYPE RESULT_SET IS REF CURSOR;
 
PROCEDURE BUSCAR_Ingreso_Egreso(o_result_set OUT RESULT_SET,mes number, anno number);
END PK_Ingreso_Egreso; 


CREATE OR REPLACE PACKAGE BODY PK_Ingreso_Egreso IS
PROCEDURE BUSCAR_Ingreso_Egreso(o_result_set OUT RESULT_SET,mes number, anno number)
  AS 
  BEGIN
  If (mes is null and anno is null) then
  
  OPEN o_result_set FOR SELECT '$'||''||e.total,Case e.m  When 1 Then 'Enero' When 2 Then 'Febrero'When 3 Then 'Marzo' When 4 Then 'Abril' When 5 Then 'Mayo' When 6 Then 'Junio' When 7 Then 'Julio'When 8 Then 'Agosto' When 9 Then 'Septiembre' When 10 Then 'Octubre' When 11 Then 'Noviembre' When 12 Then 'Diciembre'End,e.a,'$'||''||g.total,g.m,g.a
                           FROM (select sum(G_precio) as total ,Extract(Month From g_fecha)m,Extract(Year From g_fecha) a 
                                        from gasto  
                                        group by Extract(Month From g_fecha),Extract(Year From g_fecha))g
                           ,(select sum(I_cantidad) as total ,Extract(Month From i_fecha)m,Extract(Year From i_fecha) a 
                                        from ingreso 
                                        group by Extract(Month From i_fecha),Extract(Year From i_fecha)) e
                                where e.a=g.a
                                and   e.m=g.m;

  else
     OPEN o_result_set FOR SELECT '$'||''||e.total,Case e.m  When 1 Then 'Enero' When 2 Then 'Febrero'When 3 Then 'Marzo' When 4 Then 'Abril' When 5 Then 'Mayo' When 6 Then 'Junio' When 7 Then 'Julio'When 8 Then 'Agosto' When 9 Then 'Septiembre' When 10 Then 'Octubre' When 11 Then 'Noviembre' When 12 Then 'Diciembre'End ,e.a,'$'||''||g.total,g.m,g.a
                           FROM (select sum(G_precio) as total ,Extract(Month From g_fecha)m,Extract(Year From g_fecha) a 
                                        from gasto  
                                        where Extract(Month From g_fecha)=mes
                                        and Extract(Year From g_fecha )= anno
                                        group by Extract(Month From g_fecha),Extract(Year From g_fecha))g
                           ,(select sum(I_cantidad) as total ,Extract(Month From i_fecha)m,Extract(Year From i_fecha) a 
                                        from ingreso 
                                        where Extract(Month From i_fecha)=mes
                                        and Extract(Year From i_fecha )= anno
                                        group by Extract(Month From i_fecha),Extract(Year From i_fecha)) e;
                       
                                  
  end if;
  end;
  END PK_Ingreso_Egreso;

----Busca la cantidad de alquileres que ha realizado un cliente anualmente--- 
create or replace function buscar_numero(id number ,fechaI date, fechaF date ) return number
IS cant number;
   ci number;
    begin
        Select count(*) into cant from alquiler where cliente_C_id=id and A_fecha_inicio between fechaI and fechaF group by cliente_c_id ; 
        return cant ;
end;
 
 
 CREATE OR REPLACE PACKAGE PK_Reserva AS
TYPE RESULT_SET IS REF CURSOR;
 
PROCEDURE BUSCAR_Reserva(o_result_set OUT RESULT_SET, fecha_I varchar2, fecha_F varchar2, tipo varchar2);
END PK_Reserva;
 
CREATE OR REPLACE PACKAGE BODY PK_Reserva IS
PROCEDURE BUSCAR_Reserva(o_result_set OUT RESULT_SET, fecha_I varchar2, fecha_F varchar2, tipo varchar2)
  AS 
  BEGIN 
  if (fecha_i is null and fecha_f is null and tipo is null) then
    OPEN o_result_set FOR SELECT r.re_fecha_realizacion,a.a_periodo_duracion.P_Fecha_Inicio,a.a_periodo_duracion.P_Fecha_Fin, c.c_informacion_personal.IP_cedula,c.c_foto,CONCAT (c.c_informacion_personal.IP_Primer_Nombre, c.c_informacion_personal.IP_Primer_Apeliido), t.tv_nombre,v.v_placa,m.m_nombre, ma.ma_nombre, v.v_foto,e.e_descripcion
                          FROM reserva r , cliente c , alquiler a , vehiculo v , entrega e, detalle_alquiler d, tipo_vehiculo t, marca ma, modelo m
                          WHERE r.re_id= a.reserva_re_id
                          and r.cliente_C_id=a.cliente_c_id
                          and r.cliente_C_id=c.c_id
                          and d.da_id=a.detalle_alquiler_da_id
                          and vehiculo_v_placa=v.v_placa
                          and e.reserva_re_id=r.re_id
                          and t.tv_id=v.tipo_vehiculo_tv_id
                          and v.modelo_m_id=m.m_id
                          and v.modelo_marca_ma_id=ma.ma_id;
    else
        OPEN o_result_set FOR SELECT r.re_fecha_realizacion,a.a_periodo_duracion.P_Fecha_Inicio,a.a_periodo_duracion.P_Fecha_Fin, c.c_informacion_personal.IP_cedula,c.c_foto,CONCAT (c.c_informacion_personal.IP_Primer_Nombre, c.c_informacion_personal.IP_Primer_Apeliido), t.tv_nombre,v.v_placa,m.m_nombre, ma.ma_nombre, v.v_foto,e.e_descripcion
                          FROM reserva r , cliente c , alquiler a , vehiculo v , entrega e, detalle_alquiler d, tipo_vehiculo t, marca ma, modelo m
                          WHERE r.re_id= a.reserva_re_id
                          and r.cliente_C_id=a.cliente_c_id
                          and r.cliente_C_id=c.c_id
                          and d.da_id=a.detalle_alquiler_da_id
                          and vehiculo_v_placa=v.v_placa
                          and e.reserva_re_id=r.re_id
                          and t.tv_id=v.tipo_vehiculo_tv_id
                          and v.modelo_m_id=m.m_id
                          and v.modelo_marca_ma_id=ma.ma_id
                          and ( V.Tipo_Vehiculo_Tv_Id=(select tv_id from tipo_vehiculo where tv_nombre = tipo)
                          or  (a.a_periodo_duracion.P_Fecha_Inicio >= TO_DATE(Fecha_I,'dd/mm/yy')
                                  or a.a_periodo_duracion.P_Fecha_Fin <= TO_DATE(Fecha_F,'dd/mm/yy')));
  end if ;                       
  END;
  end pk_Reserva;
 ----Procedimiento que actualiza el tipo de cliente segun el numero de alquileres ha hecho anualmente --- 
 create or replace PROCEDURE cambiar_tipo_cliente (id number,fechaI date, fechaF date) 
 is  
 begin
    if(buscar_numero(id,fechaI,fechaF)=1) then
        Update cliente set tipo_cliente_tc_id =(select TC_ID from tipo_cliente where TC_NOMBRE='Ocacional')
        where c_id=id ;
      else if (buscar_numero(id,fechaI,fechaF)=3)then
        begin
        Update cliente set tipo_cliente_tc_id = (select TC_ID from tipo_cliente where TC_NOMBRE='Frecuente')
        where c_id=id;   
        end;
     else if ((buscar_numero(id,fechaI,fechaF)>=5))then
        begin
        Update cliente set tipo_cliente_tc_id =(select TC_ID from tipo_cliente where TC_NOMBRE='VIP')
        where c_id=id;   
        end;
     end if;
     end if;
      end if;
 end;
 
  ----insert de prueba----
insert into Promocion values (DEFAULT,0.50,'50% en descuento en el alquiler por día para vehiculos Toyota Fortuner 2022');
insert into Promocion values (DEFAULT,0.50,'50% en descuento en el alquiler por día para vehiculos Toyota Corolla 2023');
insert into Promocion values (DEFAULT,0.50,'50% en descuento en el alquiler por día para vehiculos Honda Civic 2014');
insert into Promocion values (DEFAULT,0.50,'50% en descuento en el alquiler por día para vehiculos Ford Explorer 2015');
--Historico Promocion---

insert into historico_promocion values (default,periodo_duracion(periodo_duracion.verificar_fecha_inicio('21/06/23','22/06/23'),periodo_duracion.verificar_fecha_fin('21/06/23','22/06/23')),1,'AB445D4');
insert into historico_promocion values (default,periodo_duracion(periodo_duracion.verificar_fecha_inicio('21/06/23','22/06/23'),periodo_duracion.verificar_fecha_fin('21/06/23','22/06/23')),2,'DF48S5');
insert into historico_promocion values (default,periodo_duracion(periodo_duracion.verificar_fecha_inicio('21/06/23','22/06/23'),periodo_duracion.verificar_fecha_fin('21/06/23','22/06/23')),3,'AA28E6');
insert into historico_promocion values (default,periodo_duracion(periodo_duracion.verificar_fecha_inicio('21/06/23','22/06/23'),periodo_duracion.verificar_fecha_fin('21/06/23','22/06/23')),4,'AA7821');

---Vehiculo--
execute PK_Vehiculo.I_Vehiculo('civic.PNG',2014,'AA28E7',50,15,'civic','Disponible','AZUL','Carro',1);
execute PK_Vehiculo.I_Vehiculo('fortuner.PNG',2022,'AB45D4',50,20,'fortuner','Disponible','PLATEADO','Camioneta',1);
execute PK_Vehiculo.I_Vehiculo('toyo.PNG',2023,'DF48S5',50,25,'corolla','Disponible','BLANCO','Carro',1);
execute PK_Vehiculo.I_Vehiculo('explorer.PNG',2015,'AA74l4',50,12,'explorer','Disponible','ROJO','Camioneta',1);
execute PK_Vehiculo.I_Vehiculo('explorer.PNG',2014,'AA5821',50,10,'explorer','Disponible','ROJO','Camioneta',1);
--Cliente--
execute PK_Cliente.I_Cliente('persona1.PNG','Jose','Manuel','Perez','Castillo','V-26778657','josemac@gmail.com','05/10/91','M','10.4974293','-66.9116934','PUENTE','Ocacional', 'Libertador')
execute PK_Cliente.I_Cliente('persona2.PNG','Javier','Marcos','Peralta','Contreras','V-26777452','javi@gmail.com','06/11/94','M','10.4974293','-66.9116934','PUENTE','VIP','Libertador')
execute PK_Cliente.I_Cliente('persona3.PNG','Luna','Mariela','Martinez','Colmenares','V-22456742','luna@gmail.com','27/04/95','M','10.4974293','-66.9116934','PUENTE','Frecuente','Libertador')
execute PK_Cliente.I_Cliente('persona4.PNG','Maria','Monica','Martinelli','Abreu','V-28456742','MMonica@gmail.com','27/04/01','M','10.4974293','-66.9116934','PUENTE','Frecuente','Libertador')
execute PK_Cliente.I_Cliente('persona4.PNG','Marisol','Monic','Martinez','Bermude','V-28456742','MMonica@gmail.com','27/04/01','F','10.4974293','-66.9116934','PUENTE','Frecuente','Libertador')


  
  --Aliado--
execute PK_Alianza.I_Aliado('descarga.PNG' ,'pana Tech');
execute PK_Alianza.I_Aliado('gruero.PNG' ,'Tu gruero');


---Alianza ---
insert into alianza values (DEFAULT,periodo_duracion(TO_DATE('2022-12-22','yyyy-MM-dd'),TO_DATE('2022-12-23','yyyy-MM-dd')),'Todos los vehículos de la compañía de alquiler cuentan con una suscripción de “PANA”','Servicio',(select ao_id from aliado where ao_nombre='pana Tech'),(SELECT S_id from sede where S_NUMEROSEDE=1));
insert into alianza values (DEFAULT,periodo_duracion(TO_DATE('2022-12-22','yyyy-MM-dd'),TO_DATE('2022-12-23','yyyy-MM-dd')),'Todos los vehículos de la compañía de alquiler cuentan con una suscripción de “TU GRUERO”','Servicio',(select ao_id from aliado where ao_nombre='Tu gruero'),(SELECT S_id from sede where S_NUMEROSEDE=1));

----taller---
 insert into taller values(DEFAULT,'TALLER NINO JR','2124567427',ubicacion_geografica(
    ubicacion_geografica.verificar_latitud(10.49708),
    ubicacion_geografica.verificar_longitud(-66.91310),
    ubicacion_geografica.verificar_timestamp(TO_TIMESTAMP('2003/12/13 10:13:18', 'YYYY/MM/DD HH:MI:SS'))),5,27);

---mantenimientos--

 insert into mantenimiento values(Default,'cambio de aceite',(select TM_ID from tipo_mantenimiento where tm_nombre='Correctivo') );
 select * from mantenimiento_taller;

  insert  into mantenimiento_taller values (default,22,1);
  insert into mantenimiento_vehiculo values(default,periodo_duracion(periodo_duracion.verificar_fecha_inicio('26/06/23','27/06/23'),periodo_duracion.verificar_fecha_fin('26/06/23','27/06/23')),'22/07/23',30,'DF48S5',1,41);
  