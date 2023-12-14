import psycopg2
from psycopg2 import sql
import numpy as np

#Conexión con la base de datos
conn = psycopg2.connect(
    dbname='corto1', 
    host='localhost', 
    port='5432', 
    user='postgres', 
    password='523811')

#Crear un cursor para ejecutar consultas
cur = conn.cursor()

# Get the number
num = int(input('Ingrese un número: '))

# Find the divisors of the number
divisors = []
for i in range(1, num + 1):
    if num % i == 0:
        divisors.append(i)

# Print the divisors in console
print(f"Los divisores de {num} son:")
print(divisors)

# Insertar información en la tabla
try:
    query = sql.SQL("INSERT INTO problema2 (num, divisores, operacion) VALUES (%s, %s, %s);")
    cur.execute(query, (num, str(divisors).replace('[', '').replace(']', ''), 'Divisores'))
    
    # Confirmar la transacción para guardar los cambios
    conn.commit()

except (Exception, psycopg2.DatabaseError) as error:
    print(f"Error durante la conexión a la DB, consulte sobre el error: {error}")

# Close the connection with the database
conn.close()