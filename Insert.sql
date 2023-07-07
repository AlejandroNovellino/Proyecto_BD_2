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

--- insert tipo entrega---
INSERT INTO tipo_gasto  VALUES (DEFAULT,'Operacionales');
INSERT INTO tipo_gasto  VALUES (DEFAULT,'No operacionales');

---insert tipo mantenimiento---
INSERT INTO tipo_mantenimiento  VALUES (DEFAULT,'Correctivo');
INSERT INTO tipo_mantenimiento  VALUES (DEFAULT,'Preventivo');
INSERT INTO tipo_mantenimiento  VALUES (DEFAULT,'De emergencia');

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

--- insert lugar---
INSERT INTO LUGAR VALUES (DEFAULT,'Venezuela','Pais',NULL);
INSERT INTO LUGAR VALUES (DEFAULT,'Distrito Capital','Estado',(select l_id from LUGAR where l_nombre='Venezuela'));
INSERT INTO LUGAR VALUES (DEFAULT,'Merida','Estado',(select l_id from LUGAR where l_nombre='Venezuela'));
INSERT INTO LUGAR VALUES (DEFAULT,'Miranda','Estado',(select l_id from LUGAR where l_nombre='Venezuela'));
INSERT INTO LUGAR VALUES (DEFAULT,'Zulia','Estado',(select l_id from LUGAR where l_nombre='Venezuela'));
INSERT INTO LUGAR VALUES (DEFAULT,'Libertador','Municipio',(select l_id from LUGAR where l_nombre='Distrito Capital'));
INSERT INTO LUGAR VALUES (DEFAULT,'LibertadorL','Municipio',(select l_id from LUGAR where l_nombre='Merida'));
INSERT INTO LUGAR VALUES (DEFAULT,'Chacao','Municipio',(select l_id from LUGAR where l_nombre='Miranda'));
INSERT INTO LUGAR VALUES (DEFAULT,'Baruta','Municipio',(select l_id from LUGAR where l_nombre='Miranda'));
INSERT INTO LUGAR VALUES (DEFAULT,'Sucre','Municipio',(select l_id from LUGAR where l_nombre='Miranda'));
INSERT INTO LUGAR VALUES (DEFAULT,'Maracaibo','Municipio',(select l_id from LUGAR where l_nombre='Zulia'));

--insertar talleres
insert into taller values (default, 'Mis 3 Hermanos', '0212-2663729', ubicacion_geografica(ubicacion_geografica.verificar_latitud('10.450231'),ubicacion_geografica.verificar_longitud('-66.914018'),null), 10, (select l_id from LUGAR where l_nombre='Libertador'));
insert into taller values (default, 'Mis 4 Hermanos', '0212-2673729', ubicacion_geografica(ubicacion_geografica.verificar_latitud('10.446929'),ubicacion_geografica.verificar_longitud('-66.881379'),null), 5, (select l_id from LUGAR where l_nombre='Libertador'));
insert into taller values (default, 'Mis 2 primos segundos por parte de papa', '0212-2163429', ubicacion_geografica(ubicacion_geografica.verificar_latitud('10.452111'),ubicacion_geografica.verificar_longitud('-66.913229'),null), 5, (select l_id from LUGAR where l_nombre='Chacao'));
insert into taller values (default, 'Thunder Cars', '0212-2672729', ubicacion_geografica(ubicacion_geografica.verificar_latitud('10.443939'),ubicacion_geografica.verificar_longitud('-67.000123'),null), 10, (select l_id from LUGAR where l_nombre='Sucre'));
insert into taller values (default, 'Eduardo Consalvo', '0212-2672729', ubicacion_geografica(ubicacion_geografica.verificar_latitud('10.454590'),ubicacion_geografica.verificar_longitud('-66.901832'),null), 4, (select l_id from LUGAR where l_nombre='Baruta'));
insert into taller values (default, 'Maquina', '0274-5172729', ubicacion_geografica(ubicacion_geografica.verificar_latitud('8.573289'),ubicacion_geografica.verificar_longitud('-71.177782'),null), 7, (select l_id from LUGAR where l_nombre='LibertadorL'));
insert into taller values (default, 'Mocar', '0274-2784684', ubicacion_geografica(ubicacion_geografica.verificar_latitud('8.574129'),ubicacion_geografica.verificar_longitud('-71.177299'),null), 4, (select l_id from LUGAR where l_nombre='LibertadorL'));
insert into taller values (default, 'Don Orlando', '0274-2131822', ubicacion_geografica(ubicacion_geografica.verificar_latitud('8.578219'),ubicacion_geografica.verificar_longitud('-71.174923'),null), 5, (select l_id from LUGAR where l_nombre='LibertadorL'));
insert into taller values (default, 'A y M Racing', '0263-1264892', ubicacion_geografica(ubicacion_geografica.verificar_latitud('10.637202'),ubicacion_geografica.verificar_longitud('-71.649201'),null), 10, (select l_id from LUGAR where l_nombre='Maracaibo'));
insert into taller values (default, 'Ritchie con la T', '0263-3729442', ubicacion_geografica(ubicacion_geografica.verificar_latitud('10.646628'),ubicacion_geografica.verificar_longitud('-71.649282'),null), 5, (select l_id from LUGAR where l_nombre='Maracaibo'));
insert into taller values (default, 'Talleres 1973', '0263-7892373', ubicacion_geografica(ubicacion_geografica.verificar_latitud('10.647286'),ubicacion_geografica.verificar_longitud('-71.661811'),null), 8, (select l_id from LUGAR where l_nombre='Maracaibo'));

--insertar manten-taller
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0), (select t_id from taller where t_nombre='Mis 3 Hermanos'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0), (select t_id from taller where t_nombre='Mis 4 Hermanos'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0), (select t_id from taller where t_nombre='Mis 2 primos segundos por parte de papa'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0), (select t_id from taller where t_nombre='Thunder Cars'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0), (select t_id from taller where t_nombre='Maquina'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0), (select t_id from taller where t_nombre='Eduardo Consalvo'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0), (select t_id from taller where t_nombre='Mocar'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0), (select t_id from taller where t_nombre='Don Orlando'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0), (select t_id from taller where t_nombre='A y M Racing'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0), (select t_id from taller where t_nombre='Ritchie con la T'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0), (select t_id from taller where t_nombre='Talleres 1973'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de bateria')>0), (select t_id from taller where t_nombre='Mis 3 Hermanos'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de bateria')>0), (select t_id from taller where t_nombre='Mis 4 Hermanos'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de bateria')>0), (select t_id from taller where t_nombre='Mis 2 primos segundos por parte de papa'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de bateria')>0), (select t_id from taller where t_nombre='Thunder Cars'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de bateria')>0), (select t_id from taller where t_nombre='Maquina'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de bateria')>0), (select t_id from taller where t_nombre='Eduardo Consalvo'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de bateria')>0), (select t_id from taller where t_nombre='Mocar'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de bateria')>0), (select t_id from taller where t_nombre='Don Orlando'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de bateria')>0), (select t_id from taller where t_nombre='A y M Racing'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de bateria')>0), (select t_id from taller where t_nombre='Ritchie con la T'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de bateria')>0), (select t_id from taller where t_nombre='Talleres 1973'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de fluidos')>0), (select t_id from taller where t_nombre='Mis 3 Hermanos'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de fluidos')>0), (select t_id from taller where t_nombre='Mis 4 Hermanos'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de fluidos')>0), (select t_id from taller where t_nombre='Mis 2 primos segundos por parte de papa'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de fluidos')>0), (select t_id from taller where t_nombre='Thunder Cars'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Revision de fluidos')>0), (select t_id from taller where t_nombre='Maquina'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Alineacion')>0), (select t_id from taller where t_nombre='Mis 3 Hermanos'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Alineacion')>0), (select t_id from taller where t_nombre='Mis 2 primos segundos por parte de papa'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Alineacion')>0), (select t_id from taller where t_nombre='Thunder Cars'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Balanceo')>0), (select t_id from taller where t_nombre='Mis 3 Hermanos'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Balanceo')>0), (select t_id from taller where t_nombre='Mis 2 primos segundos por parte de papa'));
insert into mantenimiento_taller values (default, (select m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Balanceo')>0), (select t_id from taller where t_nombre='Thunder Cars'));

--- insert formas de pago---
INSERT INTO forma_pago  VALUES (DEFAULT,'Efectivo');
INSERT INTO forma_pago  VALUES (DEFAULT,'Transferencia');
INSERT INTO forma_pago  VALUES (DEFAULT,'Pago movil');
INSERT INTO forma_pago  VALUES (DEFAULT,'Tarjeta Internacional');
INSERT INTO forma_pago  VALUES (DEFAULT,'Criptomoneda');

----insert consesionario----
INSERT INTO CONSESIONARIO VALUES (DEFAULT, 'C-1', '0212-5599283','Av. Teheran, Montalban',(select l_id from LUGAR where l_nombre='Libertador'));
 ----insert sede---
INSERT INTO SEDE VALUES (DEFAULT,'Av. Teherán, Montalbán','0212-5599283',1,20,1,(select c_id from CONSESIONARIO where c_nombre='C-1'),(select l_id from LUGAR where l_nombre='Libertador'));
INSERT INTO SEDE VALUES (DEFAULT,'Av. Urdaneta con Viaducto Sucre','0274-2883710',5,6,1,(select c_id from CONSESIONARIO where c_nombre='C-1'),(select l_id from LUGAR where l_nombre='LibertadorL'));
INSERT INTO SEDE VALUES (DEFAULT,'Urb. Los Rosales, Calle 82C','0263-7924691',7,5,0,(select c_id from CONSESIONARIO where c_nombre='C-1'),(select l_id from LUGAR where l_nombre='Maracaibo'));

---insert promocion
insert into promocion values (default,0.15,'15 % de descuento en el alquiler de cualquier camioneta de la flota');
insert into promocion values (default,0.20,'20 % de descuento en el alquiler de vehiculos Hyundai');
insert into promocion values (default,0.25,'25 % de descuento en el alquiler de vehiculos blancos');
insert into promocion values (default,0.15,'15 % de descuento en el alquiler de vehiculos Renault');
insert into promocion values (default,0.20,'20 % de descuento por Dia del Padre');
insert into promocion values (default,0.40,'40 % de descuento en alquileres durante el Viernes Negro');
insert into promocion values (default,0.20,'20 % de descuento por Dia de la Madre');
insert into promocion values (default,0.30,'30 % de descuento por la Feria del Sol');

insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AB169DA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AB169DA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AB169DA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AT262MN');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AS884SG');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AM824SH');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AJ387IN');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AG406IU');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AN843BC');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AF214UC');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AW795CG');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AF545WC');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AU552UV');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AS996WN');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-20','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),1,'AI766EO');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-04-10','yyyy-MM-dd'),TO_DATE('2023-06-30','yyyy-MM-dd')),2,'AW834JM');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-04-10','yyyy-MM-dd'),TO_DATE('2023-06-30','yyyy-MM-dd')),2,'AE230CA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-04-10','yyyy-MM-dd'),TO_DATE('2023-06-30','yyyy-MM-dd')),2,'AJ447AP');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-04-10','yyyy-MM-dd'),TO_DATE('2023-06-30','yyyy-MM-dd')),2,'AG406IU');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-04-10','yyyy-MM-dd'),TO_DATE('2023-06-30','yyyy-MM-dd')),2,'AN843BC');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-04-10','yyyy-MM-dd'),TO_DATE('2023-06-30','yyyy-MM-dd')),2,'AI040AA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-04-10','yyyy-MM-dd'),TO_DATE('2023-06-30','yyyy-MM-dd')),2,'AH224TS');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-04-10','yyyy-MM-dd'),TO_DATE('2023-06-30','yyyy-MM-dd')),2,'AS996WN');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-04-10','yyyy-MM-dd'),TO_DATE('2023-06-30','yyyy-MM-dd')),2,'AI766EO');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-06-01','yyyy-MM-dd'),TO_DATE('2023-06-15','yyyy-MM-dd')),3,'AN723ER');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-06-01','yyyy-MM-dd'),TO_DATE('2023-06-15','yyyy-MM-dd')),3,'AE230CA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-06-01','yyyy-MM-dd'),TO_DATE('2023-06-15','yyyy-MM-dd')),3,'AD630QM');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-06-01','yyyy-MM-dd'),TO_DATE('2023-06-15','yyyy-MM-dd')),3,'AI040AA')
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-25','yyyy-MM-dd'),TO_DATE('2023-06-10','yyyy-MM-dd')),4,'AU923NL');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-25','yyyy-MM-dd'),TO_DATE('2023-06-10','yyyy-MM-dd')),4,'AC824MD');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-06-10','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),5,'AB169DA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-06-10','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),5,'AA931SJ');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-06-10','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),5,'AO747KN');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-06-10','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),5,'AN723ER');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-06-10','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),5,'AA129KD');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-06-10','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),5,'AK760OA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-06-10','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),5,'AD630QM');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-06-10','yyyy-MM-dd'),TO_DATE('2023-06-20','yyyy-MM-dd')),5,'AR510ZI');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2022-11-20','yyyy-MM-dd'),TO_DATE('2022-11-30','yyyy-MM-dd')),6,'AA999TF');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2022-11-20','yyyy-MM-dd'),TO_DATE('2022-11-30','yyyy-MM-dd')),6,'AI646FO');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2022-11-20','yyyy-MM-dd'),TO_DATE('2022-11-30','yyyy-MM-dd')),6,'AB123SP');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2022-11-20','yyyy-MM-dd'),TO_DATE('2022-11-30','yyyy-MM-dd')),6,'AO747KN');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2022-11-20','yyyy-MM-dd'),TO_DATE('2022-11-30','yyyy-MM-dd')),6,'AN723ER');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2022-11-20','yyyy-MM-dd'),TO_DATE('2022-11-30','yyyy-MM-dd')),6,'AA129KD');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2022-11-20','yyyy-MM-dd'),TO_DATE('2022-11-30','yyyy-MM-dd')),6,'AT262MN');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2022-11-20','yyyy-MM-dd'),TO_DATE('2022-11-30','yyyy-MM-dd')),6,'AS884SG');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2022-11-20','yyyy-MM-dd'),TO_DATE('2022-11-30','yyyy-MM-dd')),6,'AA192DK');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2022-11-20','yyyy-MM-dd'),TO_DATE('2022-11-30','yyyy-MM-dd')),6,'AI912DV');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2022-11-20','yyyy-MM-dd'),TO_DATE('2022-11-30','yyyy-MM-dd')),6,'AT619OV');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2022-11-20','yyyy-MM-dd'),TO_DATE('2022-11-30','yyyy-MM-dd')),6,'AJ128MA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-05','yyyy-MM-dd'),TO_DATE('2023-05-15','yyyy-MM-dd')),7,'AB169DA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-05','yyyy-MM-dd'),TO_DATE('2023-05-15','yyyy-MM-dd')),7,'AA931SJ');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-05','yyyy-MM-dd'),TO_DATE('2023-05-15','yyyy-MM-dd')),7,'AO747KN');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-05','yyyy-MM-dd'),TO_DATE('2023-05-15','yyyy-MM-dd')),7,'AN723ER');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-05','yyyy-MM-dd'),TO_DATE('2023-05-15','yyyy-MM-dd')),7,'AA129KD');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-05','yyyy-MM-dd'),TO_DATE('2023-05-15','yyyy-MM-dd')),7,'AK760OA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-05','yyyy-MM-dd'),TO_DATE('2023-05-15','yyyy-MM-dd')),7,'AD630QM');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-05-05','yyyy-MM-dd'),TO_DATE('2023-05-15','yyyy-MM-dd')),7,'AR510ZI');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AC888ZR');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AL311JC');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AA174OS');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AK760OA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AD630QM');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AR510ZI');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AA619PH');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AP233MP');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AZ109WH');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AP282ZP');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AC651PJ');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AZ989AF');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AL110GH');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AE043AN');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AZ631RT');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AH784AK');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AI040AA');
insert into historico_promocion values (default,periodo_duracion(TO_DATE('2023-02-01','yyyy-MM-dd'),TO_DATE('2023-02-25','yyyy-MM-dd')),8,'AH224TS');

