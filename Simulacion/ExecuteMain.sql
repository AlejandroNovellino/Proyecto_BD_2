declare
    fecha_inicio varchar2(20) := '06/01/2023'; -- fecha inicio de la simulacion, con el fotmato: mm/dd/yyyy
    fecha_fin    varchar2(20) := '06/30/2023'; -- fecha fin de la simulacion,    con el fotmato: mm/dd/yyyy
begin
    main_pkg.main_simulacion(fecha_inicio, fecha_fin);

end;
/
