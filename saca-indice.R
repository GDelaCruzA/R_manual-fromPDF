# ensayo para leer el índice del manual de R en PDF
# 
library(pdftools)
library(stringr)
library(dplyr)
# todo el documento queda en un solo vector
elpdf2text <- pdf_text("The R Reference Index V4.2.0 indice.pdf")
# cada página del pdf (elemento del vector elpdf2text) se acomoda por renglón
# nos da una lista con un vector con cada uno de los renglones de la página
pagina <- str_split(elpdf2text[1], pattern = "\n")
# número de renglones en la página
lineas <- length(pagina[[1]])
# se prueba que el renglón tenga información; 0 es renglón vacío, solo \n
str_length(pagina[[1]][1]) # núm de pág i
str_length(pagina[[1]][2]) # renglón 0
str_length(pagina[[1]][3])
str_length(pagina[[1]][4])

# el primer renglón es el número de página, el segundo está en blanco
# 
# si el primer caracter es un número, es el número arábigo con el nombre del paquete,
# uno o dos caracteres del número luego la palabra 'The', luego el nombre del idem. 
# 
# el nombre de la función genérica viene precedida de nueve espacios en blanco;
# el nombre de la función está delimitado por un espacio; al final de la línea viene
# el conjunto de números de la página en el manual
pagi <- "\\d+$"  # dígito, uno o más, al final, página de cada paquete o función
capi <- "\\d+"  # dígito, uno o más, al principio, capítulo nombre del paquete
funi <- "\\s{9}^" # espacio, cualquier caracter, espacio, nombre de la función
funi <- "[:blank:]+"

# para cada línea hasta el total en la página (lineas)
# probar si es capi, número al inicio > capítulo,
#   entonces, sacar numero del cap, nombre del paquete, p´g de inicio en el índice
# probar si la línea inicia con más de dos espacios,
#   entonces, sacar el nombre de la función (funi) y el número de página
#   
str_starts(pagina[[1]][4], pattern = capi) # es la línea del capítulo > TRUE

str_detect(pagina[[1]][5], pattern = funi) # es la línea de la función > TRUE

str_extract(pagina[[1]][5], pattern = funi)
