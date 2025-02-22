# ============================================================================
# DEMOSTRACIÓN DE REGRESIÓN LINEAL EN R
# Autor: Darwin Del Castillo
# Fecha: Febrero 2025
# ============================================================================

# ------------- INSTALACIÓN Y CARGA DE PAQUETES NECESARIOS ---------------------

# Cargar los paquetes necesarios usando pacman
library(rigr)      # Para análisis de regresión
library(lattice)   # Para gráficos
library(MASS)      # Para conjunto de datos adicionales

# ------------- CARGAR Y PREPARAR LOS DATOS ----------------------------------
# Cargar el conjunto de datos mammals de MASS como ejemplo
data(mammals)

# Ver las primeras filas de los datos
head(mammals)

# ------------- ANÁLISIS EXPLORATORIO ---------------------------------------
# Crear un gráfico de dispersión básico
plot(mammals$body, mammals$brain,
     xlab = "Peso Corporal",
     ylab = "Peso del Cerebro",
     main = "Relación entre Peso Corporal y Cerebral",
     pch = 19)

# ------------- MODELO DE REGRESIÓN LINEAL SIMPLE --------------------------
# Ajustar el modelo usando rigr
modelo_1 <- regress("mean", brain ~ body, 
                    robustSE = FALSE, 
                    data = mammals)

# Mostrar resultados del modelo
print(modelo_1)

# ------------- VERIFICACIÓN DE SUPUESTOS ----------------------------------

# 1. Linealidad y Homocedasticidad
# Crear un data frame con valores ajustados y residuos
diagnosticos <- data.frame(
  ajustados = modelo_1$fit$fitted.values,
  residuos = residuals(modelo_1, "jackknife")
)

# Gráfico de residuos vs valores ajustados
plot(diagnosticos$ajustados, diagnosticos$residuos,
     xlab = "Valores Ajustados",
     ylab = "Residuos",
     main = "Residuos vs Valores Ajustados",
     pch = 19)
abline(h = 0, col = "red", lty = 2)

# 2. Normalidad de residuos
# Gráfico Q-Q normal
qqnorm(diagnosticos$residuos,
       main = "Gráfico Q-Q Normal de Residuos")
qqline(diagnosticos$residuos, col = "red")

# ------------- TRANSFORMACIÓN LOGARÍTMICA ---------------------------------
# Debido a la no linealidad observada, probamos transformación logarítmica

# Ajustar modelo con variables transformadas
modelo_2 <- regress("mean", log(brain) ~ log(body), 
                    robustSE = FALSE, 
                    data = mammals)

# Mostrar resultados del modelo transformado
print(modelo_2)

# Verificar supuestos del modelo transformado
diagnosticos_2 <- data.frame(
  ajustados = modelo_2$fit$fitted.values,
  residuos = residuals(modelo_2, "jackknife")
)

# Gráficos de diagnóstico para modelo transformado
par(mfrow = c(1,2))

# Residuos vs ajustados
plot(diagnosticos_2$ajustados, diagnosticos_2$residuos,
     xlab = "Valores Ajustados (log)",
     ylab = "Residuos",
     main = "Residuos vs Valores Ajustados\n(Modelo Log-transformado)",
     pch = 19)
abline(h = 0, col = "red", lty = 2)

# Q-Q plot
qqnorm(diagnosticos_2$residuos,
       main = "Gráfico Q-Q Normal\n(Modelo Log-transformado)")
qqline(diagnosticos_2$residuos, col = "red")

# Restaurar configuración original de gráficos
par(mfrow = c(1,1))

# ------------- INTERPRETACIÓN --------------------------------------------
# Calcular R-cuadrado para ambos modelos
r2_modelo1 <- cor(mammals$brain, modelo_1$fit$fitted.values)^2
r2_modelo2 <- cor(log(mammals$brain), modelo_2$fit$fitted.values)^2

# Imprimir resultados
cat("\nR-cuadrado del modelo original:", round(r2_modelo1, 3))
cat("\nR-cuadrado del modelo log-transformado:", round(r2_modelo2, 3))