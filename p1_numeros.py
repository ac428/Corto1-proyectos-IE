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

# Pedir al usuario que ingrese 3 números
num1 = int(input("Ingrese el primer número: "))
num2 = int(input("Ingrese el segundo número: "))
num3 = int(input("Ingrese el tercer número: "))

# Verificar condiciones y realizar operaciones
if (num1 > num2) and (num1 > num3):
    # Si el primero es el más grande, mostrar la suma
    resultado = num1 + num2 + num3
    operacion = 'Suma'
elif (num2 > num1) and (num2 > num3):
    # Si el segundo es el más grande, mostrar la multiplicación
    resultado = num1 * num2 * num3
    operacion = 'Multiplicación'
elif (num3 > num1) and (num3 > num2):
    # Si el tercero es el más grande, concatenar los números
    resultado = str(num1) + str(num2) + str(num3)
    operacion = 'Concatenación'

elif (num1 == num2) and (num2 == num3):
    # Si los tres son iguales, mostrar los números y un mensaje
    resultado = [num1, num2, num3]
    operacion = 'Todos son iguales'
else:
    # Si hay dos iguales, mostrar el único que no es igual
    if num1 == num2:
        resultado = num3
    elif num1 == num3:
        resultado = num2
    else:
        resultado = num1
    operacion = 'Número único'

# Mostrar resultado
print(f'Resultado de la operación ({operacion}): {resultado}')

# Insertar información en la tabla
try:
    query = sql.SQL("INSERT INTO problema1 (num1, num2, num3, resultado, operacion) VALUES (%s, %s, %s, %s, %s);")
    cur.execute(query, (num1, num2, num3, resultado, operacion))
    
    # Confirmar la transacción para guardar los cambios
    conn.commit()

except (Exception, psycopg2.DatabaseError) as error:
    print(f"Error drante la conexión a la DB, consulte sobre el error: {error}")

# Cerrar la conexión con la base de datos
conn.close()