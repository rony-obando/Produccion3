import matplotlib.pyplot as plt

# Datos proporcionados
x_values = [3, 5, 6, 8, 10, 12]
y_values = [45, 52, 58, 62, 70, 85]

# Parámetros de la línea de regresión y = ax + b
a = 62
b = 0.035

# Crear la figura y los ejes
fig, ax = plt.subplots()

# Graficar los puntos
ax.scatter(x_values, y_values, color='blue')

# Graficar la línea de regresión
x_range = range(min(x_values), max(x_values) + 1)
y_line = [a * x + b for x in x_range]
ax.plot(x_range, y_line, color='red')

# Añadir etiquetas y título
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_title('Gráfica de Regresión Lineal')

# Guardar la gráfica como una imagen
plt.savefig('regresion_lineal.png')
