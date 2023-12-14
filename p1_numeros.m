%PROBLEMA 1 -- SUMA, MULTIPLICACIÓN O CONCATENACIÓN DE TRES NÚMEROS
%Conexión con la base de datos
pkg load database
conn=pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','523811'))

% Crear tabla en base de datos
%tablename = 'problema1';
%query = ['CREATE TABLE IF NOT EXISTS ', tablename, ' (num1 INT, num2 INT, num3 INT, resultado TEXT, operacion TEXT);'];
%pq_exec_params(conn, query);

% Pedir al usuario que ingrese 3 números
num1 = input("Ingrese el primer número: ");
num2 = input("Ingrese el segundo número: ");
num3 = input("Ingrese el tercer número: ");

% Verificar condiciones y realizar operaciones
if (num1 > num2) && (num1 > num3)
    % Si el primero es el más grande, mostrar la suma
    resultado = num1 + num2 + num3;
    operacion = 'Suma';
elseif (num2 > num1) && (num2 > num3)
    % Si el segundo es el más grande, mostrar la multiplicación
    resultado = num1 * num2 * num3;
    operacion = 'Multiplicación';
elseif (num3 > num1) && (num3 > num2)
    % Si el tercero es el más grande, concatenar los números
    resultado = strcat(num2str(num1), num2str(num2),num2str(num3));
    operacion = 'Concatenación';

elseif (num1 == num2) && (num2 == num3)
    % Si los tres son iguales, mostrar los números y un mensaje
    resultado = [num1, num2, num3];
    operacion = 'Todos son iguales';
else
    % Si hay dos iguales, mostrar el único que no es igual
    if num1 == num2
        resultado = num3;
    elseif num1 == num3
        resultado = num2;
    else
        resultado = num1;
    end
    operacion = 'Número único';
end

% Mostrar resultado
fprintf('Resultado de la operación (%s): %s\n', operacion, num2str(resultado));

% Insertar información en la tabla
query = ['INSERT INTO ', tablename, ' (num1, num2, num3, resultado, operacion) VALUES (', num2str(num1), ', ', num2str(num2), ', ', num2str(num3), ', ''', num2str(resultado), ''', ''', operacion, ''');'];
pq_exec_params(conn, query);

% Cerrar la conexión con la base de datos
pq_close(conn);
