%PROGRAMA 7 -- CONTANDO LAS VOCALES
%Conexión con la base de datos
pkg load database
conn=pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','523811'))

% Crear tabla en base de datos
%tablename = 'problema7';
%query = ['CREATE TABLE ', tablename, ' (palabra TEXT, cont_A INT, cont_E INT, cont_I INT, cont_O INT, cont_U INT);'];
%pq_exec_params(conn, query);

% Solicitar una palabra
palabra = input('Ingrese una palabra: ', 's');

% Convertir la palabra a minúsculas para contar las vocales de manera insensible a mayúsculas
palabra = lower(palabra);

% Inicializar contadores para cada vocal
cont_A = 0;
cont_E = 0;
cont_I = 0;
cont_O = 0;
cont_U = 0;

% Contar las ocurrencias de cada vocal en la palabra
for i = 1:length(palabra)
    switch palabra(i)
        case 'a'
            cont_A = cont_A + 1;
        case 'e'
            cont_E = cont_E + 1;
        case 'i'
            cont_I = cont_I + 1;
        case 'o'
            cont_O = cont_O + 1;
        case 'u'
            cont_U = cont_U + 1;
    end
end

% Mostrar el resultado
fprintf('A=%d, E=%d, I=%d, O=%d, U=%d\n', cont_A, cont_E, cont_I, cont_O, cont_U);

% Insertar la información en la tabla "problema7"
query = ['INSERT INTO ', tablename, ' (palabra, cont_A, cont_E, cont_I, cont_O, cont_U) VALUES (''', palabra, ''', ', num2str(cont_A), ', ', num2str(cont_E), ', ', num2str(cont_I), ', ', num2str(cont_O), ', ', num2str(cont_U), ');'];
pq_exec_params(conn, query);

% Cerrar la conexión con la base de datos
pq_close(conn);