--insert eprsona
insert into persona values (default,EMPTY_BLOB(),ubicacion_geografica(10.450192,-68.982388),(select l_id from LUGAR where l_nombre='Libertador'),(select tc_id from tipo_cliente where tc_nombre='Ocasional'),informacion_personal(
                                    informacion_personal.verificar_cedula('V-28120942'),
                                    informacion_personal.verificar_nombre_apellido('Jose'),
                                    informacion_personal.verificar_nombre_apellido('Fernando'),
                                    informacion_personal.verificar_nombre_apellido('Sosa'),
                                    informacion_personal.verificar_nombre_apellido('Arnal'),
                                    informacion_personal.verificar_correo('jsoesoas@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('11-SEP-1998'),
                                    informacion_personal.verificar_sexo('M'),
                                    'direccion' 
                                    ));
insert into persona values (default,EMPTY_BLOB(),ubicacion_geografica(10.450192,-68.982388),(select l_id from LUGAR where l_nombre='Libertador'),(select tc_id from tipo_cliente where tc_nombre='Ocasional'),informacion_personal(
                                    informacion_personal.verificar_cedula('V-29124681'),
                                    informacion_personal.verificar_nombre_apellido('Daniela'),
                                    informacion_personal.verificar_nombre_apellido('Arantxa'),
                                    informacion_personal.verificar_nombre_apellido('Faria'),
                                    informacion_personal.verificar_nombre_apellido('Lopez'),
                                    informacion_personal.verificar_correo('daniarantxafl@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('28-MAR-1997'),
                                    informacion_personal.verificar_sexo('F'),
                                    'direccion' 
                                    ));
--insert aliado

execute PK_Alianza.I_Aliado('descarga.PNG' ,'pana Tech');
/
execute PK_Alianza.I_Aliado('gruero.PNG' ,'Tu gruero');
/

-- insert alianza

insert into alianza values (
    default,
    periodo_duracion(
        TO_DATE('05/01/2023','MM/DD/YYYY'),
        TO_DATE('08/01/2023','MM/DD/YYYY')
    ),
    'Alianza con tu gruero para fallos del auto',
    'Fallo dano',
    (select ao_id from aliado where ao_nombre = 'Tu gruero'),
    (select s_id from sede where s_numerosede = 5)
);

insert into alianza values (
    default,
    periodo_duracion(
        TO_DATE('05/01/2023','MM/DD/YYYY'),
        TO_DATE('08/01/2023','MM/DD/YYYY')
    ),
    'Alianza con tu gruero para fallos del auto',
    'Fallo dano',
    (select ao_id from aliado where ao_nombre = 'pana Tech'),
    (select s_id from sede where s_numerosede = 5)
);

insert into alianza values (
    default,
    periodo_duracion(
        TO_DATE('05/01/2023','MM/DD/YYYY'),
        TO_DATE('08/01/2023','MM/DD/YYYY')
    ),
    'Alianza con tu gruero para fallos del auto',
    'Fallo dano',
    (select ao_id from aliado where ao_nombre = 'Tu gruero'),
    (select s_id from sede where s_numerosede = 5)
);

insert into alianza values (
    default,
    periodo_duracion(
        TO_DATE('05/01/2023','MM/DD/YYYY'),
        TO_DATE('08/01/2023','MM/DD/YYYY')
    ),
    'Alianza con tu gruero para fallos del auto',
    'Fallo dano',
    (select ao_id from aliado where ao_nombre = 'pana Tech'),
    (select s_id from sede where s_numerosede = 5)
);

insert into alianza values (
    default,
    periodo_duracion(
        TO_DATE('05/01/2023','MM/DD/YYYY'),
        TO_DATE('08/01/2023','MM/DD/YYYY')
    ),
    'Alianza con tu gruero para fallos del auto',
    'Fallo dano',
    (select ao_id from aliado where ao_nombre = 'Tu gruero'),
    (select s_id from sede where s_numerosede = 1)
);

insert into alianza values (
    default,
    periodo_duracion(
        TO_DATE('05/01/2023','MM/DD/YYYY'),
        TO_DATE('08/01/2023','MM/DD/YYYY')
    ),
    'Alianza con tu gruero para fallos del auto',
    'Fallo dano',
    (select ao_id from aliado where ao_nombre = 'pana Tech'),
    (select s_id from sede where s_numerosede = 1)
);

insert into alianza values (
    default,
    periodo_duracion(
        TO_DATE('05/01/2023','MM/DD/YYYY'),
        TO_DATE('08/01/2023','MM/DD/YYYY')
    ),
    'Alianza con tu gruero para fallos del auto',
    'Fallo dano',
    (select ao_id from aliado where ao_nombre = 'Tu gruero'),
    (select s_id from sede where s_numerosede = 1)
);

insert into alianza values (
    default,
    periodo_duracion(
        TO_DATE('05/01/2023','MM/DD/YYYY'),
        TO_DATE('08/01/2023','MM/DD/YYYY')
    ),
    'Alianza con tu gruero para fallos del auto',
    'Fallo dano',
    (select ao_id from aliado where ao_nombre = 'pana Tech'),
    (select s_id from sede where s_numerosede = 1)
);

--cliente
execute PK_Cliente.I_Cliente('persona1.PNG','Jose','Manuel','Perez','Castillo','V-26778657','josemac@gmail.com',TO_DATE('05/10/1991','dd/MM/yyyy'),'M','10.4974293','-66.9116934','PUENTE','Ocasional', 'Libertador');
/
execute PK_Cliente.I_Cliente('persona2.PNG','Javier','Marcos','Peralta','Contreras','V-26777452','javi@gmail.com',TO_DATE('06/11/1994','dd/MM/yyyy'),'M','10.4974293','-66.9116934','PUENTE','VIP','Libertador');
/
execute PK_Cliente.I_Cliente('persona3.PNG','Luna','Mariela','Martinez','Colmenares','V-22456742','luna@gmail.com',TO_DATE('27/04/1995','dd/MM/yyyy'),'F','10.4974293','-66.9116934','PUENTE','Frecuente','Libertador');
/
execute PK_Cliente.I_Cliente('persona4.PNG','Maria','Monica','Martinelli','Abreu','V-28456742','MMonica@gmail.com',TO_DATE('27/04/2001','dd/MM/yyyy'),'F','10.4974293','-66.9116934','PUENTE','Frecuente','Libertador');
/
execute PK_Cliente.I_Cliente('persona5.PNG','Marisol','Monic','Martinez','Bermude','V-28456741','marisolm@gmail.com',TO_DATE('27/04/2001','dd/MM/yyyy'),'F','10.4974293','-66.9116934','PUENTE','Frecuente','Libertador');
/
execute PK_Cliente.I_Cliente('persona6.PNG','David','Jesus','Orta','Cagua','V-8114112','davidjortac@gmail.com',TO_DATE('03/02/1969','dd/MM/yyyy'),'M','10.4974293','-66.9116934','Si','Ocasional','Libertador');
/
execute PK_Cliente.I_Cliente('persona7.PNG','Jonny','Eduardo','Mora','Rodriguez','V-14728492','jonnymoraaa@gmail.com',TO_DATE('12/02/1984','dd/MM/yyyy'),'M','10.4974293','-66.9116934','Si','Ocasional','Libertador');
/
execute PK_Cliente.I_Cliente('persona8.PNG','Andrea','Josefina','Sanchez','Dominguez','V-20192124','andysandomi@gmail.com',TO_DATE('29/11/1995','dd/MM/yyyy'),'F','10.4974293','-66.9116934','Siamo','Ocasional','Libertador');
/
execute PK_Cliente.I_Cliente('persona9.PNG','Eloy','Arnaldo','Lopez','Moretti','V-14853912','eloyalmoretti@gmail.com',TO_DATE('07/03/1982','dd/MM/yyyy'),'M','10.4974293','-66.9116934','Si','Ocasional','Libertador');
/
execute PK_Cliente.I_Cliente('persona1.PNG','Juan','Daniel','Macciali','Torres','V-28126498','jdmaccialitq@gmail.com',TO_DATE('14/12/1998','dd/MM/yyyy'),'M','8.4974293','-71.9116934','Si','Ocasional','LibertadorL');
/
execute PK_Cliente.I_Cliente('persona2.PNG','Fabricio','Andres','Mata','Molina','V-18726132','fabmata18@gmail.com',TO_DATE('04/08/1991','dd/MM/yyyy'),'M','8.4974293','-71.9116934','Si','Ocasional','LibertadorL');
/
execute PK_Cliente.I_Cliente('persona3.PNG','Diana','Amanda','Altuve','Prieto','V-17277222','dianaltuve@gmail.com',TO_DATE('11/06/1992','dd/MM/yyyy'),'F','8.4974293','-71.9116934','Si','Ocasional','LibertadorL');
/
execute PK_Cliente.I_Cliente('persona4.PNG','Mercedes','Patricia','Sandia','Jugo','V-25526201','merchysandiaj@gmail.com',TO_DATE('19/07/1999','dd/MM/yyyy'),'F','8.4974293','-71.9116934','Si','Frecuente','LibertadorL');
/
execute PK_Cliente.I_Cliente('persona5.PNG','Solange','Nazarin','Diaz','Hochsprung','V-15156135','solangediazhochsprung@gmail.com',TO_DATE('27/01/1988','dd/MM/yyyy'),'F','8.4974293','-71.9116934','Si','VIP','LibertadorL');
/
execute PK_Cliente.I_Cliente('persona6.PNG','Ramiro','Jose','Gual','Carmona','V-22479001','ramgualc1992@gmail.com',TO_DATE('25/05/1992','dd/MM/yyyy'),'M','8.4974293','-71.9116934','Si','Ocasional','Maracaibo');
/
execute PK_Cliente.I_Cliente('persona7.PNG','Peter','Gualberto','Mollejon','Correa','V-23723714','elmismisimomollejon@gmail.com',TO_DATE('27/10/1994','dd/MM/yyyy'),'M','8.4974293','-71.9116934','Si','Frecuente','Maracaibo');
/
execute PK_Cliente.I_Cliente('persona8.PNG','Daicarlys','Javierina','Justo','Parra','V-19992805','daikitijusto1@gmail.com',TO_DATE('01/08/1987','dd/MM/yyyy'),'F','8.4974293','-71.9116934','Si','Ocasional','Maracaibo');
/
execute PK_Cliente.I_Cliente('persona9.PNG','Yeiberth','Juan','Lanza','Galante','V-21920405','yeiberth@gmail.com',TO_DATE('16/06/1989','dd/MM/yyyy'),'M','8.4974293','-71.9116934','Si','Ocasional','Maracaibo');
/
execute PK_Cliente.I_Cliente('persona1.PNG','Francisco','Fernando','Peraza','Obando','V-16612402','franciscoperazao@gmail.com',TO_DATE('19/12/1984','dd/MM/yyyy'),'M','8.4974293','-71.9116934','Si','VIP','Maracaibo');
/
execute PK_Cliente.I_Cliente('persona3.PNG','Josefa','Begonia','Lamus','Perez','V-13929855','jobegonialamus@gmail.com',TO_DATE('12/01/1980','dd/MM/yyyy'),'M','8.4974293','-71.9116934','Si','Frecuente','Maracaibo');
/

--insert reserva
insert into reserva values (default,TO_DATE('12/05/2023','dd/MM/yyyy'),'Agendada',2);
insert into reserva values (default,TO_DATE('24/05/2023','dd/MM/yyyy'),'Agendada',6);
insert into reserva values (default,TO_DATE('22/05/2023','dd/MM/yyyy'),'Agendada',16);
insert into reserva values (default,TO_DATE('28/05/2023','dd/MM/yyyy'),'Agendada',11);

---insert detalle-alquiler----
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AB169DA'),(select v_km from vehiculo where v_placa='AB169DA'),(select v_km from vehiculo where v_placa='AB169DA'),5,TO_DATE('2023-06-09','yyyy-MM-dd'),'AB169DA');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AS841JG'),(select v_km from vehiculo where v_placa='AS841JG'),(select v_km from vehiculo where v_placa='AS841JG'),3,TO_DATE('2023-06-02','yyyy-MM-dd'),'AS841JG');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AK183NS'),(select v_km from vehiculo where v_placa='AK183NS'),(select v_km from vehiculo where v_placa='AK183NS'),3,TO_DATE('2023-05-22','yyyy-MM-dd'),'AK183NS');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AA931SJ'),(select v_km from vehiculo where v_placa='AA931SJ'),(select v_km from vehiculo where v_placa='AA931SJ'),7,TO_DATE('2023-04-17','yyyy-MM-dd'),'AA931SJ');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AI855MC'),(select v_km from vehiculo where v_placa='AI855MC'),(select v_km from vehiculo where v_placa='AI855MC'),2,TO_DATE('2023-03-13','yyyy-MM-dd'),'AI855MC');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AD558SD'),(select v_km from vehiculo where v_placa='AD558SD'),(select v_km from vehiculo where v_placa='AD558SD'),5,TO_DATE('2023-01-30','yyyy-MM-dd'),'AD558SD');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AO773NN'),(select v_km from vehiculo where v_placa='AO773NN'),(select v_km from vehiculo where v_placa='AO773NN'),4,TO_DATE('2023-06-11','yyyy-MM-dd'),'AO773NN');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AW834JM'),(select v_km from vehiculo where v_placa='AW834JM'),(select v_km from vehiculo where v_placa='AW834JM'),9,TO_DATE('2023-03-18','yyyy-MM-dd'),'AW834JM');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AU923NL'),(select v_km from vehiculo where v_placa='AU923NL'),(select v_km from vehiculo where v_placa='AU923NL'),2,TO_DATE('2023-01-11','yyyy-MM-dd'),'AU923NL');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AA931SJ'),(select v_km from vehiculo where v_placa='AA931SJ'),(select v_km from vehiculo where v_placa='AA931SJ'),2,TO_DATE('2023-06-03','yyyy-MM-dd'),'AA931SJ');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AI855MC'),(select v_km from vehiculo where v_placa='AI855MC'),(select v_km from vehiculo where v_placa='AI855MC'),4,TO_DATE('2023-04-02','yyyy-MM-dd'),'AI855MC');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AD558SD'),(select v_km from vehiculo where v_placa='AD558SD'),(select v_km from vehiculo where v_placa='AD558SD'),12,TO_DATE('2022-11-27','yyyy-MM-dd'),'AD558SD');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AO773NN'),(select v_km from vehiculo where v_placa='AO773NN'),(select v_km from vehiculo where v_placa='AO773NN'),3,TO_DATE('2023-06-01','yyyy-MM-dd'),'AO773NN');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AW834JM'),(select v_km from vehiculo where v_placa='AW834JM'),(select v_km from vehiculo where v_placa='AW834JM'),5,TO_DATE('2023-03-23','yyyy-MM-dd'),'AW834JM');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AU923NL'),(select v_km from vehiculo where v_placa='AU923NL'),(select v_km from vehiculo where v_placa='AU923NL'),7,TO_DATE('2022-10-21','yyyy-MM-dd'),'AU923NL');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AA126FB'),(select v_km from vehiculo where v_placa='AA126FB'),(select v_km from vehiculo where v_placa='AA126FB'),4,TO_DATE('2023-06-06','yyyy-MM-dd'),'AA126FB');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AR228BD'),(select v_km from vehiculo where v_placa='AR228BD'),(select v_km from vehiculo where v_placa='AR228BD'),3,TO_DATE('2023-05-29','yyyy-MM-dd'),'AR228BD');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AC824MD'),(select v_km from vehiculo where v_placa='AC824MD'),(select v_km from vehiculo where v_placa='AC824MD'),7,TO_DATE('2023-05-31','yyyy-MM-dd'),'AC824MD');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AE119ZB'),(select v_km from vehiculo where v_placa='AE119ZB'),(select v_km from vehiculo where v_placa='AE119ZB'),5,TO_DATE('2023-04-22','yyyy-MM-dd'),'AE119ZB');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AF237ML'),(select v_km from vehiculo where v_placa='AF237ML'),(select v_km from vehiculo where v_placa='AF237ML'),6,TO_DATE('2023-05-27','yyyy-MM-dd'),'AF237ML');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AA999TF'),(select v_km from vehiculo where v_placa='AA999TF'),(select v_km from vehiculo where v_placa='AA999TF'),10,TO_DATE('2023-06-05','yyyy-MM-dd'),'AA999TF'); --macaraibo
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AI646FO'),(select v_km from vehiculo where v_placa='AI646FO'),(select v_km from vehiculo where v_placa='AI646FO'),2,TO_DATE('2023-06-08','yyyy-MM-dd'),'AI646FO');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AB123SP'),(select v_km from vehiculo where v_placa='AB123SP'),(select v_km from vehiculo where v_placa='AB123SP'),5,TO_DATE('2023-05-25','yyyy-MM-dd'),'AB123SP');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AO747KN'),(select v_km from vehiculo where v_placa='AO747KN'),(select v_km from vehiculo where v_placa='AO747KN'),3,TO_DATE('2023-06-13','yyyy-MM-dd'),'AO747KN');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AN723ER'),(select v_km from vehiculo where v_placa='AN723ER'),(select v_km from vehiculo where v_placa='AN723ER'),3,TO_DATE('2023-05-11','yyyy-MM-dd'),'AN723ER');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AA129KD'),(select v_km from vehiculo where v_placa='AA129KD'),(select v_km from vehiculo where v_placa='AA129KD'),15,TO_DATE('2023-03-22','yyyy-MM-dd'),'AA129KD');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AI912DV'),(select v_km from vehiculo where v_placa='AI912DV'),(select v_km from vehiculo where v_placa='AI912DV'),6,TO_DATE('2023-05-29','yyyy-MM-dd'),'AI912DV');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AT619OV'),(select v_km from vehiculo where v_placa='AT619OV'),(select v_km from vehiculo where v_placa='AT619OV'),2,TO_DATE('2023-03-13','yyyy-MM-dd'),'AT619OV');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AJ128MA'),(select v_km from vehiculo where v_placa='AJ128MA'),(select v_km from vehiculo where v_placa='AJ128MA'),3,TO_DATE('2022-12-02','yyyy-MM-dd'),'AJ128MA');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AV389HC'),(select v_km from vehiculo where v_placa='AV389HC'),(select v_km from vehiculo where v_placa='AV389HC'),7,TO_DATE('2022-08-29','yyyy-MM-dd'),'AV389HC');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AM824SH'),(select v_km from vehiculo where v_placa='AM824SH'),(select v_km from vehiculo where v_placa='AM824SH'),3,TO_DATE('2022-06-29','yyyy-MM-dd'),'AM824SH');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AC888ZR'),(select v_km from vehiculo where v_placa='AC888ZR'),(select v_km from vehiculo where v_placa='AC888ZR'),10,TO_DATE('2023-06-05','yyyy-MM-dd'),'AC888ZR'); --medira
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AL311JC'),(select v_km from vehiculo where v_placa='AL311JC'),(select v_km from vehiculo where v_placa='AL311JC'),2,TO_DATE('2023-06-08','yyyy-MM-dd'),'AL311JC');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AA174OS'),(select v_km from vehiculo where v_placa='AA174OS'),(select v_km from vehiculo where v_placa='AA174OS'),5,TO_DATE('2023-05-25','yyyy-MM-dd'),'AA174OS');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AK760OA'),(select v_km from vehiculo where v_placa='AK760OA'),(select v_km from vehiculo where v_placa='AK760OA'),3,TO_DATE('2023-06-13','yyyy-MM-dd'),'AK760OA');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AD630QM'),(select v_km from vehiculo where v_placa='AD630QM'),(select v_km from vehiculo where v_placa='AD630QM'),3,TO_DATE('2023-05-11','yyyy-MM-dd'),'AD630QM');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AR510ZI'),(select v_km from vehiculo where v_placa='AR510ZI'),(select v_km from vehiculo where v_placa='AR510ZI'),15,TO_DATE('2023-03-22','yyyy-MM-dd'),'AR510ZI');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AF214UC'),(select v_km from vehiculo where v_placa='AF214UC'),(select v_km from vehiculo where v_placa='AF214UC'),6,TO_DATE('2023-05-29','yyyy-MM-dd'),'AF214UC');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AW795CG'),(select v_km from vehiculo where v_placa='AW795CG'),(select v_km from vehiculo where v_placa='AW795CG'),2,TO_DATE('2023-03-13','yyyy-MM-dd'),'AW795CG');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AZ109WH'),(select v_km from vehiculo where v_placa='AZ109WH'),(select v_km from vehiculo where v_placa='AZ109WH'),3,TO_DATE('2022-12-02','yyyy-MM-dd'),'AZ109WH');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AA619PH'),(select v_km from vehiculo where v_placa='AA619PH'),(select v_km from vehiculo where v_placa='AA619PH'),7,TO_DATE('2022-08-29','yyyy-MM-dd'),'AA619PH');
insert into detalle_alquiler values (default, (select v_precio from vehiculo where v_placa='AP233MP'),(select v_km from vehiculo where v_placa='AP233MP'),(select v_km from vehiculo where v_placa='AP233MP'),3,TO_DATE('2022-06-29','yyyy-MM-dd'),'AP233MP');


