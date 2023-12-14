%PROBLEMA 2 -- DIVISORES
%Conexión con la base de datos
pkg load database
conn=pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','523811'))

% Crear tabla en base de datos
%tablename = 'problema2';
%query = ['CREATE TABLE IF NOT EXISTS ', tablename, ' (num INT, divisores TEXT, operacion TEXT);'];
%pq_exec_params(conn, query);

% Solicitar el número
num = input('Ingrese un número: ');

% Encontrar los divisores del número
divisors = [];
for i = 1:num
    if mod(num, i) == 0
        divisors = [divisors, i];
    end
end

% Mostrar los divisores en consola
disp(['Los divisores de ', num2str(num), ' son:']);
disp(divisors);

% Insertar información en la tabla
query = ['INSERT INTO ', tablename, ' (num, divisores, operacion) VALUES (', num2str(num), ', ''', strcat(num2str(divisors), ' '), ''', ''Divisores'');'];
pq_exec_params(conn, query);

% Cerrar la conexión con la base de datos
pq_close(conn);

