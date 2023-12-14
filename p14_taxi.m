%PROBLEMA 14 -- Verificar mantenimiento de taxis
%Conexión con la base de datos
pkg load database
conn = pq_connect(setdbopts('dbname', 'corto1', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', '523811'));

% Crear la tabla si no existe
%tablename = 'problema14';
%query = ['CREATE TABLE IF NOT EXISTS ', tablename, ' (id SERIAL PRIMARY KEY, modelo INTEGER, recorrido DOUBLE PRECISION, estado VARCHAR(255));'];
%pq_exec_params(conn, query);

% Función para clasificar el estado de los taxis
function estado = clasificar_taxi(modelo, recorrido)
    if modelo < 2007 && recorrido > 20000
        estado = 'Renovar';
    elseif modelo >= 2007 && modelo <= 2013 && recorrido >= 20000
        estado = 'Mantenimiento';
    elseif modelo > 2013 && recorrido < 10000
        estado = 'Óptimas condiciones';
    else
        estado = 'Mecánico';
    end
end

% Ingresar información de taxis
num_taxis = input('Ingrese el número de taxis: ');

for i = 1:num_taxis
    modelo = input('Ingrese el modelo del taxi: ');
    recorrido = input('Ingrese el recorrido del taxi (en km): ');

    % Clasificar el estado del taxi
    estado_taxi = clasificar_taxi(modelo, recorrido);

    % Almacenar la información en la tabla "problema14"
    query = ['INSERT INTO ', tablename, ' (modelo, recorrido, estado) VALUES (', num2str(modelo), ', ', num2str(recorrido), ', ''', estado_taxi, ''');'];
    pq_exec_params(conn, query);

    % Mostrar el resultado
    fprintf('El taxi con modelo %d y recorrido %f km está en estado: %s\n', modelo, recorrido, estado_taxi);
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

