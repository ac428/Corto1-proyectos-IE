% PROGRAMA 11 -- CALCULADORA DE ÁREAS DE FIGURAS GEOMÉTRICAS
%Conexión con la base de datos
pkg load database
conn=pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','523811'))

% Crear tabla en base de datos para almacenar resultados
%tablename = 'problema11';
%query = ['CREATE TABLE ', tablename, ' (figura VARCHAR(50), a REAL, b REAL, area REAL);'];
%pq_exec_params(conn, query);

% Definir funciones para calcular áreas
function area = circulo_area(radio)
    area = pi * radio^2;
end

function area = triangulo_area(base, altura)
    area = 0.5 * base * altura;
end

function area = cuadrado_area(lado)
    area = lado^2;
end

function area = rectangulo_area(base, altura)
    area = base * altura;
end

% Menú interactivo para seleccionar figura y ingresar valores
while true
    % Solicitar al usuario que ingrese un número
    figura = input('Ingrese una figura (circulo, triangulo, cuadrado, rectangulo): ', 's');
    a = input('Ingrese el valor de a: ');
    b = input('Ingrese el valor de b(si seleccionó cuadrado o circulo colocar 0): ');

    % Calcular el área de la figura seleccionada
    area = 0;
    if strcmpi(figura, 'circulo')
        area = circulo_area(a);
    elseif strcmpi(figura, 'triangulo')
        area = triangulo_area(a, b);
    elseif strcmpi(figura, 'cuadrado')
        area = cuadrado_area(a);
    elseif strcmpi(figura, 'rectangulo')
        area = rectangulo_area(a, b);
    else
        fprintf('Figura no válida.\n');
        continue;
    end

    % Mostrar el resultado
    fprintf('El área de la %s es %f.\n', figura, area);

    % Almacenar el resultado en la tabla "calculadora_areas"
    query = ['INSERT INTO ', tablename, ' (figura, a, b, area) VALUES (''', figura, ''', ', num2str(a), ', ', num2str(b), ', ', num2str(area), ');'];
    pq_exec_params(conn, query);

    % Preguntar al usuario si desea mostrar el historial de resultados
    show_history = input('¿Desea mostrar el historial de resultados? (S/N): ', 's');

    if strcmpi(show_history, 'S') || strcmpi(show_history, 's')
        % Consultar y mostrar el historial de resultados
        result = pq_exec_params(conn,'select*from problema11;') %ver datos en la tabla

        if isempty(result)
            fprintf('No se encontraron resultados en el historial.\n');
        else
            fprintf('Historial de resultados:\n');
            for i = 1:size(result, 1)
                fprintf('%s: %f unidades cuadradas\n', result{i, 1}, result{i, 4});
            end
        end
    end
end

% Cerrar la conexión con la base de datos
pq_close(conn);
