# para el indice en html
library(stringr)
# library(XML)
# define un pointer al archivo para hacer el parsing al vuelo
# indice.html <- htmlTreeParse(file = "C:/Program Files/R/R-4.2.0/library/base/html/00Index.html", useInternalNodes = TRUE )
# 
# procesa el html sobre el bloque de cada renglón en las tablas
# doc.text = unlist(xpathApply(indice.html, '//td', xmlValue))
# en este doc.text están los contenidos de las tablas de la ayuda de cada módulo
# doc.text[11:20]
# el elemento non es el nombre de la función; el elemento par es la definición
# no incluye el href
# 
#doc.text = unlist(xpathApply(indice.html, '//table', xmlValue))
#doc.text = unlist(xpathApply(indice.html, '//url', xmlValue))
# extrae el URL en LO:calc https://ask.libreoffice.org/t/url-or-hyperlink-to-text/54807
# 
# print(doc.text[3])
load("pkg_baseyreco-index.RData")
instala_base <- c(ord_base, ord_reco)
url <- 'href=\\\".*\\.html'
defpat <- ">.*</td"
funpat <- 'l\\\">.*</a'
tabla_indice_html <- data.frame(func = "", def = "", fungen = "",
                                  pkg = "", pag = "")
# se lee todo el archivo html
num_mod <- length(instala_base)
modulo <- instala_base[1]
ruta <- "C:/Program Files/R/R-4.2.0/library/"
ruta <- paste0(ruta, modulo,"/html/00Index.html")
ayuda.html <- readLines(ruta)
#ayuda.html <- readLines("C:/Program Files/R/R-4.2.0/library/base/html/00Index.html")
# print(ayuda.html[51:70])
# se extraen sólo los elementos de las tablas;
# el elemento non es el URL y el nombre de la función (el URL es el genérico de la); 
# el elemento par es la definición
positivo <- grep("<td", ayuda.html) # identifica lineas de las tablas
lineas.td <- ayuda.html[positivo]
# lineas.td[1:10]
# extrae funcion genérica del URL
href <- str_extract(lineas.td[1], url)
fungenerica <- gsub('href=\"', "", href)
fungenerica <- gsub('.html', "", fungenerica, fixed = TRUE)

# extrae el nombre de la función

orale <- str_extract(lineas.td[1], funpat)
funderivada <- gsub('l\">', "", orale)
funderivada <- gsub("</a", "", funderivada)

# se extrae la definición del elemento par
orale <- str_extract(lineas.td[2], defpat)
defini <- gsub(">", "", orale)
defini <- gsub("</td", "", defini)
contador <- dim(tabla_indice_html)[1] + 1
tabla_indice_html[contador,] <- c(funderivada, defini, fungenerica,
                                    modulo, "")
#adlivitum
#
# Delete unwanted characters in the lines we pulled out
# authors <- gsub("<I<", "", author_lines, fixed = TRUE)
