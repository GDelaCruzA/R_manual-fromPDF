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
length(pagina[[1]])
# se prueba que el renglón tenga información; 0 es renglón vacío, solo \n
str_length(pagina[[1]][1]) # núm de pág i
str_length(pagina[[1]][2]) # renglón 0
str_length(pagina[[1]][3])
str_length(pagina[[1]][4])

# el primer renglón es el número de página, el segundo está en blanco
# 
# si el primer caracter es un número, es el número arábigo con el nombre del paquete,
# uno o dos carcateres del número luego la palabra 'The', luego el nombre del idem. 
# 
# el nombre de la función genérica viene precedida de nueve espacios en blanco;
# el nombre de la función está delimitado por un espacio; al final de la línea viene
# el conjunto de números de la página en el manual