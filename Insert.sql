--Insert Color----
Insert Into Color Values (Default,'Azul');
Insert Into Color Values (Default,'Rojo');
Insert Into Color Values (Default,'Amarillo');
Insert Into Color Values (Default,'Plateado');
Insert Into Color Values (Default,'Naranja');
Insert Into Color Values (Default,'Negro');
Insert Into Color Values (Default,'Blanco');
Insert Into Color Values (Default,'Marron');
Insert Into Color Values (Default,'Gris');
Insert Into Color Values (Default,'Rosado');
Insert Into Color Values (Default,'Verde');
Insert Into Color Values (Default,'Morado');
Insert Into Color Values (Default,'Dorado');
Insert Into Color Values (Default,'Vinotinto');
Insert Into Color Values (Default,'Salmon');

--Insert Marca---
INSERT INTO MARCA VALUES (default,'Honda');
INSERT INTO MARCA VALUES (default,'Toyota');
INSERT INTO MARCA VALUES (default,'Ford');
INSERT INTO MARCA VALUES (default,'Chevrolet');
INSERT INTO MARCA VALUES (default,'Suzuki');
INSERT INTO MARCA VALUES (default,'Nissan');
INSERT INTO MARCA VALUES (default,'Jeep');
INSERT INTO MARCA VALUES (default,'Fiat');
INSERT INTO MARCA VALUES (default,'Peugeot');
INSERT INTO MARCA VALUES (default,'Mitsubishi');
INSERT INTO MARCA VALUES (default,'Kia');
INSERT INTO MARCA VALUES (default,'Renault');
INSERT INTO MARCA VALUES (default,'Bmw');
INSERT INTO MARCA VALUES (default,'Volkswagen');
INSERT INTO MARCA VALUES (default,'Hyundai');
INSERT INTO MARCA VALUES (default,'Mercedes');
INSERT INTO MARCA VALUES (default,'Subaru');
INSERT INTO MARCA VALUES (default,'Skoda');
INSERT INTO MARCA VALUES (default,'Alfa Romeo');
INSERT INTO MARCA VALUES (default,'Volvo');



---Insert Modelo---
INSERT INTO MODELO VALUES (DEFAULT,'Fortuner',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'Corolla',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'4runner',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'Yaris',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'Camry',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'Hilux',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'Rav4',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'Tundra',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));


INSERT INTO MODELO VALUES (DEFAULT,'Civic',(SELECT ma_id FROM marca Where ma_nombre='Honda'));
INSERT INTO MODELO VALUES (DEFAULT,'Fit',(SELECT ma_id FROM marca Where ma_nombre='Honda'));
INSERT INTO MODELO VALUES (DEFAULT,'Accord',(SELECT ma_id FROM marca Where ma_nombre='Honda'));
INSERT INTO MODELO VALUES (DEFAULT,'Cr-v',(SELECT ma_id FROM marca Where ma_nombre='Honda'));

INSERT INTO MODELO VALUES (DEFAULT,'Escape',(SELECT ma_id FROM marca Where ma_nombre='Ford'));
INSERT INTO MODELO VALUES (DEFAULT,'Fusion',(SELECT ma_id FROM marca Where ma_nombre='Ford'));
INSERT INTO MODELO VALUES (DEFAULT,'Explorer',(SELECT ma_id FROM marca Where ma_nombre='Ford'));
INSERT INTO MODELO VALUES (DEFAULT,'Fiesta',(SELECT ma_id FROM marca Where ma_nombre='Ford'));
INSERT INTO MODELO VALUES (DEFAULT,'Ecosport',(SELECT ma_id FROM marca Where ma_nombre='Ford'));
INSERT INTO MODELO VALUES (DEFAULT,'F-150',(SELECT ma_id FROM marca Where ma_nombre='Ford'));

INSERT INTO MODELO VALUES (DEFAULT,'Aveo',(SELECT ma_id FROM marca Where ma_nombre='Chevrolet'));
INSERT INTO MODELO VALUES (DEFAULT,'Optra',(SELECT ma_id FROM marca Where ma_nombre='Chevrolet'));
INSERT INTO MODELO VALUES (DEFAULT,'Tahoe',(SELECT ma_id FROM marca Where ma_nombre='Chevrolet'));
INSERT INTO MODELO VALUES (DEFAULT,'Cruze',(SELECT ma_id FROM marca Where ma_nombre='Chevrolet'));
INSERT INTO MODELO VALUES (DEFAULT,'Spark',(SELECT ma_id FROM marca Where ma_nombre='Chevrolet'));
INSERT INTO MODELO VALUES (DEFAULT,'Orlando',(SELECT ma_id FROM marca Where ma_nombre='Chevrolet'));

