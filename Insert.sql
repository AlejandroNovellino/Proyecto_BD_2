--Insert Color----
INSERT INTO COLOR VALUES (default,'AZUL');
INSERT INTO COLOR VALUES (default,'ROJO');
INSERT INTO COLOR VALUES (default,'AMARILLO');
INSERT INTO COLOR VALUES (default,'PLATEADO');
INSERT INTO COLOR VALUES (default,'NARANJA');
INSERT INTO COLOR VALUES (default,'NEGRO');
INSERT INTO COLOR VALUES (default,'BLANCO');
INSERT INTO COLOR VALUES (default,'MARRON');
INSERT INTO COLOR VALUES (default,'GRIS');
INSERT INTO COLOR VALUES (default,'ROSADO');
INSERT INTO COLOR VALUES (default,'VERDE');
INSERT INTO COLOR VALUES (default,'MORADO');
INSERT INTO COLOR VALUES (default,'DORADO');
INSERT INTO COLOR VALUES (default,'VINOTINTO');
INSERT INTO COLOR VALUES (default,'SALMON');

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
INSERT INTO MARCA VALUES (default,'Lexus');
INSERT INTO MARCA VALUES (default,'Mercedes');
INSERT INTO MARCA VALUES (default,'Subaru');
INSERT INTO MARCA VALUES (default,'Mg');



---Insert Modelo---
INSERT INTO MODELO VALUES (DEFAULT,'fortuner',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'corolla',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'4runner',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'yaris',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'camry',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'hilux',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'rav4',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));
INSERT INTO MODELO VALUES (DEFAULT,'tundra',(SELECT ma_id FROM marca Where ma_nombre='Toyota'));


INSERT INTO MODELO VALUES (DEFAULT,'civic',(SELECT ma_id FROM marca Where ma_nombre='Honda'));
INSERT INTO MODELO VALUES (DEFAULT,'fit',(SELECT ma_id FROM marca Where ma_nombre='Honda'));
INSERT INTO MODELO VALUES (DEFAULT,'accord',(SELECT ma_id FROM marca Where ma_nombre='Honda'));
INSERT INTO MODELO VALUES (DEFAULT,'cr-v',(SELECT ma_id FROM marca Where ma_nombre='Honda'));

INSERT INTO MODELO VALUES (DEFAULT,'escape',(SELECT ma_id FROM marca Where ma_nombre='Ford'));
INSERT INTO MODELO VALUES (DEFAULT,'fusion',(SELECT ma_id FROM marca Where ma_nombre='Ford'));
INSERT INTO MODELO VALUES (DEFAULT,'explorer',(SELECT ma_id FROM marca Where ma_nombre='Ford'));
INSERT INTO MODELO VALUES (DEFAULT,'fiesta',(SELECT ma_id FROM marca Where ma_nombre='Ford'));
INSERT INTO MODELO VALUES (DEFAULT,'ecosport',(SELECT ma_id FROM marca Where ma_nombre='Ford'));
INSERT INTO MODELO VALUES (DEFAULT,'f-150',(SELECT ma_id FROM marca Where ma_nombre='Ford'));

INSERT INTO MODELO VALUES (DEFAULT,'aveo',(SELECT ma_id FROM marca Where ma_nombre='Chevrolet'));
INSERT INTO MODELO VALUES (DEFAULT,'optra',(SELECT ma_id FROM marca Where ma_nombre='Chevrolet'));
INSERT INTO MODELO VALUES (DEFAULT,'tahoe',(SELECT ma_id FROM marca Where ma_nombre='Chevrolet'));
INSERT INTO MODELO VALUES (DEFAULT,'cruze',(SELECT ma_id FROM marca Where ma_nombre='Chevrolet'));
INSERT INTO MODELO VALUES (DEFAULT,'spark',(SELECT ma_id FROM marca Where ma_nombre='Chevrolet'));
INSERT INTO MODELO VALUES (DEFAULT,'orlando',(SELECT ma_id FROM marca Where ma_nombre='Chevrolet'));

INSERT INTO MODELO VALUES (DEFAULT,'cherokee',(SELECT ma_id FROM marca Where ma_nombre='Jeep'));
INSERT INTO MODELO VALUES (DEFAULT,'grand-cherokee',(SELECT ma_id FROM marca Where ma_nombre='Jeep'));
INSERT INTO MODELO VALUES (DEFAULT,'wrangler',(SELECT ma_id FROM marca Where ma_nombre='Jeep'));
INSERT INTO MODELO VALUES (DEFAULT,'compass',(SELECT ma_id FROM marca Where ma_nombre='Jeep'));
INSERT INTO MODELO VALUES (DEFAULT,'gladiator',(SELECT ma_id FROM marca Where ma_nombre='Jeep'));

