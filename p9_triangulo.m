% PROGRAMA 9 -- JUEGO DEL TRIÁNGULO

%Conexión con la base de datos
pkg load database
conn=pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','523811'))

% Solicitar al usuario que ingrese los tres lados del triángulo
a = input('Ingrese el primer lado del triángulo: ');
b = input('Ingrese el segundo lado del triángulo: ');
c = input('Ingrese el tercer lado del triángulo: ');

% Verificar si el triángulo es válido
if a + b <= c || a + c <= b || b + c <= a
    fprintf('Los tres números ingresados no forman un triángulo válido.\n');
else
    % Determinar el tipo de triángulo
    if a == b && b == c
        fprintf('El triángulo es equilátero.\n');
        resultado = 'equilátero';
    elseif a == b || a == c || b == c
        fprintf('El triángulo es isósceles.\n');
        resultado = 'isósceles';
    else
        fprintf('El triángulo es escaleno.\n');
        resultado = 'escaleno';
    end
end

% Preguntar al usuario si desea guardar el resultado en la base de datos
save = input('¿Desea guardar el resultado en la base de datos? (S/N): ', 's');

if strcmpi(save, 'S') || strcmpi(save, 's')
    % Crear tabla en base de datos si no existe
    %tablename = 'problema9';
    %query = ['CREATE TABLE ', tablename, ' (a INT, b INT, c INT, resultado VARCHAR(20));'];
    %pq_exec_params(conn, query);

    % Insertar el resultado en la tabla "problema9"
    query = ['INSERT INTO ', tablename, ' (a, b, c, resultado) VALUES (', num2str(a), ', ', num2str(b), ', ', num2str(c), ', ', "'" resultado, "'", ');'];
    pq_exec_params(conn, query);

    fprintf('Resultados guardados en la base de datos.\n');
else
    fprintf('Resultados no guardados en la base de datos.\n');
end

% Cerrar la conexión con la base de datos
pq_close(conn);
