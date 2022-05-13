# prototipos para procesar el pdf del manual de R
library(pdftools)
library(stringr)
library(dplyr)
#
# carga el pdf y lo convierte a texto; vector con cada página del pdf
pdf1 <- "E:/ftp2022/05Mayo/R stuff/R index/02 compiler The R Reference Index V4.2.0 220510 fullrefman-2.pdf"
pdf2 <- "E:/ftp2022/05Mayo/R stuff/R index/03 datasets The R Reference Index V4.2.0 220510 fullrefman-3.pdf"
elpdf2text <- pdf_text(pdf1)
lafun <- "/n{5}//s{2}.*/n{4}"
uso <- "\n{2}Usage\n.*\n{2}" 
pags <- length(elpdf2text)
ultimalinea <- "(\n.*\n)$"
primeralinea <- "^(.*\n)"
numpag <- "\\d+"
tabla <- data.frame(pag = "", pkg = "", func = "", def = "", funclean = "")

for (i in 1:pags) {
  #print(i)
  print(str_count(elpdf2text[i], lafun))
  print(str_locate(elpdf2text[i], lafun))
  # algoritmo:
  # para cada una de las páginas,
  # sondear cuántas instancias de lafun hay
  # # si count es diferente/mayor que cero (0)
  # # para cada instancia de lafun
  # # sacar y procesar el nombre de la función y su definición
  # # con str_locate y str_sub para lineafunclean
  # sondear cuántas instancias de losusos hay;
  # # si count es diferente/mayor que cero (0)
  # # para cada instancia de losusos
  # # sacar y procesar las versiones de la función
  # # con str_locate y str_sub para losusos
  # 
  # funcdef
  # número de página
  if (i > 1){
    # numero de página en primera línea de la dos en adelante
    linea <- str_extract(elpdf2text[2], primeralinea)
    
  } else{
    # número de página en última línea en la primera pag del capítulo
    linea <- str_extract(elpdf2text[1], ultimalinea)
  }
  numeropag <- str_extract(linea, numpag)
  # procesa la página, primero la definición de la función, si hay
  numdef <- str_count(elpdf2text[i], lafun)
  if (numdef > 0) {
    donde <- str_locate(elpdf2text[i], lafun) # matriz con start, stop
    for (j in 1:numdef) {
      origen <- donde[j,1]
      final <- donde[j,2]
      lineafun <- str_sub(elpdf2text[i], origen, final)
      lineafunclean <- str_trim(str_remove_all(lineafun, "\n"), side = "both")
      dos_comomat <- str_split_fixed(lineafunclean, "\\s",2)
      dos_comomat[1,2] <- str_trim(dos_comomat[1,2], side = "left")
      #aquí ya tenemos el # de pág, la función y su definición
      # no olvidar el nombre del módulo o paquete
      # pag, pkg, func, def, funclean
      # agregar a la tabla de resultados
      # tabla[contador,] <- c(pag, pkg, func, def, funclean)
      funclean <- dos_comomat[1,1]
      funclean <- str_extract(funclean, ".*\\(")
      funclean <- str_remove(funclean, "\\(")
      contador <- dim(tabla)[1] + 1
      tabla[contador,] <- c(numeropag, pkg,
                            dos_comomat[1,1], dos_comomat[1,2],
                            funclean)
    } # termina bloque de iteración de las lineas de definición de función
  } # termina bloque condicional cuando hay definición de función
  # procesa la página para Usage
  # para sacar los usos de la función (familia de); como tiene \n embebidos
  # se tiene que usar la modalidad de regex
  losusos <- str_extract(elpdf2text[3], regex(uso, dotall = TRUE))
  #
  ## si no hay los usos (NA) pasa a la siguiente página
  
  numdef <- str_count(elpdf2text[i], regex(uso, dotall = TRUE))
  if (numdef > 0) {
    
  } # bloque para identificar la existencia de Usage
} # bloque iterativo para la siguiente página
  
  

donde <- str_locate(elpdf2text[3], lafun)
origen <- donde[1,1]
final <- donde[1,2]
cualfun <- str_sub(elpdf2text[3], origen, final)
#terminar con lineafunclean

print(elpdf2text[8])



linea1 <- str_locate(elpdf2text[1], "\n")
lin1str <- str_sub(elpdf2text[1], end = linea1)

elpdf2text <- pdf_text(pdf2)
print(elpdf2text[2])

ultimalinea <- "(\n.*\n)$"
linea <- str_extract(elpdf2text[1], ultimalinea)
primeralinea <- "^(.*\n)"
linea <- str_extract(elpdf2text[2], primeralinea)
numpag <- "\\d+"
str_extract(linea,numpag)


tabla <- data.frame(
  pag = c(1,2,3),
  lin = c(3,2,1),
  tres = c(2,4,6)
)

contador <- dim(tabla)[1]
tabla[contador+1,] <- c(4,5,6)
contador <- dim(tabla)[1]
tabla[contador+1,] <- c(5,6,7)
ejemplo <- "funcion(con,argumen,tos)"
sacado <- str_extract(ejemplo, ".*\\(")
limpio <- str_remove(sacado, "\\(")

print(str_count(elpdf2text[3], regex(uso, dotall = TRUE)))
print(str_count(elpdf2text[3], lafun))