INSERT INTO MODELO VALUES (DEFAULT,'Cherokee',(SELECT ma_id FROM marca Where ma_nombre='Jeep'));
INSERT INTO MODELO VALUES (DEFAULT,'Grand-cherokee',(SELECT ma_id FROM marca Where ma_nombre='Jeep'));
INSERT INTO MODELO VALUES (DEFAULT,'Wrangler',(SELECT ma_id FROM marca Where ma_nombre='Jeep'));
INSERT INTO MODELO VALUES (DEFAULT,'Compass',(SELECT ma_id FROM marca Where ma_nombre='Jeep'));
INSERT INTO MODELO VALUES (DEFAULT,'Gladiator',(SELECT ma_id FROM marca Where ma_nombre='Jeep'));

INSERT INTO MODELO VALUES (DEFAULT,'Elantra',(SELECT ma_id FROM marca Where ma_nombre='Hyundai'));
INSERT INTO MODELO VALUES (DEFAULT,'Accent',(SELECT ma_id FROM marca Where ma_nombre='Hyundai'));
INSERT INTO MODELO VALUES (DEFAULT,'Excel',(SELECT ma_id FROM marca Where ma_nombre='Hyundai'));
INSERT INTO MODELO VALUES (DEFAULT,'SantaFe',(SELECT ma_id FROM marca Where ma_nombre='Hyundai'));
INSERT INTO MODELO VALUES (DEFAULT,'Tucson',(SELECT ma_id FROM marca Where ma_nombre='Hyundai'));
INSERT INTO MODELO VALUES (DEFAULT,'Sonata',(SELECT ma_id FROM marca Where ma_nombre='Hyundai'));

INSERT INTO MODELO VALUES (DEFAULT,'Lancer',(SELECT ma_id FROM marca Where ma_nombre='Mitsubishi'));
INSERT INTO MODELO VALUES (DEFAULT,'Signo',(SELECT ma_id FROM marca Where ma_nombre='Mitsubishi'));
INSERT INTO MODELO VALUES (DEFAULT,'Evolution',(SELECT ma_id FROM marca Where ma_nombre='Mitsubishi'));
INSERT INTO MODELO VALUES (DEFAULT,'Montero-sport',(SELECT ma_id FROM marca Where ma_nombre='Mitsubishi'));
INSERT INTO MODELO VALUES (DEFAULT,'Mf',(SELECT ma_id FROM marca Where ma_nombre='Mitsubishi'));
INSERT INTO MODELO VALUES (DEFAULT,'Pajero',(SELECT ma_id FROM marca Where ma_nombre='Mitsubishi'));

INSERT INTO MODELO VALUES (DEFAULT,'Symbol',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'Twingo',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'Evolution',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'Logan',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'Megane',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'Duster',(SELECT ma_id FROM marca Where ma_nombre='Renault'));

INSERT INTO MODELO VALUES (DEFAULT,'Swift',(SELECT ma_id FROM marca Where ma_nombre='Suzuki'));
INSERT INTO MODELO VALUES (DEFAULT,'Alto',(SELECT ma_id FROM marca Where ma_nombre='Suzuki'));
INSERT INTO MODELO VALUES (DEFAULT,'Vitara',(SELECT ma_id FROM marca Where ma_nombre='Suzuki'));
INSERT INTO MODELO VALUES (DEFAULT,'Cultus',(SELECT ma_id FROM marca Where ma_nombre='Suzuki'));
INSERT INTO MODELO VALUES (DEFAULT,'Sx4',(SELECT ma_id FROM marca Where ma_nombre='Suzuki'));

