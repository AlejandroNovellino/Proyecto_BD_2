--Creacion de un directorio para guardar imagenes
CREATE OR REPLACE DIRECTORY OBJETOS_LOB AS 'C:\IMAGENES\';
/
CREATE OR REPLACE PACKAGE PK_Vehiculo AS
TYPE RESULT_SET IS REF CURSOR;

PROCEDURE  I_Vehiculo(V_Nombre_foto varchar2,v_anno number,v_placa Varchar2,v_km number,v_precio number, modelos varchar2,status varchar2, colorv varchar2,tipo varchar2,sedes number);
END PK_Vehiculo;
  /
 CREATE OR REPLACE PACKAGE BODY PK_Vehiculo IS
 
PROCEDURE I_Vehiculo(V_Nombre_foto varchar2,v_anno number,v_placa Varchar2,v_km number,v_precio number, modelos varchar2,status varchar2, colorv varchar2,tipo varchar2,sedes number)
is 
 temp blob;
 fle bfile;
  BEGIN
    INSERT INTO vehiculo values (v_placa,v_anno,EMPTY_BLOB(),v_km,v_precio,(SELECT m_id From modelo where m_nombre = modelos),(SELECT marca_ma_id From modelo where m_nombre = modelos), (SELECT sv_id From status_vehiculo where sv_nombre = status),(SELECT c_id From color where c_nombre = colorv) ,(SELECT tv_id From tipo_vehiculo where tv_nombre = tipo),(SELECT s_id From sede where  s_numerosede  = sedes)) returning v_foto INTO temp;
   fle:= BFILENAME ('OBJETOS_LOB', V_Nombre_foto);
   DBMS_LOB.fileopen (fle, DBMS_LOB.file_readonly);
   DBMS_LOB.loadfromfile (temp,fle,DBMS_LOB.getlength (fle));
   DBMS_LOB.fileclose (fle);
    COMMIT;
  END I_Vehiculo;
  END PK_Vehiculo;
  /
CREATE OR REPLACE PACKAGE PK_Cliente AS
TYPE RESULT_SET IS REF CURSOR;
 
PROCEDURE BUSCAR_Cliente(o_result_set OUT RESULT_SET,  fecha_I varchar2, fecha_F varchar2);
PROCEDURE I_Cliente(V_Nombre_foto varchar2,p_nombre Varchar2,s_nombre Varchar2, p_apellido varchar2, s_apellido varchar2, ci varchar2,correo varchar2,nac date,sexo varchar2,latitud varchar2, longitud varchar2, direccion varchar2, tipo varchar2, lugar varchar2);
END PK_Cliente;
/

CREATE OR REPLACE PACKAGE BODY PK_Cliente IS
 
