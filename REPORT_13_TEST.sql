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