INSERT INTO MODELO VALUES (DEFAULT,'Altima',(SELECT ma_id FROM marca Where ma_nombre='Nissan'));
INSERT INTO MODELO VALUES (DEFAULT,'Sentra',(SELECT ma_id FROM marca Where ma_nombre='Nissan'));
INSERT INTO MODELO VALUES (DEFAULT,'Murano',(SELECT ma_id FROM marca Where ma_nombre='Nissan'));
INSERT INTO MODELO VALUES (DEFAULT,'Rogue',(SELECT ma_id FROM marca Where ma_nombre='Nissan'));
INSERT INTO MODELO VALUES (DEFAULT,'Versa',(SELECT ma_id FROM marca Where ma_nombre='Nissan'));

INSERT INTO MODELO VALUES (DEFAULT,'M',(SELECT ma_id FROM marca Where ma_nombre='Bmw'));
INSERT INTO MODELO VALUES (DEFAULT,'M2',(SELECT ma_id FROM marca Where ma_nombre='Bmw'));
INSERT INTO MODELO VALUES (DEFAULT,'M3',(SELECT ma_id FROM marca Where ma_nombre='Bmw'));
INSERT INTO MODELO VALUES (DEFAULT,'M4',(SELECT ma_id FROM marca Where ma_nombre='Bmw'));
INSERT INTO MODELO VALUES (DEFAULT,'M5',(SELECT ma_id FROM marca Where ma_nombre='Bmw'));

INSERT INTO MODELO VALUES (DEFAULT,'AMG',(SELECT ma_id FROM marca Where ma_nombre='Mercedes'));
INSERT INTO MODELO VALUES (DEFAULT,'GLC',(SELECT ma_id FROM marca Where ma_nombre='Mercedes'));
INSERT INTO MODELO VALUES (DEFAULT,'W201',(SELECT ma_id FROM marca Where ma_nombre='Mercedes'));
INSERT INTO MODELO VALUES (DEFAULT,'AMG GT',(SELECT ma_id FROM marca Where ma_nombre='Mercedes'));
INSERT INTO MODELO VALUES (DEFAULT,'CLK GTR',(SELECT ma_id FROM marca Where ma_nombre='Mercedes'));

INSERT INTO MODELO VALUES (DEFAULT,'Outback',(SELECT ma_id FROM marca Where ma_nombre='Subaru'));
INSERT INTO MODELO VALUES (DEFAULT,'Impreza',(SELECT ma_id FROM marca Where ma_nombre='Subaru'));
INSERT INTO MODELO VALUES (DEFAULT,'Wrx',(SELECT ma_id FROM marca Where ma_nombre='Subaru'));
INSERT INTO MODELO VALUES (DEFAULT,'Legacy',(SELECT ma_id FROM marca Where ma_nombre='Subaru'));
INSERT INTO MODELO VALUES (DEFAULT,'Brz',(SELECT ma_id FROM marca Where ma_nombre='Subaru'));

INSERT INTO MODELO VALUES (DEFAULT,'Octavia',(SELECT ma_id FROM marca Where ma_nombre='Skoda'));
INSERT INTO MODELO VALUES (DEFAULT,'Scala',(SELECT ma_id FROM marca Where ma_nombre='Skoda'));
INSERT INTO MODELO VALUES (DEFAULT,'Kodiaq',(SELECT ma_id FROM marca Where ma_nombre='Skoda'));
INSERT INTO MODELO VALUES (DEFAULT,'Fabia',(SELECT ma_id FROM marca Where ma_nombre='Skoda'));
INSERT INTO MODELO VALUES (DEFAULT,'Karoq',(SELECT ma_id FROM marca Where ma_nombre='Skoda'));

INSERT INTO MODELO VALUES (DEFAULT,'Giulia',(SELECT ma_id FROM marca Where ma_nombre='Alfa Romeo'));
INSERT INTO MODELO VALUES (DEFAULT,'Giulietta',(SELECT ma_id FROM marca Where ma_nombre='Alfa Romeo'));
INSERT INTO MODELO VALUES (DEFAULT,'Stelvio',(SELECT ma_id FROM marca Where ma_nombre='Alfa Romeo'));
INSERT INTO MODELO VALUES (DEFAULT,'156',(SELECT ma_id FROM marca Where ma_nombre='Alfa Romeo'));
INSERT INTO MODELO VALUES (DEFAULT,'155',(SELECT ma_id FROM marca Where ma_nombre='Alfa Romeo'));