PROCEDURE BUSCAR_Cliente( o_result_set OUT RESULT_SET, fecha_I varchar2, fecha_F varchar2) 
  AS fecha_max date;
  fecha_min date;
  BEGIN

  
  select max(fecha_registro) into fecha_max from cliente ;
  select min(fecha_registro) into fecha_min from cliente ;
  
  if ((fecha_I is null) and (fecha_F is null))then 
    OPEN o_result_set FOR SELECT  c.c_id,
    c.c_informacion_personal.IP_cedula cedula,
    CONCAT( c.c_informacion_personal.IP_Primer_Nombre ,c.c_informacion_personal.IP_Segundo_Nombre) full_name,
    CONCAT(  c.c_informacion_personal.IP_Primer_Apeliido , c.c_informacion_personal.IP_Segundo_Apellido)full_ape,
    c.c_informacion_personal.IP_Correo correo,
    c.c_informacion_personal.IP_Fecha_Nacimiento fnac,
   CASE c.c_informacion_personal.IP_Sexo WHEN 'M' THEN 'Masculino' When 'F' THEN 'Femenino'  END AS sexo,
    c.ubicacion_mapa.UG_Latitud lat,
    c.ubicacion_mapa.UG_Longitud lon,
    CASE c. tipo_cliente_tc_id WHEN 1 THEN 'Ocasional' WHEN 2 THEN 'Frecuente' when 3 then 'VIP ' when 4 then 'No deseado' END AS Tipo_cliente ,
    c.c_foto
    FROM  cliente c;
    --where fecha_registro between TO_DATE(fecha_I,'dd/mm/yy')  and TO_DATE(fecha_F,'dd/mm/yy') ;
    else if ((fecha_F is null)) THEN
          OPEN o_result_set FOR SELECT  c.c_id,
            c.c_informacion_personal.IP_cedula cedula,
            CONCAT( c.c_informacion_personal.IP_Primer_Nombre ,c.c_informacion_personal.IP_Segundo_Nombre) full_name,
           
            CONCAT(  c.c_informacion_personal.IP_Primer_Apeliido , c.c_informacion_personal.IP_Segundo_Apellido)full_ape,
          
            c.c_informacion_personal.IP_Correo correo,
            c.c_informacion_personal.IP_Fecha_Nacimiento fnac,
           CASE c.c_informacion_personal.IP_Sexo WHEN 'M' THEN 'Masculino' When 'F' THEN 'Femenino'  END AS sexo,
            c.ubicacion_mapa.UG_Latitud lat,
            c.ubicacion_mapa.UG_Longitud lon,
            CASE c. tipo_cliente_tc_id WHEN 1 THEN 'Ocasional' WHEN 2 THEN 'Frecuente' when 3 then 'VIP ' when 4 then 'No deseado' END AS Tipo_cliente ,
            c.c_foto
            FROM  cliente c
                where fecha_registro >= TO_DATE(fecha_I,'dd/mm/yy') and  fecha_registro<= TO_DATE(fecha_max,'dd/mm/yy') ;
    else if ((fecha_I is null)) THEN
          OPEN o_result_set FOR SELECT  c.c_id,
            c.c_informacion_personal.IP_cedula cedula,
            CONCAT( c.c_informacion_personal.IP_Primer_Nombre ,c.c_informacion_personal.IP_Segundo_Nombre) full_name,
           
            CONCAT(  c.c_informacion_personal.IP_Primer_Apeliido , c.c_informacion_personal.IP_Segundo_Apellido)full_ape,
         
            c.c_informacion_personal.IP_Correo correo,
            c.c_informacion_personal.IP_Fecha_Nacimiento fnac,
           CASE c.c_informacion_personal.IP_Sexo WHEN 'M' THEN 'Masculino' When 'F' THEN 'Femenino'  END AS sexo,
            c.ubicacion_mapa.UG_Latitud lat,
            c.ubicacion_mapa.UG_Longitud lon,
            CASE c. tipo_cliente_tc_id WHEN 1 THEN 'Ocasional' WHEN 2 THEN 'Frecuente' when 3 then 'VIP ' when 4 then 'No deseado' END AS Tipo_cliente ,
            c.c_foto
            FROM  cliente c
                where fecha_registro >= TO_DATE(fecha_min,'dd/mm/yy') and  fecha_registro<= TO_DATE(fecha_f,'dd/mm/yy') ;
    
    else if ((fecha_I is not null)and (fecha_F is not null)) THEN
          OPEN o_result_set FOR SELECT  c.c_id,
            c.c_informacion_personal.IP_cedula cedula,
            CONCAT( c.c_informacion_personal.IP_Primer_Nombre ,c.c_informacion_personal.IP_Segundo_Nombre) full_name,
           
            CONCAT(  c.c_informacion_personal.IP_Primer_Apeliido , c.c_informacion_personal.IP_Segundo_Apellido)full_ape,
        
            c.c_informacion_personal.IP_Correo correo,
            c.c_informacion_personal.IP_Fecha_Nacimiento fnac,
           CASE c.c_informacion_personal.IP_Sexo WHEN 'M' THEN 'Masculino' When 'F' THEN 'Femenino'  END AS sexo,
            c.ubicacion_mapa.UG_Latitud lat,
            c.ubicacion_mapa.UG_Longitud lon,
            CASE c.tipo_cliente_tc_id WHEN 1 THEN 'Ocasional' WHEN 2 THEN 'Frecuente' when 3 then 'VIP ' when 4 then 'No deseado' END AS Tipo_cliente ,
            c.c_foto
            FROM  cliente c
                where fecha_registro >= TO_DATE(fecha_I,'dd/mm/yy') and  fecha_registro<= TO_DATE(fecha_f,'dd/mm/yy') ;
    
    
    end if;
    end IF;
    end if;
    end if;
  END BUSCAR_Cliente;

 PROCEDURE I_Cliente(V_Nombre_foto varchar2,p_nombre Varchar2,s_nombre Varchar2, p_apellido varchar2, s_apellido varchar2, ci varchar2,correo varchar2,nac date,sexo varchar2,latitud varchar2, longitud varchar2, direccion varchar2, tipo varchar2, lugar VARCHAR2)