----insert alquiler------
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=1),periodo_duracion((select da_fecha from detalle_alquiler where da_id=1),(select da_fecha from detalle_alquiler where da_id=1)+(select da_cantidad_dia from detalle_alquiler where da_id=1)),NULL,1,1);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=2),periodo_duracion((select da_fecha from detalle_alquiler where da_id=2),(select da_fecha from detalle_alquiler where da_id=2)+(select da_cantidad_dia from detalle_alquiler where da_id=2)),NULL,2,2);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=3),periodo_duracion((select da_fecha from detalle_alquiler where da_id=3),(select da_fecha from detalle_alquiler where da_id=3)+(select da_cantidad_dia from detalle_alquiler where da_id=3)),NULL,3,2);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=4),periodo_duracion((select da_fecha from detalle_alquiler where da_id=4),(select da_fecha from detalle_alquiler where da_id=4)+(select da_cantidad_dia from detalle_alquiler where da_id=4)),NULL,4,2);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=5),periodo_duracion((select da_fecha from detalle_alquiler where da_id=5),(select da_fecha from detalle_alquiler where da_id=5)+(select da_cantidad_dia from detalle_alquiler where da_id=5)),NULL,5,2);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=6),periodo_duracion((select da_fecha from detalle_alquiler where da_id=6),(select da_fecha from detalle_alquiler where da_id=6)+(select da_cantidad_dia from detalle_alquiler where da_id=6)),NULL,6,2);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=7),periodo_duracion((select da_fecha from detalle_alquiler where da_id=7),(select da_fecha from detalle_alquiler where da_id=7)+(select da_cantidad_dia from detalle_alquiler where da_id=7)),NULL,7,3);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=8),periodo_duracion((select da_fecha from detalle_alquiler where da_id=8),(select da_fecha from detalle_alquiler where da_id=8)+(select da_cantidad_dia from detalle_alquiler where da_id=8)),NULL,8,3);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=9),periodo_duracion((select da_fecha from detalle_alquiler where da_id=9),(select da_fecha from detalle_alquiler where da_id=9)+(select da_cantidad_dia from detalle_alquiler where da_id=9)),NULL,9,3);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=10),periodo_duracion((select da_fecha from detalle_alquiler where da_id=10),(select da_fecha from detalle_alquiler where da_id=10)+(select da_cantidad_dia from detalle_alquiler where da_id=10)),NULL,10,4);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=11),periodo_duracion((select da_fecha from detalle_alquiler where da_id=11),(select da_fecha from detalle_alquiler where da_id=11)+(select da_cantidad_dia from detalle_alquiler where da_id=11)),NULL,11,4);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=12),periodo_duracion((select da_fecha from detalle_alquiler where da_id=12),(select da_fecha from detalle_alquiler where da_id=12)+(select da_cantidad_dia from detalle_alquiler where da_id=12)),NULL,12,4);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=13),periodo_duracion((select da_fecha from detalle_alquiler where da_id=13),(select da_fecha from detalle_alquiler where da_id=13)+(select da_cantidad_dia from detalle_alquiler where da_id=13)),NULL,13,5);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=14),periodo_duracion((select da_fecha from detalle_alquiler where da_id=14),(select da_fecha from detalle_alquiler where da_id=14)+(select da_cantidad_dia from detalle_alquiler where da_id=14)),NULL,14,5);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=15),periodo_duracion((select da_fecha from detalle_alquiler where da_id=15),(select da_fecha from detalle_alquiler where da_id=15)+(select da_cantidad_dia from detalle_alquiler where da_id=15)),NULL,15,5);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=16),periodo_duracion((select da_fecha from detalle_alquiler where da_id=16),(select da_fecha from detalle_alquiler where da_id=16)+(select da_cantidad_dia from detalle_alquiler where da_id=16)),NULL,16,6);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=17),periodo_duracion((select da_fecha from detalle_alquiler where da_id=17),(select da_fecha from detalle_alquiler where da_id=17)+(select da_cantidad_dia from detalle_alquiler where da_id=17)),NULL,17,7);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=18),periodo_duracion((select da_fecha from detalle_alquiler where da_id=18),(select da_fecha from detalle_alquiler where da_id=18)+(select da_cantidad_dia from detalle_alquiler where da_id=18)),NULL,18,8);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=19),periodo_duracion((select da_fecha from detalle_alquiler where da_id=19),(select da_fecha from detalle_alquiler where da_id=19)+(select da_cantidad_dia from detalle_alquiler where da_id=19)),NULL,19,9);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=20),periodo_duracion((select da_fecha from detalle_alquiler where da_id=20),(select da_fecha from detalle_alquiler where da_id=20)+(select da_cantidad_dia from detalle_alquiler where da_id=20)),NULL,20,10);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=21),periodo_duracion((select da_fecha from detalle_alquiler where da_id=21),(select da_fecha from detalle_alquiler where da_id=21)+(select da_cantidad_dia from detalle_alquiler where da_id=21)),NULL,21,16);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=22),periodo_duracion((select da_fecha from detalle_alquiler where da_id=22),(select da_fecha from detalle_alquiler where da_id=22)+(select da_cantidad_dia from detalle_alquiler where da_id=22)),NULL,22,17);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=23),periodo_duracion((select da_fecha from detalle_alquiler where da_id=23),(select da_fecha from detalle_alquiler where da_id=23)+(select da_cantidad_dia from detalle_alquiler where da_id=23)),NULL,23,18);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=24),periodo_duracion((select da_fecha from detalle_alquiler where da_id=24),(select da_fecha from detalle_alquiler where da_id=24)+(select da_cantidad_dia from detalle_alquiler where da_id=24)),NULL,24,19);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=25),periodo_duracion((select da_fecha from detalle_alquiler where da_id=25),(select da_fecha from detalle_alquiler where da_id=25)+(select da_cantidad_dia from detalle_alquiler where da_id=25)),NULL,25,19);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=26),periodo_duracion((select da_fecha from detalle_alquiler where da_id=26),(select da_fecha from detalle_alquiler where da_id=26)+(select da_cantidad_dia from detalle_alquiler where da_id=26)),NULL,26,19);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=27),periodo_duracion((select da_fecha from detalle_alquiler where da_id=27),(select da_fecha from detalle_alquiler where da_id=27)+(select da_cantidad_dia from detalle_alquiler where da_id=27)),NULL,27,20);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=28),periodo_duracion((select da_fecha from detalle_alquiler where da_id=28),(select da_fecha from detalle_alquiler where da_id=28)+(select da_cantidad_dia from detalle_alquiler where da_id=28)),NULL,28,20);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=29),periodo_duracion((select da_fecha from detalle_alquiler where da_id=29),(select da_fecha from detalle_alquiler where da_id=29)+(select da_cantidad_dia from detalle_alquiler where da_id=29)),NULL,29,20);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=30),periodo_duracion((select da_fecha from detalle_alquiler where da_id=30),(select da_fecha from detalle_alquiler where da_id=30)+(select da_cantidad_dia from detalle_alquiler where da_id=30)),NULL,30,20);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=31),periodo_duracion((select da_fecha from detalle_alquiler where da_id=31),(select da_fecha from detalle_alquiler where da_id=31)+(select da_cantidad_dia from detalle_alquiler where da_id=31)),NULL,31,20);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=32),periodo_duracion((select da_fecha from detalle_alquiler where da_id=32),(select da_fecha from detalle_alquiler where da_id=32)+(select da_cantidad_dia from detalle_alquiler where da_id=32)),NULL,32,11);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=33),periodo_duracion((select da_fecha from detalle_alquiler where da_id=33),(select da_fecha from detalle_alquiler where da_id=33)+(select da_cantidad_dia from detalle_alquiler where da_id=33)),NULL,33,12);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=34),periodo_duracion((select da_fecha from detalle_alquiler where da_id=34),(select da_fecha from detalle_alquiler where da_id=34)+(select da_cantidad_dia from detalle_alquiler where da_id=34)),NULL,34,13);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=35),periodo_duracion((select da_fecha from detalle_alquiler where da_id=35),(select da_fecha from detalle_alquiler where da_id=35)+(select da_cantidad_dia from detalle_alquiler where da_id=35)),NULL,35,14);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=36),periodo_duracion((select da_fecha from detalle_alquiler where da_id=36),(select da_fecha from detalle_alquiler where da_id=36)+(select da_cantidad_dia from detalle_alquiler where da_id=36)),NULL,36,14);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=37),periodo_duracion((select da_fecha from detalle_alquiler where da_id=37),(select da_fecha from detalle_alquiler where da_id=37)+(select da_cantidad_dia from detalle_alquiler where da_id=37)),NULL,37,14);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=38),periodo_duracion((select da_fecha from detalle_alquiler where da_id=38),(select da_fecha from detalle_alquiler where da_id=38)+(select da_cantidad_dia from detalle_alquiler where da_id=38)),NULL,38,15);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=39),periodo_duracion((select da_fecha from detalle_alquiler where da_id=39),(select da_fecha from detalle_alquiler where da_id=39)+(select da_cantidad_dia from detalle_alquiler where da_id=39)),NULL,39,15);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=40),periodo_duracion((select da_fecha from detalle_alquiler where da_id=40),(select da_fecha from detalle_alquiler where da_id=40)+(select da_cantidad_dia from detalle_alquiler where da_id=40)),NULL,40,15);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=41),periodo_duracion((select da_fecha from detalle_alquiler where da_id=41),(select da_fecha from detalle_alquiler where da_id=41)+(select da_cantidad_dia from detalle_alquiler where da_id=41)),NULL,41,15);
insert into alquiler values (default,(select da_precio_diario*da_cantidad_dia from detalle_alquiler where da_id=42),periodo_duracion((select da_fecha from detalle_alquiler where da_id=42),(select da_fecha from detalle_alquiler where da_id=42)+(select da_cantidad_dia from detalle_alquiler where da_id=42)),NULL,42,15);

