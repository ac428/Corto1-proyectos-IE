%PROBLEMA 13 -- AÑO BISIESTO
%Conexión con la base de datos
pkg load database
conn = pq_connect(setdbopts('dbname', 'corto1', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', '523811'));

% Crear la tabla si no existe
%tablename = 'problema13';
%query = ['CREATE TABLE IF NOT EXISTS ', tablename, ' (id SERIAL PRIMARY KEY, año INTEGER, bisiesto BOOLEAN);'];
%pq_exec_params(conn, query);

% Función que verifica si un año es bisiesto
function resultado = es_bisiesto(year)
    if mod(year, 4) == 0
        if mod(year, 100) == 0
            if mod(year, 400) == 0
                resultado = true;
            else
                resultado = false;
            end
        else
            resultado = true;
        end
    else
        resultado = false;
    end
end

% Menú interactivo para ingresar el año de nacimiento
while true
    year = input('Ingrese el año de nacimiento: ');
    bisiesto = es_bisiesto(year); % Verificar si el año es bisiesto

    % Almacenar el resultado en la tabla "problema13"
    query = ['INSERT INTO ', tablename, ' (año, bisiesto) VALUES (', num2str(year), ', ''', num2str(bisiesto), ''');'];
    pq_exec_params(conn, query);

    % Mostrar el resultado
    if bisiesto
        fprintf('El año %d es bisiesto.\n', year);
    else
        fprintf('El año %d no es bisiesto.\n', year);
    end

    % Preguntar al usuario si desea ingresar otro año
    another_year = input('¿Desea verificar otro año? (S/N): ', 's');

    if ~strcmpi(another_year, 'S') && ~strcmpi(another_year, 's')
        break;
    end
end

% Preguntar al usuario si desea mostrar el historial de resultados
show_history = input('¿Desea mostrar el historial de resultados? (S/N): ', 's');

if strcmpi(show_history, 'S') || strcmpi(show_history, 's')
    % Consultar y mostrar el historial de resultados
    result = pq_exec_params(conn, ['SELECT * FROM ', tablename, ';']);
    disp(result);
end

% Cerrar la conexión con la base de datos
pq_close(conn);

