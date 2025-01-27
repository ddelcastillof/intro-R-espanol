# =================================================================
# INTRODUCCIÓN A R: CONCEPTOS BÁSICOS
# Autor: Darwin Del Castillo
# Fecha: 09-01-2025
# =================================================================

# R como calculadora
# -----------------------------------------------------------------
# R puede realizar operaciones matemáticas básicas
2 + 3  # Suma
5 - 2  # Resta
4 * 3  # Multiplicación
10 / 2  # División
2 ^ 3  # Potencia
sqrt(16)  # Raíz cuadrada
abs(-4)  # Valor absoluto

# Operaciones con decimales y orden de operaciones
3.14159 * 2
(2 + 3) * 4  # Los paréntesis determinan el orden de las operaciones

# Variables y asignación
# -----------------------------------------------------------------
# Podemos guardar valores en variables usando <- o =
x <- 10  # Forma preferida en R
y = 20   # Alternativa válida pero menos común en R
z <- x + y
print(z)

# Funciones básicas en R
# -----------------------------------------------------------------
# Las funciones son bloques fundamentales en R
# Veamos algunas funciones básicas con ejemplos

# La función mean() calcula el promedio aritmético
numeros_ejemplo <- c(10, 12, 13, 13, 14, 18, 20)
promedio <- mean(numeros_ejemplo)
print(promedio)

# La función round() redondea números
# Requiere dos argumentos: x (el número) y digits (decimales a mantener)
round(x = 5.7668, digits = 2)  # Redondea a 2 decimales
round(promedio, 1)  # Redondea nuestro promedio a 1 decimal

# La función seq() crea secuencias
# Muy útil para crear vectores con patrones específicos
seq(from = 1, to = 10, by = 2)  # Números impares del 1 al 10
seq(from = 0, to = 1, length.out = 5)  # 5 números equidistantes entre 0 y 1

# Tipos de datos básicos
# -----------------------------------------------------------------
# Numérico (numeric)
numero <- 42.5
typeof(numero)

# Texto (character)
texto <- "Hola mundo"
typeof(texto)

# Lógico (logical)
logico <- TRUE  # También puede ser FALSE
typeof(logico)

# Factor (útil para variables categóricas)
factor_ejemplo <- factor(c("Bajo", "Medio", "Alto", "Medio", "Bajo"))
levels(factor_ejemplo)  # Muestra las categorías únicas
table(factor_ejemplo)   # Muestra la frecuencia de cada categoría

# Vectores
# -----------------------------------------------------------------
# Los vectores son colecciones unidimensionales de elementos del mismo tipo
numeros <- c(1, 2, 3, 4, 5)
textos <- c("rojo", "verde", "azul")
logicos <- c(TRUE, FALSE, TRUE)

# Operaciones vectorizadas
suma_vector <- numeros + 2  # Suma 2 a cada elemento
producto_vectores <- numeros * c(2, 2, 2, 2, 2)  # Multiplicación elemento por elemento

# Funciones útiles con vectores
length(numeros)  # Longitud del vector
sum(numeros)     # Suma de todos los elementos
mean(numeros)    # Promedio
sd(numeros)      # Desviación estándar
max(numeros)     # Valor máximo
min(numeros)     # Valor mínimo

# Selección de elementos en vectores
primer_elemento <- numeros[1]  # R usa índices que empiezan en 1
elementos_especificos <- numeros[c(1, 3, 5)]  # Selección múltiple
elementos_condicion <- numeros[numeros > 3]  # Selección condicional

# Matrices
# -----------------------------------------------------------------
# Las matrices son arreglos bidimensionales
matriz <- matrix(1:9, nrow = 3, ncol = 3)
print(matriz)

# Creación de matrices con datos específicos
matriz_personalizada <- matrix(
  c(1, 2, 3,
    4, 5, 6,
    7, 8, 9),
  nrow = 3,
  byrow = TRUE  # Llena la matriz por filas
)

# Operaciones con matrices
transpuesta <- t(matriz)  # Transponer matriz
suma_matrices <- matriz + matriz  # Suma elemento por elemento
producto_matriz <- matriz %*% matriz  # Multiplicación matricial

# Atributos de matrices
dim(matriz)  # Dimensiones de la matriz
nrow(matriz)  # Número de filas
ncol(matriz)  # Número de columnas

# Selección en matrices
elemento_matriz <- matriz[2, 3]  # Elemento en fila 2, columna 3
fila_matriz <- matriz[1, ]  # Primera fila completa
columna_matriz <- matriz[, 2]  # Segunda columna completa

# Listas
# -----------------------------------------------------------------
# Las listas pueden contener elementos de diferentes tipos
mi_lista <- list(
  numeros = c(1, 2, 3),
  texto = "ejemplo",
  logico = TRUE,
  matriz = matrix(1:4, 2, 2)
)

# Acceso a elementos de la lista
primer_elemento_lista <- mi_lista$numeros  # Usando $
segundo_elemento_lista <- mi_lista[[2]]  # Usando índices dobles
elemento_nombre <- mi_lista[["texto"]]  # Usando nombre

# Estructura de la lista
str(mi_lista)  # Muestra la estructura detallada de la lista

# Data Frames
# -----------------------------------------------------------------
# Los data frames son tablas de datos donde cada columna puede ser de diferente tipo
df <- data.frame(
  nombre = c("Ana", "Juan", "María", "Pedro"),
  edad = c(25, 30, 28, 35),
  altura = c(165, 180, 170, 175),
  activo = c(TRUE, FALSE, TRUE, TRUE)
)

# Estructura y resumen del data frame
str(df)  # Muestra la estructura
summary(df)  # Resumen estadístico básico

# Acceso a datos en el data frame
nombres <- df$nombre  # Selección de columna
primera_fila <- df[1, ]  # Primera fila
subset_df <- df[df$edad > 25, ]  # Filas que cumplen una condición

# Nombres de columnas y filas
colnames(df)  # Nombres de las columnas
rownames(df)  # Nombres de las filas
rownames(df) <- c("A", "B", "C", "D")  # Asignar nombres a las filas

# Funciones avanzadas
# -----------------------------------------------------------------
# Función con validación y múltiples salidas
calcular_estadisticas <- function(datos, tipo = "completo") {
  # Validación de entrada
  if (!is.numeric(datos)) {
    stop("Los datos deben ser numéricos")
  }
  
  # Cálculos básicos
  resultados <- list(
    n = length(datos),
    promedio = mean(datos),
    desviacion = sd(datos)
  )
  
  # Cálculos adicionales según el tipo
  if (tipo == "completo") {
    resultados$mediana <- median(datos)
    resultados$rango <- range(datos)
    resultados$cuartiles <- quantile(datos)
  }
  
  return(resultados)
}

# Ejemplo de uso de la función
datos_prueba <- c(10, 15, 20, 25, 30, 35, 40)
stats_basicas <- calcular_estadisticas(datos_prueba, tipo = "basico")
stats_completas <- calcular_estadisticas(datos_prueba, tipo = "completo")

# Instalación y carga de paquetes
# -----------------------------------------------------------------
# Instalar un paquete (comentado para evitar la instalación accidental)
# install.packages("dplyr")

# Cargar un paquete instalado
# library(dplyr)

# Ver paquetes instalados
installed.packages()[, c("Package", "Version")]

# Ayuda y documentación
# -----------------------------------------------------------------
# Obtener ayuda sobre una función
# ?mean
# help(sum)
# example(plot)
