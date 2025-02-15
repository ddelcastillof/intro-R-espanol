# =================================================================
# INTRODUCCIÓN A R: ESTADISTICA DESCRIPTIVA Y ANALISIS BIVARIADO 
# Autor: Darwin Del Castillo & José Tinedo 
# Fecha: 15-02-2025
# =================================================================

# Cargar librerías necesarias
library(ggplot2)
library(dplyr)

# Generar datos simulados para estudiantes de medicina
set.seed(123)  # Para reproducibilidad
n <- 100  # Número de estudiantes

datos <- data.frame(
  Edad = rnorm(n, mean = 22, sd = 2),  # Edad de los estudiantes
  Peso = rnorm(n, mean = 70, sd = 10),  # Peso en kg
  Altura = rnorm(n, mean = 170, sd = 8),  # Altura en cm
  Presion_Sistolica = rnorm(n, mean = 120, sd = 10),  # Presión sistólica
  Presion_Diastolica = rnorm(n, mean = 80, sd = 5),  # Presión diastólica
  Fuma = sample(c("Sí", "No"), n, replace = TRUE, prob = c(0.3, 0.7)),  # Fumador o no
  Genero = sample(c("Hombre", "Mujer"), n, replace = TRUE),  # Género de los estudiantes
  Grupo = sample(c("A", "B", "C"), n, replace = TRUE)  # Grupo de estudio
)
# Ver las primeras filas de los datos
head(datos)

# Estadística descriptiva
summary(datos)

# ----------------------------------------------------------
# 1. HISTOGRAMA (Distribución de una variable continua)
# ----------------------------------------------------------
# Histograma de la edad
ggplot(datos, aes(x = Edad)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black") +
  labs(title = "Distribución de Edad", x = "Edad", y = "Frecuencia")

# Un histograma muestra la distribución de una variable continua.
ggplot(datos, aes(x = Edad)) +
  geom_histogram(binwidth = 2, fill = "skyblue", color = "black") +
  labs(title = "Histograma de Edad",
       x = "Edad", y = "Frecuencia") +
  theme_minimal()

# ----------------------------------------------------------
# 2. GRÁFICO DE BARRAS (Comparación de categorías)
# ----------------------------------------------------------

# Un gráfico de barras es útil para comparar frecuencias entre categorías.
ggplot(datos, aes(x = Grupo, fill = Grupo)) +
  geom_bar() +
  labs(title = "Distribución de Grupo",
       x = "Grupo", y = "Cantidad") +
  theme_minimal()

# ----------------------------------------------------------
# 3. BOXPLOT (Distribución y comparación entre grupos)
# ----------------------------------------------------------
# Un boxplot muestra la distribución de una variable continua por grupos.
# Boxplot de presión sistólica por hábito de fumar
ggplot(datos, aes(x = Fuma, y = Presion_Sistolica, fill = Fuma)) +
  geom_boxplot() +
  labs(title = "Presión Sistólica por Hábito de Fumar", x = "Fuma", y = "Presión Sistólica")

ggplot(datos, aes(x = Grupo, y = Peso, fill = Grupo)) +
  geom_boxplot() +
  labs(title = "Distribución de Peso por Grupo",
       x = "Grupo", y = "Peso (kg)") +
  theme_minimal()

# ----------------------------------------------------------
# 4. SCATTER PLOT (Relación entre dos variables continuas)
# ----------------------------------------------------------
# Scatter plot de peso vs altura
ggplot(datos, aes(x = Peso, y = Altura)) +
  geom_point(color = "red") +
  labs(title = "Peso vs Altura", x = "Peso (kg)", y = "Altura (cm)")

# Un scatter plot muestra la relación entre dos variables continuas.
ggplot(datos, aes(x = Altura, y = Peso)) +
  geom_point(color = "orange", size = 3) +
  labs(title = "Relación entre Altura y Peso",
       x = "Altura (cm)", y = "Peso (kg)") +
  theme_minimal()

# ----------------------------------------------------------
# 5. GRÁFICO DE BARRAS AGRUPADAS (Comparación de dos categorías)
# ----------------------------------------------------------
# Un gráfico de barras agrupadas compara dos variables categóricas.
ggplot(datos, aes(x = Grupo, fill = Genero)) +
  geom_bar(position = "dodge") +
  labs(title = "Distribución de Género por Grupo",
       x = "Grupo", y = "Cantidad", fill = "Género") +
  theme_minimal()

# ----------------------------------------------------------
# 6. GRÁFICO DE DENSIDAD (Distribución suavizada)
# ----------------------------------------------------------
# Gráfico de densidad para la presión diastólica
ggplot(datos, aes(x = Presion_Diastolica, fill = Genero)) +
  geom_density(alpha = 0.5) +
  labs(title = "Distribución de Presión Diastólica por Género", x = "Presión Diastólica", y = "Densidad")

# Un gráfico de densidad muestra la distribución suavizada de una variable.
ggplot(datos, aes(x = Edad, fill = Genero)) +
  geom_density(alpha = 0.5) +  # alpha para transparencia
  labs(title = "Distribución de Edad por Género",
       x = "Edad", y = "Densidad") +
  theme_minimal()

# ----------------------------------------------------------
# 7. PERSONALIZACIÓN BÁSICA (Títulos, colores, temas)
# ----------------------------------------------------------
# ggplot2 permite personalizar los gráficos fácilmente.
ggplot(datos, aes(x = Altura, y = Peso, color = Genero)) +
  geom_point(size = 3) +
  labs(title = "Relación entre Altura y Peso por Género",
       x = "Altura (cm)", y = "Peso (kg)", color = "Género") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    axis.title = element_text(size = 12),
    legend.position = "bottom"
  )

# ----------------------------------------------------------
# ANALISIS BIVARIADOS
# ----------------------------------------------------------

# Correlación entre peso y altura (Rho de Spearman)
correlacion_spearman <- cor(datos$Peso, datos$Altura, method = "spearman")
print(paste("La correlación de Spearman entre Peso y Altura es:", round(correlacion_spearman, 2)))

# Prueba t para comparar presión sistólica entre fumadores y no fumadores
t_test <- t.test(Presion_Sistolica ~ Fuma, data = datos)
print(t_test)

# Análisis de chi-cuadrado para género y hábito de fumar
tabla_contingencia <- table(datos$Genero, datos$Fuma)
chi_cuadrado <- chisq.test(tabla_contingencia)
print(chi_cuadrado)
