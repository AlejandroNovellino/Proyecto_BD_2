select count(alq.a_id) cantidades,  dia_semana.dia 
                from alquiler alq, (select to_char(TO_DATE('01/16/2023','MM/DD/YYYY'), 'DAY') dia FROM dual) dia_semana
                where TO_DATE('01/16/2023','MM/DD/YYYY') between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin
                group by dia_semana.dia
union all
select count(alq.a_id) cantidades,  dia_semana.dia 
                from alquiler alq, (select to_char(TO_DATE('01/17/2023','MM/DD/YYYY'), 'DAY') dia FROM dual) dia_semana
                where TO_DATE('01/17/2023','MM/DD/YYYY') between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin
                group by dia_semana.dia;
                
SELECT
    to_char(TO_DATE('06/30/2023', 'MM/DD/YYYY'), 'DAY') "DIA"
FROM
    "SYS"."DUAL" "A1";
    
select alq.a_periodo_duracion.P_Fecha_Inicio, alq.a_periodo_duracion.P_Fecha_Fin
    from alquiler alq;
    
select tp_veh.tv_nombre tipo_vehiculo_r, marca.ma_nombre marca_vehiculo, modelo.m_nombre modelo_vehiculo, veh.v_anno anno_vehiculo, veh.v_placa placa_vehiculo, veh.v_foto foto_vehiculo, ra.r_escala_satisfaccion escala, (
                    select XMLAGG(XMLELEMENT(E,obs.o_descripcion||' ')).EXTRACT('//text()').getstringval()
                    from observacion obs
                    where   obs.rating_r_id = ra.r_id
                ) observaciones
                from (
                        select *
                        from alquiler a_aux
                        where   TO_DATE('06/01/2023','MM/DD/YYYY') <= a_aux.a_periodo_duracion.P_Fecha_Inicio   or 
                                TO_DATE('07/30/2023','MM/DD/YYYY')  >= a_aux.a_periodo_duracion.P_Fecha_Fin
                    ) alq, 
                    (
                        select *
                        from vehiculo
                        where   tipo_vehiculo_tv_id = (select tv_id from tipo_vehiculo where tv_nombre = 'Carro')     or
                                modelo_marca_ma_id = (select ma_id from marca where ma_nombre = 'Kia')                or
                                modelo_m_id = (select m_id from modelo where m_nombre = 'Sportage')                   or
                                v_placa = NULL
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
                       -- elementos que dependen de los parametros
            ;
      
SELECT TRUNC (to_date(concat('01/01/',to_char(extract(year from SYSDATE)+1)),'dd/mm/yyyy') - ROWNUM) dt
  FROM DUAL CONNECT BY ROWNUM < 366;

-- Query de prueba
select count(alq.a_id), to_char(dias.dia, 'Day') dia_semana
from    (
            select trunc(to_date(concat('01/01/',to_char(extract(year from SYSDATE)+1)),'dd/mm/yyyy') - rownum) dia
            from DUAL 
            connect by rownum < 366
        ) dias,
        alquiler alq
where   to_char(dias.dia, 'Day') like to_char(to_date('19/06/2023','dd/mm/yyyy'), 'Day') and
        dias.dia between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin   
group by to_char(dias.dia, 'Day');

-- Actualmente pareciera que funciona
-- Query para los lunes
select count(alq.a_id), to_char(dias.dia, 'Day') dia_semana
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
select count(alq.a_id), to_char(dias.dia, 'Day') dia_semana
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
select count(alq.a_id), to_char(dias.dia, 'Day') dia_semana
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
select count(alq.a_id), to_char(dias.dia, 'Day') dia_semana
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
select count(alq.a_id), to_char(dias.dia, 'Day') dia_semana
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
select count(alq.a_id), to_char(dias.dia, 'Day') dia_semana
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
select count(alq.a_id), to_char(dias.dia, 'Day') dia_semana
from    (
            select trunc(to_date(concat('01/01/',to_char(extract(year from SYSDATE)+1)),'dd/mm/yyyy') - rownum) dia
            from DUAL 
            connect by rownum < 366
        ) dias,
        alquiler alq
where   to_char(dias.dia, 'Day') like to_char(to_date('25/06/2023','dd/mm/yyyy'), 'Day') and
        dias.dia between alq.a_periodo_duracion.P_Fecha_Inicio and alq.a_periodo_duracion.P_Fecha_Fin   
group by to_char(dias.dia, 'Day');