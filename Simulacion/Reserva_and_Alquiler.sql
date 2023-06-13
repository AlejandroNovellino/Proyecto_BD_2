create or replace package reserva_and_alquiler_pkg as
    -- funcion para verificar si el vehiculo podria ser alquilado en un periodo dado
    function verificar_periodo_valido(vehiculo_seleccionado vehiculo%rowtype, periodo_alquiler periodo_duracion) return boolean;
    -- funcion para comprobar disponibilidad del vehiculo
    function comprobacion_disponibilidad_vehiculo(vehiculo_seleccionado IN OUT vehiculo%rowtype, periodo_alquiler periodo_duracion, sede_pk number) return boolean;
    -- procedure para encontrarle al usuario una opcion de vehiculo para alquilar
    procedure solucion_vehiculo_no_disponible_en_sede(cliente_seleccionado cliente%rowtype, vehiculo_seleccionado IN OUT vehiculo%rowtype, periodo_alquiler periodo_duracion, sede_donde_no_hay_el_vehiculo number);
    -- procedure para encontrarle al usuario una opcion de vehiculo para reservar
    procedure solucion_vehiculo_no_disponible_en_sede_para_reserva(cliente_seleccionado cliente%rowtype, vehiculo_seleccionado IN OUT vehiculo%rowtype, periodo_alquiler periodo_duracion, sede_donde_no_hay_el_vehiculo number, dia_actual date);
    -- funcion para el fallo en pago
    function fallo_durante_pago(forma_pago_actual forma_pago%rowtype) return boolean;
    -- procedure para el pago del alquiler
    procedure pago_alquiler(cliente_seleccionado cliente%rowtype, vehiculo_seleccionado vehiculo%rowtype, periodo_alquiler periodo_duracion, alquiler_realizado alquiler%rowtype);
    -- procedure para alquiler
    procedure realizar_alquiler(cliente_reservar cliente%rowtype, vehiculo_seleccionado vehiculo%rowtype, periodo_alquiler periodo_duracion, ultimo_alquiler_realizado IN OUT alquiler%rowtype, reserva_pk number DEFAULT NULL);
    -- procedure para reserva
    procedure realizar_reserva(cliente_reservar cliente%rowtype, dia_actual date, pk_reserva OUT number);
    -- procedure para simular el modulo de reservas
    procedure simulacion_reservas(pk_sede number, dia_actual date, fecha_fin_simulacion date);
    -- procedure para simular el modulo de alquileres
    procedure simulacion_alquileres(pk_sede number, dia_actual date, fecha_fin_simulacion date);
    ----------------------------------------------------------------------------
    -- procedure para simular un robo de vehiculo
    procedure robo_vehiculo(alquiler_a_finalizar alquiler%rowtype);
    -- procedure para actualizar el status del cliente
    procedure actualizacion_status_cliente(alquiler_a_finalizar alquiler%rowtype);
    -- procedure para finalizar un alquiler
    procedure finalizar_alquiler(alquiler_a_finalizar alquiler%rowtype);
    -- procedure para finalizar alquileres que terminan ese dia
    procedure simulacion_finalizacion_alquileres(dia_actual date);
    ----------------------------------------------------------------------------
    -- procedure para simular cancelar reservas
    procedure cancelacion_reservas(dia_actual date);
    ----------------------------------------------------------------------------
    -- procedure para simular un error en el alquiler
    procedure problema_durante_alquiler(alquiler_a_fallar alquiler%rowtype, pk_sede number, dia_actual date);
    -- procedure para simular errores en alquileres activos
    procedure simulacion_problemas_durante_alquileres(pk_sede number, dia_actual date);
    
end reserva_and_alquiler_pkg;
/