--insert de ratings--
insert into rating values (default,TO_DATE('2023-05-25','yyyy-MM-dd'),5,5,3);
insert into rating values (default,TO_DATE('2023-04-24','yyyy-MM-dd'),4,5,4);
insert into rating values (default,TO_DATE('2023-03-15','yyyy-MM-dd'),5,5,5);
insert into rating values (default,TO_DATE('2023-02-04','yyyy-MM-dd'),3,5,6);
insert into rating values (default,TO_DATE('2023-03-27','yyyy-MM-dd'),5,5,8);
insert into rating values (default,TO_DATE('2023-01-13','yyyy-MM-dd'),5,5,9);
insert into rating values (default,TO_DATE('2023-04-06','yyyy-MM-dd'),4,5,11);
insert into rating values (default,TO_DATE('2022-12-09','yyyy-MM-dd'),4,5,12);
insert into rating values (default,TO_DATE('2023-03-28','yyyy-MM-dd'),5,5,14);
insert into rating values (default,TO_DATE('2022-10-28','yyyy-MM-dd'),3,5,15);
insert into rating values (default,TO_DATE('2023-04-27','yyyy-MM-dd'),4,5,18);
insert into rating values (default,TO_DATE('2023-05-30','yyyy-MM-dd'),5,5,23);
insert into rating values (default,TO_DATE('2023-05-14','yyyy-MM-dd'),4,5,25);
insert into rating values (default,TO_DATE('2023-04-06','yyyy-MM-dd'),3,5,26);
insert into rating values (default,TO_DATE('2023-03-15','yyyy-MM-dd'),5,5,28);
insert into rating values (default,TO_DATE('2022-12-05','yyyy-MM-dd'),4,5,29);
insert into rating values (default,TO_DATE('2022-09-05','yyyy-MM-dd'),5,5,30);
insert into rating values (default,TO_DATE('2022-07-02','yyyy-MM-dd'),2,5,31);
insert into rating values (default,TO_DATE('2023-05-30','yyyy-MM-dd'),4,5,34);
insert into rating values (default,TO_DATE('2023-05-14','yyyy-MM-dd'),5,5,36);
insert into rating values (default,TO_DATE('2023-04-06','yyyy-MM-dd'),5,5,37);
insert into rating values (default,TO_DATE('2023-03-15','yyyy-MM-dd'),3,5,39);
insert into rating values (default,TO_DATE('2022-12-05','yyyy-MM-dd'),5,5,40);
insert into rating values (default,TO_DATE('2022-09-05','yyyy-MM-dd'),5,5,41);
insert into rating values (default,TO_DATE('2022-07-02','yyyy-MM-dd'),4,5,42);

