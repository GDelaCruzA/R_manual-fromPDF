# consolida las dos tablas de índices en una sola
# 
library(dplyr)
load("indice_html_acumulado.RData")
load("tabla-indice-manual.RData")

tabla_indice_manual <- tabla_indice_manual[-1, ]

paginas <- tabla_indice_manual[, c(3,5)]

# se corrige la tabla html
# en las fungen hay entradas con punto inicial en el manual, 
# que no está en el html; reinsertar las que tienen punto inicial

pos_con_punto <- grep("^\\.", tabla_indice_manual[ , 3])
total <- length(pos_con_punto)
# posicion <- grep(".via.", indice_html_acumulado[ , 3], fixed = TRUE)
for (i in 1:total) {
  pos_match <- pos_con_punto[i]
  # se define el termino sin el punto
  busca <- sub(".", "", tabla_indice_manual[pos_match, 3], fixed = TRUE)
  pos_donde <- grep(busca, indice_html_acumulado[, 3], fixed = TRUE)
  # se sustituye
  indice_html_acumulado[pos_donde, 3] <- tabla_indice_manual[pos_match, 3]
}
save(indice_html_acumulado, file = "indice_html_acumulado.RData")

# tabla_indice_manual[pos_match,c(1,3, 5)]
# indice_html_acumulado[pos_donde,]

# se incorpora la página de referencia en cada una de las funciones derivadas
# 
total <- dim(paginas)[1]
for (i in 1:total) {
  i <- 3 # hasta el total
  busca <- paginas[i, 1]
  pos_donde <- grep(busca, indice_html_acumulado[, 3], fixed = TRUE)
  subtotal <- length(pos_donde)
  for (j in 1:subtotal) {
    j <- 1146L # hasta el número de pos_donde
    indice_html_acumulado[pos_donde[j], 5] <- paginas[i, 2]
  }
}

indice_html_acumulado[j,c(1, 3, 5)]
