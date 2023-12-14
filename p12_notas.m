%PROBLEMA 12 -- PROMEDIO DE NOTAS
%Conexión con la base de datos
pkg load database
conn=pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','523811'))

% Crear la tabla si no existe
%tablename = 'problema12';
%query = ['CREATE TABLE IF NOT EXISTS ', tablename, ' (id SERIAL PRIMARY KEY, nota1 INTEGER, nota2 INTEGER, nota3 INTEGER, promedio REAL, resultado VARCHAR(10));'];
%pq_exec_params(conn, query);

% Menú interactivo para ingresar notas
while true
    % Solicitar al usuario que ingrese 3 notas
    nota1 = input('Ingrese la primera nota: ');
    nota2 = input('Ingrese la segunda nota: ');
    nota3 = input('Ingrese la tercera nota: ');

    % Calcular el promedio de las notas
    promedio = (nota1 + nota2 + nota3) / 3;

    % Determinar si el estudiante aprobó o no
    resultado = '';
    if promedio >= 60
        resultado = 'Aprobado';
    else
        resultado = 'Reprobado';
    end

    % Mostrar el resultado
    fprintf('El promedio de las notas es %f y el resultado es %s.\n', promedio, resultado);

    % Almacenar el resultado en la tabla
    query = ['INSERT INTO ', tablename, ' (nota1, nota2, nota3, promedio, resultado) VALUES (', num2str(nota1), ', ', num2str(nota2), ', ', num2str(nota3), ', ', num2str(promedio), ', ''', resultado, ''');'];
    pq_exec_params(conn, query);

    % Preguntar al usuario si desea mostrar el historial de resultados
    show_history = input('¿Desea mostrar el historial de resultados? (S/N): ', 's');

    if strcmpi(show_history, 'S') || strcmpi(show_history, 's')
        % Consultar y mostrar el historial de resultados
        pq_exec_params(conn,'select*from problema12;') %ver datos en la tabla
      else
        fprintf('No se encontraron resultados en el historial.\n');
    end
    break
end
% Cerrar la conexión con la base de datos
pq_close(conn);