insert into observacion values (default,'Excelente atencion',1);
insert into observacion values (default,'Buena atencion pero el vehiculo sin aire',4);
insert into observacion values (default,'Vehiculo bien cuidado',9);
insert into observacion values (default,'Vino con un rayon en la puerta del copiloto',10);
insert into observacion values (default,'Excelente atencion',15);
insert into observacion values (default,'Tuve que mandar el carro al taller dos veces',18);
insert into observacion values (default,'No tiene la potencia del motor original',22);
insert into observacion values (default,'Muy buen servicio, carro impecable',24);

/*
---insert vehiculo
insert into vehiculo values ('AB169DA',2014,EMPTY_BLOB(),12662,56,(select m_id from modelo where m_nombre='Camry'),(select marca_ma_id from modelo where m_nombre='Camry'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),1);
insert into vehiculo values ('AS841JG',2014,EMPTY_BLOB(),11137,56,(select m_id from modelo where m_nombre='Corolla'),(select marca_ma_id from modelo where m_nombre='Corolla'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),1);
insert into vehiculo values ('AK183NS',2013,EMPTY_BLOB(),10773,54,(select m_id from modelo where m_nombre='Sentra'),(select marca_ma_id from modelo where m_nombre='Sentra'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),1);
insert into vehiculo values ('AA931SJ',2015,EMPTY_BLOB(),8763,50,(select m_id from modelo where m_nombre='Yaris'),(select marca_ma_id from modelo where m_nombre='Yaris'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Azul'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),1);
insert into vehiculo values ('AI855MC',2013,EMPTY_BLOB(),11225,48,(select m_id from modelo where m_nombre='Murano'),(select marca_ma_id from modelo where m_nombre='Murano'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),1);
insert into vehiculo values ('AD558SD',2012,EMPTY_BLOB(),16251,54,(select m_id from modelo where m_nombre='Sportage'),(select marca_ma_id from modelo where m_nombre='Sportage'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),1);
insert into vehiculo values ('AO773NN',2013,EMPTY_BLOB(),14251,55,(select m_id from modelo where m_nombre='Sportage'),(select marca_ma_id from modelo where m_nombre='Sportage'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Negro'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),1);
insert into vehiculo values ('AW834JM',2016,EMPTY_BLOB(),8836,60,(select m_id from modelo where m_nombre='Elantra'),(select marca_ma_id from modelo where m_nombre='Elantra'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Azul'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),1);
insert into vehiculo values ('AU923NL',2014,EMPTY_BLOB(),9682,120,(select m_id from modelo where m_nombre='Duster'),(select marca_ma_id from modelo where m_nombre='Duster'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Dorado'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),1);
insert into vehiculo values ('AA126FB',2013,EMPTY_BLOB(),13985,115,(select m_id from modelo where m_nombre='Cherokee'),(select marca_ma_id from modelo where m_nombre='Cherokee'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Dorado'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),1);
insert into vehiculo values ('AR228BD',2017,EMPTY_BLOB(),9223,125,(select m_id from modelo where m_nombre='Hilux'),(select marca_ma_id from modelo where m_nombre='Hilux'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),2);
insert into vehiculo values ('AC824MD',2018,EMPTY_BLOB(),4391,36,(select m_id from modelo where m_nombre='Megane'),(select marca_ma_id from modelo where m_nombre='Megane'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Negro'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AE119ZB',2017,EMPTY_BLOB(),4296,40,(select m_id from modelo where m_nombre='Palio'),(select marca_ma_id from modelo where m_nombre='Palio'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Verde'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AF237ML',2012,EMPTY_BLOB(),8519,50,(select m_id from modelo where m_nombre='XC90'),(select marca_ma_id from modelo where m_nombre='XC90'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);


insert into vehiculo values ('AA999TF',2015,EMPTY_BLOB(),37754,48,(select m_id from modelo where m_nombre='Rio'),(select marca_ma_id from modelo where m_nombre='Rio'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Negro'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AI646FO',2014,EMPTY_BLOB(),48754,45,(select m_id from modelo where m_nombre='Picanto'),(select marca_ma_id from modelo where m_nombre='Picanto'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Negro'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AB123SP',2015,EMPTY_BLOB(),27345,48,(select m_id from modelo where m_nombre='Sportage'),(select marca_ma_id from modelo where m_nombre='Sportage'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AO747KN',2016,EMPTY_BLOB(),18251,50,(select m_id from modelo where m_nombre='Corolla'),(select marca_ma_id from modelo where m_nombre='Corolla'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AN723ER',2015,EMPTY_BLOB(),38498,50,(select m_id from modelo where m_nombre='Corolla'),(select marca_ma_id from modelo where m_nombre='Corolla'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Blanco'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AA129KD',2017,EMPTY_BLOB(),26518,54,(select m_id from modelo where m_nombre='Camry'),(select marca_ma_id from modelo where m_nombre='Camry'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AT262MN',2016,EMPTY_BLOB(),48251,130,(select m_id from modelo where m_nombre='Fortuner'),(select marca_ma_id from modelo where m_nombre='Fortuner'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Gris'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),3);
insert into vehiculo values ('AS884SG',2015,EMPTY_BLOB(),49027,120,(select m_id from modelo where m_nombre='Hilux'),(select marca_ma_id from modelo where m_nombre='Hilux'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),3);
insert into vehiculo values ('AA192DK',2018,EMPTY_BLOB(),16131,50,(select m_id from modelo where m_nombre='Aveo'),(select marca_ma_id from modelo where m_nombre='Aveo'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AI912DV',2018,EMPTY_BLOB(),25648,48,(select m_id from modelo where m_nombre='Optra'),(select marca_ma_id from modelo where m_nombre='Optra'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AT619OV',2017,EMPTY_BLOB(),38251,45,(select m_id from modelo where m_nombre='Spark'),(select marca_ma_id from modelo where m_nombre='Spark'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Azul'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AJ128MA',2014,EMPTY_BLOB(),40015,42,(select m_id from modelo where m_nombre='Scala'),(select marca_ma_id from modelo where m_nombre='Scala'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Verde'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AV389HC',2015,EMPTY_BLOB(),40195,42,(select m_id from modelo where m_nombre='Fabia'),(select marca_ma_id from modelo where m_nombre='Fabia'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Marron'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AM824SH',2014,EMPTY_BLOB(),49542,42,(select m_id from modelo where m_nombre='Kodiaq'),(select marca_ma_id from modelo where m_nombre='Kodiaq'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Gris'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AJ387IN',2014,EMPTY_BLOB(),38462,55,(select m_id from modelo where m_nombre='Outback'),(select marca_ma_id from modelo where m_nombre='Outback'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Gris'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),3);
insert into vehiculo values ('AO433GB',2014,EMPTY_BLOB(),33461,50,(select m_id from modelo where m_nombre='Impreza'),(select marca_ma_id from modelo where m_nombre='Impreza'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Azul'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AZ700FO',2015,EMPTY_BLOB(),41956,55,(select m_id from modelo where m_nombre='Legacy'),(select marca_ma_id from modelo where m_nombre='Legacy'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Negro'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AT074RI',2016,EMPTY_BLOB(),32645,50,(select m_id from modelo where m_nombre='Siena'),(select marca_ma_id from modelo where m_nombre='Siena'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Azul'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AH698TV',2014,EMPTY_BLOB(),49562,45,(select m_id from modelo where m_nombre='Palio'),(select marca_ma_id from modelo where m_nombre='Palio'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AR610AB',2015,EMPTY_BLOB(),41653,46,(select m_id from modelo where m_nombre='Uno'),(select marca_ma_id from modelo where m_nombre='Uno'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AE230CA',2018,EMPTY_BLOB(),21156,54,(select m_id from modelo where m_nombre='Accent'),(select marca_ma_id from modelo where m_nombre='Accent'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Blanco'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AJ447AP',2017,EMPTY_BLOB(),28796,52,(select m_id from modelo where m_nombre='Elantra'),(select marca_ma_id from modelo where m_nombre='Elantra'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),3);
insert into vehiculo values ('AG406IU',2017,EMPTY_BLOB(),35616,124,(select m_id from modelo where m_nombre='SantaFe'),(select marca_ma_id from modelo where m_nombre='SantaFe'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Dorado'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),3);
insert into vehiculo values ('AN843BC',2019,EMPTY_BLOB(),19989,140,(select m_id from modelo where m_nombre='Tucson'),(select marca_ma_id from modelo where m_nombre='Tucson'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),3);

insert into vehiculo values ('AC888ZR',2015,EMPTY_BLOB(),37754,48,(select m_id from modelo where m_nombre='Rio'),(select marca_ma_id from modelo where m_nombre='Rio'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Negro'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AL311JC',2014,EMPTY_BLOB(),48754,45,(select m_id from modelo where m_nombre='Picanto'),(select marca_ma_id from modelo where m_nombre='Picanto'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Negro'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AA174OS',2015,EMPTY_BLOB(),27345,48,(select m_id from modelo where m_nombre='Rio'),(select marca_ma_id from modelo where m_nombre='Sportage'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AK760OA',2016,EMPTY_BLOB(),18251,50,(select m_id from modelo where m_nombre='Corolla'),(select marca_ma_id from modelo where m_nombre='Corolla'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AD630QM',2015,EMPTY_BLOB(),38498,50,(select m_id from modelo where m_nombre='Corolla'),(select marca_ma_id from modelo where m_nombre='Corolla'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Blanco'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AR510ZI',2017,EMPTY_BLOB(),26518,54,(select m_id from modelo where m_nombre='Camry'),(select marca_ma_id from modelo where m_nombre='Camry'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AF214UC',2016,EMPTY_BLOB(),48251,130,(select m_id from modelo where m_nombre='Hilux'),(select marca_ma_id from modelo where m_nombre='Hilux'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Gris'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),2);
insert into vehiculo values ('AW795CG',2015,EMPTY_BLOB(),49027,120,(select m_id from modelo where m_nombre='Hilux'),(select marca_ma_id from modelo where m_nombre='Hilux'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),2);
insert into vehiculo values ('AZ109WH',2018,EMPTY_BLOB(),16131,50,(select m_id from modelo where m_nombre='Aveo'),(select marca_ma_id from modelo where m_nombre='Aveo'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AA619PH',2018,EMPTY_BLOB(),25648,48,(select m_id from modelo where m_nombre='Optra'),(select marca_ma_id from modelo where m_nombre='Optra'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AP233MP',2017,EMPTY_BLOB(),38251,45,(select m_id from modelo where m_nombre='Spark'),(select marca_ma_id from modelo where m_nombre='Spark'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Azul'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AP282ZP',2014,EMPTY_BLOB(),40015,42,(select m_id from modelo where m_nombre='Lancer'),(select marca_ma_id from modelo where m_nombre='Lancer'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Verde'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AC651PJ',2015,EMPTY_BLOB(),40195,42,(select m_id from modelo where m_nombre='Signo'),(select marca_ma_id from modelo where m_nombre='Signo'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Marron'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AF545WC',2014,EMPTY_BLOB(),49542,42,(select m_id from modelo where m_nombre='Pajero'),(select marca_ma_id from modelo where m_nombre='Pajero'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Gris'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AU552UV',2014,EMPTY_BLOB(),38462,55,(select m_id from modelo where m_nombre='Outback'),(select marca_ma_id from modelo where m_nombre='Outback'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Gris'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),2);
insert into vehiculo values ('AE043AN',2014,EMPTY_BLOB(),33461,50,(select m_id from modelo where m_nombre='Impreza'),(select marca_ma_id from modelo where m_nombre='Impreza'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Azul'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AZ631RT',2015,EMPTY_BLOB(),41956,55,(select m_id from modelo where m_nombre='Legacy'),(select marca_ma_id from modelo where m_nombre='Legacy'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Negro'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AZ989AF',2016,EMPTY_BLOB(),32645,50,(select m_id from modelo where m_nombre='Siena'),(select marca_ma_id from modelo where m_nombre='Siena'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Azul'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AL110GH',2014,EMPTY_BLOB(),49562,45,(select m_id from modelo where m_nombre='Palio'),(select marca_ma_id from modelo where m_nombre='Palio'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AH784AK',2015,EMPTY_BLOB(),41653,46,(select m_id from modelo where m_nombre='Uno'),(select marca_ma_id from modelo where m_nombre='Uno'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AI040AA',2018,EMPTY_BLOB(),21156,54,(select m_id from modelo where m_nombre='Accent'),(select marca_ma_id from modelo where m_nombre='Accent'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Blanco'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AH224TS',2017,EMPTY_BLOB(),28796,52,(select m_id from modelo where m_nombre='Elantra'),(select marca_ma_id from modelo where m_nombre='Elantra'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Rojo'),(select tv_id from tipo_vehiculo where tv_nombre='Carro'),2);
insert into vehiculo values ('AS996WN',2017,EMPTY_BLOB(),35616,124,(select m_id from modelo where m_nombre='SantaFe'),(select marca_ma_id from modelo where m_nombre='SantaFe'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Dorado'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),2);
insert into vehiculo values ('AI766EO',2019,EMPTY_BLOB(),19989,140,(select m_id from modelo where m_nombre='Tucson'),(select marca_ma_id from modelo where m_nombre='Tucson'),(select sv_id from status_vehiculo where sv_nombre='Disponible'),(select c_id from color where c_nombre='Plateado'),(select tv_id from tipo_vehiculo where tv_nombre='Camioneta'),2);
*/

