%PROBLEMA 6 -- LISTA DE MAYOR A MENOR
%Conexión con la base de datos
pkg load database
conn=pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','523811'))

% Crear tabla en base de datos
%tablename = 'problema6';
%query = ['CREATE TABLE ', tablename, ' (num INT, num_inicio INT, num_fin INT, operacion TEXT);'];
%pq_exec_params(conn, query);


% Solicitar dos números
num1 = input('Ingrese el primer número: ');
num2 = input('Ingrese el segundo número: ');

% Verificar cual es el mayor y asignarlo a "num_mayor"
num_mayor = max(num1, num2);

% Calcular los números desde el número mayor hasta el número menor
for i = num_mayor:-1:min(num1, num2)
    disp(i); % Mostrar los números en la consola
end

% Insertar la información en la tabla "problema6"
query = ['INSERT INTO ', tablename, ' (num, num_inicio, num_fin, operacion) VALUES (', num2str(i), ', ', num2str(num1), ', ', num2str(num2), ', ''Lista de mayor a menor'');'];
pq_exec_params(conn, query);

% Cerrar la conexión con la base de datos
pq_close(conn);
