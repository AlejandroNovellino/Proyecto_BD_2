-- creacion del TDA de informacion personal ------------------------------------
create or replace type informacion_personal as object (
    -- atributos del objeto
    IP_cedula               VARCHAR2(15),
    IP_Primer_Nombre        VARCHAR2(20),
    IP_Segundo_Nombre       VARCHAR2(20),
    IP_Primer_Apeliido      VARCHAR2(20),
    IP_Segundo_Apellido     VARCHAR2(20),
    IP_Correo               VARCHAR2(20),
    IP_Fecha_Nacimiento     DATE,
    IP_Sexo                 VARCHAR2(1), --Puede ser M, F u O (Otro)
    IP_Direccion            VARCHAR2(250),
    -- metodos static del objeto
    STATIC FUNCTION verificar_cedula(cedula VARCHAR2) return VARCHAR2,
    --STATIC FUNCTION verificar_espacio_blanco (palabra VARCHAR2) return BOOLEAN,
    --STATIC FUNCTION verificar_numero (palabra VARCHAR2) return VARCHAR2,
    STATIC FUNCTION verificar_nombre_apellido (palabra VARCHAR2) return VARCHAR2,
    STATIC FUNCTION verificar_correo (correo VARCHAR2) return VARCHAR2,
    STATIC FUNCTION verificar_fecha_nacimiento (fecha_n DATE) return DATE,
    STATIC FUNCTION verificar_sexo  (sexo VARCHAR2) return VARCHAR2,
    -- metodos mienbros del objeto
    member FUNCTION get_edad return number
);
/

-- creacion del cuerpo del TDA
create or replace type body informacion_personal as 
    -- verificar cedula
    STATIC FUNCTION verificar_cedula(cedula VARCHAR2) return VARCHAR2
    is 
    begin
        if (cedula not like 'V-%' or LENGTH(cedula) is null or cedula is null) then
            RAISE_APPLICATION_ERROR(-20001, 'La cedula posee un error');
        else 
            return cedula;
        end if;
    end verificar_cedula;
    
    -- verificar nombre apellido
    STATIC FUNCTION verificar_nombre_apellido (palabra VARCHAR2) return varchar2
    is
        trimmed_palabra varchar2(20);
    begin 
        trimmed_palabra := TRIM(' ' from palabra);
        if (LENGTH(trimmed_palabra) is NULL) then
            RAISE_APPLICATION_ERROR(-20001, 'El nombre o apellido posee un error');
        else 
            return palabra;
        end if;
    end verificar_nombre_apellido;
    
    -- verificar correo
    STATIC FUNCTION verificar_correo (correo VARCHAR2) return VARCHAR2
    is
    begin
        if (correo like '%@gmail.com' or correo like '%@outlook.%' or correo like '%@yahoo.%') then 
            return correo;
        else 
            RAISE_APPLICATION_ERROR(-20001, 'Correo invalido; solo se permiten correos Gmail, Outlook o Yahoo');
        end if;
    end verificar_correo;
    
    -- verficar fecha nacimiento
    STATIC FUNCTION verificar_fecha_nacimiento (fecha_n DATE) return DATE
    is 
        current_date date;
    begin
        -- tomamos la fecha de hoy
        select SYSDATE into current_date from dual;
        -- hacemos las verificaciones
        if (fecha_n is null or fecha_n >= current_date) then 
            RAISE_APPLICATION_ERROR(-20001, 'Fecha de nacimiento invalida');
        elsif ( (current_date - fecha_n) < 18) then
            RAISE_APPLICATION_ERROR(-20001, 'Debe ser mayor de edad');
        else 
            return fecha_n;
        end if;
    end verificar_fecha_nacimiento;
    
    -- verifcar sexo
    STATIC FUNCTION verificar_sexo  (sexo VARCHAR2) return VARCHAR2
    is 
    begin
        if (sexo like 'F' or sexo like 'M' or sexo like 'O')then
            return sexo;
        else 
            RAISE_APPLICATION_ERROR(-20002, 'Sexo invalido; solo se permiten F, M u O');
        end if;
    end;
    
    -- get edad
    member FUNCTION get_edad return number
    is 
        current_date date;
    begin
        -- tomamos la fecha de hoy
        select SYSDATE into current_date from dual;
        return MONTHS_BETWEEN(current_date, IP_Fecha_Nacimiento) / 12;
    end;
end;
/

