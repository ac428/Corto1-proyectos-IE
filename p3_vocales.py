import psycopg2
from psycopg2 import sql

# Conexión con la base de datos
conn = psycopg2.connect(
    dbname='corto1', 
    host='localhost', 
    port='5432', 
    user='postgres', 
    password='523811')

# Crear un cursor para ejecutar consultas
cur = conn.cursor()

# Solicitar la palabra
word = input('Ingrese una palabra: ')

# Convertir la palabra a minúsculas
word = word.lower()

# Contar cuántas vocales tiene la palabra
numVowels = 0
for char in word:
    if char in 'aeiou':
        numVowels += 1

# Mostrar cuántas vocales tiene la palabra en consola
print(f"La palabra {word} tiene {numVowels} vocales.")

# Insertar la información en la tabla "problema3"
try:
    query = sql.SQL("INSERT INTO problema3 (word, num_vowels, operacion) VALUES (%s, %s, %s);")
    cur.execute(query, (word, numVowels, 'Vocales'))

    # Confirmar la transacción para guardar los cambios
    conn.commit()
except (Exception, psycopg2.DatabaseError) as error:
    print(f"Error durante la conexión a la DB, consulte sobre el error: {error}")

# Cerrar la conexión con la base de datos
conn.close()