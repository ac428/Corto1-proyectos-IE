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

# Solicitar dos números
num1 = int(input('Ingrese el primer número: '))
num2 = int(input('Ingrese el segundo número: '))

# Verificar cual es el mayor y asignarlo a "num_mayor"
num_mayor = max(num1, num2)

# Calcular los números desde el número mayor hasta el número menor
for i in range(num_mayor, min(num1, num2) - 1, -1):
    print(i) # Mostrar los números en la consola

try:
    # Insertar la información en la tabla "problema6"
    query = sql.SQL("INSERT INTO problema6 (num, num_inicio, num_fin, operacion) VALUES (%s, %s, %s, %s);")
    cur.execute(query, (i, num1, num2, 'Lista de mayor a menor'))
    conn.commit()
    
except (Exception, psycopg2.DatabaseError) as error:
    print(f"Error durante la conexión a la DB, consulte sobre el error: {error}")

# Cerrar la conexión con la base de datos
conn.close()