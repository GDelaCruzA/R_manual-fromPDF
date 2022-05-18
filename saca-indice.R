# ensayo para leer el índice del manual de R en PDF
# 
library(pdftools)
library(stringr)
library(dplyr)

capi <- "\\d+"  # dígito, uno o más, al principio, capítulo nombre del paquete
funi <- "\\s+" # nueve espacios al inicio de la entrada de la función
puntos <- "\\.\\s\\."
tabla_indice_manual <- data.frame(func = "", def = "", pkg = "",
                                  funclean = "", pag = "")

# todo el documento queda en un solo vector con las páginas como elemento
elpdf2text <- pdf_text("The R Reference Index V4.2.0 indice.pdf")
numdepags <- length(elpdf2text)
#numdepags <- 5
for (i in 1:numdepags) {
  # cada página del pdf (elemento del vector elpdf2text) se acomoda por renglón
  # nos da una lista con un vector con cada uno de los renglones de la página
  pagina <- str_split(elpdf2text[i], pattern = "\n")[[1]]
  # número de renglones en la página
  numdelineas <- length(pagina)
  # para cada uno de los renglones
  for (j in 1:numdelineas) {
    # se prueba que el renglón tenga información; 0 es renglón vacío, solo \n
    renglon <- pagina[j]
    lonrenglon <- str_length(renglon)
    # si el tamaño > 0 entonces se procesa  
    if (lonrenglon > 0) {
      # para cada línea hasta el total en la página (lineas)
      # probar si es capi, número al inicio > capítulo,
      # si...  
      if (str_starts(renglon, pattern = capi)) {
        # es la línea del capítulo -> TRUE
        # extraer el número, nombre del paquete y la página del manual
        saca <- as.vector(str_extract_all(renglon, pattern = "\\w+")[[1]])
        capinum <- saca[1]
        paquete <- saca[3]
        paginum <- saca[5]
        # se integra a la base de datos
        contador <- dim(tabla_indice_manual)[1] + 1
        tabla_indice_manual[contador,] <- c("", "", paquete, "", paginum)
      #} else if (str_starts(renglon, pattern = funi)) {
       } else if (str_detect(renglon, pattern = puntos)) {
        # es la línea de la función > TRUE)
        # partir y extraer el nombre de la función y la página del manual
        lineafun <- str_split(renglon, " ")[[1]]
        numele <- length(lineafun)
        for (k in 1:numele) {
          if (lineafun[k] != "") {
            nomfuncion <- lineafun[k]
            break
          }
        }
        #nomfuncion <- lineafun[10]
        nomfunpag <- lineafun[length(lineafun)]
        # se integra a la base de datos
        contador <- dim(tabla_indice_manual)[1] + 1
        tabla_indice_manual[contador,] <- c(nomfuncion, "", paquete,
                              nomfuncion, nomfunpag)
      } 
    }
  }
}
# se guarda la tablita

save(tabla_indice_manual, file = "tabla-indice-manual.RData")

# para cargar la tabla, load(file = "tabla-indice-manual.RData")
# 
# str_length(pagina[[1]][1]) # núm de pág i
# str_length(pagina[[1]][2]) # renglón 0
# str_length(pagina[[1]][3])
# str_length(pagina[[1]][4])

# el primer renglón es el número de página, el segundo está en blanco
# 
# si el primer caracter es un número, es el número arábigo con el nombre del paquete,
# uno o dos caracteres del número luego la palabra 'The', luego el nombre del idem. 
# 
# el nombre de la función genérica viene precedida de nueve espacios en blanco;
# el nombre de la función está delimitado por un espacio; al final de la línea viene
# el conjunto de números de la página en el manual
# pagi <- "\\d+$"  # dígito, uno o más, al final, página de cada paquete o función
# capi <- "\\d+"  # dígito, uno o más, al principio, capítulo nombre del paquete
# funi <- "\\s{9}^" # espacio, cualquier caracter, espacio, nombre de la función



# renglon <- pagina[[1]][2]
# renglon <- pagina[[1]][3]
# renglon <- pagina[[1]][4]
# renglon <- pagina[[1]][6]


#   entonces, sacar numero del cap, nombre del paquete, p´g de inicio en el índice
# probar si la línea inicia con más de dos espacios,
#   entonces, sacar el nombre de la función (funi) y el número de página

# comprobar que es línea de función
# el nombre puede llevar ., _ o - como parte de sus palabras
# palabra <- "[:alpha:\\.\\-\\_]\\w+"
# palabra <- "[:alpha:]\\w+"
# 

# sacafun <- "\\s{9}.+\\s\\."
# saca <- as.vector(str_extract_all(renglon, pattern = palabra)[[1]])
# str_extract(renglon, sacafun)
# comprobar que es línea de función
# str_starts(renglon, pattern = funi) # es la línea de la función > TRUE
# ok. identifica la línea de la función, entonces
# dale!!!
pagina <- str_split(elpdf2text[1], pattern = "\n")[[1]]
pagina[5]
(elementos <- str_split(pagina[5], " ")[[1]])
length(elementos)
