%PROBLEMA 4 -- suma de números
%Conexión con la base de datos
pkg load database
conn=pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','523811'))

% Crear tabla en base de datos
%tablename = 'problema4';
%query = ['CREATE TABLE ', tablename, ' (num INT, sum INT, operacion TEXT);'];
%pq_exec_params(conn, query);


% Solicitar un número
num = input('Ingrese un número: ');

% Calcular la suma de los números desde 0 hasta el número ingresado
sum = 0;
for i = 0:num
    sum = sum + i;
end

% Mostrar la suma en la consola
disp(['La suma de los números desde 0 hasta ', num2str(num), ' es: ', num2str(sum)]);

% Insertar la información en la tabla "problema4"
query = ['INSERT INTO ', tablename, ' (num, sum, operacion) VALUES (', num2str(num), ', ', num2str(sum), ', ''Suma'');'];
pq_exec_params(conn, query);

% Cerrar la conexión con la base de datos
pq_close(conn);
