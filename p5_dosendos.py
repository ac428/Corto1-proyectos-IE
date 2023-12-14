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

# Solicitar un número de inicio y un número de fin
num_inicio = int(input('Ingrese un número de inicio: '))
num_fin = int(input('Ingrese un número de fin: '))

# Calcular los números de 2 en 2 desde el número de inicio hasta el número de fin
for i in range(num_inicio, num_fin + 1, 2):
    # Mostrar los números en la consola
    print(i)

    try:
        # Insertar la información en la tabla "problema5"
        query = sql.SQL("INSERT INTO problema5 (num, num_inicio, num_fin, operacion) VALUES (%s, %s, %s, %s);")
        cur.execute(query, (i, num_inicio, num_fin, 'Numeros de 2 en 2'))

        # Confirmar la transacción para guardar los cambios
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(f"Error durante la conexión a la DB, consulte sobre el error: {error}")

# Cerrar la conexión con la base de datos
conn.close()