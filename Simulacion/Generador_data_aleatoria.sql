-- objetos para las imagenes
CREATE OR REPLACE DIRECTORY IMAGENES_VEHICULOS AS 'C:\Users\alnov\Pictures\BD2\VEHICULOS\';
CREATE OR REPLACE DIRECTORY IMAGENES_PERSONAS AS 'C:\Users\alnov\Pictures\BD2\PERSONAS\';

-- paquete para generar la data de forma aleatoria
create or replace package generador_data_aleatoria_pkg as
    -- variables globales necesarias para el paquete
    cedula_counter number := 1; -- contador de la cedula
    
    -- procedure para generar una persona
    procedure generar_persona;
    -- procedure para generar un cliente
    procedure generar_cliente;
    -- procedure para la generacion aleatoria de personas
    procedure generador_personas(cantidad number);
    -- procedure para la generacion aleatoria de clientes
    procedure generador_clientes(cantidad number);
    -- procedure para la generacion aleatoria de autos
    
end generador_data_aleatoria_pkg; 
/

create or replace package body generador_data_aleatoria_pkg as 
    ---------------------------------------------------------------------------
    -- procedure para generar una persona
    procedure generar_persona
    is
        -- arreglo de sexo
        type sexo_array IS VARRAY(3) OF VARCHAR2(1);
        -- arreglo de correo
        type  correo_array IS VARRAY(3) OF VARCHAR2(20);
        -- arreglos de nombres y apellidos
        type nombres_array IS VARRAY(30) OF VARCHAR2(20);
        type apellidos_array IS VARRAY(50) OF VARCHAR2(20);
        -- arreglos para imagenes
        type imagenes_array IS VARRAY(2) OF VARCHAR2(20);
        -- arreglo para direcciones
        type direcciones_array IS VARRAY(6) OF CLOB;
        -- arreglo para los tipos de clientes
        type tipos_cliente_array IS VARRAY(4) OF VARCHAR2(50);
        aux_tipo_cliente VARCHAR2(50);
        
        -- variable auxiliar para el lugar
        aux_lugar lugar%rowtype;
        
        -- variables para las imagenes
        nombre_imagen varchar2(20); -- nombre de la imagen a insertar
        blob_temporal blob;         -- blob temporal
        documento bfile;            -- bfile para la insercion de la imagen
        
        -- variables para los valores a dar a la persona
        -- variables de la tabla
        --direccion            VARCHAR2(50);
        foto                 BLOB;
        pk_de_lugar          number;
        pk_de_tipo_cliente   number;
        -- variables del tda
        cedula               VARCHAR2(15);
        primer_nombre        VARCHAR2(20);
        segundo_nombre       VARCHAR2(20);
        primer_apellido      VARCHAR2(20);
        segundo_apellido     VARCHAR2(20);
        correo               VARCHAR2(50);
        fecha_nacimiento     DATE;
        sexo                 VARCHAR2(1); --Puede ser M, F u O (Otro)
        direccion            CLOB;
        
        -- definimos el arreglo de sexo
        sexos sexo_array := sexo_array(
            'F',
            'M',
            'O'
        );
        -- arrelgo de correo
        tipos_correos correo_array := correo_array(
            'gmail.com',
            'outlook.com',
            'yahoo.com'
        );
        -- definicion de los arreglos de posibles nombres y apellidos
        -- nombres mujer
        nombres_mujer nombres_array := nombres_array(
            'Isabella',
            'Martina',
            'Catalina',
            'Sofia',
            'Olivia',
            'Martha',
            'Roxana',
            'María',
            'Elizabeth',
            'Sonia',
            'Vera',
            'Manuela',
            'Nora',
            'Lía',
            'Luna',
            'Ainara',
            'Mar',
            'Mara',
            'Helena',
            'Nahia',
            'Débora',
            'Eloisa',
            'Elsa',
            'Fabiana',
            'Genoveva',
            'Gracia',
            'Jade',
            'Jessica',
            'Nina',
            'Patricia'
        );
        -- nombres hombre
         nombres_hombre nombres_array := nombres_array(
            'Lucas',
            'Mateo',
            'Daniel',
            'Manuel',
            'David',
            'Mario',
            'Diego',
            'Marcos',
            'Javier',
            'Carlos',
            'Antonio',
            'Marc',
            'Gonzalo',
            'Gael',
            'Sergio',
            'Jorge',
            'Gabriel',
            'Dylan',
            'Samuel',
            'Adam',
            'Liam',
            'Eric',
            'Samuel',
            'Amir',
            'Francisco',
            'Jaime',
            'Guillermo',
            'Luis',
            'Alberto',
            'Santiago'
        );
        -- apellidos
        apellidos apellidos_array := apellidos_array(
            'Gonzalez',
            'Rojas',
            'Rojas',
            'Diaz',
            'Perez',
            'Pena',
            'Soto',
            'Solvo',
            'Martinez',
            'Sepulveda',
            'Morales',
            'Rodriguez',
            'Lopez',
            'Fuente',
            'Hernandez',
            'Torres',
            'Fuentes',
            'Torres',
            'Araya',
            'Flores',
            'Espinoza',
            'Castillo',
            'Tapia',
            'Reyes',
            'Gutierrez',
            'Castro',
            'Pizarro',
            'Ramirez',
            'Carrasco',
            'Gomez',
            'Cortes',
            'Herrera',
            'Jara',
            'Vergara',
            'Garcia',
            'Rivera',
            'Miranda',
            'Gallardo',
            'Ortiz',
            'Navarro',
            'Parra',
            'Romera',
            'Moreno',
            'Lagos',
            'Godoy',
            'Palma',
            'Medina',
            'Alvarado',
            'Farias',
            'Toro'
        );
        
        -- definicion de los arreglos de posibles imagenes
        imagenes_mujeres imagenes_array := imagenes_array(
            'mujer_1.png',
            'mujer_2.jpg'
        );
        
         imagenes_hombres imagenes_array := imagenes_array(
            'hombre_1.jpg',
            'hombre_2.jpg'
        );
        
        -- definicion del arreglo de posbiles direcciones
        direcciones_posibles direcciones_array  := direcciones_array(
            'C26W+7F, San Antonio de Los Altos 1204, Miranda',
            'Avenida La salle, con Av. Florencio Jiménez, Barquisimeto 3001, Lara',
            'Avenida La Estancia, C/C C. Ernesto Blohm, 1090, Miranda',
            'Avenida Libertador, con C. Los Ángeles, Caracas 1071, Miranda',
            'F5PH+9HF, Avenida Francisco de Miranda, Caracas 1071, Miranda',
            'Calle Real De Playa Verde, Maiquetía, Vargas',
            'Av. Urdaneta con Viaducto Sucre, Merida 5101, Merida'
        );
        
        -- definicion del arreglo de posibles tipos de clientes
        tipos_clientes tipos_cliente_array := tipos_cliente_array(
            'Ocasional',
            'Frecuente',
            'VIP',
            'No deseado'
        );
    begin
        DBMS_OUTPUT.PUT_LINE('  Persona aleatoria sera generada');
        
        -- generamos la data para la persona -----------------------------------
        -- generamos el sexo
        sexo := sexos(utilities_pkg.get_random_integer(1,4));
        DBMS_OUTPUT.PUT_LINE(sexo);
        -- generamos los nombres y la foto en base al genero
        if (sexo = 'F') then
            -- nombres
            primer_nombre := nombres_mujer(utilities_pkg.get_random_integer(1,31));
            segundo_nombre := nombres_mujer(utilities_pkg.get_random_integer(1,31));
            -- foto
            nombre_imagen := imagenes_mujeres(utilities_pkg.get_random_integer(1,3));
        elsif (sexo = 'M') then
            -- nombres
            primer_nombre := nombres_hombre(utilities_pkg.get_random_integer(1,31));
            segundo_nombre := nombres_hombre(utilities_pkg.get_random_integer(1,31));
            -- foto
            nombre_imagen := imagenes_hombres(utilities_pkg.get_random_integer(1,3));
        else 
            -- nombres
            primer_nombre := nombres_mujer(utilities_pkg.get_random_integer(1,31));
            segundo_nombre := nombres_hombre(utilities_pkg.get_random_integer(1,31));
            -- foto
            nombre_imagen := imagenes_mujeres(utilities_pkg.get_random_integer(1,3));
        end if;
        DBMS_OUTPUT.PUT_LINE(primer_nombre);
        DBMS_OUTPUT.PUT_LINE(segundo_nombre);
        DBMS_OUTPUT.PUT_LINE(nombre_imagen);
        -- generamos los apellidos
        primer_apellido  := apellidos(utilities_pkg.get_random_integer(1,51));
        segundo_apellido := apellidos(utilities_pkg.get_random_integer(1,51));
        DBMS_OUTPUT.PUT_LINE(primer_apellido);
        DBMS_OUTPUT.PUT_LINE(segundo_apellido);
        -- generamos el correo
        correo := primer_nombre || primer_apellido || tipos_correos(utilities_pkg.get_random_integer(1,4));
        DBMS_OUTPUT.PUT_LINE(correo);
        
        -- generar cedula
        cedula := TO_CHAR(cedula_counter); -- asignamos la cedula del contador
        cedula_counter := cedula_counter + 1; -- actualizamos el contador + 1
        DBMS_OUTPUT.PUT_LINE(cedula);
        -- generar direccion
        direccion := direcciones_posibles(utilities_pkg.get_random_integer(1,7));
        DBMS_OUTPUT.PUT_LINE(direccion);
        
        -- fecha de nacimiento
        SELECT TO_DATE(
              TRUNC(
                   DBMS_RANDOM.VALUE(TO_CHAR(DATE '1940-01-01','J')
                                    ,TO_CHAR(DATE '2002-12-31','J')
                                    ) 
                    ),'J'
               ) into fecha_nacimiento FROM DUAL;
        DBMS_OUTPUT.PUT_LINE(to_char(fecha_nacimiento, 'dd-mm-yyyy'));
        -- generar el tipo de cliente
        -- seleccionamos un tipo de cliente al azar
        aux_tipo_cliente := tipos_clientes(utilities_pkg.get_random_integer(1,5));
        DBMS_OUTPUT.PUT_LINE('Tipo cliente: '|| aux_tipo_cliente);
        select tc_id into pk_de_tipo_cliente from tipo_cliente where tc_nombre = aux_tipo_cliente;
        DBMS_OUTPUT.PUT_LINE('Tipo cliente pk: '|| pk_de_tipo_cliente);
        
        -- generar el lugar
        aux_lugar := utilities_pkg.get_lugar_random();
        DBMS_OUTPUT.PUT_LINE(to_char(aux_lugar.l_id) || ' ' || aux_lugar.l_nombre);
        pk_de_lugar := aux_lugar.l_id;
        
        -- insertar en la tabla personas
        insert into persona values(
            default,
            EMPTY_BLOB(),
            pk_de_lugar,
            pk_de_tipo_cliente,
            informacion_personal(
                cedula,
                primer_nombre,
                segundo_nombre,
                primer_apellido,
                segundo_apellido,
                correo,
                fecha_nacimiento,
                sexo,
                direccion
            )
        ) RETURNING foto INTO blob_temporal;
        -- insertamos la imagen
        documento := BFILENAME ('IMAGENES_PERSONAS', nombre_imagen);
        DBMS_LOB.fileopen (documento, DBMS_LOB.file_readonly);
        DBMS_LOB.loadfromfile (blob_temporal,documento,DBMS_LOB.getlength (documento));
        DBMS_LOB.fileclose (documento);
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('  Persona aleatoria insertada');
    EXCEPTION
       WHEN OTHERS
       THEN
          DBMS_OUTPUT.put_line (   'ORA-'
             || TO_CHAR (UTL_CALL_STACK.error_number (1), 'fm00000')
             || ': '
             || UTL_CALL_STACK.error_msg (1));
    end generar_persona;
    ----------------------------------------------------------------------------
    -- procedure para generar un cliente
    procedure generar_cliente
    is
    begin
        -- POR AHORA NO PARECE NECEARIO GENERAR CLIENTES DE FORMA ALEATORIA
        -- selecciamos una persona de forma aleatorio y pasa a ser cliente
        
        -- ya las personas tienen un tipo de cliente por defecto
        
        -- se inserta en la tabla cliente
        return;
        -- se elimina de la tabla persona porque paso a ser un cliente
        
    end generar_cliente;
    ----------------------------------------------------------------------------
    -- procedure para la generacion aleatoria de personas
    -- inserta la cantidad indicada de personas de creadas de forma aleatoria
    procedure generador_personas(cantidad number) 
    is
    begin
        for numero in 1..cantidad loop
            generador_data_aleatoria_pkg.generar_persona();
        end loop;
    end generador_personas;
    ----------------------------------------------------------------------------
    -- procedure para la generacion aleatoria de clientes
    -- inserta 15 registros aleatorios de a tabla persona en la tabla cliente
    procedure generador_clientes(cantidad number) 
    is
    begin
        return;
    end generador_clientes;
    
end generador_data_aleatoria_pkg;
/
