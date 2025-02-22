# =================================================================
# INTRODUCCIÓN A R: ESTADISTICA INFERENCIAL 
# Autor: Darwin Del Castillo & José Tinedo 
# Fecha: 22-02-2025
# =================================================================

#Activar librerias
library(ggplot2)

## Preparando la base de datos
# URL del archivo de datos
url <- "https://raw.githubusercontent.com/jbrownlee/Datasets/master/pima-indians-diabetes.data.csv"

# Leer los datos usando read.table
diabetes_data <- read.table(url, sep = ",", header = FALSE)

# Asignar nombres a las columnas
colnames(diabetes_data) <- c("Pregnancies", "Glucose", "BloodPressure", "SkinThickness", 
                             "Insulin", "BMI", "DiabetesPedigreeFunction", "Age", "Outcome")

# Mostrar las primeras filas
head(diabetes_data)

# Estadistica descriptiva 
# Uso del paquete rigr
install.packages("rigr")
library(rigr)
descrip(diabetes_data$Glucose)
descrip(diabetes_data$BMI)

# Prueba t de dos muestras independientes
#queremos comparar los niveles de glucosa entre pacientes 
# con y sin diabetes utilizando el conjunto de datos de diabetes mencionado anteriormente:
t.test(diabetes_data$Glucose[diabetes_data$Outcome == 0], diabetes_data$Glucose[diabetes_data$Outcome == 1])

#Regresion lineal 
# La cración de un modelo de puede hacer con multiples funciones entre ellas tenemos
# regress de la libreia "rigr" y lm que es una funcion de r base 
#Creación del modelo 
modelo <- regress("mean", Outcome ~ BMI + Glucose , data = diabetes_data)
summary(modelo)

#Creación del modelo por lm 
mod <- lm(Age ~ Glucose , data = diabetes_data) 
summary(mod)

#Comprobacíón de suspuestos 
#Supuesto de Linealidad
mean(mod$residuals)

#Supuesto de Normalidad
# Prueba de Shapiro-Wilk
shapiro.test(mod$residuals)

#Graficar la ecuacion de la recta
ggplot(diabetes_data, aes(y=Age, x=Glucose))+ 
  geom_smooth(method=lm, colour="red")+
  geom_point()# linear model

#Homocedasticidad
#para el analisis de homocedasticidad utilizaremos el paquete lmtest
install.packages("lmtest")
library(lmtest) 
# Se utiliza el comando bptest para ejecutar el test de Breusch-Pagan.
# la función utiliza los residuos por ello no es necesario señalarlos.
bptest(mod)

#Independencia
install.packages("car")
library(car) # para el test de durbin-watson
# Se utiliza la prueba de 
durbinWatsonTest(mod)
