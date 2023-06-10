create or replace package reserva_and_alquiler_pkg as
    -- funcion para verificar si el vehiculo podria ser alquilado en un periodo dado
    function verificar_periodo_valido(vehiculo_seleccionado vehiculo%rowtype, periodo_alquiler periodo_duracion) return boolean;
    -- funcion para comprobar disponibilidad del vehiculo
    function comprobacion_disponibilidad_vehiculo(vehiculo_seleccionado IN OUT vehiculo%rowtype, periodo_alquiler periodo_duracion, sede_pk number) return boolean;
    -- procedure para encontrarle al usuario una opcion de vehiculo para alquilar
    procedure solucion_vehiculo_no_disponible_en_sede(cliente_seleccionado cliente%rowtype, vehiculo_seleccionado IN OUT vehiculo%rowtype, periodo_alquiler periodo_duracion, sede_donde_no_hay_el_vehiculo number);
    -- funcion para el fallo en pago
    function fallo_durante_pago(forma_pago_actual forma_pago%rowtype) return boolean;
    -- procedure para el pago del alquiler
    procedure pago_alquiler(cliente_seleccionado cliente%rowtype, vehiculo_seleccionado vehiculo%rowtype, periodo_alquiler periodo_duracion, alquiler_realizado alquiler%rowtype);
    -- procedure para alquiler
    procedure realizar_alquiler(cliente_reservar cliente%rowtype, vehiculo_seleccionado vehiculo%rowtype, periodo_alquiler periodo_duracion, ultimo_alquiler_realizado IN OUT alquiler%rowtype);
    -- procedure para reserva
    procedure reserva(cliente_reservar cliente%rowtype, dia_actual date, fecha_fin_simulacion date);
    -- procedure para simular el modulo de reservas
    procedure simulacion_reservas(pk_sede number, dia_actual date, fecha_fin_simulacion date);
    -- procedure para simular el modulo de alquileres
    procedure simulacion_alquileres(pk_sede number, dia_actual date, fecha_fin_simulacion date);
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
        
        DBMS_OUTPUT.PUT_LINE('  - Cantidad de alquileres ya en el periodo seleccionado sobre el auto seleccionado ' || to_char(cantidad_alquileres_ya_en_ese_periodo));
        
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
        -- se seleccionan todos los carros menos el ya seleccionado al aza, que son de la misma marca y modelo
        cursor vehiculos is select * 
            from vehiculo v 
            where v.v_placa != vehiculo_seleccionado.v_placa and
                  v.modelo_m_id=vehiculo_seleccionado.modelo_m_id and
                  v.modelo_marca_ma_id=vehiculo_seleccionado.modelo_marca_ma_id and
                  v.sede_s_id=sede_pk; 
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
        DBMS_OUTPUT.PUT_LINE('      - Vehiculo no disponible, se buscara otro disponible en la sede');
        
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
            where v.sede_s_id!=sede_donde_no_hay_el_vehiculo; 
        -- se seleccionan todos los vehiculos de otras sedes que tengan las mismas caracteristicas
        cursor vehiculos_iguales_al_deseado_por_cliente is select * 
            from vehiculo v 
            where v.v_placa != vehiculo_seleccionado.v_placa and
                  v.modelo_m_id=vehiculo_seleccionado.modelo_m_id and
                  v.modelo_marca_ma_id=vehiculo_seleccionado.modelo_marca_ma_id and
                  v.sede_s_id!=sede_donde_no_hay_el_vehiculo; 
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
            DBMS_OUTPUT.PUT_LINE('  - Se pudo encontrar otro vechiulo con las mismas carcateristicas en otra sede,  se procede a su alquiler.');
            
            vehiculo_seleccionado := nuevo_vehiculo_a_alquilar;
            -- se alquila el vehiculo
            reserva_and_alquiler_pkg.realizar_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
            
            -- se llama al escenario 'pago de alquiler'
            reserva_and_alquiler_pkg.pago_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
            
            DBMS_OUTPUT.PUT_LINE('  RESULTADO: se finalizo el alquiler satisfactoriamente');
            
            -- finaliza el procedure
            return;
        end if;
        
        ------------------------------------------------------------------------
        -- si no se selecciono un vehiculo entonces no hay con las mismas caracteristicas en otras sedes
        -- disponibles para ser alquilados, por lo tanto se alquila el primer vechiculo en otra sede que este disponible
        
        DBMS_OUTPUT.PUT_LINE('  - No se pudo encontrar otro vechiulo con las mismas carcateristicas en otra sede,  se procede a seleccionar el primer vehiculo disponible');
        
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
            DBMS_OUTPUT.PUT_LINE('  - Existe un vehiculo disponible, se procede a su alquiler.');
            
            vehiculo_seleccionado := nuevo_vehiculo_a_alquilar;
            -- se alquila el vehiculo
            reserva_and_alquiler_pkg.realizar_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
            
            -- se llama al escenario 'pago de alquiler'
            reserva_and_alquiler_pkg.pago_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
            
            DBMS_OUTPUT.PUT_LINE('  RESULTADO: se finalizo el alquiler satisfactoriamente');
            
            -- finaliza el procedure
            return;
        else 
            -- no existe ningun vehiculo disponible para alquiler
            DBMS_OUTPUT.PUT_LINE('  RESULTADO: no hay vehiculos disponibles, no se puede realizar un alquiler');
        end if;
        
    end solucion_vehiculo_no_disponible_en_sede;
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
                DBMS_OUTPUT.PUT_LINE('      Monto a pagar con descuento aplicado' || to_char(monto_a_pagar_total));
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
    procedure realizar_alquiler(cliente_reservar cliente%rowtype, vehiculo_seleccionado vehiculo%rowtype, periodo_alquiler periodo_duracion, ultimo_alquiler_realizado IN OUT alquiler%rowtype)
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
            0,
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
            null,
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
        
    end realizar_alquiler;
    ----------------------------------------------------------------------------
    -- procedure para reserva
    procedure reserva(cliente_reservar cliente%rowtype, dia_actual date, fecha_fin_simulacion date)
    is 
        tipo_cliente_actual tipo_cliente%rowtype; -- tipo de cliente del cliente actual
        periodo_duracion_reserva periodo_duracion; -- periodo durante el cual sera el alquiler a reservar
        
    begin
       return;
    end reserva;
    ----------------------------------------------------------------------------
    -- procedure para alquiler
    procedure simulacion_reservas(pk_sede number, dia_actual date, fecha_fin_simulacion date) 
    is
        numero_reservas number;                 -- numero de reservas a realizar
        
        prob_cliente number := 75;              -- probabilidad en % de que se seleccione un cliente para realizar el proceso de alquiler
        cliente_seleccionado cliente%rowtype;   -- variable para guardar si se selecciono un cliente
        persona_seleccionada persona%rowtype;   -- variable para guardar si se selecciono un cliente
        
    begin
        -- numero de reservas a realizar
        numero_reservas := utilities_pkg.get_random_integer(1,16);
        -- iteramos para cada reserva
        for i in 0..numero_reservas loop
            -- verificamos si la reserva la hara una persona o un cliente basado en la probabilidad establecida
            if(utilities_pkg.get_random_integer(0, 101) <= 75) then
                -- si la hace un cliente 
                cliente_seleccionado := utilities_pkg.get_cliente_random();
            else
                -- si la hace una persona no resgitrada
                persona_seleccionada := utilities_pkg.get_persona_random();
            end if;
            
            -- realizamos una reserva para el cliente
            --reserva(cliente_seleccionado);
            --
        end loop;
        
    end simulacion_reservas;
    ----------------------------------------------------------------------------
    -- procedure para simular el modulo de alquileres
    procedure simulacion_alquileres(pk_sede number, dia_actual date, fecha_fin_simulacion date) 
    is
        numero_alquileres number;                   -- numero de alquileres a realizar
        
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
        -- numero de alquileres a realizar
        numero_alquileres := utilities_pkg.get_random_integer(0,16);
        -- iteramos para cada reserva
        for i in 0..numero_alquileres loop
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('  ---- Alquiler numero ' || to_char(i) || ' ----');
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
            
            DBMS_OUTPUT.PUT_LINE('  - Intentara realizar el alquiler el cliente: ');
            utilities_pkg.print_cliente(cliente_seleccionado);
            
            -- buscamos el tipo del cliente
            select * into tipo_cliente_actual from tipo_cliente tc where tc.tc_id=cliente_seleccionado.tipo_cliente_tc_id;
            
            -- se verifica si el cliente es del tipo no deseado
            if(tipo_cliente_actual.tc_nombre = 'no deseado') then
                -- imprimimos mensaje de error y el cliente
                DBMS_OUTPUT.PUT_LINE('  ALERTA: este cliente no puede realizar alquileres debido a que es NO DESEADO');
                utilities_pkg.print_cliente(cliente_seleccionado, 'NO DESEADO');
                continue;
            end if;
            
            -- loop para poder simular si el cliente quiere tratar de alquiler otro carro dado que el que selecciono la primera vez no estaba disponible
            -- y no existe otro vechiculo con las mismas caracteristicas
            while sigue_bucle_alquiler_para_mismo_cliente
            loop 
                -- se hace el loop cuantas veces el cliente quiere intentar alquilar nuevamente dado que el vehiculo seleccionado no se encuentra disponible
                -- ni ninguno otro con iguales caracteristica
                
                -- se selecciona al azar un vehiculo de la sede, este o no disponible
                vehiculo_seleccionado := utilities_pkg.get_vehiculo_random(pk_sede);
                if (vehiculo_seleccionado.v_placa is NULL) then
                    DBMS_OUTPUT.PUT_LINE('  - No se selecciono un vehiculo, finaliza todo el proceso para este cliente. ');
                    exit;
                end if;
                DBMS_OUTPUT.PUT_LINE('  - El cliente selecciono el vehiculo: ');
                utilities_pkg.print_vehiculo(vehiculo_seleccionado);
                
                
                -- se selecciona un periodo de forma aleatoria 
                periodo_alquiler := utilities_pkg.get_random_periodo(dia_actual, fecha_fin_simulacion);
                DBMS_OUTPUT.PUT_LINE('  - El cliente selecciono el periodo ' || 
                                    TO_CHAR(periodo_alquiler.P_Fecha_Inicio , 'dd/mm/yyyy')|| 
                                    ' --- ' || 
                                    TO_CHAR(periodo_alquiler.P_Fecha_Fin , 'dd/mm/yyyy')
                );
                DBMS_OUTPUT.PUT_LINE('');
                
                -- se llama al escenario 'comprobacion de disponibilida de vehiculo'
                se_puede_realizar_un_alquiler := comprobacion_disponibilidad_vehiculo(vehiculo_seleccionado, periodo_alquiler, pk_sede);
                
                -- se verifica si se pudo realizar un alquiler
                if(se_puede_realizar_un_alquiler) then
                
                    -- se realiza el alquiler
                    realizar_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
                    
                    -- se llama al escenario 'pago de alquiler'
                    pago_alquiler(cliente_seleccionado, vehiculo_seleccionado, periodo_alquiler, alquiler_realizado);
                    
                    DBMS_OUTPUT.PUT_LINE('');
                    DBMS_OUTPUT.PUT_LINE('  - RESULTADO: se realizo el alquiler satisfactoriamente');
                    
                    -- salimos del loop while
                    exit;
                else 
                    -- si no se pudo realizar un alquiler es porque no existen vehiculos con las mismas caracteristicas que el seleccionado por primera vez
                    -- se verifica si el cliente desea alquilar otro vechiculo diferente o no
                    if(utilities_pkg.get_random_integer(0, 101) <= 25) then
                        -- el cliente desea alquiler otro carro entonces se mantiene 'sigue_bucle_alquiler_para_mismo_cliente' en true 
                        DBMS_OUTPUT.PUT_LINE('  - Cliente no pudo alquilar, pero seguira intentando');
                    else 
                        -- el cliente no desea realizar un alquiler con otro carro entonces se cambia 'sigue_bucle_alquiler_para_mismo_cliente' a false  
                        DBMS_OUTPUT.PUT_LINE('  - Cliente no pudo alquilar el vehiculo en la sede ' || pk_sede);
                        DBMS_OUTPUT.PUT_LINE('  - Se llama escenario 6 "Solución a carro no disponible en sede" para encontrar una solucion');
                        
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
        end loop;
        
    end simulacion_alquileres;
    
end reserva_and_alquiler_pkg;
/
