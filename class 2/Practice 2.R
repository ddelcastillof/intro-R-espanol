# =================================================================
# INTRODUCCIÓN A R: LIMPIEZA Y ANALISIS DE DATOS
# Autor: Darwin Del Castillo & José Tinedo 
# Fecha: 27-01-2025
# =================================================================

#### IMPORTACIÓN DE DATOS ####

# En R existen diferentes formas de importar los datos y acepta
# datos de multiples fuentes y formatos.
# comando read 
data <- read.csv("~/R/intro-R-espanol/class 2/dataset.csv") # datos en formato csv
data <- readxl::read_excel(path) # datos en formato xls o xlxs
data <- readClipboard() # datos copiado en portapapeles  

# botón Import Dataset
# asistente de importación de datos con interfaz intuitiva.
# desventaja: formatos limitados

# Evaluación general de los datos
head(data) # Mostrar datos de cabecera (6 primeras filas)
tail(data) # Mostrar datos de la parte final (6 ultimas filas)
summary(data) # Mostrar un resumen estadistico general de cada columna
    
#### LIMPIEZA DE DATOS ####
# Verificamos si existen registros problema (datos faltantes, duplicados)

sum(is.na(data))   # Suma todos los datos NA que existe en el dataframe
sum(duplicated(data)) # Suma todos los registros duplicados exactos 

# Parte de la limpieza es tener mis datos sin registros erroneos o faltantes 

datos_limpios <- unique(df_duplicado) # Eliminamos datos duplicados exactos
sum(duplicated(datos_limpios)) # Comprobando el resultado

datos_limpios <- na.omit(datos_limpios) # Eliminar filas con datos faltantes 

# A veces es posible no querer eliminar los registros con NA 
# dependiendo del tipo de dato y la cantidad se podria realizar una imputación 
# de los datos faltantes

datos[is.na(datos)] <- "numero"  # Reemplaza NA con un numero

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
# dplyr es una paqueteria que permite manipular datos de forma fácil y rápida.
library("dplyr")
# operador pipe %>% : permite encadenar código para hacerlo más legible
# no genera un resultado por si mismo.

# select: selecciona columnas

datos_seleccionados <- datos_limpios %>%
  select(ID, Sexo)

head(datos_seleccionados)

# filter: filtra un dataframe basandose en una o más condiciones 
#Una condición
datos_filtrados <- datos_limpios %>%
  filter(Estado_Civil == "Soltero")
head(datos_filtrados)

#Dos condiciones
datos_filtrados <- datos_limpios %>%
  filter(Estado_Civil == "Soltero", Departamento == "Ventas")
head(datos_filtrados)

# Mutate: Añade nuevas columnas o modifica columnas existentes en un dataframe
# Una columna
datos_mutados <- datos_limpios %>% 
  mutate(empleado_feliz = Satisfaccion_Laboral >= 4)
summary(datos_mutados)

# Arrange: Ordena las filas de un dataframe según los valores de una o más columnas
#Una columna
datos_ordenados <- datos_limpios %>% 
  arrange(Edad)
print(datos_ordenados, n=100)

#dos columnas
datos_ordenados <- datos_limpios %>% 
  arrange(Edad, Salario)
print(datos_ordenados, n=100)

# summarise: resume los datos, generalmente aplicando una función de agregación como mean, sum, max, etc.

resumen <- datos_limpios %>% 
  summarise(edad_promedio = mean(Edad), 
            Experiencia_promedio = mean(Experiencia_Años),
            maxima_edad = max(Edad))
print(resumen)

# group_by: Agrupa los datos por una o más columnas, para luego aplicar operaciones por grupo

datos_agrupados <- datos_limpios %>% 
  group_by(Departamento) %>%
  summarise(edad_promedio = mean(Edad), 
            Experiencia_promedio = mean(Experiencia_Años))
print(datos_agrupados)

# rename: Cambia el nombre de una o más columnas
datos_rename <- datos_limpios %>%
  rename(Trabajador = Nombre)
print(datos_rename)

# count: Cuenta el número de filas por cada grupo de una o más columnas.
conteo <- datos_limpios %>%
  count(Departamento)
print(conteo)

conteo <- datos_limpios %>%
  count(Departamento, Estado_Civil)
print(conteo)

# La aplicacion de las funciones pueden ser en conjunto y se utiliza el 
# operador pipe
datos_nuevos <- datos_limpios %>%
  rename(Trabajador = Nombre) %>% 
  arrange(Edad) %>%
  mutate(empleado_triste = Satisfaccion_Laboral == 1)
print(datos_nuevos)
  