INSERT INTO MODELO VALUES (DEFAULT,'XC90',(SELECT ma_id FROM marca Where ma_nombre='Volvo'));
INSERT INTO MODELO VALUES (DEFAULT,'S90',(SELECT ma_id FROM marca Where ma_nombre='Volvo'));
INSERT INTO MODELO VALUES (DEFAULT,'XC60',(SELECT ma_id FROM marca Where ma_nombre='Volvo'));
INSERT INTO MODELO VALUES (DEFAULT,'V60',(SELECT ma_id FROM marca Where ma_nombre='Volvo'));
INSERT INTO MODELO VALUES (DEFAULT,'S60',(SELECT ma_id FROM marca Where ma_nombre='Volvo'));

INSERT INTO MODELO VALUES (DEFAULT,'Sportage',(SELECT ma_id FROM marca Where ma_nombre='Kia'));
INSERT INTO MODELO VALUES (DEFAULT,'Rio',(SELECT ma_id FROM marca Where ma_nombre='Kia'));
INSERT INTO MODELO VALUES (DEFAULT,'Picanto',(SELECT ma_id FROM marca Where ma_nombre='Kia'));
INSERT INTO MODELO VALUES (DEFAULT,'Soul',(SELECT ma_id FROM marca Where ma_nombre='Kia'));
INSERT INTO MODELO VALUES (DEFAULT,'Sorento',(SELECT ma_id FROM marca Where ma_nombre='Kia'));

INSERT INTO MODELO VALUES (DEFAULT,'Siena',(SELECT ma_id FROM marca Where ma_nombre='Fiat'));
INSERT INTO MODELO VALUES (DEFAULT,'Palio',(SELECT ma_id FROM marca Where ma_nombre='Fiat'));
INSERT INTO MODELO VALUES (DEFAULT,'Uno',(SELECT ma_id FROM marca Where ma_nombre='Fiat'));

INSERT INTO MODELO VALUES (DEFAULT,'207',(SELECT ma_id FROM marca Where ma_nombre='Peugeot'));
INSERT INTO MODELO VALUES (DEFAULT,'206',(SELECT ma_id FROM marca Where ma_nombre='Peugeot'));
INSERT INTO MODELO VALUES (DEFAULT,'208',(SELECT ma_id FROM marca Where ma_nombre='Peugeot'));

----insert tipo vehiculo---

INSERT INTO tipo_vehiculo VALUES (DEFAULT,'Carro');
INSERT INTO tipo_vehiculo VALUES (DEFAULT,'Camioneta');
INSERT INTO tipo_vehiculo VALUES (DEFAULT,'Moto');

---insert status vehiculo---
INSERT INTO status_vehiculo VALUES (DEFAULT,'Disponible');
INSERT INTO status_vehiculo VALUES (DEFAULT,'Vendido');
INSERT INTO status_vehiculo VALUES (DEFAULT,'En mantenimiento');
INSERT INTO status_vehiculo VALUES (DEFAULT,'En alquiler');
INSERT INTO status_vehiculo VALUES (DEFAULT,'Inhabilitado');

---insert tipo cliente ---
INSERT INTO tipo_cliente  VALUES (DEFAULT,'Ocasional');
INSERT INTO tipo_cliente  VALUES (DEFAULT,'Frecuente');
INSERT INTO tipo_cliente  VALUES (DEFAULT,'VIP');
INSERT INTO tipo_cliente  VALUES (DEFAULT,'No deseado');

---insert tipo mantenimiento---
INSERT INTO tipo_mantenimiento  VALUES (DEFAULT,'Correctivo');
INSERT INTO tipo_mantenimiento  VALUES (DEFAULT,'Preventivo');
INSERT INTO tipo_mantenimiento  VALUES (DEFAULT,'De emergencia');

--- insert tipo entrega---
INSERT INTO tipo_gasto  VALUES (DEFAULT,'Operacionales');
INSERT INTO tipo_gasto  VALUES (DEFAULT,'No operacionales');

---insert status mantenimiento---
INSERT INTO status_mantenimiento VALUES (DEFAULT,'Operativo');
INSERT INTO status_mantenimiento VALUES (DEFAULT,'Finalizado');

