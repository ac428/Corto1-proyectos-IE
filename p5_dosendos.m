%PROBLEMA 5 -- NUMEROS DE DOS EN DOS
%Conexión con la base de datos
pkg load database
conn=pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','523811'))

% Crear tabla en base de datos
%tablename = 'problema5';
%query = ['CREATE TABLE ', tablename, ' (num INT, num_inicio INT, num_fin INT, operacion TEXT);'];
%pq_exec_params(conn, query);


% Solicitar un número de inicio y un número de fin
num_inicio = input('Ingrese un número de inicio: ');
num_fin = input('Ingrese un número de fin: ');

% Calcular los números de 2 en 2 desde el número de inicio hasta el número de fin
for i = num_inicio:2:num_fin
    % Mostrar los números en la consola
    disp(i);

    % Insertar la información en la tabla "problema5"
    query = ['INSERT INTO ', tablename, ' (num, num_inicio, num_fin, operacion) VALUES (', num2str(i), ', ', num2str(num_inicio), ', ', num2str(num_fin), ', ''Numeros de 2 en 2'');'];
    pq_exec_params(conn, query);
end

% Cerrar la conexión con la base de datos
pq_close(conn);

