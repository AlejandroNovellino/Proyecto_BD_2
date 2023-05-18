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

DECLARE
   resultado boolean; 
   fecha_actual date;
   fecha_menor date;
   fecha_mayor date;
   
   timestamp_menor timestamp := TO_TIMESTAMP('2000/DEC/13 10:13:18', 'YYYY/MON/DD HH:MI:SS');
   timestamp_mayor timestamp := TO_TIMESTAMP('2020/DEC/13 10:13:18', 'YYYY/MON/DD HH:MI:SS');
   timestamp_actual timestamp;
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
END;    
/

drop function BOOLEAN_TO_CHAR;
/