---insert mantenimiento
insert into mantenimiento values (default,'Aire',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Cambio de aceite',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Lavado',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Lubricacion',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Revision de bateria',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Revision de fluidos',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Revision de amortiguadores',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Revision de faros',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Revision de sistema de escape',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Revision de correas',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Revision de filtros',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Revision de frenos',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Revision de limpiaparabrisas',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Revision completa',(select tm_id from tipo_mantenimiento where tm_nombre='Preventivo'));
insert into mantenimiento values (default,'Aire acondicionado',(select tm_id from tipo_mantenimiento where tm_nombre='Correctivo'));
insert into mantenimiento values (default,'Alineacion',(select tm_id from tipo_mantenimiento where tm_nombre='Correctivo'));
insert into mantenimiento values (default,'Balanceo',(select tm_id from tipo_mantenimiento where tm_nombre='Correctivo'));
insert into mantenimiento values (default,'Cambio de bateria',(select tm_id from tipo_mantenimiento where tm_nombre='Correctivo'));
insert into mantenimiento values (default,'Cambio de neumaticos',(select tm_id from tipo_mantenimiento where tm_nombre='Correctivo'));
insert into mantenimiento values (default,'Motor',(select tm_id from tipo_mantenimiento where tm_nombre='Correctivo'));
insert into mantenimiento values (default,'Reparacion de transmision',(select tm_id from tipo_mantenimiento where tm_nombre='Correctivo'));
insert into mantenimiento values (default,'Suspension',(select tm_id from tipo_mantenimiento where tm_nombre='Correctivo'));


--- insert formas de pago---
INSERT INTO forma_pago  VALUES (DEFAULT,'Efectivo');
INSERT INTO forma_pago  VALUES (DEFAULT,'Transferencia');
INSERT INTO forma_pago  VALUES (DEFAULT,'Pago movil');
INSERT INTO forma_pago  VALUES (DEFAULT,'Tarjeta Internacional');
INSERT INTO forma_pago  VALUES (DEFAULT,'Criptomoneda');

--- insert lugar---
INSERT INTO LUGAR VALUES (DEFAULT,'Venezuela','Pais',NULL);
INSERT INTO LUGAR VALUES (DEFAULT,'Distrito Capital','Estado',(select l_id from LUGAR where l_nombre='Venezuela'));
INSERT INTO LUGAR VALUES (DEFAULT,'Libertador','Municipio',(select l_id from LUGAR where l_nombre='Distrito Capital'));
----insert consesionario----
INSERT INTO CONSESIONARIO VALUES (DEFAULT, 'C-1', '0212-5599283','Av. Teheran, Montalban',(select l_id from LUGAR where l_nombre='Libertador'));
 ----insert sede---
INSERT INTO SEDE VALUES (DEFAULT,'Av. Teheran, Montalban','0212-5599283',1,20,1,(select c_id from CONSESIONARIO where c_nombre='C-1'),(select l_id from LUGAR where l_nombre='Libertador'));
----insert alquiler------



---insert detalle-alquiler----


---insert vehiculo
insert into vehiculo values ('AB169DA',2009,EMPTY_BLOB(),12662,22000
                            ,(select m_id from modelo where m_nombre='Camry')
                            ,(select marca_ma_id from modelo where m_nombre='Camry')
                            ,(select sv_id from status_vehiculo where sv_nombre='Disponible')
                            ,(select c_id from color where c_nombre='Plateado')
                            ,(select tv_id from tipo_vehiculo where tv_nombre='Carro')
                            ,1);
insert into vehiculo values ('AK183NS',2013,EMPTY_BLOB(),10773,28000,(select m_id from modelo where m_nombre='Sentra'),(select marca_ma_id from modelo where m_nombre='Sentra'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),1);
insert into vehiculo values ('AD558SD',2012,EMPTY_BLOB(),16251,27000,(select m_id from modelo where m_nombre='Sportage'),(select marca_ma_id from modelo where m_nombre='Sportage'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),1);
insert into vehiculo values ('AW834JM',2016,EMPTY_BLOB(),8836,30000,(select m_id from modelo where m_nombre='Elantra'),(select marca_ma_id from modelo where m_nombre='Elantra'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Azul'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),1);
insert into vehiculo values ('AU923NL',2014,EMPTY_BLOB(),9682,48000,(select m_id from modelo where m_nombre='Duster'),(select marca_ma_id from modelo where m_nombre='Duster'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Dorado'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),1);

--insert mantenimiento veh

insert into mantenimiento_vehiculo values (default
                                            ,periodo_duracion(TO_DATE('2023-03-22','yyyy-MM-dd')
                                                                ,TO_DATE('2023-03-23','yyyy-MM-dd'))
                                            ,TO_DATE('2023-06-22','yyyy-MM-dd')
                                            ,40
                                            ,'AB169DA'
                                            ,(SELECT s_id from status_mantenimiento where s_nombre='Finalizado')
                                            ,(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-12-22','yyyy-MM-dd'),TO_DATE('2022-12-23','yyyy-MM-dd')),TO_DATE('2023-03-22','yyyy-MM-dd'),40,'AB169DA',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-09-22','yyyy-MM-dd'),TO_DATE('2022-09-23','yyyy-MM-dd')),TO_DATE('2022-12-22','yyyy-MM-dd'),40,'AB169DA',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-06-22','yyyy-MM-dd'),TO_DATE('2022-06-23','yyyy-MM-dd')),TO_DATE('2022-09-22','yyyy-MM-dd'),40,'AB169DA',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-03-22','yyyy-MM-dd'),TO_DATE('2022-03-23','yyyy-MM-dd')),TO_DATE('2022-06-22','yyyy-MM-dd'),40,'AB169DA',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-02-22','yyyy-MM-dd'),TO_DATE('2023-02-23','yyyy-MM-dd')),TO_DATE('2023-05-22','yyyy-MM-dd'),40,'AK183NS',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-11-22','yyyy-MM-dd'),TO_DATE('2022-11-23','yyyy-MM-dd')),TO_DATE('2023-02-22','yyyy-MM-dd'),40,'AK183NS',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-08-22','yyyy-MM-dd'),TO_DATE('2022-08-23','yyyy-MM-dd')),TO_DATE('2022-11-22','yyyy-MM-dd'),40,'AK183NS',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-05-22','yyyy-MM-dd'),TO_DATE('2022-05-23','yyyy-MM-dd')),TO_DATE('2022-08-22','yyyy-MM-dd'),40,'AK183NS',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-02-22','yyyy-MM-dd'),TO_DATE('2022-02-23','yyyy-MM-dd')),TO_DATE('2022-05-22','yyyy-MM-dd'),40,'AK183NS',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-04-06','yyyy-MM-dd'),TO_DATE('2023-04-07','yyyy-MM-dd')),TO_DATE('2023-07-06','yyyy-MM-dd'),40,'AD558SD',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-01-06','yyyy-MM-dd'),TO_DATE('2023-01-07','yyyy-MM-dd')),TO_DATE('2023-04-06','yyyy-MM-dd'),40,'AD558SD',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-10-06','yyyy-MM-dd'),TO_DATE('2022-10-07','yyyy-MM-dd')),TO_DATE('2023-01-06','yyyy-MM-dd'),40,'AD558SD',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-07-06','yyyy-MM-dd'),TO_DATE('2022-07-07','yyyy-MM-dd')),TO_DATE('2022-10-06','yyyy-MM-dd'),40,'AD558SD',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-04-06','yyyy-MM-dd'),TO_DATE('2022-04-07','yyyy-MM-dd')),TO_DATE('2022-07-06','yyyy-MM-dd'),40,'AD558SD',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-04-02','yyyy-MM-dd'),TO_DATE('2023-04-03','yyyy-MM-dd')),TO_DATE('2023-07-02','yyyy-MM-dd'),40,'AW834JM',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-01-02','yyyy-MM-dd'),TO_DATE('2023-01-03','yyyy-MM-dd')),TO_DATE('2023-04-02','yyyy-MM-dd'),40,'AW834JM',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-10-02','yyyy-MM-dd'),TO_DATE('2022-10-03','yyyy-MM-dd')),TO_DATE('2023-01-02','yyyy-MM-dd'),40,'AW834JM',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-07-02','yyyy-MM-dd'),TO_DATE('2022-07-03','yyyy-MM-dd')),TO_DATE('2022-10-02','yyyy-MM-dd'),40,'AW834JM',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));
--insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-04-02','yyyy-MM-dd'),TO_DATE('2022-04-03','yyyy-MM-dd')),TO_DATE('2022-07-02','yyyy-MM-dd'),40,'AW834JM',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0),(SELECT tipo_mantenimiento_tm_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));