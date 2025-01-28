# =================================================================
# INTRODUCCIÓN A R: LIMPIEZA Y ANALISIS DE DATOS
# Autor: Darwin Del Castillo & José Tinedo 
# Fecha: 27-01-2025
# =================================================================

#### IMPORTACIÓN DE DATOS ####

# En R existen diferentes formas de importar los datos y acepta
# datos de multiples fuentes y formatos.
# comando read 
data <- read.csv(path) # datos en formato csv
data <- readxl::read_excel(path) # datos en formato xls o xlxs
data <- readClipboard() # datos copiado en portapapeles  
  
datos <-iris
  
# botón Import Dataset
# asistente de importación de datos con interfaz intuitiva.
# desventaja: formatos limitados

# Evaluación general de los datos
head(data) # Mostrar datos de cabecera (6 primeras filas)
tail(data) # Mostrar datos de la parte final (6 ultimas filas)
summary(data) # Mostrar un resumen estadistico general de cada columna
    
#### LIMPIEZA DE DATOS ####

datos_limpios <- na.omit(data) # Eliminar filas con datos faltantes 
datos_limpios <- unique(data) # Eliminamos datos duplicados 
datos[is.na(datos)] <- 0  # Reemplaza NA con 0

# Datos limpios

#### GESTIÓN DE PAQUETES #### 

# Instalación de paquetes desde CRAN con R base 
install.packages("nombre del paquete")
install.packages("pacman")

# Activar o llamar un paquete
library("pacman")

# Instalación de paquetes con Pacman
p_load(dplyr, ggplot2, devtools) #instala y/o activa paquetes mencionados

# Instalación de paquetes con devtools - github 
install_github("usuario/repositorio")

# Leer la documentación del paquete 
help.search("dplyr")

# Desactivar paquetes 
detach("pacman", unload=TRUE)

# Para saber que paquetes/librerias estan activas en la sesión.
search()

# Eliminar paquetes 
remove.packages("nombre del paquete")
remove.packages("pacman")

#### USO DE DYPLYR #### 
# dplyr es una paqueteria que permite manipular datos de forma facil y rapida.
library("dplyr")
# operador pipe %>% : permite encadenar código para hacerlo más legible
# no genera un resultado por si mismo.

# select: selecciona columnas
datos_seleccionados <- iris %>%
  select(Sepal.Length, Species)
install.packages("medicaldata")
library("medicaldata")
data(package = "medicaldata")
summary(airquality)
# filter
# mutate
# arrange
# summarise
# group_by
# rename
# count
