declare
    fecha_inicio varchar2(20) := '01/20/2013'; -- fecha inicio de la simulacion, con el fotmato: mm/dd/yyyy
    fecha_fin    varchar2(20) := '02/25/2013'; -- fecha fin de la simulacion,    con el fotmato: mm/dd/yyyy
begin
    main_pkg.main_simulacion(fecha_inicio, fecha_fin);
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.PUT_LINE('Error en generador data aleatoria');
      DBMS_OUTPUT.put_line (   'ORA-'
         || TO_CHAR (UTL_CALL_STACK.error_number (1), 'fm00000')
         || ': '
         || UTL_CALL_STACK.error_msg (1));
end;
/
