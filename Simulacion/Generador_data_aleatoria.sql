create or replace package generador_data_aleatoria_pkg as
    -- procedure para generar una persona
    procedure generar_persona;
    -- procedure para la generacion aleatoria de personas
    procedure generador_personas(cantidad number);
    -- procedure para la generacion aleatoria de clientes
    procedure generador_clientes(cantidad number);
    -- procedure para la generacion aleatoria de autos
    
    -- procedure para la generacion aleatoria de 
end generador_data_aleatoria_pkg; 
/

create or replace package body generador_data_aleatoria_pkg as 
    ---------------------------------------------------------------------------
    -- procedure para generar una persona
    procedure generar_persona
    is
        -- arreglo de sexo
        type sexo_array IS VARRAY(3) OF VARCHAR2(1);
        sexos sexo_array;
        -- arreglo de correo
        type  correo_array IS VARRAY(3) OF VARCHAR2(20);
        tipos_correos correo_array;
        -- arreglos de nombres y apellidos
        type nombres_mujer_array IS VARRAY(30) OF VARCHAR2(20);
        type nombres_hombre_array IS VARRAY(30) OF VARCHAR2(20);
        type apellidos_array IS VARRAY(50) OF VARCHAR2(20);
        nombres_mujer nombres_mujer_array;
        nombres_hombre nombres_hombre_array;
        apellidos apellidos_array;
        
        -- variables para los valores a dar a la persona
        -- variables de la tabla
        direccion            VARCHAR2(50);
        foto                 BLOB;
        lugar                number;
        tipo_cliente         number;
        -- variables del dta
        cedula               VARCHAR2(15);
        primer_nombre        VARCHAR2(20);
        segundo_nombre       VARCHAR2(20);
        primer_apellido      VARCHAR2(20);
        segundo_apellido     VARCHAR2(20);
        correo               VARCHAR2(20);
        fecha_nacimiento     DATE;
        sexo                 VARCHAR2(1); --Puede ser M, F u O (Otro)
        direccion            VARCHAR2(250);
    begin
        -- definimos el arreglo de sexo
        sexos := (
            'F',
            'M',
            'O'
        );
        -- arrelgo de correo
        correos := (
            'gmail.com',
            'outlook.com',
            'yahoo.com'
        );
        -- definicion de los arreglos de posibles nombres y apellidos
        -- nombres mujer
        nombres_mujer := (
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
        nombres_hombre := (
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
        apellidos := (
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
        
        -- generamos los valores que se daran a al cliente
        -- generamos el sexo
        sexo := sexos(utilities_pkg.get_random_integer(1,4));
        -- generamos los nombres en base al genero
        if (sexo = 'F') then
            primer_nombre := nombres_mujer(utilities_pkg.get_random_integer(1,31));
            segundo_nombre := nombres_mujer(utilities_pkg.get_random_integer(1,31));
        elsif (sexo = 'M') then
            primer_nombre := nombres_hombre(utilities_pkg.get_random_integer(1,31));
            segundo_nombre := nombres_hombre(utilities_pkg.get_random_integer(1,31));
        else 
            primer_nombre := nombres_mujer(utilities_pkg.get_random_integer(1,31));
            segundo_nombre := nombres_hombre(utilities_pkg.get_random_integer(1,31));
        end if;
        -- generamos los apellidos
        primer_apellido  := apellidos(utilities_pkg.get_random_integer(1,51));
        segundo_apellido := apellidos(utilities_pkg.get_random_integer(1,51));
        -- generamos el correo
        correo := primer_nombre || primer_apellido || correos(utilities_pkg.get_random_integer(1,4));
        
        -- faltan
        -- generar foto
        -- generar cedula
        -- generar direccion
        -- generar direccion
        -- fecha de nacimiento
        -- generar tipo de cliente
        
    end generador_personas;
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
    end generador_clientes;
    
    
end generador_data_aleatoria_pkg;
/