execute PK_Vehiculo.I_Vehiculo('camry.jpeg','AB169DA',2014,12662,56,'Camry','Disponible','Plateado','Carro',1);
execute PK_Vehiculo.I_Vehiculo('corolla.jpeg','AA931SJ',2014,11137,56,'Corolla','Disponible','Plateado','Carro',1);
execute PK_Vehiculo.I_Vehiculo('sentra.jpeg','AK183NS',2013,10773,54,'Sentra','Disponible','Plateado','Carro',1);
execute PK_Vehiculo.I_Vehiculo('yaris.jpeg','AA931SJ',2015,8763,50,'Yaris','Disponible','Azul','Carro',1);
execute PK_Vehiculo.I_Vehiculo('murano.jpeg','AI855MC',2013,11225,48,'Murano','Disponible','Rojo','Carro',1);
execute PK_Vehiculo.I_Vehiculo('sportage.jpeg','AD558SD',2012,16251,54,'Sportage','Disponible','Rojo','Carro',1);
execute PK_Vehiculo.I_Vehiculo('sportage.jpeg','AO773NN',2013,14251,55,'Sportage','Disponible','Negro','Carro',1);
execute PK_Vehiculo.I_Vehiculo('elantra.jpeg','AW834JM',2016,8836,60,'Elantra','Disponible','Azul','Carro',1);
execute PK_Vehiculo.I_Vehiculo('duster.jpeg','AU923NL',2014,9682,120,'Duster','Disponible','Dorado','Camioneta',1);
execute PK_Vehiculo.I_Vehiculo('cherokee.jpeg','AA126FB',2013,13985,115,'Cherokee','Disponible','Dorado','Camioneta',1);
execute PK_Vehiculo.I_Vehiculo('hilux.jpeg','AR228BD',2017,9223,125,'Hilux','Disponible','Plateado','Camioneta',1);
execute PK_Vehiculo.I_Vehiculo('megane.jpeg','AC824MD',2018,4391,36,'Megane','Disponible','Negro','Carro',1);
execute PK_Vehiculo.I_Vehiculo('palio.jpeg','AE119ZB',2017,4296,40,'Palio','Disponible','Verde','Carro',1);
execute PK_Vehiculo.I_Vehiculo('xc90.jpeg','AF237ML',2012,8519,50,'XC90','Disponible','Plateado','Carro',1);

