% PROGRAMA 10 -- CÁLCULO DEL FACTORIAL SI EL NÚMERO ES DIVISIBLE POR 7
%Conexión con la base de datos
pkg load database
conn=pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','523811'))

% Solicitar al usuario que ingrese un número
num = input('Ingrese un número: ');

% Verificar si el número es divisible por 7
if mod(num, 7) ~= 0
    fprintf('El número ingresado no es divisible por 7.\n');
else
    % Calcular el factorial del número
    fact = 1;
    for i = 1:num
        fact = fact * i;
    end

    % Mostrar el resultado
    fprintf('El factorial de %d es %d.\n', num, fact);
end

% Preguntar al usuario si desea guardar el resultado en la base de datos
save = input('¿Desea guardar el resultado en la base de datos? (S/N): ', 's');

if strcmpi(save, 'S') || strcmpi(save, 's')
    % Crear tabla en base de datos si no existe
    %tablename = 'problema10';
    %query = ['CREATE TABLE ', tablename, ' (num INT, fact BIGINT);'];
    %pq_exec_params(conn, query);


    % Insertar el resultado en la tabla "problema10"
    % Convertir el valor a tipo "bigint" antes de realizar la inserción
    fact_bigint = num2str(int64(fact));
    query = ['INSERT INTO ', tablename, ' (num, fact) VALUES (', num2str(num), ', ', fact_bigint, ');'];
    pq_exec_params(conn, query);

    fprintf('Resultados guardados en la base de datos.\n');
else
    fprintf('Resultados no guardados en la base de datos.\n');
end

% Cerrar la conexión con la base de datos
pq_close(conn);
