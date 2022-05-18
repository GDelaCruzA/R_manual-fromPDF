# para el indice en html
library(XML)
# define un pointer al archivo para hacer el parsing al vuelo
indice.html <- htmlTreeParse(file = "C:/Program Files/R/R-4.2.0/library/base/html/00Index.html",
                             useInternalNodes = TRUE )
# procesa el html sobre el bloque de cada renglón en las tablas
doc.text = unlist(xpathApply(indice.html, '//td', xmlValue))
# en este doc.text están los contenidos de las tablas de la ayuda de cada módulo
doc.text[11:20]
# el elemento non es el nombre de la función; el elemento par es la definición
# no incluye el href
# 
#doc.text = unlist(xpathApply(indice.html, '//table', xmlValue))
#doc.text = unlist(xpathApply(indice.html, '//url', xmlValue))
# extrae el URL en LO:calc https://ask.libreoffice.org/t/url-or-hyperlink-to-text/54807
# 
print(doc.text[3])
# se lee todo el archivo html
indice.html <- readLines("C:/Program Files/R/R-4.2.0/library/base/html/00Index.html")
print( indice.html[51:70])
# se extraen sólo los elementos de las tablas;
# el elemento non es el URL y el nombre de la función (el URL es genérico de la); 
# el elemento par es la definición
linea1 <- indice.html[grep("<td", indice.html)]
linea1[1:10]
# extrae funcion genérica del URL
url <- 'href=\\\".*\\.html'
href <- str_extract(linea1[1], url)
fungenerica <- gsub('href=\"', "", href)
fungenerica <- gsub('.html', "", fungenerica, fixed = TRUE)

# extrae el nombre de la función
funpat <- 'l\\\">.*</a'
orale <- str_extract(linea1[1], funpat)
derivada <- gsub('l\">', "", orale)
derivada <- gsub("</a", "", derivada)

# se extrae la definición del elemento par
defpat <- ">.*</td"
orale <- str_extract(linea1[2], defpat)
defini <- gsub(">", "", orale)
defini <- gsub("</td", "", defini)
#adlivitum
#
# Delete unwanted characters in the lines we pulled out
# authors <- gsub("<I<", "", author_lines, fixed = TRUE)