execute PK_Vehiculo.I_Vehiculo('rio.jpeg','AA999TF',2015,37754,48,'Rio','Disponible','Negro','Carro',3);
execute PK_Vehiculo.I_Vehiculo('picanto.jpeg','AI646FO',2014,48754,45,'Picanto','Disponible','Negro','Carro',3);
execute PK_Vehiculo.I_Vehiculo('sportage.jpeg','AB123SP',2015,27345,48,'Sportage','Disponible','Plateado','Carro',3);
execute PK_Vehiculo.I_Vehiculo('corolla.jpeg','AO747KN',2016,18251,50,'Corolla','Disponible','Plateado','Carro',3);
execute PK_Vehiculo.I_Vehiculo('corolla.jpeg','AN723ER',2015,38498,50,'Corolla','Disponible','Blanco','Carro',3);
execute PK_Vehiculo.I_Vehiculo('camry.jpeg','AA129KD',2017,26518,54,'Camry','Disponible','Plateado','Carro',3);
execute PK_Vehiculo.I_Vehiculo('fortuner.jpeg','AT262MN',2016,48251,130,'Fortuner','Disponible','Gris','Camioneta',3);
execute PK_Vehiculo.I_Vehiculo('hilux.jpeg','AS884SG',2015,49027,120,'Hilux','Disponible','Plateado','Camioneta',3);
execute PK_Vehiculo.I_Vehiculo('aveo.jpeg','AA192DK',2018,16131,50,'Aveo','Disponible','Rojo','Carro',3);
execute PK_Vehiculo.I_Vehiculo('optra.jpeg','AI912DV',2018,25648,48,'Optra','Disponible','Rojo','Carro',3);
execute PK_Vehiculo.I_Vehiculo('spark.jpeg','AT619OV',2017,38251,45,'Spark','Disponible','Azul','Carro',3);
execute PK_Vehiculo.I_Vehiculo('scala.jpeg','AJ128MA',2014,40015,42,'Scala','Disponible','Verde','Carro',3);
execute PK_Vehiculo.I_Vehiculo('fabia.jpeg','AV389HC',2015,40195,42,'Fabia','Disponible','Marron','Carro',3);
execute PK_Vehiculo.I_Vehiculo('kodiaq.jpeg','AM824SH',2014,49542,100,'Kodiaq','Disponible','Gris','Camioneta',3);
execute PK_Vehiculo.I_Vehiculo('outback.jpeg','AJ387IN',2014,38462,135,'Outback','Disponible','Gris','Camioneta',3);
execute PK_Vehiculo.I_Vehiculo('impreza.jpeg','AO433GB',2014,33461,50,'Impreza','Disponible','Azul','Carro',3);
execute PK_Vehiculo.I_Vehiculo('legacy.jpeg','AZ700FO',2015,41956,55,'Legacy','Disponible','Negro','Carro',3);
execute PK_Vehiculo.I_Vehiculo('siena.jpeg','AT074RI',2016,32645,50,'Siena','Disponible','Azul','Carro',3);
execute PK_Vehiculo.I_Vehiculo('palio.jpeg','AH698TV',2014,49562,45,'Palio','Disponible','Rojo','Carro',3);
execute PK_Vehiculo.I_Vehiculo('uno.jpeg','AR610AB',2015,41653,30,'Uno','Disponible','Rojo','Carro',3);
execute PK_Vehiculo.I_Vehiculo('accent.jpeg','AE230CA',2018,21156,54,'Accent','Disponible','Blanco','Carro',3);
execute PK_Vehiculo.I_Vehiculo('elantra.jpeg','AJ447AP',2017,28796,52,'Elantra','Disponible','Rojo','Carro',3);
execute PK_Vehiculo.I_Vehiculo('santafe.jpeg','AG406IU',2017,35616,124,'SantaFe','Disponible','Dorado','Camioneta',3);
execute PK_Vehiculo.I_Vehiculo('tucson.jpeg','AN843BC',2019,19989,140,'Tucson','Disponible','Plateado','Camioneta',3);

execute PK_Vehiculo.I_Vehiculo('rio.jpeg','AC888ZR',2015,37754,48,'Rio','Disponible','Negro','Carro',2);
execute PK_Vehiculo.I_Vehiculo('picanto.jpeg','AL311JC',2014,48754,45,'Picanto','Disponible','Negro','Carro',2);
execute PK_Vehiculo.I_Vehiculo('rio.jpeg','AA174OS',2015,27345,48,'Rio','Disponible','Plateado','Carro',2);
execute PK_Vehiculo.I_Vehiculo('corolla.jpeg','AK760OA',2016,18251,50,'Corolla','Disponible','Plateado','Carro',2);
execute PK_Vehiculo.I_Vehiculo('corolla.jpeg','AD630QM',2015,38498,50,'Corolla','Disponible','Blanco','Carro',2);
execute PK_Vehiculo.I_Vehiculo('camry.jpeg','AR510ZI',2017,26518,54,'Camry','Disponible','Plateado','Carro',2);
execute PK_Vehiculo.I_Vehiculo('hilux.jpeg','AF214UC',2016,48251,130,'Hilux','Disponible','Gris','Camioneta',2);
execute PK_Vehiculo.I_Vehiculo('hilux.jpeg','AW795CG',2015,49027,120,'Hilux','Disponible','Plateado','Camioneta',2);
execute PK_Vehiculo.I_Vehiculo('aveo.jpeg','AZ109WH',2018,16131,50,'Aveo','Disponible','Rojo','Carro',2);
execute PK_Vehiculo.I_Vehiculo('optra.jpeg','AA619PH',2018,25648,48,'Optra','Disponible','Rojo','Carro',2);
execute PK_Vehiculo.I_Vehiculo('spark.jpeg','AP233MP',2017,38251,45,'Spark','Disponible','Azul','Carro',2);
execute PK_Vehiculo.I_Vehiculo('lancer.jpeg','AP282ZP',2014,40015,42,'Lancer','Disponible','Verde','Carro',2);
execute PK_Vehiculo.I_Vehiculo('signo.jpeg','AC651PJ',2015,40195,42,'Signo','Disponible','Marron','Carro',2);
execute PK_Vehiculo.I_Vehiculo('pajero.jpeg','AF545WC',2014,49542,128,'Pajero','Disponible','Gris','Camioneta',2);
execute PK_Vehiculo.I_Vehiculo('outback.jpeg','AU552UV',2014,38462,55,'Outback','Disponible','Gris','Camioneta',2);
execute PK_Vehiculo.I_Vehiculo('impreza.jpeg','AE043AN',2014,33461,50,'Impreza','Disponible','Azul','Carro',2);
execute PK_Vehiculo.I_Vehiculo('legacy.jpeg','AZ631RT',2015,41956,55,'Legacy','Disponible','Negro','Carro',2);
execute PK_Vehiculo.I_Vehiculo('siena.jpeg','AZ989AF',2016,32645,50,'Siena','Disponible','Azul','Carro',2);
execute PK_Vehiculo.I_Vehiculo('palio.jpeg','AL110GH',2014,49562,45,'Palio','Disponible','Rojo','Carro',2);
execute PK_Vehiculo.I_Vehiculo('uno.jpeg','AH784AK',2015,41653,46,'Uno','Disponible','Rojo','Carro',2);
execute PK_Vehiculo.I_Vehiculo('accent.jpeg','AI040AA',2018,21156,54,'Accent','Disponible','Blanco','Carro',2);
execute PK_Vehiculo.I_Vehiculo('elantra.jpeg','AH224TS',2017,28796,52,'Elantra','Disponible','Rojo','Carro',2);
execute PK_Vehiculo.I_Vehiculo('santafe.jpeg','AS996WN',2017,35616,124,'SantaFe','Disponible','Dorado','Camioneta',2);
execute PK_Vehiculo.I_Vehiculo('tucson.jpeg','AI766EO',2019,19989,140,'Tucson','Disponible','Plateado','Camioneta',2);


--insert mantenimiento veh

insert into mantenimiento_vehiculo values (default
                                            ,periodo_duracion(TO_DATE('2023-03-22','yyyy-MM-dd')
                                                                ,TO_DATE('2023-03-23','yyyy-MM-dd'))
                                            ,TO_DATE('2023-06-22','yyyy-MM-dd')
                                            ,40
                                            ,'AB169DA'
                                            ,(SELECT s_id from status_mantenimiento where s_nombre='Finalizado')
                                            ,(SELECT mt_id 
                                                from mantenimiento_taller 
                                               where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0)
                                                 and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 3 Hermanos')
                                              ));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-12-22','yyyy-MM-dd'),TO_DATE('2022-12-23','yyyy-MM-dd')),TO_DATE('2023-03-22','yyyy-MM-dd'),40,'AB169DA',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 3 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-09-22','yyyy-MM-dd'),TO_DATE('2022-09-23','yyyy-MM-dd')),TO_DATE('2022-12-22','yyyy-MM-dd'),40,'AB169DA',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 3 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-06-22','yyyy-MM-dd'),TO_DATE('2022-06-23','yyyy-MM-dd')),TO_DATE('2022-09-22','yyyy-MM-dd'),40,'AB169DA',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 3 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-03-22','yyyy-MM-dd'),TO_DATE('2022-03-23','yyyy-MM-dd')),TO_DATE('2022-06-22','yyyy-MM-dd'),40,'AB169DA',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 3 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-02-22','yyyy-MM-dd'),TO_DATE('2023-02-23','yyyy-MM-dd')),TO_DATE('2023-05-22','yyyy-MM-dd'),40,'AK183NS',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 3 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-11-22','yyyy-MM-dd'),TO_DATE('2022-11-23','yyyy-MM-dd')),TO_DATE('2023-02-22','yyyy-MM-dd'),40,'AK183NS',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 3 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-08-22','yyyy-MM-dd'),TO_DATE('2022-08-23','yyyy-MM-dd')),TO_DATE('2022-11-22','yyyy-MM-dd'),40,'AK183NS',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 3 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-05-22','yyyy-MM-dd'),TO_DATE('2022-05-23','yyyy-MM-dd')),TO_DATE('2022-08-22','yyyy-MM-dd'),40,'AK183NS',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 3 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-02-22','yyyy-MM-dd'),TO_DATE('2022-02-23','yyyy-MM-dd')),TO_DATE('2022-05-22','yyyy-MM-dd'),40,'AK183NS',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 3 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-04-06','yyyy-MM-dd'),TO_DATE('2023-04-07','yyyy-MM-dd')),TO_DATE('2023-07-06','yyyy-MM-dd'),40,'AD558SD',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 4 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-01-06','yyyy-MM-dd'),TO_DATE('2023-01-07','yyyy-MM-dd')),TO_DATE('2023-04-06','yyyy-MM-dd'),40,'AD558SD',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 4 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-10-06','yyyy-MM-dd'),TO_DATE('2022-10-07','yyyy-MM-dd')),TO_DATE('2023-01-06','yyyy-MM-dd'),40,'AD558SD',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 4 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-07-06','yyyy-MM-dd'),TO_DATE('2022-07-07','yyyy-MM-dd')),TO_DATE('2022-10-06','yyyy-MM-dd'),40,'AD558SD',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 4 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-04-06','yyyy-MM-dd'),TO_DATE('2022-04-07','yyyy-MM-dd')),TO_DATE('2022-07-06','yyyy-MM-dd'),40,'AD558SD',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mis 4 Hermanos')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-04-02','yyyy-MM-dd'),TO_DATE('2023-04-03','yyyy-MM-dd')),TO_DATE('2023-07-02','yyyy-MM-dd'),40,'AW834JM',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Thunder Cars')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-01-02','yyyy-MM-dd'),TO_DATE('2023-01-03','yyyy-MM-dd')),TO_DATE('2023-04-02','yyyy-MM-dd'),40,'AW834JM',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Thunder Cars')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-10-02','yyyy-MM-dd'),TO_DATE('2022-10-03','yyyy-MM-dd')),TO_DATE('2023-01-02','yyyy-MM-dd'),40,'AW834JM',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Thunder Cars')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-07-02','yyyy-MM-dd'),TO_DATE('2022-07-03','yyyy-MM-dd')),TO_DATE('2022-10-02','yyyy-MM-dd'),40,'AW834JM',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Thunder Cars')));
--insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-04-02','yyyy-MM-dd'),TO_DATE('2022-04-03','yyyy-MM-dd')),TO_DATE('2022-07-02','yyyy-MM-dd'),40,'AW834JM',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0),(SELECT tipo_mantenimiento_tm_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0));

insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-02-17','yyyy-MM-dd'),TO_DATE('2023-02-17','yyyy-MM-dd')),TO_DATE('2023-05-17','yyyy-MM-dd'),20,'AA999TF',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mocar')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-11-17','yyyy-MM-dd'),TO_DATE('2022-11-17','yyyy-MM-dd')),TO_DATE('2023-02-17','yyyy-MM-dd'),20,'AA999TF',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mocar')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-08-17','yyyy-MM-dd'),TO_DATE('2022-08-17','yyyy-MM-dd')),TO_DATE('2022-11-17','yyyy-MM-dd'),20,'AA999TF',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mocar')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-05-17','yyyy-MM-dd'),TO_DATE('2022-05-17','yyyy-MM-dd')),TO_DATE('2022-08-17','yyyy-MM-dd'),20,'AA999TF',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Don Orlando')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-02-17','yyyy-MM-dd'),TO_DATE('2022-02-17','yyyy-MM-dd')),TO_DATE('2022-05-17','yyyy-MM-dd'),20,'AA999TF',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mocar')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-03-03','yyyy-MM-dd'),TO_DATE('2023-03-03','yyyy-MM-dd')),TO_DATE('2023-06-03','yyyy-MM-dd'),20,'AI646FO',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mocar')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-12-03','yyyy-MM-dd'),TO_DATE('2022-12-03','yyyy-MM-dd')),TO_DATE('2023-03-03','yyyy-MM-dd'),20,'AI646FO',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mocar')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-09-03','yyyy-MM-dd'),TO_DATE('2022-09-03','yyyy-MM-dd')),TO_DATE('2022-12-03','yyyy-MM-dd'),20,'AI646FO',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mocar')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2022-06-03','yyyy-MM-dd'),TO_DATE('2022-06-03','yyyy-MM-dd')),TO_DATE('2022-09-03','yyyy-MM-dd'),20,'AI646FO',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mocar')));
insert into mantenimiento_vehiculo values (default,periodo_duracion(TO_DATE('2023-03-03','yyyy-MM-dd'),TO_DATE('2022-03-03','yyyy-MM-dd')),TO_DATE('2022-06-03','yyyy-MM-dd'),20,'AI646FO',(SELECT s_id from status_mantenimiento where s_nombre='Finalizado'),(SELECT mt_id from mantenimiento_taller where mantenimiento_m_id=(SELECT m_id from mantenimiento where DBMS_LOB.instr(m_descripcion,'Cambio de aceite')>0) and taller_t_id=(SELECT t_id from taller where t_nombre='Mocar')));


insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-25917216'),
                                    informacion_personal.verificar_nombre_apellido('Jose'),
                                    informacion_personal.verificar_nombre_apellido('Andres'),
                                    informacion_personal.verificar_nombre_apellido('Gonzalez'),
                                    informacion_personal.verificar_nombre_apellido('Cardona'),
                                    informacion_personal.verificar_correo('jagcjagc@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('12-JUN-1993'),
                                    informacion_personal.verificar_sexo('M'),
                                    'direccion' 
                                    ),2400,1);
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-28846541'),
                                    informacion_personal.verificar_nombre_apellido('Andres'),
                                    informacion_personal.verificar_nombre_apellido('Jesus'),
                                    informacion_personal.verificar_nombre_apellido('Colina'),
                                    informacion_personal.verificar_nombre_apellido('Melendez'),
                                    informacion_personal.verificar_correo('ajcolina12@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('23-SEP-2000'),
                                    informacion_personal.verificar_sexo('M'),
                                    'direccion' 
                                    ),2400,1);        
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-27065111'),
                                    informacion_personal.verificar_nombre_apellido('Maria'),
                                    informacion_personal.verificar_nombre_apellido('Camila'),
                                    informacion_personal.verificar_nombre_apellido('Hernandez'),
                                    informacion_personal.verificar_nombre_apellido('Sojo'),
                                    informacion_personal.verificar_correo('star160300@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('16-MAR-2000'),
                                    informacion_personal.verificar_sexo('F'),
                                    'direccion' 
                                    ),2400,1);   
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-29456644'),
                                    informacion_personal.verificar_nombre_apellido('Daniel'),
                                    informacion_personal.verificar_nombre_apellido('Moises'),
                                    informacion_personal.verificar_nombre_apellido('Laddio'),
                                    informacion_personal.verificar_nombre_apellido('Perez'),
                                    informacion_personal.verificar_correo('bolocko23@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('23-AGO-2001'),
                                    informacion_personal.verificar_sexo('M'),
                                    'direccion' 
                                    ),2400,1);                      
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-19225468'),
                                    informacion_personal.verificar_nombre_apellido('Jesus'),
                                    informacion_personal.verificar_nombre_apellido('Ramiro'),
                                    informacion_personal.verificar_nombre_apellido('Gil'),
                                    informacion_personal.verificar_nombre_apellido('Gomez'),
                                    informacion_personal.verificar_correo('jregramiro@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('04-DEC-1986'),
                                    informacion_personal.verificar_sexo('M'),
                                    'direccion' 
                                    ),2400,1);               
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-5015122'),
                                    informacion_personal.verificar_nombre_apellido('Reina'),
                                    informacion_personal.verificar_nombre_apellido('Alma'),
                                    informacion_personal.verificar_nombre_apellido('Sepulveda'),
                                    informacion_personal.verificar_nombre_apellido('Rodriguez'),
                                    informacion_personal.verificar_correo('reinasepulveda@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('02-ENE-1959'),
                                    informacion_personal.verificar_sexo('F'),
                                    'direccion' 
                                    ),2400,1);    
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-13354684'),
                                    informacion_personal.verificar_nombre_apellido('Jairo'),
                                    informacion_personal.verificar_nombre_apellido('David'),
                                    informacion_personal.verificar_nombre_apellido('Tevez'),
                                    informacion_personal.verificar_nombre_apellido('Osuna'),
                                    informacion_personal.verificar_correo('jairodtevez@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('29-JUL-1981'),
                                    informacion_personal.verificar_sexo('M'),
                                    'direccion' 
                                    ),2400,1);
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-28446513'),
                                    informacion_personal.verificar_nombre_apellido('David'),
                                    informacion_personal.verificar_nombre_apellido('Arturo'),
                                    informacion_personal.verificar_nombre_apellido('La Riva'),
                                    informacion_personal.verificar_nombre_apellido('Hernandez'),
                                    informacion_personal.verificar_correo('davidlarivaa@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('06-OCT-2000'),
                                    informacion_personal.verificar_sexo('M'),
                                    'direccion' 
                                    ),2400,2);                                                                                                                                                                                                
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-29050613'),
                                    informacion_personal.verificar_nombre_apellido('Yonathan'),
                                    informacion_personal.verificar_nombre_apellido('Jose'),
                                    informacion_personal.verificar_nombre_apellido('Vazquez'),
                                    informacion_personal.verificar_nombre_apellido('Arias'),
                                    informacion_personal.verificar_correo('yonisoni56@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('31-MAY-2001'),
                                    informacion_personal.verificar_sexo('M'),
                                    'direccion' 
                                    ),2400,2);
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-27670971'),
                                    informacion_personal.verificar_nombre_apellido('Eduardo'),
                                    informacion_personal.verificar_nombre_apellido('Miguel'),
                                    informacion_personal.verificar_nombre_apellido('Consalvo'),
                                    informacion_personal.verificar_nombre_apellido('Perez'),
                                    informacion_personal.verificar_correo('educon001@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('08-SEP-2001'),
                                    informacion_personal.verificar_sexo('M'),
                                    'direccion' 
                                    ),2400,3);            
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-30005546'),
                                    informacion_personal.verificar_nombre_apellido('Valeria'),
                                    informacion_personal.verificar_nombre_apellido('Andreina'),
                                    informacion_personal.verificar_nombre_apellido('Matuzzi'),
                                    informacion_personal.verificar_nombre_apellido('Lopez'),
                                    informacion_personal.verificar_correo('valeeematuzzi@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('22-NOV-2002'),
                                    informacion_personal.verificar_sexo('F'),
                                    'direccion' 
                                    ),2400,3);           
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-22605655'),
                                    informacion_personal.verificar_nombre_apellido('Perla'),
                                    informacion_personal.verificar_nombre_apellido('Sofia'),
                                    informacion_personal.verificar_nombre_apellido('Davila'),
                                    informacion_personal.verificar_nombre_apellido('Ortiz'),
                                    informacion_personal.verificar_correo('perladavila@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('17-JAN-1994'),
                                    informacion_personal.verificar_sexo('F'),
                                    'direccion' 
                                    ),2400,3);                                                                                                                         
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-28879546'),
                                    informacion_personal.verificar_nombre_apellido('Manuel'),
                                    informacion_personal.verificar_nombre_apellido('Jose'),
                                    informacion_personal.verificar_nombre_apellido('Iribarren'),
                                    informacion_personal.verificar_nombre_apellido('Garcia'),
                                    informacion_personal.verificar_correo('iribarrengarcia@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('07-FEB-1999'),
                                    informacion_personal.verificar_sexo('M'),
                                    'direccion' 
                                    ),2400,3);                                    
insert into empleado values (default,informacion_personal(
                                    informacion_personal.verificar_cedula('V-29374855'),
                                    informacion_personal.verificar_nombre_apellido('Jose'),
                                    informacion_personal.verificar_nombre_apellido('Luis'),
                                    informacion_personal.verificar_nombre_apellido('Sanson'),
                                    informacion_personal.verificar_nombre_apellido('Ortega'),
                                    informacion_personal.verificar_correo('jsanson9191@gmail.com'),
                                    informacion_personal.verificar_fecha_nacimiento('05-OCT-1998'),
                                    informacion_personal.verificar_sexo('M'),
                                    'direccion' 
                                    ),2400,3);     
                                    
--  insert detalles de compras
insert into detalle_compra values (
    default,
    1,
    2500,
    (select v_placa from vehiculo fetch first 1 row only)
);
insert into detalle_compra values (
    default,
    1,
    3500,
    (select v_placa from vehiculo fetch first 1 row only)
);