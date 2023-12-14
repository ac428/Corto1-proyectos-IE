% PROGRAMA 8 -- MOSTRAR NÚMEROS IMPARES Y CUANTOS HAY
%Conexión con la base de datos
pkg load database
conn=pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','523811'))

% Crear tabla en base de datos
%tablename = 'problema8';
%query = ['CREATE TABLE ', tablename, ' (numero INT, opcion VARCHAR(20));'];
%pq_exec_params(conn, query);

% Crear lista para almacenar los números impares y la cantidad de números impares
impares = [];
cantidad = 0;

% Mostrar los números impares desde el 1 hasta el 100
for i = 1:100
    if mod(i, 2) ~= 0
        impares = [impares, i];
        fprintf('%d ', i);
        cantidad = cantidad + 1;
    end
end

fprintf('\nCantidad de números impares: %d\n', cantidad);

% Preguntar al usuario si desea guardar el resultado en la base de datos
save = input('¿Desea guardar el resultado en la base de datos? (S/N): ', 's');

if strcmpi(save, 'S') || strcmpi(save, 's')
    % Almacenar el resultado en la tabla "problema8"
    for i = 1:length(impares)
        query = ['INSERT INTO ', tablename, ' (numero, opcion) VALUES (', num2str(impares(i)), ', ', "'impares'", ');'];
        pq_exec_params(conn, query);
    end

    query = ['INSERT INTO ', tablename, ' (numero, opcion) VALUES (', num2str(cantidad), ', ', "'cantidad'", ');'];
    pq_exec_params(conn, query);

    fprintf('Resultados guardados en la base de datos.\n');
else
    fprintf('Resultados no guardados en la base de datos.\n');
end

% Cerrar la conexión con la base de datos
pq_close(conn);
