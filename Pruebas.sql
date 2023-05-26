CREATE OR REPLACE FUNCTION boolean_to_char(STATUS IN BOOLEAN)
RETURN VARCHAR2 IS
BEGIN
  RETURN
   CASE STATUS
     WHEN TRUE THEN 'TRUE'
     WHEN FALSE THEN 'FALSE'
     ELSE 'NULL'
   END;
   
END boolean_to_char;
/

create or replace procedure prueba_procedure
is
   resultado boolean; 
   fecha_actual date;
   fecha_menor date;
   fecha_mayor date;
   
   mes_imprimir varchar2(50);
   
   timestamp_menor timestamp := TO_TIMESTAMP('2000/DEC/13 10:13:18', 'YYYY/MON/DD HH:MI:SS');
   timestamp_mayor timestamp := TO_TIMESTAMP('2020/DEC/13 10:13:18', 'YYYY/MON/DD HH:MI:SS');
   timestamp_actual timestamp;
   
    -- cursor
   cursor   cursor_prueba is select * from 
           (select * from help) 
           where rownum<=5;
    
   help_row help%rowtype; 
   topic    help.topic%type;
   seq      help.seq%type;
   info     help.info%type;
BEGIN 

    select ADD_MONTHS(sysdate, 4) into fecha_actual from dual;
    select ADD_MONTHS(sysdate, 2) into fecha_menor from dual;
    select ADD_MONTHS(sysdate, 8) into fecha_mayor from dual;
    
    select SYSTIMESTAMP into timestamp_actual from dual;
    
    -- revisar fecha actual mayor
    resultado := fecha_actual>fecha_menor;
    DBMS_OUTPUT.PUT_LINE('fecha_actual>fecha_menor: '|| boolean_to_char(resultado)); 
    
    -- revisar fecha actual mayor
    resultado := fecha_actual<fecha_menor;
    DBMS_OUTPUT.PUT_LINE('fecha_actual<fecha_menor: '|| boolean_to_char(resultado));
    
    -- revisar fecha actual menor
    resultado := fecha_actual>fecha_mayor;
    DBMS_OUTPUT.PUT_LINE('fecha_actual>fecha_mayor: '|| boolean_to_char(resultado)); 
    
    -- revisar fecha actual menor
    resultado := fecha_actual<fecha_mayor;
    DBMS_OUTPUT.PUT_LINE('fecha_actual<fecha_mayor: '|| boolean_to_char(resultado));
    
    
    -- revisar operaciones de fecha
    DBMS_OUTPUT.PUT_LINE(chr(10)||'Operaciones con fechas:'||chr(10));
    
    DBMS_OUTPUT.PUT_LINE('fecha_actual - fecha_mayor: '|| to_char(fecha_actual-fecha_menor));
    
    -- revisar operaciones de strings
    DBMS_OUTPUT.PUT_LINE(chr(10)||'Revisar operaciones de strings:'||chr(10));
    
    DBMS_OUTPUT.PUT_LINE('Longitud de "hola": '|| LENGTH('hola'));
    DBMS_OUTPUT.PUT_LINE('Longitud de "hola": '|| boolean_to_char(LENGTH('') is NULL));
    
    -- revisar operaciones de timestamps
    DBMS_OUTPUT.PUT_LINE(chr(10)||'Revisar operaciones de timestamps:'||chr(10));
    
    DBMS_OUTPUT.PUT_LINE('Timestamp actual: '|| timestamp_actual);
    DBMS_OUTPUT.PUT_LINE('timestamp_menor < timestamp_mayor: '|| boolean_to_char(timestamp_menor < timestamp_mayor));
    DBMS_OUTPUT.PUT_LINE('timestamp_menor < timestamp_actual: '|| boolean_to_char(timestamp_menor < timestamp_actual));
    DBMS_OUTPUT.PUT_LINE('timestamp_mayor > timestamp_actual: '|| boolean_to_char(timestamp_mayor > timestamp_actual));
    
    -- revisar operaciones con cursores
    OPEN cursor_prueba;
    LOOP
        FETCH cursor_prueba into topic, seq, info;
        EXIT WHEN cursor_prueba%notfound; 
         
        DBMS_OUTPUT.PUT_LINE('  TOPIC: '||topic);
        DBMS_OUTPUT.PUT_LINE('  SEQ: '||seq);
        DBMS_OUTPUT.PUT_LINE('  INFO: '||info);
        
    end loop;
    close cursor_prueba;
    
    OPEN cursor_prueba;
    LOOP
        FETCH cursor_prueba into help_row;
        EXIT WHEN cursor_prueba%notfound; 
         
        DBMS_OUTPUT.PUT_LINE('  TOPIC: '||help_row.topic);
        DBMS_OUTPUT.PUT_LINE('  SEQ: '||help_row.seq);
        DBMS_OUTPUT.PUT_LINE('  INFO: '||help_row.info);
        
    end loop;
    close cursor_prueba;
    
    -- prueba de to_date
    fecha_mayor := TO_DATE('04/20/2013','MM/DD/YYYY');
    DBMS_OUTPUT.PUT_LINE(to_char(fecha_mayor));
    
    -- prueba tomar el mes de una fecha
    select to_char(to_date(fecha_mayor, 'DD-MM-YYYY'), 'Month') into mes_imprimir from dual;
    mes_imprimir := 'Mes a imprimir: ' || mes_imprimir; 
    DBMS_OUTPUT.PUT_LINE(mes_imprimir);
    
    -- prueba de exit
    if (5>1) then
        DBMS_OUTPUT.PUT_LINE('Hola dentro del if');
        return;
    end if;
    DBMS_OUTPUT.PUT_LINE('Hola exit no funciono');
    
END;    
/

execute prueba_procedure();
/

drop procedure prueba_procedure;
/

drop function BOOLEAN_TO_CHAR;
/
