%PROBLEMA 3 -- VOCALES
%Conexión con la base de datos
pkg load database
conn=pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','523811'))

% Crear tabla en base de datos
%tablename = 'problema3';
%query = ['CREATE TABLE IF NOT EXISTS ', tablename, ' (word TEXT, num_vowels INT, operacion TEXT);'];
%pq_exec_params(conn, query);

% Solicitar la palabra
word = input('Ingrese una palabra: ', 's');

% Convertir la palabra a minúsculas
word = lower(word);

% Contar cuántas vocales tiene la palabra
numVowels = 0;
for i = 1:length(word)
    if ismember(word(i), 'aeiou')
        numVowels = numVowels + 1;
    end
end

% Mostrar cuántas vocales tiene la palabra en consola
disp(['La palabra ', word, ' tiene ', num2str(numVowels), ' vocales.']);

% Insertar la información en la tabla "problema3"
query = ['INSERT INTO ', tablename, ' (word, num_vowels, operacion) VALUES (''', word, ''', ', num2str(numVowels), ', ''Vocales'');'];
pq_exec_params(conn, query);

% Cerrar la conexión con la base de datos
pq_close(conn);
