CREATE OR REPLACE DIRECTORY OBJETOS_LOB AS 'C:\IMAGENES\';

CREATE OR REPLACE PROCEDURE I_Vehiculo(V_Nombre_foto varchar2,v_anno number,v_placa Varchar2,v_km number,v_precio number, modelos varchar2,status varchar2, colorv varchar2,tipo varchar2,sedes number)
is 
 temp blob;
   fle bfile;
   
  BEGIN
    INSERT INTO Vehiculo values (v_anno,v_placa,EMPTY_BLOB(),v_km,v_precio,(SELECT m_id From modelo where m_nombre = modelos), (SELECT sv_id From status_vehiculo where sv_nombre = status),(SELECT c_id From color where c_nombre = colorv) ,(SELECT tv_id From tipo_vehiculo where tv_nombre = tipo),(SELECT s_id From sede where  s_numerosede  = sedes)) returning v_foto INTO temp;
   fle:= BFILENAME ('Objetos_lob', V_Nombre_foto);
   DBMS_LOB.fileopen (fle, DBMS_LOB.file_readonly);
   DBMS_LOB.loadfromfile (temp,fle,DBMS_LOB.getlength (fle));
   DBMS_LOB.fileclose (fle);
  
  END;
  
  CREATE OR REPLACE PROCEDURE I_Aliado(V_Nombre_foto varchar2,nombre Varchar2)
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
  END;
  
  execute I_Aliado('descarga.PNG' ,'pana Tech');