create or replace package body reserva_and_alquiler_pkg as
    ----------------------------------------------------------------------------
    -- funcion para verificar si el vehiculo podria ser alquilado en un periodo dado
    -- retorna true si el vechiculo esta disponible
    -- retorna false si no esta disponible
    function verificar_periodo_valido(vehiculo_seleccionado vehiculo%rowtype, periodo_alquiler periodo_duracion) return boolean
    is
        cantidad_alquileres_ya_en_ese_periodo number := 0;
        periodo_valido boolean := true;
    begin
        
        -- contamos la cantidad de alquileres que ya posee ese vehiculo durante ese periodo, que en teoria deberia ser 1 o 0
        select count(*) into cantidad_alquileres_ya_en_ese_periodo
            from (
                select a.a_id, a.a_periodo_duracion
                from alquiler a, detalle_alquiler da
                where a.detalle_alquiler_da_id = da.da_id and
                      da.vehiculo_v_placa=vehiculo_seleccionado.v_placa
            ) filtered_a
            where periodo_alquiler.P_Fecha_Fin between filtered_a.a_periodo_duracion.P_Fecha_Inicio and filtered_a.a_periodo_duracion.P_Fecha_Fin or
                  periodo_alquiler.P_Fecha_Inicio between filtered_a.a_periodo_duracion.P_Fecha_Inicio and filtered_a.a_periodo_duracion.P_Fecha_Fin;
        
        DBMS_OUTPUT.PUT_LINE('          - Cantidad de alquileres ya en el periodo seleccionado sobre el auto seleccionado ' || to_char(cantidad_alquileres_ya_en_ese_periodo));
        
        -- vehiculo ya posee un alquiler en este periodo  
        if (cantidad_alquileres_ya_en_ese_periodo != 0) then
            periodo_valido := false;
        end if;
        
        return periodo_valido;
    end verificar_periodo_valido;
    ----------------------------------------------------------------------------
    -- funcion para comprobar disponibilidad del vehiculo
    function comprobacion_disponibilidad_vehiculo(vehiculo_seleccionado IN OUT vehiculo%rowtype, periodo_alquiler periodo_duracion, sede_pk number) return boolean
    is    
        vehiculo_disponible boolean; -- variable a retornar
        -- variables para el cursor
        -- se seleccionan todos los carros menos el ya seleccionado al azar, que son de la misma marca y modelo
        cursor vehiculos is select * 
            from vehiculo v 
            where v.v_placa != vehiculo_seleccionado.v_placa and
                  v.modelo_m_id=vehiculo_seleccionado.modelo_m_id and
                  v.modelo_marca_ma_id=vehiculo_seleccionado.modelo_marca_ma_id and
                  v.sede_s_id=sede_pk and
                  v.status_vehiculo_sv_id = (
                    select sv_id from status_vehiculo where sv_nombre = 'Disponible'
                  ); 
        vehiculo_row vehiculo%rowtype := NULL;
        -- nuevo vehiculo a alquilar
        nuevo_vehiculo_a_alquilar vehiculo%rowtype := NULL;
    begin
    
        -- verificamos si el vehiculo ya pertenece a un alquiler dentro del periodo especificado
        vehiculo_disponible := verificar_periodo_valido(vehiculo_seleccionado, periodo_alquiler);
        -- si el vehiculo esta disponible
        if (vehiculo_disponible) then 
            return true;
        end if;
        
        -- si el vehiculo no esta disponible seguimos --------------------------
        
        -- imprimimos que el vehiculo no esta disponible
        DBMS_OUTPUT.PUT_LINE('          - Vehiculo no disponible, se buscara otro disponible en la sede');
        
        -- se procede a buscar otro auto con las mismas caracteristicas del seleccionado en la sede donde nos encontramos
        -- se seleccionara el primer auto con los mismos valores de marca, modelo y anno que se consiga en todas las sedes
        -- abrimos el cursor e iteramos sobre el 
        open vehiculos;
        loop 
            fetch vehiculos into vehiculo_row;
            exit when vehiculos%notfound;

            -- verificamos si el vehiculo esta disponible
            vehiculo_disponible := reserva_and_alquiler_pkg.verificar_periodo_valido(vehiculo_row, periodo_alquiler);
            
            -- se verifica si se tiene un vehiculo disponible
            if (vehiculo_disponible) then
                nuevo_vehiculo_a_alquilar := vehiculo_row;
                -- salimos del bucle de busqueda de vehiculos
                exit;
            end if;
        end loop;
        -- cerramos el cursor
        close vehiculos;
        -- luego de este proceso se verifica si selecciono un vehiculo
        if (nuevo_vehiculo_a_alquilar.v_placa is NULL) then
            -- si no se selecciono un vehiculo se retorna falso
            return false;
        else
            -- si se selecciono un vehiculo, se procede a actualizar el nuevo vehiculo para el cliente y retornar verdadero
            vehiculo_seleccionado := nuevo_vehiculo_a_alquilar;
            return true;
        end if;
        
    end comprobacion_disponibilidad_vehiculo;
    ----------------------------------------------------------------------------
    -- procedure para encontrarle al usuario una opcion de vehiculo para alquilar (escenario 6)
    procedure solucion_vehiculo_no_disponible_en_sede(cliente_seleccionado cliente%rowtype, vehiculo_seleccionado IN OUT vehiculo%rowtype, periodo_alquiler periodo_duracion, sede_donde_no_hay_el_vehiculo number)
      is    
        vehiculo_disponible boolean;            -- variable para verificar si un vehiculo esta disponible o no
        alquiler_realizado alquiler%rowtype;    -- variable para el alquiler que se realizara si existe auto disponible
        
        -- variables para el cursor
        -- se seleccionan todos los vehiculos de las otras sedes
        cursor todos_vehiculos_de_las_otras_sedes is select * 
            from vehiculo v 
            where v.sede_s_id!=sede_donde_no_hay_el_vehiculo and
                  v.status_vehiculo_sv_id = (
                    select sv_id from status_vehiculo where sv_nombre = 'Disponible'
                  ); 
        -- se seleccionan todos los vehiculos de otras sedes que tengan las mismas caracteristicas
        cursor vehiculos_iguales_al_deseado_por_cliente is select * 
            from vehiculo v 
            where v.v_placa != vehiculo_seleccionado.v_placa and
                  v.modelo_m_id=vehiculo_seleccionado.modelo_m_id and
                  v.modelo_marca_ma_id=vehiculo_seleccionado.modelo_marca_ma_id and
                  v.sede_s_id!=sede_donde_no_hay_el_vehiculo and
                  v.status_vehiculo_sv_id = (
                    select sv_id from status_vehiculo where sv_nombre = 'Disponible'
                  ); 
        -- variable para recorrer el cursor
        vehiculo_row vehiculo%rowtype := NULL;
        -- nuevo vehiculo a alquilar
        nuevo_vehiculo_a_alquilar vehiculo%rowtype := NULL;
    begin
        
        -- se procede a buscar otro auto con las mismas caracteristicas del seleccionado en la sede donde nos encontramos
        -- se seleccionara el primer auto con los mismos valores de marca, modelo y anno que se consiga en todas las sedes
        -- abrimos el cursor e iteramos sobre el 
        open vehiculos_iguales_al_deseado_por_cliente;
        loop 
            fetch vehiculos_iguales_al_deseado_por_cliente into vehiculo_row;
            exit when vehiculos_iguales_al_deseado_por_cliente%notfound;

            -- llamamos a la funcion para verificar si el vehiculo esta disponible
            vehiculo_disponible := reserva_and_alquiler_pkg.verificar_periodo_valido(vehiculo_row, periodo_alquiler);
            
            -- verificamos si el vehiculo esta disponible
            if (vehiculo_disponible) then
                nuevo_vehiculo_a_alquilar := vehiculo_row;
                -- salimos del bucle de busqueda de vehiculos
                exit;
            end if;
        end loop;
        -- cerramos el cursor
        close vehiculos_iguales_al_deseado_por_cliente;
        -- luego de este proceso se verifica si se selecciono un vehiculo
        if (nuevo_vehiculo_a_alquilar.v_placa is not NULL) then
            -- si se selecciono entonces existe un vehiculo con las mismas caracteristica en otra sede que puede ser alquilado
            DBMS_OUTPUT.PUT_LINE('          - Se pudo encontrar otro vechiulo con las mismas carcateristicas en otra sede,  se procede a su alquiler.');
            
            vehiculo_seleccionado := nuevo_vehiculo_a_alquilar;
            -- se alquila el vehiculo
            reserva_and_alquiler_pkg.realizar_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
            
            -- se llama al escenario 'pago de alquiler'
            reserva_and_alquiler_pkg.pago_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
            
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('          RESULTADO: se finalizo el alquiler satisfactoriamente');
            
            -- finaliza el procedure
            return;
        end if;
        
        ------------------------------------------------------------------------
        -- si no se selecciono un vehiculo entonces no hay con las mismas caracteristicas en otras sedes
        -- disponibles para ser alquilados, por lo tanto se alquila el primer vechiculo en otra sede que este disponible
        
        DBMS_OUTPUT.PUT_LINE('          - No se pudo encontrar otro vechiulo con las mismas carcateristicas en otra sede,  se procede a seleccionar el primer vehiculo disponible');
        
        open todos_vehiculos_de_las_otras_sedes;
        loop 
            fetch todos_vehiculos_de_las_otras_sedes into vehiculo_row;
            exit when todos_vehiculos_de_las_otras_sedes%notfound;

            -- llamamos a la funcion para veirficar si el vehiculo esta disponible
            vehiculo_disponible := reserva_and_alquiler_pkg.verificar_periodo_valido(vehiculo_row, periodo_alquiler);
            
            -- verificamos si el vehiculo esta disponible
            if (vehiculo_disponible) then
                nuevo_vehiculo_a_alquilar := vehiculo_row;
                -- salimos del bucle de busqueda de vehiculos
                exit;
            end if;
        end loop;
        -- cerramos el cursor
        close todos_vehiculos_de_las_otras_sedes;
        -- luego de este proceso se verifica si selecciono un vehiculo
        if (nuevo_vehiculo_a_alquilar.v_placa is not NULL) then
            -- si se selecciono entonces existe un vehiculo con las mismas caracteristica en otra sede que puede ser alquilado
            DBMS_OUTPUT.PUT_LINE('          - Existe un vehiculo disponible, se procede a su alquiler.');
            
            vehiculo_seleccionado := nuevo_vehiculo_a_alquilar;
            -- se alquila el vehiculo
            reserva_and_alquiler_pkg.realizar_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
            
            -- se llama al escenario 'pago de alquiler'
            reserva_and_alquiler_pkg.pago_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
            
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('          RESULTADO: se finalizo el alquiler satisfactoriamente');
            
            -- finaliza el procedure
            return;
        else 
            -- no existe ningun vehiculo disponible para alquiler
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('          RESULTADO: no hay vehiculos disponibles, no se puede realizar un alquiler');
        end if;
        
    end solucion_vehiculo_no_disponible_en_sede;
    
    ----------------------------------------------------------------------------
    -- procedure para encontrarle al usuario una opcion de vehiculo para reservar (escenario 6)
    procedure solucion_vehiculo_no_disponible_en_sede_para_reserva(cliente_seleccionado cliente%rowtype, vehiculo_seleccionado IN OUT vehiculo%rowtype, periodo_alquiler periodo_duracion, sede_donde_no_hay_el_vehiculo number, dia_actual date)
      is    
        vehiculo_disponible boolean;            -- variable para verificar si un vehiculo esta disponible o no
        alquiler_realizado alquiler%rowtype;    -- variable para el alquiler que se realizara si existe auto disponible
        pk_reserva  number := NULL;             -- parametro OUT para realizar_reserva
        
        -- variables para el cursor
        -- se seleccionan todos los vehiculos de las otras sedes
        cursor todos_vehiculos_de_las_otras_sedes is select * 
            from vehiculo v 
            where v.sede_s_id!=sede_donde_no_hay_el_vehiculo and
                  v.status_vehiculo_sv_id = (
                    select sv_id from status_vehiculo where sv_nombre = 'Disponible'
                  ); 
        -- se seleccionan todos los vehiculos de otras sedes que tengan las mismas caracteristicas
        cursor vehiculos_iguales_al_deseado_por_cliente is select * 
            from vehiculo v 
            where v.v_placa != vehiculo_seleccionado.v_placa and
                  v.modelo_m_id=vehiculo_seleccionado.modelo_m_id and
                  v.modelo_marca_ma_id=vehiculo_seleccionado.modelo_marca_ma_id and
                  v.sede_s_id!=sede_donde_no_hay_el_vehiculo and
                  v.status_vehiculo_sv_id = (
                    select sv_id from status_vehiculo where sv_nombre = 'Disponible'
                  ); 
        -- variable para recorrer el cursor
        vehiculo_row vehiculo%rowtype := NULL;
        -- nuevo vehiculo a alquilar
        nuevo_vehiculo_a_alquilar vehiculo%rowtype := NULL;
    begin
        
        -- se procede a buscar otro auto con las mismas caracteristicas del seleccionado en la sede donde nos encontramos
        -- se seleccionara el primer auto con los mismos valores de marca, modelo y anno que se consiga en todas las sedes
        -- abrimos el cursor e iteramos sobre el 
        open vehiculos_iguales_al_deseado_por_cliente;
        loop 
            fetch vehiculos_iguales_al_deseado_por_cliente into vehiculo_row;
            exit when vehiculos_iguales_al_deseado_por_cliente%notfound;

            -- llamamos a la funcion para verificar si el vehiculo esta disponible
            vehiculo_disponible := reserva_and_alquiler_pkg.verificar_periodo_valido(vehiculo_row, periodo_alquiler);
            
            -- verificamos si el vehiculo esta disponible
            if (vehiculo_disponible) then
                nuevo_vehiculo_a_alquilar := vehiculo_row;
                -- salimos del bucle de busqueda de vehiculos
                exit;
            end if;
        end loop;
        -- cerramos el cursor
        close vehiculos_iguales_al_deseado_por_cliente;
        -- luego de este proceso se verifica si se selecciono un vehiculo
        if (nuevo_vehiculo_a_alquilar.v_placa is not NULL) then
            -- si se selecciono entonces existe un vehiculo con las mismas caracteristica en otra sede que puede ser alquilado
            DBMS_OUTPUT.PUT_LINE('          - Se pudo encontrar otro vechiulo con las mismas carcateristicas en otra sede,  se procede a su alquiler.');
            
            vehiculo_seleccionado := nuevo_vehiculo_a_alquilar;
            
            -- se realiza la reserva
            realizar_reserva(cliente_seleccionado, dia_actual, pk_reserva);
            
            -- se alquila el vehiculo
            reserva_and_alquiler_pkg.realizar_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado, pk_reserva);
            
            -- se llama al escenario 'pago de alquiler'
            reserva_and_alquiler_pkg.pago_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
            
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('          RESULTADO: se finalizo el alquiler satisfactoriamente');
            
            -- finaliza el procedure
            return;
        end if;
        
        ------------------------------------------------------------------------
        -- si no se selecciono un vehiculo entonces no hay con las mismas caracteristicas en otras sedes
        -- disponibles para ser alquilados, por lo tanto se alquila el primer vechiculo en otra sede que este disponible
        
        DBMS_OUTPUT.PUT_LINE('          - No se pudo encontrar otro vechiulo con las mismas carcateristicas en otra sede,  se procede a seleccionar el primer vehiculo disponible');
        
        open todos_vehiculos_de_las_otras_sedes;
        loop 
            fetch todos_vehiculos_de_las_otras_sedes into vehiculo_row;
            exit when todos_vehiculos_de_las_otras_sedes%notfound;

            -- llamamos a la funcion para veirficar si el vehiculo esta disponible
            vehiculo_disponible := reserva_and_alquiler_pkg.verificar_periodo_valido(vehiculo_row, periodo_alquiler);
            
            -- verificamos si el vehiculo esta disponible
            if (vehiculo_disponible) then
                nuevo_vehiculo_a_alquilar := vehiculo_row;
                -- salimos del bucle de busqueda de vehiculos
                exit;
            end if;
        end loop;
        -- cerramos el cursor
        close todos_vehiculos_de_las_otras_sedes;
        -- luego de este proceso se verifica si selecciono un vehiculo
        if (nuevo_vehiculo_a_alquilar.v_placa is not NULL) then
            -- si se selecciono entonces existe un vehiculo con las mismas caracteristica en otra sede que puede ser alquilado
            DBMS_OUTPUT.PUT_LINE('          - Existe un vehiculo disponible, se procede a su alquiler.');
            
            vehiculo_seleccionado := nuevo_vehiculo_a_alquilar;
            
            -- se realiza la reserva
            realizar_reserva(cliente_seleccionado, dia_actual, pk_reserva);
            
            -- se alquila el vehiculo
            reserva_and_alquiler_pkg.realizar_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado, pk_reserva);
            
            -- se llama al escenario 'pago de alquiler'
            reserva_and_alquiler_pkg.pago_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
            
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('          RESULTADO: se finalizo la reserva y alquiler satisfactoriamente');
            
            -- finaliza el procedure
            return;
        else 
            -- no existe ningun vehiculo disponible para alquiler
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('          RESULTADO: no hay vehiculos disponibles, no se puede realizar la reserva');
        end if;
        
    end solucion_vehiculo_no_disponible_en_sede_para_reserva;
    
    ----------------------------------------------------------------------------
    -- funcion para el fallo en pago
    function fallo_durante_pago(forma_pago_actual forma_pago%rowtype) return boolean
    is
        se_dio_un_fallo boolean := false; -- varibale a retornar por si se dio un fallo o no
        error_que_ocurrio varchar2(35);
        
        -- errores para las posibles opciones
        TYPE tipos_de_fallos IS VARRAY(5) OF VARCHAR2(35);
        errores_efectivo tipos_de_fallos := tipos_de_fallos('Billete invalido', 'Cambio insuficiente');
        errores_tranferencia tipos_de_fallos := tipos_de_fallos('Perdida de conexion', 'Fondo insuficiente', 'Seguridad bancaria');
        errores_pago_movil tipos_de_fallos :=  tipos_de_fallos('Perdida de conexion', 'Fondo insuficiente');
        errores_tarjeta_internacional tipos_de_fallos := tipos_de_fallos('Perdida de conexion', 'Fondo insuficiente', 'Seguridad bancaria');
        errores_criptomonedas tipos_de_fallos := tipos_de_fallos('Perdida de conexion', 'Fondo insuficiente');
    begin
        -- se verifica si se genero un fallo o no
        if (utilities_pkg.get_random_integer(0,101) <= 20) then
            -- actualizamos la variable a retornar
            se_dio_un_fallo := true;
            
            -- verificamos que tipo de error se dara segun el metodo de pago
            if (forma_pago_actual.fp_nombre = 'Efectivo') then
                -- caso cuando el metodo de pago Efectivo
                -- seleccionamos uno de los posibles fallos para este metodo
                error_que_ocurrio := errores_efectivo(
                    utilities_pkg.get_random_integer(1,3)
                );
            elsif (forma_pago_actual.fp_nombre = 'Transferencia') then
                -- caso cuando el metodo de pago Transferencia
                -- seleccionamos uno de los posibles fallos para este metodo
                error_que_ocurrio := errores_tranferencia(
                    utilities_pkg.get_random_integer(1,4)
                );
            elsif (forma_pago_actual.fp_nombre = 'Pago movil') then
                -- caso cuando el metodo de pago Pago movil
                -- seleccionamos uno de los posibles fallos para este metodo
                 error_que_ocurrio := errores_pago_movil(
                    utilities_pkg.get_random_integer(1,3)
                );
            elsif (forma_pago_actual.fp_nombre = 'Tarjeta Internacional') then
                -- caso cuando el metodo de pago Tarjeta Internacional
                -- seleccionamos uno de los posibles fallos para este metodo
                 error_que_ocurrio := errores_tarjeta_internacional(
                    utilities_pkg.get_random_integer(1,4)
                );
            elsif (forma_pago_actual.fp_nombre = 'Criptomoneda') then
                -- caso cuando el metodo de pago Criptomoneda
                -- seleccionamos uno de los posibles fallos para este metodo
                 error_que_ocurrio := errores_criptomonedas(
                    utilities_pkg.get_random_integer(1,3)
                );
            end if;
            
            -- imprimimos que se dio el error
            DBMS_OUTPUT.PUT_LINE('      Ocurrio un error con el tipo de metodo de pago ' || 
                                    forma_pago_actual.fp_nombre ||
                                    ' ' || error_que_ocurrio);
        end if;
        
        return se_dio_un_fallo;
    end fallo_durante_pago;
    ----------------------------------------------------------------------------
    -- procedure para el pago del alquiler
    procedure pago_alquiler(cliente_seleccionado cliente%rowtype, vehiculo_seleccionado vehiculo%rowtype, periodo_alquiler periodo_duracion, alquiler_realizado alquiler%rowtype)
    is 
        detalle_alquiler_actual detalle_alquiler%rowtype; -- variable para guardar el detalle alquiler del alqjiler acutla que se esta pagando
        monto_a_pagar_total number := 0; -- valor total a pagar
        tipo_cliente_actual tipo_cliente%rowtype; -- tipo de cliente del cliente actual seleccionado
        descuento_aplicado number := 0; -- variable para llevar el conteo del descuento aplicado. el desceunto se llevo con enteros del 0 al 100
        cant_metodos_pago_a_utilizar number; -- variable para guardar cuantos metodos de pago se utilizaran
        monto_pagar_por_metodo_pago number := 0; -- variable para guardar cuanto se pagara por cada metodo de pago
        
        -- variables para el cursor de historico de promociones
        -- se seleccionan todos los historicos de promociones para el carro que se desea alquilar
        cursor historicos_promociones is select * 
            from historico_promocion hp
            where hp.vehiculo_v_placa=vehiculo_seleccionado.v_placa and
                ( (
                    select SYSDATE from dual
                ) >= hp.hp_periodo_duracion.P_Fecha_Inicio) and 
                ( (
                    select SYSDATE from dual
                ) <= hp.hp_periodo_duracion.P_Fecha_Fin);
        -- se crea la variable para poder recorrer el cursor
        historico_promocion_row historico_promocion%rowtype := NULL;
        -- variable para buscar la promocion a la que este historico pertenece
        promocion_row promocion%rowtype := NULL;
        
        -- variables para el cursor de metodos de pago
        -- se seleccionan todos los metodos de pagos
        cursor formas_pago is select * 
            from forma_pago fp;
        -- se crea la variable para poder recorrer el cursor
        forma_pago_row forma_pago%rowtype := NULL;
    begin
            -- se imprimer que se va a pagar
             DBMS_OUTPUT.PUT_LINE('  - Se procede a pagar el alquiler:');
             
             -- buscamos el detalle del alquiler del alquiler que se va a pagar
             select * into detalle_alquiler_actual
                from detalle_alquiler da
                where da.da_id = alquiler_realizado.detalle_alquiler_da_id;
            
            -- calculamos el valor total a pagar por el alquiler, que sera igual al precio del vechiculo por dia alquilado
            monto_a_pagar_total := periodo_alquiler.get_cantidad_dias_del_periodo() * vehiculo_seleccionado.v_precio;
            
            -- buscamos las promociones que se encuentren activas y sumamos el descuento 
            OPEN historicos_promociones;
            LOOP
                FETCH historicos_promociones into historico_promocion_row;
                EXIT WHEN historicos_promociones%notfound; 
                
                -- verificamos si esta activa la promocion
                if (historico_promocion_row.hp_periodo_duracion.verificar_activo()) then
                    -- si esta activa buscamos la promocion
                    select * into promocion_row 
                    from promocion p
                    where p.p_id = historico_promocion_row.promocion_p_id;
                    
                    -- sumamos el porcentaje de descuento al total si al sumar no da mayor a 100
                    if (descuento_aplicado + promocion_row.p_porcentaje_descuento <= 100) then
                        -- sumamos al total de descuento que se desea aplicar
                        descuento_aplicado := descuento_aplicado + promocion_row.p_porcentaje_descuento;
                    end if;
                end if;
                
            end loop;
            close historicos_promociones;
            
             -- buscamos el tipo del cliente
            select * into tipo_cliente_actual from tipo_cliente tc where tc.tc_id=cliente_seleccionado.tipo_cliente_tc_id;
            -- si el cliente es VIP aplicamos un 15% de descuento
            if (tipo_cliente_actual.tc_nombre = 'VIP' and descuento_aplicado + 15 <= 100) then 
                -- sumamos al total de descuento el 15%
                descuento_aplicado := descuento_aplicado + 15;
            end if;
            
            DBMS_OUTPUT.PUT_LINE('      Monto a pagar ' || to_char(monto_a_pagar_total) || ' con un descuento de ' || to_char(descuento_aplicado));
            
            -- aplicamos el descuento
            monto_a_pagar_total := monto_a_pagar_total - (monto_a_pagar_total * descuento_aplicado/100);
            
            if(monto_a_pagar_total = 0) then
               DBMS_OUTPUT.PUT_LINE('       Monto a pagar es 0 por lo tanto no hay nada a cancelar');
               return;
            else 
                DBMS_OUTPUT.PUT_LINE('      Monto a pagar con descuento aplicado ' || to_char(monto_a_pagar_total));
            end if;
            
            -- verificamos cuantas pagos se haran, es decir cuantos metodos de pago se utilizaran
            -- tenemos por ahora 5 metodos de pagos por lo tanto como maximo se pueden hacer 4 pagos
            cant_metodos_pago_a_utilizar := utilities_pkg.get_random_integer(1, 6);
            -- calculamos el monto a pagar por metodo de pago se hara monto_pagar / cant_metodos_pago_a_utilizar
            monto_pagar_por_metodo_pago := (monto_a_pagar_total)/cant_metodos_pago_a_utilizar;
            
            DBMS_OUTPUT.PUT_LINE('      Se pagaran con ' || to_char(cant_metodos_pago_a_utilizar) || 
                                ' metodos y se cancelara por cada uno ' || 
                                to_char(monto_pagar_por_metodo_pago));
            
            -- iteramos por los metodos de pago
            -- abrimos el cursor e iteramos sobre el 
            open formas_pago;
            loop 
                fetch formas_pago into forma_pago_row;
                exit when formas_pago%notfound;
                while true
                loop 
                    -- verificamos si se da un error o no 
                    if(not reserva_and_alquiler_pkg.fallo_durante_pago(forma_pago_row)) then
                        -- pagar con el metodo
                        insert into detalle_pago values (
                            default,
                            forma_pago_row.fp_id,
                            monto_pagar_por_metodo_pago,
                            alquiler_realizado.a_id
                        );
                        -- salimos del while
                        exit;
                    end if;
                    -- no se cumple la condicion por lo tanto hubo un problema se vuelve a intentar
                end loop;
                -- se verifica si se llego al index deseado
                if (cant_metodos_pago_a_utilizar = formas_pago%rowcount) then
                    -- salimos del loop del cursor
                    exit;
                end if;
            end loop;
            -- cerramos el cursor
            close formas_pago;
            
            -- luego de salir del bucle ya se debio cancelar todo lo referente al pago
            
            -- imprimimos que se realizo el pago del alquiler
            DBMS_OUTPUT.PUT_LINE('      Se completo el pago del alquiler.');
            
    end pago_alquiler;
    ----------------------------------------------------------------------------
    -- procedure para alquilar
    procedure realizar_alquiler(cliente_reservar cliente%rowtype, vehiculo_seleccionado vehiculo%rowtype, periodo_alquiler periodo_duracion, ultimo_alquiler_realizado IN OUT alquiler%rowtype, reserva_pk number DEFAULT NULL)
    is
        dia_atual   date;               -- dia actual EL DIA DEBERIA SER PASADO COMO PARAMETRO
        detalle_alquiler_id number;     -- detalle del alquiler recien insertado
        alquiler_id number;             -- alquiler recien insertado
        monto_a_pagar_total number;     -- monto total a insertar en alquiler
    begin
        -- buscamos el dia actual
        select SYSDATE into dia_atual from dual;
        -- calculamos el monto total a insertar
        monto_a_pagar_total := periodo_alquiler.get_cantidad_dias_del_periodo() * vehiculo_seleccionado.v_precio;
        
        -- insertar el detalle de alquiler
        insert into detalle_alquiler values (
            default,
            vehiculo_seleccionado.v_precio,
            vehiculo_seleccionado.v_km,
            0,
            periodo_alquiler.get_cantidad_dias_del_periodo(),
            dia_atual,
            vehiculo_seleccionado.v_placa
        ) returning da_id into detalle_alquiler_id;
        
        -- insertar el alquiler
        insert into alquiler values (
            default,
            monto_a_pagar_total,
            periodo_alquiler,
            reserva_pk,
            detalle_alquiler_id,
            cliente_reservar.c_id
        ) returning a_id into alquiler_id;
        
        -- si el ultimo alquiler vale NULL retornar y no hacer nada
        --if (ultimo_alquiler_realizado.a_id is NULL) then
            --return;
        --end if;
        
        -- modificamos el valor del ultimo alquiler realizado
        select * into ultimo_alquiler_realizado
            from alquiler a
            where a.a_id = alquiler_id;
            
        -- llamamos al modulo de mantenimiento siguiente durante alquiler
        mantenimiento_pkg.siguiente_mantenimiento_durante_alquiler(
            periodo_alquiler.P_Fecha_Inicio, 
            periodo_alquiler.P_Fecha_Fin, 
            vehiculo_seleccionado.v_placa
        );
        
    end realizar_alquiler;
    ----------------------------------------------------------------------------
    -- procedure para reserva
    procedure realizar_reserva(cliente_reservar cliente%rowtype, dia_actual date, pk_reserva OUT number)
    is 
        tipo_cliente_actual tipo_cliente%rowtype;   -- tipo de cliente del cliente actual
        periodo_duracion_reserva periodo_duracion;  -- periodo durante el cual sera el alquiler a reservar
        time_stamp_actual timestamp;                      -- timestamp por si desea entrega
        
    begin
        -- realizamos la reserva y guardamos el id en la varibale de salida
        insert into reserva values (
            default,
            dia_actual,
            'HECHA',
            cliente_reservar.c_id
        ) returning re_id into pk_reserva;
        
        -- validamos si el cliente desea una entrega
        if (utilities_pkg.get_random_integer(1, 101) <= 50) then
            
            -- tomamos el time stamp
            select CURRENT_TIMESTAMP into time_stamp_actual from DUAL;
        
            insert into entrega values (
                default,
                time_stamp_actual,
                utilities_pkg.get_random_ubicacion_geografica(),
                'Entrega del vehiculo necesaria a una direccion',
                pk_reserva
            );
            DBMS_OUTPUT.PUT_LINE('      La reserva requiere de una entrega');
        end if;
       
    end realizar_reserva;
    ----------------------------------------------------------------------------
    -- procedure para simular las reservas
    procedure simulacion_reservas(pk_sede number, dia_actual date, fecha_fin_simulacion date) 
    is
        numero_reservas number;                     -- numero de alquileres a realizar
        numero_intentos_cliente number := 1;        -- numero de intentos del cliente 
        
        prob_cliente number := 75;                  -- probabilidad en % de que se seleccione un cliente para realizar el proceso de alquiler
        cliente_seleccionado cliente%rowtype;       -- cliente seleccionado en el caso de que se haya seleccionado uno
        persona_seleccionada persona%rowtype;       -- persona seleccionada en el caso de que se haya seleccionado una
        pk_reserva  number := NULL;                         -- parametro OUT para realizar_reserva
        alquiler_realizado alquiler%rowtype;        -- ultimo alquiler realizado
        
        vehiculo_seleccionado vehiculo%rowtype;   -- variable para guardar el vehiculo seleccionado aleatoriamente
        periodo_alquiler periodo_duracion;        -- periodo durante el que se realizara el alquiler
        
        tipo_cliente_actual tipo_cliente%rowtype; -- tipo de cliente del cliente actual seleccionado
        
        se_puede_realizar_un_alquiler boolean := false; -- variable para verificar si se podra realizar un alquiler o no
        sigue_bucle_alquiler_para_mismo_cliente boolean := true; -- variable para verificar si se sigue con el bucle de alquiler para el cliente que esta seleccionado
    begin
        -- indicamos que dio inicio el modulo
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('-------------- INICIA LA SIMULACION DE RESERVAS --------------');
        DBMS_OUTPUT.PUT_LINE('');
        -- numero de reservas a realizar
        numero_reservas := utilities_pkg.get_random_integer(0,11);
        DBMS_OUTPUT.PUT_LINE('  Se realizaran ' || to_char(numero_reservas) || ' reservas');
        -- iteramos para cada reserva
        for i in 1..numero_reservas loop
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('  ---- Reserva numero ' || to_char(i) || ' ----');
            DBMS_OUTPUT.PUT_LINE('');
            
            -- verificamos si la reserva la hara una persona o un cliente basado en la probabilidad establecida
            if(utilities_pkg.get_random_integer(0, 101) <= 75) then
                -- si la hace un cliente 
                cliente_seleccionado := utilities_pkg.get_cliente_random();
            else
                -- si la hace una persona no registrada
                persona_seleccionada := utilities_pkg.get_persona_random();
                -- registramos la persona en el sistema
                -- para ello se llama al modulo 4(paquete: gestion_clientes_pkg)
                -- esta funciona selecciona al cliente a la misma vez
                gestion_clientes_pkg.registro_cliente(persona_seleccionada, cliente_seleccionado);
            end if;
            
            DBMS_OUTPUT.PUT_LINE('      - Intentara realizar la reserva el cliente: ');
            utilities_pkg.print_cliente(cliente_seleccionado);
            
            -- buscamos el tipo del cliente
            select * into tipo_cliente_actual from tipo_cliente tc where tc.tc_id=cliente_seleccionado.tipo_cliente_tc_id;
            
            -- se verifica si el cliente es del tipo no deseado
            if(tipo_cliente_actual.tc_nombre = 'no deseado') then
                -- imprimimos mensaje de error y el cliente
                DBMS_OUTPUT.PUT_LINE('      ALERTA: este cliente no puede realizar reservas debido a que es NO DESEADO');
                utilities_pkg.print_cliente(cliente_seleccionado, 'NO DESEADO');
                continue;
            end if;
            
            -- loop para poder simular si el cliente quiere tratar de reservar otro carro dado que el que selecciono la primera vez no estaba disponible
            -- y no existe otro vechiculo con las mismas caracteristicas
            while sigue_bucle_alquiler_para_mismo_cliente
            loop 
                DBMS_OUTPUT.PUT_LINE('');
                DBMS_OUTPUT.PUT_LINE('      ---- Intento numero ' || to_char(numero_intentos_cliente) || ' del cliente');
                DBMS_OUTPUT.PUT_LINE('');
                
                -- se hace el loop cuantas veces el cliente quiere intentar alquilar nuevamente dado que el vehiculo seleccionado no se encuentra disponible
                -- ni ninguno otro con iguales caracteristica
                
                -- se selecciona al azar un vehiculo de la sede, este o no disponible
                vehiculo_seleccionado := utilities_pkg.get_vehiculo_random(pk_sede);
                if (vehiculo_seleccionado.v_placa is NULL) then
                    DBMS_OUTPUT.PUT_LINE('          - No se selecciono un vehiculo, finaliza todo el proceso para este cliente. ');
                    exit;
                end if;
                DBMS_OUTPUT.PUT_LINE('          - El cliente selecciono el vehiculo: ');
                utilities_pkg.print_vehiculo(vehiculo_seleccionado);
                
                
                -- se selecciona un periodo de forma aleatoria 
                periodo_alquiler := utilities_pkg.get_random_periodo(dia_actual, fecha_fin_simulacion);
                DBMS_OUTPUT.PUT_LINE('          - El cliente selecciono el periodo ' || 
                                    TO_CHAR(periodo_alquiler.P_Fecha_Inicio , 'dd/mm/yyyy')|| 
                                    ' --- ' || 
                                    TO_CHAR(periodo_alquiler.P_Fecha_Fin , 'dd/mm/yyyy')
                );
                
                -- se llama al escenario 'comprobacion de disponibilida de vehiculo'
                se_puede_realizar_un_alquiler := comprobacion_disponibilidad_vehiculo(vehiculo_seleccionado, periodo_alquiler, pk_sede);
                
                -- se verifica si se pudo realizar un alquiler
                if(se_puede_realizar_un_alquiler) then
                
                    -- se realiza la reserva
                    realizar_reserva(cliente_seleccionado, dia_actual, pk_reserva);
                
                    -- se realiza el alquiler
                    realizar_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado, pk_reserva);
                    
                    -- se llama al escenario 'pago de alquiler'
                    pago_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
                    
                    DBMS_OUTPUT.PUT_LINE('');
                    DBMS_OUTPUT.PUT_LINE('          - RESULTADO: se realizo la reserva y alquiler satisfactoriamente');
                    
                    -- salimos del loop while
                    exit;
                else 
                    -- si no se pudo realizar un alquiler es porque no existen vehiculos con las mismas caracteristicas que el seleccionado por primera vez
                    -- se verifica si el cliente desea alquilar otro vechiculo diferente o no
                    if(utilities_pkg.get_random_integer(0, 101) <= 25) then
                        -- el cliente desea alquiler otro carro entonces se mantiene 'sigue_bucle_alquiler_para_mismo_cliente' en true 
                        DBMS_OUTPUT.PUT_LINE('          - Cliente no pudo alquilar, pero seguira intentando');
                        
                        -- actualizamos la varibale de intentos de conteo
                        numero_intentos_cliente := numero_intentos_cliente + 1;
                    else 
                        -- el cliente no desea realizar un alquiler con otro carro entonces se cambia 'sigue_bucle_alquiler_para_mismo_cliente' a false  
                        DBMS_OUTPUT.PUT_LINE('          - Cliente no pudo reservar el vehiculo en la sede ' || pk_sede);
                        DBMS_OUTPUT.PUT_LINE('          - Se llama escenario 6 "Solución a carro no disponible para reserva en sede" para encontrar una solucion');
                        
                        -- se llama al escenario 6
                        solucion_vehiculo_no_disponible_en_sede_para_reserva(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, pk_sede, dia_actual);
                        
                        -- si cambia la variable a false ya que no seguira intentando por este medio, se llamara al escenario 6
                        sigue_bucle_alquiler_para_mismo_cliente := false;
                    end if;
                end if;
                
            end loop;
            
            -- preparamos las variables para la siguiente iteracion
            cliente_seleccionado := NULL;
            persona_seleccionada := NULL;
            sigue_bucle_alquiler_para_mismo_cliente := true;
            pk_reserva := NULL;
            numero_intentos_cliente := 1;
        end loop;
        
    end simulacion_reservas;
    ----------------------------------------------------------------------------
    -- procedure para simular el modulo de alquileres
    procedure simulacion_alquileres(pk_sede number, dia_actual date, fecha_fin_simulacion date) 
    is
        numero_alquileres number;                   -- numero de alquileres a realizar
        numero_intentos_cliente number := 1;        -- numero de intentos del cliente 
        
        prob_cliente number := 75;                  -- probabilidad en % de que se seleccione un cliente para realizar el proceso de alquiler
        cliente_seleccionado cliente%rowtype;       -- cliente seleccionado en el caso de que se haya seleccionado uno
        persona_seleccionada persona%rowtype;       -- persona seleccionada en el caso de que se haya seleccionado una
        alquiler_realizado alquiler%rowtype;        -- ultimo alquiler realizado
        
        vehiculo_seleccionado vehiculo%rowtype;   -- variable para guardar el vehiculo seleccionado aleatoriamente
        periodo_alquiler periodo_duracion;        -- periodo durante el que se realizara el alquiler
        
        tipo_cliente_actual tipo_cliente%rowtype; -- tipo de cliente del cliente actual seleccionado
        
        se_puede_realizar_un_alquiler boolean := false; -- variable para verificar si se podra realizar un alquiler o no
        sigue_bucle_alquiler_para_mismo_cliente boolean := true; -- variable para verificar si se sigue con el bucle de alquiler para el cliente que esta seleccionado
    begin
        -- indicamos que dio inicio el modulo
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('-------------- INICIA LA SIMULACION DE ALQUILERES --------------');
        DBMS_OUTPUT.PUT_LINE('');
        -- numero de alquileres a realizar
        numero_alquileres := utilities_pkg.get_random_integer(0,11);
        DBMS_OUTPUT.PUT_LINE('  Se realizaran ' || to_char(numero_alquileres) || ' alquileres');
        -- iteramos para cada reserva
        for i in 1..numero_alquileres loop
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('  ---- Alquiler numero ' || to_char(i) || ' ----');
            DBMS_OUTPUT.PUT_LINE('');
            
            -- verificamos si el alquiler la hara una persona o un cliente basado en la probabilidad establecida
            if(utilities_pkg.get_random_integer(0, 101) <= 75) then
                -- si la hace un cliente 
                cliente_seleccionado := utilities_pkg.get_cliente_random();
            else
                -- si la hace una persona no registrada
                persona_seleccionada := utilities_pkg.get_persona_random();
                -- registramos la persona en el sistema
                -- para ello se llama al modulo 4(paquete: gestion_clientes_pkg)
                -- esta funciona selecciona al cliente a la misma vez
                gestion_clientes_pkg.registro_cliente(persona_seleccionada, cliente_seleccionado);
            end if;
            
            DBMS_OUTPUT.PUT_LINE('      - Intentara realizar el alquiler el cliente: ');
            utilities_pkg.print_cliente(cliente_seleccionado);
            
            -- buscamos el tipo del cliente
            select * into tipo_cliente_actual from tipo_cliente tc where tc.tc_id=cliente_seleccionado.tipo_cliente_tc_id;
            
            -- se verifica si el cliente es del tipo no deseado
            if(tipo_cliente_actual.tc_nombre = 'no deseado') then
                -- imprimimos mensaje de error y el cliente
                DBMS_OUTPUT.PUT_LINE('      ALERTA: este cliente no puede realizar alquileres debido a que es NO DESEADO');
                utilities_pkg.print_cliente(cliente_seleccionado, 'NO DESEADO');
                continue;
            end if;
            
            -- loop para poder simular si el cliente quiere tratar de alquiler otro carro dado que el que selecciono la primera vez no estaba disponible
            -- y no existe otro vechiculo con las mismas caracteristicas
            while sigue_bucle_alquiler_para_mismo_cliente
            loop 
                DBMS_OUTPUT.PUT_LINE('');
                DBMS_OUTPUT.PUT_LINE('      ---- Intento numero ' || to_char(numero_intentos_cliente) || ' del cliente');
                DBMS_OUTPUT.PUT_LINE('');
                
                -- se hace el loop cuantas veces el cliente quiere intentar alquilar nuevamente dado que el vehiculo seleccionado no se encuentra disponible
                -- ni ninguno otro con iguales caracteristica
                
                -- se selecciona al azar un vehiculo de la sede, este o no disponible
                vehiculo_seleccionado := utilities_pkg.get_vehiculo_random(pk_sede);
                if (vehiculo_seleccionado.v_placa is NULL) then
                    DBMS_OUTPUT.PUT_LINE('          - No se selecciono un vehiculo, finaliza todo el proceso para este cliente. ');
                    exit;
                end if;
                DBMS_OUTPUT.PUT_LINE('          - El cliente selecciono el vehiculo: ');
                utilities_pkg.print_vehiculo(vehiculo_seleccionado);
                
                
                -- se selecciona un periodo de forma aleatoria 
                periodo_alquiler := utilities_pkg.get_random_periodo_fecha_inicio_seteada(dia_actual, fecha_fin_simulacion);
                DBMS_OUTPUT.PUT_LINE('          - El cliente selecciono el periodo ' || 
                                    TO_CHAR(periodo_alquiler.P_Fecha_Inicio , 'dd/mm/yyyy')|| 
                                    ' --- ' || 
                                    TO_CHAR(periodo_alquiler.P_Fecha_Fin , 'dd/mm/yyyy')
                );
                
                -- se llama al escenario 'comprobacion de disponibilida de vehiculo'
                se_puede_realizar_un_alquiler := comprobacion_disponibilidad_vehiculo(vehiculo_seleccionado, periodo_alquiler, pk_sede);
                
                -- se verifica si se pudo realizar un alquiler
                if(se_puede_realizar_un_alquiler) then
                
                    -- se realiza el alquiler
                    realizar_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
                    
                    -- se llama al escenario 'pago de alquiler'
                    pago_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
                    
                    DBMS_OUTPUT.PUT_LINE('');
                    DBMS_OUTPUT.PUT_LINE('          - RESULTADO: se realizo el alquiler satisfactoriamente');
                    
                    -- salimos del loop while
                    exit;
                else 
                    -- si no se pudo realizar un alquiler es porque no existen vehiculos con las mismas caracteristicas que el seleccionado por primera vez
                    -- se verifica si el cliente desea alquilar otro vechiculo diferente o no
                    if(utilities_pkg.get_random_integer(0, 101) <= 25) then
                        -- el cliente desea alquiler otro carro entonces se mantiene 'sigue_bucle_alquiler_para_mismo_cliente' en true 
                        DBMS_OUTPUT.PUT_LINE('          - Cliente no pudo alquilar, pero seguira intentando');
                        
                        -- actualizamos la varibale de intentos de conteo
                        numero_intentos_cliente := numero_intentos_cliente + 1;
                    else 
                        -- el cliente no desea realizar un alquiler con otro carro entonces se cambia 'sigue_bucle_alquiler_para_mismo_cliente' a false  
                        DBMS_OUTPUT.PUT_LINE('          - Cliente no pudo alquilar el vehiculo en la sede ' || pk_sede);
                        DBMS_OUTPUT.PUT_LINE('          - Se llama escenario 6 "Solución a carro no disponible en sede" para encontrar una solucion');
                        
                        -- se llama al escenario 6
                        reserva_and_alquiler_pkg.solucion_vehiculo_no_disponible_en_sede(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, pk_sede);
                        
                        -- si cambia la variable a false ya que no seguira intentando por este medio, se llamara al escenario 6
                        sigue_bucle_alquiler_para_mismo_cliente := false;
                    end if;
                end if;
                
            end loop;
            
            -- preparamos las variables para la siguiente iteracion
            cliente_seleccionado := NULL;
            persona_seleccionada := NULL;
            sigue_bucle_alquiler_para_mismo_cliente := true;
            numero_intentos_cliente := 1;
        end loop;
        
    end simulacion_alquileres;
    ----------------------------------------------------------------------------
    -- procedure para simular un robo de vehiculo
    procedure robo_vehiculo(alquiler_a_finalizar alquiler%rowtype)
    is
    begin 
        DBMS_OUTPUT.PUT_LINE('          - El alquiler con el periodo ' || 
                TO_CHAR(alquiler_a_finalizar.a_periodo_duracion.P_Fecha_Inicio, 'dd/mm/yyyy') || ' ' || 
                TO_CHAR(alquiler_a_finalizar.a_periodo_duracion.P_Fecha_Fin, 'dd/mm/yyyy'));
        DBMS_OUTPUT.PUT_LINE('              - Finalizo con el robo del vehiculo');
        -- creamos la denuncia
        insert into denuncia values (
            default,
            alquiler_a_finalizar.a_periodo_duracion.P_Fecha_Fin,
            'Realizaron el robo de este vehiculo y no fue entregado el dia que finalizaba su alquiler',
            alquiler_a_finalizar.a_id
        );
        -- los triggers:
            -- cambio_status_cliente_por_robo: actualiza el status del cliente
            -- cambio_status_vehiculo_por_robo: actualiza el status del vehiculo
    end robo_vehiculo;
    ----------------------------------------------------------------------------
    -- procedure para actualizar el status del cliente
    procedure actualizacion_status_cliente(alquiler_a_finalizar alquiler%rowtype)
    is
        cantidad_alquileres_realizados_por_clientes number; -- cantidad de alquileres realizados por el cliente
        cliente_a_actualizar cliente%rowtype;               -- cliente a actualizar
        pk_tipo_cliente number;                             -- pk del tipo de cliente
        pk_tipo_cliente_VIP number;                         -- pk del tipo de cliente VIP
        pk_tipo_cliente_frecuente number;                   -- pk del tipo de cliente frecuente
    begin
        -- buscamos las PK de cada tipo de cliente
        select tc_id into pk_tipo_cliente_VIP from tipo_cliente where tc_nombre = 'VIP';
        select tc_id into pk_tipo_cliente_frecuente from tipo_cliente where tc_nombre = 'Frecuente';
        
        -- buscamos al cliente a actualizar
        select * into cliente_a_actualizar from cliente where c_id = alquiler_a_finalizar.cliente_c_id;
        
        -- buscamos la cantida de alquileres que ha realizado el cliente de este alquiler
        select count(alq.a_id) into cantidad_alquileres_realizados_por_clientes
                from alquiler alq
                where alq.cliente_c_id = alquiler_a_finalizar.cliente_c_id and
                    alquiler_a_finalizar.a_periodo_duracion.P_Fecha_Fin >= alq.a_periodo_duracion.P_Fecha_Fin;
                    
        -- actualizamos el status del cliente segun la cantidad de alquileres
        if (cantidad_alquileres_realizados_por_clientes >= 5 and cliente_a_actualizar.tipo_cliente_tc_id != pk_tipo_cliente_VIP) then
            -- actualizamos e imprimimos
            update cliente set tipo_cliente_tc_id = pk_tipo_cliente_VIP
                    where c_id = alquiler_a_finalizar.cliente_c_id;
            DBMS_OUTPUT.PUT_LINE('      - Se actualizara el tipo del cliente a VIP del cliente:');
            utilities_pkg.print_cliente(cliente_a_actualizar);
        elsif (3 <= cantidad_alquileres_realizados_por_clientes and cantidad_alquileres_realizados_por_clientes < 5 and cliente_a_actualizar.tipo_cliente_tc_id != pk_tipo_cliente_frecuente) then
             -- actualizamos e imprimimos
            update cliente set tipo_cliente_tc_id = pk_tipo_cliente_frecuente
                    where c_id = alquiler_a_finalizar.cliente_c_id;
            DBMS_OUTPUT.PUT_LINE('      - Se actualizara el tipo del cliente a Frecuente del cliente:'); 
            utilities_pkg.print_cliente(cliente_a_actualizar);
        end if;
        
    end actualizacion_status_cliente;
    ----------------------------------------------------------------------------
    -- procedure para finalizar un alquiler
    procedure finalizar_alquiler(alquiler_a_finalizar alquiler%rowtype)
    is
        detalle_alquiler_a_actualizar detalle_alquiler%rowtype; -- detalle alquiler a actualizar
        km_recorridos_durante_alquiler number;                  -- cantidad de km recorridos durante el alquiler 
        pk_rating number;                                       -- pk del rating insertado
        numero_rating number;                                   -- escala que dio el liente al alquiler
        vehiculo_a_validar_para_ser_vendido vehiculo%rowtype;   -- vehiculo para verificar su km
        -- arreglo de observaciones
        type observaciones_array IS VARRAY(9) OF CLOB;
        -- definimos el arreglo de observaciones
        posibles_observaciones observaciones_array := observaciones_array(
            'Mal servicio al cliente',
            'Demasiado tiempo de espera',
            'Mala calidad de autos',
            'Buen servicio, pero pueden mejorar la atencion al cliente',
            'Las condiciones del auto fueron buenas',
            'Fueron puntuales',
            'Excelente servicio',
            'Excelente calidad del auto',
            'Fueron puntuales y preocupados'
        );
        limite_inferior number; -- limite inferior del arreglo de observaciones
        limite_superior number; -- limite superior del arreglo de observaciones
    begin
        -- verificamos si se genera un robo
        if (utilities_pkg.get_random_integer(0, 101) <= 10) then
            -- llamamos a la funcion que simula un robo
            robo_vehiculo(alquiler_a_finalizar);
            
            -- finaliza sin actualizar el detalle ya que se dio un robo
            return;
        else
            -- buscamos el detalle del alquiler
            select * into detalle_alquiler_a_actualizar 
                    from detalle_alquiler
                    where da_id = alquiler_a_finalizar.detalle_alquiler_da_id;
            -- generamos una cantidad de Km aleatoria que recorrio el carro
            km_recorridos_durante_alquiler := utilities_pkg.get_random_integer(500, 5001);
            -- actualizamos el resultado del alquiler en detalle alquiler
            update detalle_alquiler 
                    set da_km_final = detalle_alquiler_a_actualizar.da_km_inicial + km_recorridos_durante_alquiler
                    where da_id = alquiler_a_finalizar.detalle_alquiler_da_id;
            -- eltrigger "actualizacion_vehiculo_al_finalizar_alquiler" actualiza de forma automatica el status del carro
            
            DBMS_OUTPUT.PUT_LINE('          - Finaliza el alquiler con el periodo ' || 
                TO_CHAR(alquiler_a_finalizar.a_periodo_duracion.P_Fecha_Inicio, 'dd/mm/yyyy') || ' ' || 
                TO_CHAR(alquiler_a_finalizar.a_periodo_duracion.P_Fecha_Fin, 'dd/mm/yyyy') || 
                ' donde se recorrieron ' || to_char(km_recorridos_durante_alquiler) || ' kms');
            
            -- actualizamos el status del cliente
            actualizacion_status_cliente(alquiler_a_finalizar);
            
            -- verificamos si el cliente desea dejar un rating o no
            if (utilities_pkg.get_random_integer(0, 101) <= 95) then
                -- si se deja un rating
                
                -- generamos el valor de la escala
                numero_rating := utilities_pkg.get_random_integer(1, 6);
                -- escogemos los limites supriores e inferiores del arreglo de observaciones
                if (numero_rating = 5) then
                    limite_inferior := 7;
                    limite_superior := 9;
                elsif (4 >= numero_rating and numero_rating >= 3) then
                    limite_inferior := 4;
                    limite_superior := 6;
                else
                    limite_inferior := 1;
                    limite_superior := 3;
                end if;
                
                -- insertamos el rating
                insert into rating values(
                    default,
                    alquiler_a_finalizar.a_periodo_duracion.P_Fecha_Fin,
                    numero_rating,
                    numero_rating,
                    alquiler_a_finalizar.a_id
                ) returning r_id into pk_rating;
                
                DBMS_OUTPUT.PUT_LINE('          - Cliente dejo un rating de ' || numero_rating || 'con las siguientes observaciones:');
                
                -- creamos las observaciones
                for observaciones_index in limite_inferior..limite_superior
                loop
                    insert into observacion values (
                        default,
                        posibles_observaciones(observaciones_index),
                        pk_rating
                    );
                    DBMS_OUTPUT.PUT_LINE('              - Observacion: ' || posibles_observaciones(observaciones_index));
                end loop;
            else
                -- si no se deja un rating
                return; -- pareciera que no hacemos nada
            end if;
            
            -- verificamos si el auto debe ser vendido -------------------------
            -- buscamos el auto del detalle de alquiler
            select * into vehiculo_a_validar_para_ser_vendido from vehiculo where v_placa = detalle_alquiler_a_actualizar.vehiculo_v_placa;
            -- verificamos si se vende
            inventario_pkg.fin_de_vida_util (
                vehiculo_a_validar_para_ser_vendido.sede_s_id, 
                vehiculo_a_validar_para_ser_vendido.v_placa
            );
        end if;
    end finalizar_alquiler;
    ----------------------------------------------------------------------------
    -- procedure para finalizar alquileres que terminan ese dia
    procedure simulacion_finalizacion_alquileres(dia_actual date)
    is
        cantidad_alquileres_que_finalizan number := 0; -- cantidad de alquileres que finalizan este dia
        -- variables para el cursor
        cursor alquileres_a_finalizar is select * from alquiler;
        alquiler_row alquiler%rowtype;
    begin
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('-------------- INICIA LA SIMULACION DE FINALIZACION DE ALQUILERES --------------');
        DBMS_OUTPUT.PUT_LINE('');
        -- contamos los alquileres que finalizan hoy
        -- iteramos sobre los alquileres a finalizar
        -- abrimos el cursor e iteramos sobre el 
        open alquileres_a_finalizar;
        loop 
            fetch alquileres_a_finalizar into alquiler_row;
            exit when alquileres_a_finalizar%notfound;
            -- verificamos si el alquiler finaliza este dia
            if (alquiler_row.a_periodo_duracion.P_Fecha_Fin = dia_actual) then
                -- finalizamos el alquiler
                cantidad_alquileres_que_finalizan := cantidad_alquileres_que_finalizan + 1;
            end if;
        end loop;
        close alquileres_a_finalizar;
        
        DBMS_OUTPUT.PUT_LINE('      - Este dia finalizan ' || cantidad_alquileres_que_finalizan || ' alquileres'); 
        
        -- iteramos sobre los alquileres a finalizar
        -- abrimos el cursor e iteramos sobre el 
        open alquileres_a_finalizar;
        loop 
            fetch alquileres_a_finalizar into alquiler_row;
            exit when alquileres_a_finalizar%notfound;
            -- verificamos si el alquiler finaliza este dia
            if (alquiler_row.a_periodo_duracion.P_Fecha_Fin = dia_actual) then
                -- finalizamos el alquiler
                finalizar_alquiler(alquiler_row);
            end if;
        end loop;
        -- cerramos el cursor
        close alquileres_a_finalizar;
    end simulacion_finalizacion_alquileres;
    ----------------------------------------------------------------------------
    -- procedure para simular cancelar reservas
    procedure cancelacion_reservas(dia_actual date)
    is 
        -- variables para el cursor
        cursor reservas_a_cancelar is select * from reserva;
        reserva_row reserva%rowtype;
        
        cantidad_reservas_eliminar number := 0;         -- cantidad de reservas a eliminar
        contador_reservas_eliminadas number := 0;       -- contador de cantidad de reservas eliminadas
        alquiler_de_la_reserva alquiler%rowtype;        -- aquiler de la reserva sobre la que se esta verificando
    begin
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('-------------- INICIA LA SIMULACION DE CANCELACION DE RESERVAS --------------');
        DBMS_OUTPUT.PUT_LINE('');
        
        -- verificamos si se cancelaran reservas
        if (utilities_pkg.get_random_integer(0, 101) <= 15) then
            DBMS_OUTPUT.PUT_LINE('      - Si se cancelaran reservas'); 
            
            -- generamos la cantidad de reservas a eliminar
            cantidad_reservas_eliminar := utilities_pkg.get_random_integer(1, 5);
            
            DBMS_OUTPUT.PUT_LINE('      - Se intentaran cancelar ' ||  to_char(cantidad_reservas_eliminar) || ' reservas'); 
            
            -- se eliminan las reservas y con ellas toda informacion
            -- iteramos sobre las reservas a cancelar
            -- abrimos el cursor e iteramos sobre el 
            open reservas_a_cancelar;
            loop 
                fetch reservas_a_cancelar into reserva_row;
                exit when reservas_a_cancelar%notfound;
                -- buscamos el alquiler de esta reserva
                select * into alquiler_de_la_reserva
                        from alquiler
                        where reserva_re_id = reserva_row.re_id;
                -- verificamos si el alquiler ya ha finalizado o no, para verificar si puede ser cancelado o no
                if ((dia_actual < alquiler_de_la_reserva.a_periodo_duracion.P_Fecha_Inicio) and (dia_actual < alquiler_de_la_reserva.a_periodo_duracion.P_Fecha_Fin)) then
                    -- no ha emppezado el alquiler por lo tanto puede ser cancelado
                    DBMS_OUTPUT.PUT_LINE('      - Se elimina la reserva realizada el dia ' || 
                                        TO_CHAR(reserva_row.re_fecha_realizacion, 'dd/mm/yyyy') ||
                                        ' para el periodo ' ||
                                        TO_CHAR(alquiler_de_la_reserva.a_periodo_duracion.P_Fecha_Inicio, 'dd/mm/yyyy') || '---' ||
                                        TO_CHAR(alquiler_de_la_reserva.a_periodo_duracion.P_Fecha_Fin, 'dd/mm/yyyy')
                    ); 
                    -- eliminamos la reserva y con ello todos los datos referentes a ella gracias al on cascade y al trigger
                    delete from reserva where re_id = reserva_row.re_id;
                    -- actualizamos el contador
                    contador_reservas_eliminadas := contador_reservas_eliminadas + 1;
                end if;
                
                -- verificamos si se llego a la cantidad de reservas eliminadas
                if (contador_reservas_eliminadas = cantidad_reservas_eliminar) then
                    DBMS_OUTPUT.PUT_LINE('      - Elimino la cantidad de reservas totales ');
                    exit;
                end if;
            end loop;
        else
            DBMS_OUTPUT.PUT_LINE('      - No se cancelaran reservas'); 
        end if;
    end cancelacion_reservas;
    ----------------------------------------------------------------------------
    -- procedure para simular un error en el alquiler
    procedure problema_durante_alquiler(alquiler_a_fallar alquiler%rowtype, pk_sede number, dia_actual date)
    is 
        existe_alianza_para_tipo_fallo boolean := false;    -- variable para saber si existe una alianza para ese fallo
        tipo_fallo_seleccionado clob;                       -- variable para tipo de fallo seleccionado
        cliente_para_alquilar cliente%rowtype;              -- cliente que debe realizar el alquiler
        periodo_alquiler periodo_duracion;                  -- periodo de duracion del alquiler
        vehiculo_seleccionado vehiculo%rowtype;              -- estilo de vehiculo que se quiere alquilar
        
        -- variables para el cursor
        cursor alianzas_activas_en_sede is 
            select  al.aa_id,
                    al.aa_periodo_duracion,
                    al.aa_descripcion,
                    al.aa_tipo,
                    al.aliado_ao_id,
                    al.sede_s_id
            from alianza al where al.sede_s_id = pk_sede;
        -- variable para recorrer el cursor
        alianza_row alianza%rowtype;
        
        -- arreglo de posibles fallos
        type tipos_fallos_array IS VARRAY(2) OF CLOB;
        tipos_fallos tipos_fallos_array := tipos_fallos_array(
            'Fallo choque',
            'Fallo dano'
        );
    begin
        -- verificamos si se da un fallo
        if (utilities_pkg.get_random_integer(0, 101) <= 10) then
            DBMS_OUTPUT.PUT_LINE('      - Se dara un error sobre el alquiler ' || 
                                alquiler_a_fallar.a_id || 
                                ' del periodo ' || 
                                TO_CHAR(alquiler_a_fallar.a_periodo_duracion.P_Fecha_Inicio, 'dd/mm/yyyy') || '---' ||
                                TO_CHAR(alquiler_a_fallar.a_periodo_duracion.P_Fecha_Fin, 'dd/mm/yyyy')
            );
            
            -- seleccionamos un tipo de fallo
            tipo_fallo_seleccionado := tipos_fallos(utilities_pkg.get_random_integer(1, 3));
            
            -- verificamos si existen promociones activas para el vehiculo del alquiler
            -- recorremos el cursor
            -- abrimos el cursor e iteramos sobre el 
            open alianzas_activas_en_sede;
            loop 
                fetch alianzas_activas_en_sede into alianza_row;
                exit when alianzas_activas_en_sede%notfound;
                -- se llama al modulo de fallo en alquiler
                if (
                    alianza_row.aa_periodo_duracion.P_Fecha_Inicio <= alquiler_a_fallar.a_periodo_duracion.P_Fecha_Inicio and
                    alianza_row.aa_tipo = tipo_fallo_seleccionado
                ) then
                    -- salimos del loop
                    existe_alianza_para_tipo_fallo := true;
                    exit;
                end if;
            end loop;
            -- cerramos el cursor
            close alianzas_activas_en_sede;
            
            -- verificamos si existe una alianza para este tipo de fallo
            if (existe_alianza_para_tipo_fallo) then
                DBMS_OUTPUT.PUT_LINE('      - Existe una alianza para este tipo de fallo, por lo tanto no se registra un gasto');
            else
                DBMS_OUTPUT.PUT_LINE('      - No existe una alianza para este tipo de fallo, por lo tanto se registra un gasto');
                -- insertamos un gasto operacional de 2000
                insert into gasto values (
                    default,
                    2000,
                    dia_actual,
                    'Se genero por ' || tipo_fallo_seleccionado,
                    (select tg_id from tipo_gasto where tg_nombre = 'Operacionales'),
                    pk_sede
                );
            end if;
            
            -- finalizamos el alquiler
            finalizar_alquiler(alquiler_a_fallar);
            DBMS_OUTPUT.PUT_LINE('      - Finalizamos el alquiler');
            
            -- buscamos el cliente
            select * into cliente_para_alquilar from cliente where c_id = alquiler_a_fallar.cliente_c_id;
            
            -- creamos el periodo
            periodo_alquiler := periodo_duracion(
                dia_actual,
                alquiler_a_fallar.a_periodo_duracion.P_Fecha_Fin
            );
            
            -- traemos el auto seleccionado para tratar de alquilar uno parecido a traves del escenario 6
            select  v.v_placa,
                    v.v_anno,
                    v.v_foto,
                    v.v_km,
                    v.v_precio,
                    v.modelo_m_id,
                    v.modelo_marca_ma_id,
                    v.status_vehiculo_sv_id,
                    v.color_c_id,
                    v.tipo_vehiculo_tv_id,
                    v.sede_s_id
                    into vehiculo_seleccionado 
                    from vehiculo v, detalle_alquiler da
                    where alquiler_a_fallar.detalle_alquiler_da_id = da.da_id and
                          da.vehiculo_v_placa = v.v_placa;
            
            -- realizamos el mantenimiento del vehiculo
            insert into mantenimiento_vehiculo values (default
                                                        ,periodo_duracion(dia_actual,dia_actual+1)
                                                        ,dia_actual+90
                                                        ,2000
                                                        ,vehiculo_seleccionado.v_placa
                                                        ,(SELECT s_id from status_mantenimiento where s_nombre='Operativo')
                                                        ,(SELECT mt_id from mantenimiento_taller fetch first 1 rows only)
                                                        );
            update vehiculo
                set status_vehiculo_sv_id=(select sv_id from status_vehiculo where sv_nombre='En mantenimiento')
                where v_placa = vehiculo_seleccionado.v_placa;
                
            DBMS_OUTPUT.PUT_LINE('      - Registramos el mantenimiento');
            
            -- REALIZAMOS EL ALQUILER       
            -- se llama al escenario 6
            solucion_vehiculo_no_disponible_en_sede(cliente_para_alquilar, vehiculo_seleccionado, periodo_alquiler, pk_sede);
            
        else 
            DBMS_OUTPUT.PUT_LINE('      - No se dara un error sobre el alquiler ' || 
                                alquiler_a_fallar.a_id || 
                                ' del periodo ' || 
                                TO_CHAR(alquiler_a_fallar.a_periodo_duracion.P_Fecha_Inicio, 'dd/mm/yyyy') || '---' ||
                                TO_CHAR(alquiler_a_fallar.a_periodo_duracion.P_Fecha_Fin, 'dd/mm/yyyy')
            );
        end if;
    end problema_durante_alquiler;
    ----------------------------------------------------------------------------
    -- procedure para simular errores en alquileres activos
    procedure simulacion_problemas_durante_alquileres(pk_sede number, dia_actual date)
    is 
        cantidad_alquileres_que_finalizan number := 0; -- cantidad de alquileres que finalizan este dia
        -- variables para el cursor
        cursor alquileres_activos_de_la_sede is 
            select  a.a_id,
                    a.a_monto_total,
                    a.a_periodo_duracion,
                    a.reserva_re_id,
                    a.detalle_alquiler_da_id,
                    a.cliente_c_id    
            from alquiler a, detalle_alquiler da, vehiculo v
            where a.detalle_alquiler_da_id = da.da_id and
                  da.vehiculo_v_placa = v.v_placa and
                  v.sede_s_id = pk_sede and
                  a.a_periodo_duracion.P_Fecha_Inicio <= dia_actual and
                  a.a_periodo_duracion.P_Fecha_Fin >= dia_actual;
        -- variable para recorrer el cursor
        alquiler_row alquiler%rowtype;
    begin
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('-------------- INICIA LA SIMULACION DE PROBLEMAS DURANTE ALQUILER --------------');
        DBMS_OUTPUT.PUT_LINE('');
        
        -- recorremos el cursor
        -- abrimos el cursor e iteramos sobre el 
        open alquileres_activos_de_la_sede;
        loop 
            fetch alquileres_activos_de_la_sede into alquiler_row;
            exit when alquileres_activos_de_la_sede%notfound;
            -- se llama al modulo de fallo en alquiler
           problema_durante_alquiler(alquiler_row, pk_sede, dia_actual);
        end loop;
        -- cerramos el cursor
        close alquileres_activos_de_la_sede;
        
    end simulacion_problemas_durante_alquileres;
    
end reserva_and_alquiler_pkg;
/
