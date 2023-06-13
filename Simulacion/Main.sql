-- paquete para main -----------------------------------------------------------
create or replace package main_pkg as

    TYPE fechas_associative_array IS TABLE OF DATE    -- Associative array of number type
    INDEX BY PLS_INTEGER;                                  -- indexed by PLS_INTEGER

    FUNCTION get_intervalo_fechas(fecha_inicio date, fecha_fin date) RETURN fechas_associative_array;
    PROCEDURE main_simulacion(fecha_inicio varchar2, fecha_fin varchar2);

end main_pkg;
/

create or replace package body main_pkg as 
    -- devuelve un arreglo de fechas sobre las que iterar
    function get_intervalo_fechas(fecha_inicio date, fecha_fin date) return fechas_associative_array
    is
      fecha_inicio_number number;
      fecha_fin_number number;
      
      fechas  fechas_associative_array; 
      index_counter PLS_INTEGER;
    begin
        -- fechas de iniico a fin a number
        fecha_inicio_number := to_number(to_char(fecha_inicio, 'j'));
        fecha_fin_number := to_number(to_char(fecha_fin, 'j'));
        -- 
        index_counter := 0;
        
        -- convierte uno a uno los numeros en dates y se agregan al arreglo
        for curr_dia in fecha_inicio_number..fecha_fin_number loop
            fechas(index_counter) := to_date(curr_dia, 'j');
            index_counter := index_counter + 1;
        end loop;
        
        return fechas;
    end get_intervalo_fechas;
    
    -- cuerpo del procedure main de la simulacion ------------------------------------------------
    -- la fecha debe venir con el formato '2013-04-20', 'yyyy-MM-dd'
    PROCEDURE main_simulacion(fecha_inicio varchar2, fecha_fin varchar2)
    is
        fecha_inicio_simulacion date;                     -- fecha de inicio de la simulacion
        fecha_fin_simulacion date;                        -- fecha de fin de la simulacion
        
        periodo_fechas  fechas_associative_array;         -- Associative array variable
        index_fecha PLS_INTEGER;                          -- index para el arreglo de fechas
        
        cursor cursor_sedes is select * from sede;        -- cursor para las sedes
        sede_actual sede%rowtype;                         -- variable para poder utilizar el cursor
    begin
        DBMS_Output.PUT_LINE('--------------------------- Inicio de la simulacion ---------------------------');
        DBMS_Output.PUT_LINE('');
        
        -- guardamos las fechas de la simulacion
        fecha_inicio_simulacion := TO_DATE(fecha_inicio,'MM/DD/YYYY');
        fecha_fin_simulacion := TO_DATE(fecha_fin,'MM/DD/YYYY'); 
    
        -- tomar el arreglo de dias para iterar sobre ellos
        periodo_fechas := get_intervalo_fechas(TO_DATE(fecha_inicio,'MM/DD/YYYY'), TO_DATE(fecha_fin,'MM/DD/YYYY'));
        
        -- imprimimos los dias obtenidos
        index_fecha := periodo_fechas.FIRST;
        -- iteramos sobre las fechas
        WHILE index_fecha IS NOT NULL LOOP
            
            -- iteramos sobre las sedes
            OPEN cursor_sedes; -- abrimos el cursos
            LOOP
                FETCH cursor_sedes into sede_actual; 
                EXIT WHEN cursor_sedes%notfound; 
                 
                -- DESARROLLO POR CADA SEDE-------------------------------------
                DBMS_Output.PUT_LINE('-------------------------- Actividades para la sede ' || to_char(sede_actual.s_id) || ' --------------------------');
                
                -- generamos los datos aleatorios para personas y clientes por cada dia
                generador_data_aleatoria_pkg.generador_personas(25);
                generador_data_aleatoria_pkg.generador_clientes(15);
                
                -- PRESENTAMOS QUE DIA SE ESTA TRABAJANDO
                DBMS_Output.PUT_LINE('');
                DBMS_Output.PUT_LINE('---- DIA ' || TO_CHAR(periodo_fechas(index_fecha), 'dd/mm/yyyy') || ' de la simulacion');
                
                -- MODULO 5 ----------------------------------------------------
                -- CREACION DE ALIANZAS
                alianzas_pkg.creacion_de_alianza(
                    periodo_fechas(index_fecha),
                    sede_actual.s_id
                );
                
                -- MODULO 1 ----------------------------------------------------
                -- RESERVAS
                reserva_and_alquiler_pkg.simulacion_reservas(
                    sede_actual.s_id, 
                    periodo_fechas(index_fecha), 
                    fecha_fin_simulacion
                );
                
                -- ALQUILERES
                reserva_and_alquiler_pkg.simulacion_alquileres(
                    sede_actual.s_id, 
                    periodo_fechas(index_fecha), 
                    fecha_fin_simulacion
                );
                
                -- ALQUILERES QUE ESTEN EN PROCESO (SIMULACION DE ERRORES)
                reserva_and_alquiler_pkg.simulacion_problemas_durante_alquileres(
                    sede_actual.s_id, 
                    periodo_fechas(index_fecha)
                );
                
                -- ACTIVIDADES DEL DIA 28 --------------------------------------
                -- COMPRA DE VEHICULO
                inventario_pkg.compra_de_vehiculo(
                    periodo_fechas(index_fecha), 
                    sede_actual.s_id
                );
                
                -- SALIDA DE EMPLEADO
                empleados_pkg.salida_de_empleado(
                    periodo_fechas(index_fecha), 
                    sede_actual.s_id
                );
                
                -- CONTRATACION DE EMPLEADO
                empleados_pkg.contratacion(sede_actual.s_id);
                
                -- GASTOS DE NOMINAS
                gastos_pkg.gasto_de_nomina(
                    periodo_fechas(index_fecha), 
                    sede_actual.s_id
                );
                
                -- GASTOS DE OPERACION
                gastos_pkg.gasto_de_operacion(
                    periodo_fechas(index_fecha), 
                    sede_actual.s_id
                );
                
                
            end loop;
            close cursor_sedes; -- cerramos el cursor
            
            -- FINALIZACION DE ALQUILERES
            reserva_and_alquiler_pkg.simulacion_finalizacion_alquileres(periodo_fechas(index_fecha));
            
            -- CANCELACION SE RESERVAS
            reserva_and_alquiler_pkg.cancelacion_reservas(periodo_fechas(index_fecha));
            
            -- MODULO 3 --------------------------------------------------------
            -- REALIZACION MANTENIMIENTOS DEL DIA
            mantenimiento_pkg.realizacion_de_mantenimiento(periodo_fechas(index_fecha));
            
            -- FINALIZACION MANTENIMIENTOS DEL DIA
            mantenimiento_pkg.finalizacion_de_mantenimiento(periodo_fechas(index_fecha));
            
            
            
            ------------------------------------------------------------------------------------
            -- obtenemos la siguiente fecha 
            index_fecha := periodo_fechas.NEXT(index_fecha);  -- siguiente elemento del arreglo
        END LOOP;
                
    end main_simulacion;
    
end main_pkg;
/