-- creacion del TDA de ubicacion geografica ------------------------------------
create or replace type ubicacion_geografica as object (
    -- atributos del objeto
    UG_Latitud      varchar2(12), -- dada como 180.623215 o -180.102456
    UG_Longitud     varchar2(12), -- dada como 180.623215 o -180.102456   
    UG_Time_Stamp   timestamp,
    -- metodos static del objeto
    static FUNCTION verificar_latitud (latitud varchar2) return varchar2,
    static FUNCTION verificar_longitud (longitud varchar2) return varchar2,
    static FUNCTION verificar_timestamp (fecha_hora timestamp) return timestamp
); 
/

-- creacion del body del TDA
create or replace type body ubicacion_geografica as
    -- verificar latitud
    static FUNCTION verificar_latitud (latitud varchar2) return varchar2
    is
    begin
        if(latitud is null or INSTR(latitud, '.') <= 0) then 
            RAISE_APPLICATION_ERROR(-20002, 'Latitud invalida');
        else 
            return latitud;
        end if;
    end verificar_latitud;
    
    -- verificar longitud
    static FUNCTION verificar_longitud (longitud varchar2) return varchar2
    is
    begin
        if(longitud is null or INSTR(longitud, '.') <= 0) then 
            RAISE_APPLICATION_ERROR(-20002, 'longtid invalida');
        else 
            return longitud;
        end if;
    end verificar_longitud;
    
    -- verificar timestamp
    static FUNCTION verificar_timestamp (fecha_hora timestamp) return timestamp
    is 
        current_timestamp timestamp;
    begin
        -- tomamos el timestamp del dia actual
        select SYSTIMESTAMP into current_timestamp from dual;
        -- hacemos la verificacion
        if(fecha_hora is null) then
            RAISE_APPLICATION_ERROR(-20002, 'TimeStamp no puede ser nulo');
        else
            return fecha_hora;
        end if;
    end verificar_timestamp;
end;
/

-- creacion del TDA de periodo de duracion -------------------------------------
create or replace type periodo_duracion as object (
-- atributos del objeto
    P_Fecha_Inicio  date,
    P_Fecha_Fin     date,
    -- metodos static del objeto
    static FUNCTION verificar_fecha_inicio (fecha_inicio date, fecha_fin date) return date,
    static FUNCTION verificar_fecha_fin    (fecha_inicio date, fecha_fin date) return date,
    -- metodos mienbro del objeto
    member FUNCTION verificar_activo return boolean,
    member FUNCTION get_dia_semana_inicio return varchar2,
    member FUNCTION get_dia_semana_final return varchar2
);
/

-- creacion del body del TDA
create or replace type body periodo_duracion as
    -- verficar fechas de inicio
    static FUNCTION verificar_fecha_inicio (fecha_inicio date, fecha_fin date) return date
    is 
        current_date date;
    begin
        -- tomamos la fecha de hoy
        select SYSDATE into current_date from dual;
        -- hacemos las verificaciones
        if (fecha_inicio is null or fecha_inicio < current_date or fecha_inicio > fecha_fin) then 
            RAISE_APPLICATION_ERROR(-20001, 'Fecha de inicio invalida');
        else 
            return fecha_inicio;
        end if;
    end verificar_fecha_inicio;
    
    -- verficar fechas de fin
    static FUNCTION verificar_fecha_fin (fecha_inicio date, fecha_fin date) return date
    is 
        current_date date;
    begin
        -- tomamos la fecha de hoy
        select SYSDATE into current_date from dual;
        -- hacemos las verificaciones
        if (fecha_fin is null or fecha_fin < current_date or fecha_fin < fecha_inicio) then 
            RAISE_APPLICATION_ERROR(-20001, 'Fecha de fin invalida');
        else 
            return fecha_fin;
        end if;
    end verificar_fecha_fin;
    
    -- verificar activo
    member FUNCTION verificar_activo return boolean
    is
        current_date DATE;
    begin
        -- encontramos la fecha actual
        select SYSDATE into current_date from dual;
        -- retornamos
        return (current_date >= P_Fecha_Inicio) and (current_date <= P_Fecha_Fin);
    end verificar_activo;
    
    -- get dia de la semana fecha de inicio
    member FUNCTION get_dia_semana_inicio return varchar2
    is
        dia_semana varchar2(20);
    begin
        select TO_CHAR(P_Fecha_Inicio, 'DAY') day into dia_semana FROM dual;
        return dia_semana;
    end get_dia_semana_inicio;
    
    -- get dia de la semana fecha de fin
    member FUNCTION get_dia_semana_final return varchar2
    is
        dia_semana varchar2(20);
    begin
        select TO_CHAR(P_Fecha_Fin, 'DAY') day into dia_semana FROM dual;
        return dia_semana;
    end get_dia_semana_final;
end;
/

--drop type informacion_personal;
--/
--drop type ubicacion_geografica;
--/
--drop type periodo_duracion;
--/