INSERT INTO MODELO VALUES (DEFAULT,'elantra',(SELECT ma_id FROM marca Where ma_nombre='Hyundai'));
INSERT INTO MODELO VALUES (DEFAULT,'accent',(SELECT ma_id FROM marca Where ma_nombre='Hyundai'));
INSERT INTO MODELO VALUES (DEFAULT,'excel',(SELECT ma_id FROM marca Where ma_nombre='Hyundai'));
INSERT INTO MODELO VALUES (DEFAULT,'santaFe',(SELECT ma_id FROM marca Where ma_nombre='Hyundai'));
INSERT INTO MODELO VALUES (DEFAULT,'tucson',(SELECT ma_id FROM marca Where ma_nombre='Hyundai'));
INSERT INTO MODELO VALUES (DEFAULT,'sonata',(SELECT ma_id FROM marca Where ma_nombre='Hyundai'));

INSERT INTO MODELO VALUES (DEFAULT,'lancer',(SELECT ma_id FROM marca Where ma_nombre='Mitsubishi'));
INSERT INTO MODELO VALUES (DEFAULT,'signo',(SELECT ma_id FROM marca Where ma_nombre='Mitsubishi'));
INSERT INTO MODELO VALUES (DEFAULT,'evolution',(SELECT ma_id FROM marca Where ma_nombre='Mitsubishi'));
INSERT INTO MODELO VALUES (DEFAULT,'montero-sport',(SELECT ma_id FROM marca Where ma_nombre='Mitsubishi'));
INSERT INTO MODELO VALUES (DEFAULT,'mf',(SELECT ma_id FROM marca Where ma_nombre='Mitsubishi'));
INSERT INTO MODELO VALUES (DEFAULT,'pajero',(SELECT ma_id FROM marca Where ma_nombre='Mitsubishi'));

INSERT INTO MODELO VALUES (DEFAULT,'simbol',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'twingo',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'evolution',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'logan',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'megane',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'duster',(SELECT ma_id FROM marca Where ma_nombre='Renault'));

INSERT INTO MODELO VALUES (DEFAULT,'simbol',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'twingo',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'evolution',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'logan',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'megane',(SELECT ma_id FROM marca Where ma_nombre='Renault'));
INSERT INTO MODELO VALUES (DEFAULT,'duster',(SELECT ma_id FROM marca Where ma_nombre='Renault'));

INSERT INTO MODELO VALUES (DEFAULT,'sportage',(SELECT ma_id FROM marca Where ma_nombre='Kia'));
INSERT INTO MODELO VALUES (DEFAULT,'rio',(SELECT ma_id FROM marca Where ma_nombre='Kia'));
INSERT INTO MODELO VALUES (DEFAULT,'picanto',(SELECT ma_id FROM marca Where ma_nombre='Kia'));
INSERT INTO MODELO VALUES (DEFAULT,'soul',(SELECT ma_id FROM marca Where ma_nombre='Kia'));
INSERT INTO MODELO VALUES (DEFAULT,'sorento',(SELECT ma_id FROM marca Where ma_nombre='Kia'));

INSERT INTO MODELO VALUES (DEFAULT,'siena',(SELECT ma_id FROM marca Where ma_nombre='Fiat'));
INSERT INTO MODELO VALUES (DEFAULT,'palio',(SELECT ma_id FROM marca Where ma_nombre='Fiat'));
INSERT INTO MODELO VALUES (DEFAULT,'uno',(SELECT ma_id FROM marca Where ma_nombre='Fiat'));

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
INSERT INTO tipo_cliente  VALUES (DEFAULT,'Ocacional');
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


--- insert formas de pago---
INSERT INTO forma_pago  VALUES (DEFAULT,'Efectivo');
INSERT INTO forma_pago  VALUES (DEFAULT,'Transferencia');
INSERT INTO forma_pago  VALUES (DEFAULT,'Pago movil');
INSERT INTO forma_pago  VALUES (DEFAULT,'Tarjeta Internacional');
INSERT INTO forma_pago  VALUES (DEFAULT,'Criptomoneda');

--- insert lugar---
    INSERT INTO LUGAR VALUES (DEFAULT,'Venezuela','Pais',NULL,NULL);/
    INSERT INTO LUGAR VALUES (DEFAULT,'Distrito Capital','Estado',NULL,(select l_id from LUGAR where l_nombre='Venezuela'));/
    INSERT INTO LUGAR VALUES (DEFAULT,'Libertador','Municipio',NULL,(select l_id from LUGAR where l_nombre='Distrito Capital'));
----insert consesionario----
 INSERT INTO CONSESIONARIO VALUES (DEFAULT,'0212-5599283','Av. Teheran, Montalban',(select l_id from LUGAR where l_nombre='Libertador'));/
 ----insert sede---
    INSERT INTO SEDE VALUES (DEFAULT,'Av. Teheran, Montalban','0212-5599283',1,20,1,(select c_id from CONSESIONARIO where c_direccion='Av. Teheran, Montalban'),(select l_id from LUGAR where l_nombre='Libertador'));
----insert alquiler------



---insert detalle-alquiler----