is 
 temp blob;
fle bfile;
  BEGIN
    INSERT INTO cliente values (DEFAULT, informacion_personal(
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
/
----Creacion del paquete para alquiler----
CREATE OR REPLACE PACKAGE PK_Alquiler AS
TYPE RESULT_SET IS REF CURSOR;
 
PROCEDURE BUSCAR_Vehiculo(o_result_set OUT RESULT_SET,  fecha_I varchar2, fecha_F varchar2);
PROCEDURE BUSCAR_Vehiculo_Mes(o_result_set OUT RESULT_SET);
END PK_Alquiler;
/
---Creacion del body del paquete
CREATE OR REPLACE PACKAGE BODY PK_Alquiler IS
----Precedimiento para el reporte 1----
Procedure Buscar_Vehiculo( O_Result_Set Out Result_Set, Fecha_I Varchar2, Fecha_F Varchar2) 
  As fecha_min date;
    fecha_max date;
  Begin
  select max(a.a_periodo_duracion.P_Fecha_Inicio ) into fecha_max from alquiler a ;
  select min(a.a_periodo_duracion.P_Fecha_Inicio ) into fecha_min from alquiler a ;
  
 
         if ((Fecha_I is null) and (Fecha_F is null) or ((Fecha_I ='')and (Fecha_F= ''))) then
    Open O_Result_Set For Select V_Foto,Anno,Modelo,Marca,Tipo,Cant
                        From (Select Count(*) As Cant, V.V_Anno As Anno,M.M_Nombre As Modelo,N.Ma_Nombre As Marca,T.Tv_Nombre As Tipo,V.V_Placa As Placa
                              From  Marca N , Modelo M,Tipo_Vehiculo T , Detalle_Alquiler D, Alquiler A , Vehiculo V
                              Where V.Modelo_M_Id=M.M_Id 
                              And V.Tipo_Vehiculo_Tv_Id=T.Tv_Id 
                              And N.Ma_Id=M.Marca_Ma_Id
                              And V.V_Placa=d.vehiculo_v_placa
                              And A.Detalle_Alquiler_Da_Id=D.Da_Id
                             -- And D.Da_Fecha Between To_Date(Fecha_I,'dd/mm/yy')And To_Date(Fecha_F,'dd/mm/yy')
                              Group By  V.V_Anno,M.M_Nombre,N.Ma_Nombre,T.Tv_Nombre,V.V_Placa
                              Order By 1 Desc) ,vehiculo
                        Where Placa=V_Placa
                        Order By Cant Desc;  
 
  else if ((Fecha_I is null)) then
    Open O_Result_Set For Select V_Foto,Anno,Modelo,Marca,Tipo,Cant
                        From (Select Count(*) As Cant, V.V_Anno As Anno,M.M_Nombre As Modelo,N.Ma_Nombre As Marca,T.Tv_Nombre As Tipo,V.V_Placa As Placa
                              From  Marca N , Modelo M,Tipo_Vehiculo T , Detalle_Alquiler D, Alquiler A , Vehiculo V
                              Where V.Modelo_M_Id=M.M_Id 
                              And V.Tipo_Vehiculo_Tv_Id=T.Tv_Id 
                              And N.Ma_Id=M.Marca_Ma_Id
                              And V.V_Placa=D.vehiculo_v_placa
                              And A.Detalle_Alquiler_Da_Id=D.Da_Id
                             And a.a_periodo_duracion.P_Fecha_Inicio  Between To_Date(fecha_min,'dd/mm/yy')And To_Date(Fecha_F,'dd/mm/yy')
                              Group By  V.V_Anno,M.M_Nombre,N.Ma_Nombre,T.Tv_Nombre,V.V_Placa
                              Order By 1 Desc) ,vehiculo
                        Where Placa=V_Placa
                        Order By Cant Desc;
      else if ((Fecha_F is null)) then
    Open O_Result_Set For Select V_Foto,Anno,Modelo,Marca,Tipo,Cant
                        From (Select Count(*) As Cant, V.V_Anno As Anno,M.M_Nombre As Modelo,N.Ma_Nombre As Marca,T.Tv_Nombre As Tipo,V.V_Placa As Placa
                              From  Marca N , Modelo M,Tipo_Vehiculo T , Detalle_Alquiler D, Alquiler A , Vehiculo V
                              Where V.Modelo_M_Id=M.M_Id 
                              And V.Tipo_Vehiculo_Tv_Id=T.Tv_Id 
                              And N.Ma_Id=M.Marca_Ma_Id
                              And V.V_Placa=D.vehiculo_v_placa
                              And A.Detalle_Alquiler_Da_Id=D.Da_Id
                              And a.a_periodo_duracion.P_Fecha_Inicio  Between To_Date(Fecha_I,'dd/mm/yy')And To_Date(fecha_max,'dd/mm/yy')
                              Group By  V.V_Anno,M.M_Nombre,N.Ma_Nombre,T.Tv_Nombre,V.V_Placa
                              Order By 1 Desc) ,vehiculo
                        Where Placa=V_Placa
                        Order By Cant Desc; 
  
      
     else  if ((Fecha_I is not null) and (Fecha_F is not null)) then
    Open O_Result_Set For Select V_Foto,Anno,Modelo,Marca,Tipo,Cant
                        From (Select Count(*) As Cant, V.V_Anno As Anno,M.M_Nombre As Modelo,N.Ma_Nombre As Marca,T.Tv_Nombre As Tipo,V.V_Placa As Placa
                              From  Marca N , Modelo M,Tipo_Vehiculo T , Detalle_Alquiler D, Alquiler A , Vehiculo V
                              Where V.Modelo_M_Id=M.M_Id 
                              And V.Tipo_Vehiculo_Tv_Id=T.Tv_Id 
                              And N.Ma_Id=M.Marca_Ma_Id
                              And V.V_Placa=D.vehiculo_v_placa
                              And A.Detalle_Alquiler_Da_Id=D.Da_Id
                              And a.a_periodo_duracion.P_Fecha_Inicio  Between To_Date(Fecha_I,'dd/mm/yy')And To_Date(Fecha_F,'dd/mm/yy')
                              Group By  V.V_Anno,M.M_Nombre,N.Ma_Nombre,T.Tv_Nombre,V.V_Placa
                              Order By 1 Desc) ,vehiculo 
                        Where Placa=V_Placa
                        Order By Cant Desc; 
      
      end if;                  
      end if ;
     end if ;  
      end if ;  
  End Buscar_Vehiculo;
  ----Precedimiento para el reporte 3----
  Procedure Buscar_Vehiculo_Mes( O_Result_Set Out Result_Set) 
  As
  Begin
    Open O_Result_Set For Select V_Foto,Anno,Modelo,Marca,Tipo,Case  MO When 1 Then 'Enero' When 2 Then 'Febrero'When 3 Then 'Marzo' When 4 Then 'Abril' When 5 Then 'Mayo' When 6 Then 'Junio' When 7 Then 'Julio'When 8 Then 'Agosto' When 9 Then 'Septiembre' When 10 Then 'Octubre' When 11 Then 'Noviembre' When 12 Then 'Diciembre'End,An, Cant
                          From (Select Count(V_Placa)As Cant,Extract(Month From a.a_periodo_duracion.P_Fecha_Inicio  ) As Mo
                          ,Extract(Year From a.a_periodo_duracion.P_Fecha_Inicio  ) As An, V_Placa As Placa ,V.V_Anno As Anno,M.M_Nombre As Modelo,N.Ma_Nombre As Marca,T.Tv_Nombre As Tipo
                                  From  Marca N , Modelo M,Tipo_Vehiculo T , Detalle_Alquiler D, alquiler A , Vehiculo V
                                  Where V.Modelo_M_Id=M.M_Id 
                                  And V.Tipo_Vehiculo_Tv_Id=T.Tv_Id 
                                  And N.Ma_Id=M.Marca_Ma_Id
                                  And V.V_Placa=D.vehiculo_v_placa
                                  And A.Detalle_Alquiler_Da_Id=D.Da_Id
                             -- and d.DA_fecha between TO_DATE(fecha_I,'dd/mm/yy')and TO_DATE(fecha_F,'dd/mm/yy')
                              Group By Extract(Month From a.a_periodo_duracion.P_Fecha_Inicio ), Extract(Year From a.a_periodo_duracion.P_Fecha_Inicio  ),V_Placa,V.V_Anno,M.M_Nombre,N.Ma_Nombre,T.Tv_Nombre
                              Order By 2 asc,3 desc,1 desc
                              ) ,Vehiculo 
                        Where Placa=V_Placa;
                        --Order By 6 desc  ;
  End Buscar_Vehiculo_Mes;
  End Pk_Alquiler;
 /
----  paquete pk_promocion-----
CREATE OR REPLACE PACKAGE PK_Promocion AS
TYPE RESULT_SET IS REF CURSOR;
 
PROCEDURE BUSCAR_Promocion(o_result_set OUT RESULT_SET,  fecha_I varchar2, fecha_F varchar2);
END PK_Promocion;
/
----create body package------
CREATE OR REPLACE PACKAGE BODY PK_Promocion IS
PROCEDURE BUSCAR_Promocion( o_result_set OUT RESULT_SET, fecha_I varchar2, fecha_F varchar2) 
  AS fecha_max date;
     fecha_min date;
  BEGIN
   select max(h.hp_periodo_duracion.P_Fecha_Inicio ) into fecha_max from historico_promocion h;
  select min(h.hp_periodo_duracion.P_Fecha_Inicio ) into fecha_min  from historico_promocion h ;
  
 
         if ((fecha_I is null) and (fecha_F is null) or ((Fecha_I ='')and (Fecha_F= ''))) then
    OPEN o_result_set FOR SELECT p.p_descripcion,v.v_precio, v.v_precio-(v.v_precio- p.p_porcentaje_descuento),m.m_nombre,n.ma_nombre, v.v_foto,v_anno
                          from  marca n , modelo m,historico_promocion  h, Promocion p , vehiculo v
                          where v.modelo_M_ID=m.m_id  
                          and n.ma_id=m.marca_ma_id
                          and p.p_id =h.promocion_p_id 
                          and h.vehiculo_v_placa=v.v_placa;
                         -- and h. hp_fecha_i between TO_DATE(fecha_I,'dd/mm/yy')and TO_DATE(fecha_F,'dd/mm/yy'); 
                          
         else if ((fecha_I is null)) then
    OPEN o_result_set FOR SELECT p.p_descripcion,v.v_precio, v.v_precio-(v.v_precio- p.p_porcentaje_descuento),m.m_nombre,n.ma_nombre, v.v_foto,v_anno
                          from  marca n , modelo m,historico_promocion  h, Promocion p , vehiculo v
                          where v.modelo_M_ID=m.m_id  
                          and n.ma_id=m.marca_ma_id
                          and p.p_id =h.promocion_p_id 
                          and h.vehiculo_v_placa=v.v_placa
                          and h.hp_periodo_duracion.P_Fecha_Inicio  between TO_DATE(fecha_min,'dd/mm/yy')and TO_DATE(fecha_F,'dd/mm/yy'); 
                          
         else if ((fecha_F is null)) then
    OPEN o_result_set FOR SELECT p.p_descripcion,v.v_precio, v.v_precio-(v.v_precio- p.p_porcentaje_descuento),m.m_nombre,n.ma_nombre, v.v_foto,v_anno
                          from  marca n , modelo m,historico_promocion  h, Promocion p , vehiculo v
                          where v.modelo_M_ID=m.m_id  
                          and n.ma_id=m.marca_ma_id
                          and p.p_id =h.promocion_p_id 
                          and h.vehiculo_v_placa=v.v_placa
                          and h.hp_periodo_duracion.P_Fecha_Inicio between TO_DATE(fecha_I,'dd/mm/yy')and TO_DATE(fecha_max,'dd/mm/yy');      
                          
         else if ((fecha_F is not null) and (fecha_I is not null)) then
    OPEN o_result_set FOR SELECT p.p_descripcion,v.v_precio, v.v_precio-(v.v_precio- p.p_porcentaje_descuento),m.m_nombre,n.ma_nombre, v.v_foto,v_anno
                          from  marca n , modelo m,historico_promocion  h, Promocion p , vehiculo v
                          where v.modelo_M_ID=m.m_id  
                          and n.ma_id=m.marca_ma_id
                          and p.p_id =h.promocion_p_id 
                          and h.vehiculo_v_placa=v.v_placa
                          and h.hp_periodo_duracion.P_Fecha_Inicio between TO_DATE(fecha_I,'dd/mm/yy')and TO_DATE(fecha_F,'dd/mm/yy');  
         end if;
         end if;
         end if;
         end if;
                          
                          
  END BUSCAR_Promocion;
  END PK_Promocion;
/
CREATE OR REPLACE PACKAGE PK_Alianza AS
TYPE RESULT_SET IS REF CURSOR;
 
PROCEDURE BUSCAR_Alianza(o_result_set OUT RESULT_SET, fecha_I varchar2, fecha_F varchar2);
PROCEDURE I_Aliado(V_Nombre_foto varchar2,nombre Varchar2);
END PK_Alianza;
/

CREATE OR REPLACE PACKAGE BODY  PK_Alianza IS
PROCEDURE BUSCAR_alianza( o_result_set OUT RESULT_SET,fecha_I varchar2, fecha_F varchar2) 
  AS
  BEGIN
    OPEN o_result_set FOR SELECT aa_fechaI,aa_fechaF,aa_FechaFirma,aa_descripcion,ao_nombre,ao_logo
                          from  alianza, aliado
                          where aliado_ao_id=ao_id
                          and AA_fechai between TO_DATE(fecha_I,'dd/mm/yy')and TO_DATE(fecha_F,'dd/mm/yy'); 
                                                                  
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
/
 
CREATE OR REPLACE PACKAGE PK_Mantenimiento AS
TYPE RESULT_SET IS REF CURSOR;
 
PROCEDURE BUSCAR_Mantenimiento(o_result_set OUT RESULT_SET,fecha_I varchar2, fecha_F varchar2);
END PK_Mantenimiento; 
 /

CREATE OR REPLACE PACKAGE BODY PK_Mantenimiento IS
PROCEDURE BUSCAR_Mantenimiento( o_result_set OUT RESULT_SET,fecha_I varchar2, fecha_F varchar2) 
  AS fecha_max date;
     fecha_min date;
  BEGIN
   select max( mv.man_periodo_duracion.P_Fecha_Inicio) into fecha_max from mantenimiento_vehiculo mv;
  select min( mv.man_periodo_duracion.P_Fecha_Inicio) into fecha_min from mantenimiento_vehiculo mv;
  
 
         if ((fecha_I is null) and (fecha_F is null) ) then
    OPEN o_result_set FOR SELECT v.v_placa,v.v_anno ,v.v_foto,m.m_nombre,n.ma_nombre ,ma.m_descripcion,t.tm_nombre,s.s_nombre,ta.t_ubicacion_geografica.UG_Latitud,ta.t_ubicacion_geografica.UG_Longitud,mv.man_fecha_proximo_man,mv.man_periodo_duracion.P_Fecha_Inicio,ta.T_nombre
                          FROM vehiculo v, marca n , modelo m, mantenimiento ma,taller ta,mantenimiento_vehiculo mv, mantenimiento_taller mt, status_mantenimiento s, tipo_mantenimiento t
                          WHERE v.v_placa=mv.vehiculo_v_placa
                          and n.ma_id=m.marca_ma_id
                          and v.modelo_M_ID=m.m_id 
                          and s.s_id= mv.status_mantenimiento_s_id
                          and ma.tipo_mantenimiento_TM_ID= t.tm_id
                          and mv.mantenimiento_m_id=ma.m_id
                          and mt.mantenimiento_m_id=ma.m_id
                          and mt.taller_t_id=ta.t_id;
                        
         else  if ((fecha_I is null)) then
    OPEN o_result_set FOR SELECT v.v_placa,v.v_anno ,v.v_foto,m.m_nombre,n.ma_nombre ,ma.m_descripcion,t.tm_nombre,s.s_nombre,ta.t_ubicacion_geografica.UG_Latitud,ta.t_ubicacion_geografica.UG_Longitud,mv.man_fecha_proximo_man,mv.man_periodo_duracion.P_Fecha_Inicio,ta.T_nombre
                          FROM vehiculo v, marca n , modelo m, mantenimiento ma,taller ta,mantenimiento_vehiculo mv, mantenimiento_taller mt, status_mantenimiento s, tipo_mantenimiento t
                          WHERE v.v_placa=mv.vehiculo_v_placa
                          and n.ma_id=m.marca_ma_id
                          and v.modelo_M_ID=m.m_id 
                          and s.s_id= mv.status_mantenimiento_s_id
                          and ma.tipo_mantenimiento_TM_ID= t.tm_id
                          and mv.mantenimiento_m_id=ma.m_id
                          and mt.mantenimiento_m_id=ma.m_id
                          and mt.taller_t_id=ta.t_id
                         and mv.man_periodo_duracion.P_Fecha_Inicio between TO_DATE(fecha_min,'dd/mm/yy')and TO_DATE(fecha_F,'dd/mm/yy');        
                         
             else     if ((fecha_F is null)) then
    OPEN o_result_set FOR SELECT v.v_placa,v.v_anno ,v.v_foto,m.m_nombre,n.ma_nombre ,ma.m_descripcion,t.tm_nombre,s.s_nombre,ta.t_ubicacion_geografica.UG_Latitud,ta.t_ubicacion_geografica.UG_Longitud,mv.man_fecha_proximo_man,mv.man_periodo_duracion.P_Fecha_Inicio,ta.T_nombre
                          FROM vehiculo v, marca n , modelo m, mantenimiento ma,taller ta,mantenimiento_vehiculo mv, mantenimiento_taller mt, status_mantenimiento s, tipo_mantenimiento t
                          WHERE v.v_placa=mv.vehiculo_v_placa
                          and n.ma_id=m.marca_ma_id
                          and v.modelo_M_ID=m.m_id 
                          and s.s_id= mv.status_mantenimiento_s_id
                          and ma.tipo_mantenimiento_TM_ID= t.tm_id
                          and mv.mantenimiento_m_id=ma.m_id
                          and mt.mantenimiento_m_id=ma.m_id
                          and mt.taller_t_id=ta.t_id
                         and mv.man_periodo_duracion.P_Fecha_Inicio between TO_DATE(fecha_I,'dd/mm/yy')and TO_DATE(fecha_max,'dd/mm/yy');          
          
            else if ((fecha_I is not null) and (fecha_F is  not null) ) then
    OPEN o_result_set FOR SELECT v.v_placa,v.v_anno ,v.v_foto,m.m_nombre,n.ma_nombre ,ma.m_descripcion,t.tm_nombre,s.s_nombre,ta.t_ubicacion_geografica.UG_Latitud,ta.t_ubicacion_geografica.UG_Longitud,mv.man_fecha_proximo_man,mv.man_periodo_duracion.P_Fecha_Inicio,ta.T_nombre
                          FROM vehiculo v, marca n , modelo m, mantenimiento ma,taller ta,mantenimiento_vehiculo mv, mantenimiento_taller mt, status_mantenimiento s, tipo_mantenimiento t
                          WHERE v.v_placa=mv.vehiculo_v_placa
                          and n.ma_id=m.marca_ma_id
                          and v.modelo_M_ID=m.m_id 
                          and s.s_id= mv.status_mantenimiento_s_id
                          and ma.tipo_mantenimiento_TM_ID= t.tm_id
                          and mv.mantenimiento_m_id=ma.m_id
                          and mt.mantenimiento_m_id=ma.m_id
                          and mt.taller_t_id=ta.t_id
                         and mv.man_periodo_duracion.P_Fecha_Inicio between TO_DATE(fecha_I,'dd/mm/yy')and TO_DATE(fecha_F,'dd/mm/yy');     
                         
           end if;
           end if;
           end if;
           end if ;
                         
  END BUSCAR_Mantenimiento;
  END PK_Mantenimiento;
 /
----Busca la cantidad de alquileres que ha realizado un cliente anualmente--- 
create or replace function buscar_numero(id number ,fechaI date, fechaF date ) return number
IS cant number;
   ci number;
    begin
        Select count(*) into cant from alquiler where cliente_C_id=id and A_fecha_inicio between fechaI and fechaF group by cliente_c_id ; 
        return cant ;
end;
 /
 
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
/ 

 
  ----insert de prueba----
insert into Promocion values (DEFAULT,0.50,'50% en descuento en el alquiler por d�a para vehiculos Toyota Fortuner 2022');
insert into Promocion values (DEFAULT,0.50,'50% en descuento en el alquiler por d�a para vehiculos Toyota Corolla 2023');
insert into Promocion values (DEFAULT,0.50,'50% en descuento en el alquiler por d�a para vehiculos Honda Civic 2014');
insert into Promocion values (DEFAULT,0.50,'50% en descuento en el alquiler por d�a para vehiculos Ford Explorer 2015');
--Historico Promocion---
insert into historico_promocion values (default,periodo_duracion(periodo_duracion.verificar_fecha_inicio('21/06/23','22/06/23'),periodo_duracion.verificar_fecha_fin('21/06/23','21/06/23')),1,'AB445D4');
insert into historico_promocion values (default,periodo_duracion(periodo_duracion.verificar_fecha_inicio('21/06/23','22/06/23'),periodo_duracion.verificar_fecha_fin('21/06/23','21/06/23')),2,'DF48S5');
insert into historico_promocion values (default,periodo_duracion(periodo_duracion.verificar_fecha_inicio('21/06/23','22/06/23'),periodo_duracion.verificar_fecha_fin('21/06/23','21/06/23')),3,'AA28E6');
insert into historico_promocion values (default,periodo_duracion(periodo_duracion.verificar_fecha_inicio('21/06/23','22/06/23'),periodo_duracion.verificar_fecha_fin('21/06/23','21/06/23')),4,'AA7821');

---Vehiculo--
execute PK_Vehiculo.I_Vehiculo('civic.PNG',2,'AA28E7',50,1,'civic','Disponible','AZUL','Carro',1);
execute PK_Vehiculo.I_Vehiculo('fortuner.PNG',2022,'AB45D4',50,1,'fortuner','Disponible','PLATEADO','Camioneta',1);
execute PK_Vehiculo.I_Vehiculo('toyo.PNG',2023,'DF48S5',50,1,'corolla','Disponible','BLANCO','Carro',1);
execute PK_Vehiculo.I_Vehiculo('explorer.PNG',2015,'AA74l4',50,1,'explorer','Disponible','ROJO','Camioneta',1);
execute PK_Vehiculo.I_Vehiculo('explorer.PNG',2014,'AA5821',50,1,'explorer','Disponible','ROJO','Camioneta',1);
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
insert into alianza values (DEFAULT,'25/05/23','25/06/23','02/05/23','Todos los veh�culos de la compa��a de alquiler cuentan con una suscripci�n de �PANA�','Servicio',(select ao_id from aliado where ao_nombre='pana Tech'),(SELECT S_id from sede where S_NUMEROSEDE=1));
insert into alianza values (DEFAULT,'25/05/23','25/06/23','02/06/23','Todos los veh�culos de la compa��a de alquiler cuentan con una suscripci�n de �TU GRUERO�','Servicio',(select ao_id from aliado where ao_nombre='Tu gruero'),(SELECT S_id from sede where S_NUMEROSEDE=1));

----taller---
 insert into taller values(DEFAULT,'TALLER NINO JR','2124567427',ubicacion_geografica(
    ubicacion_geografica.verificar_latitud(10.49708),
    ubicacion_geografica.verificar_longitud(-66.91310),
    ubicacion_geografica.verificar_timestamp(TO_TIMESTAMP('2003/12/13 10:13:18', 'YYYY/MM/DD HH:MI:SS'))),5,27);

---mantenimientos--
 insert into mantenimiento values(Default,'cambio de aceite',(select TM_ID from tipo_mantenimiento where tm_nombre='Preventido') );
  insert  into mantenimiento_taller values (default,4,1);
  insert into mantenimiento_vehiculo values(default,periodo_duracion(periodo_duracion.verificar_fecha_inicio('21/06/23','22/06/23'),periodo_duracion.verificar_fecha_fin('21/06/23','21/06/23')),'22/07/23',30,'DF48S5',1,4);
