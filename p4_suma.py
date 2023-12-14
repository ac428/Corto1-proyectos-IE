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

# Solicitar un número
num = int(input('Ingrese un número: '))

# Calcular la suma de los números desde 0 hasta el número ingresado
sum = 0
for i in range(num + 1):
    sum += i

# Mostrar la suma en la consola
print(f"La suma de los números desde 0 hasta {num} es: {sum}")

try: 
    # Insertar la información en la tabla "problema4"
    query = sql.SQL("INSERT INTO problema4 (num, sum, operacion) VALUES (%s, %s, %s);")
    cur.execute(query, (num, sum, 'Suma'))
    conn.commit()

except (Exception, psycopg2.DatabaseError) as error:
    print(f"Error durante la conexión a la DB, consulte sobre el error: {error}")

# Cerrar la conexión con la base de datos
conn.close()