# consolida las dos tablas de índices en una sola
# 
library(dplyr)
load("indice_html_acumulado.RData")
load("tabla-indice-manual.RData")

tabla_indice_manual <- tabla_indice_manual[-1, ]

paginas <- tabla_indice_manual[, c(3,5)]
indice_html_corregido <- indice_html_acumulado
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
  pos_donde <- grep(busca, indice_html_corregido[, 3], fixed = TRUE)
  # se sustituye
  indice_html_corregido[pos_donde, 3] <- tabla_indice_manual[pos_match, 3]
}
#verificación de la corrección
pos_con_punto2 <- grep("^\\.", indice_html_corregido[ , 3])
print(indice_html_corregido[pos_con_punto2, c(1,3,5)])
#



# tabla_indice_manual[pos_match,c(1,3, 5)]
# indice_html_acumulado[pos_donde,]

# se incorpora la página de referencia en cada una de las funciones derivadas
# este bloque con regexp no fununcia; se requiere el match a palabra completa
# total <- dim(paginas)[1]
# for (i in 1:total) {
#   # i <- 3 # hasta el total
#   busca <- paste0("\\<", paginas[i, 1], "\\>")
#   pos_donde <- grep(busca, indice_html_corregido[, 3])
#   #subtotal <- length(pos_donde)
#   # for (j in 1:subtotal) {
#     # j <- 1146L # hasta el número de pos_donde
#   indice_html_corregido[pos_donde, 5] <- paginas[i, 2]
#   # }
# }
# los métodos regexp no fununcian... se tienen que usar métodos literales
# indice_html_corregido[j,c(1, 3, 5)]

total <- dim(paginas)[1]
total2 <- dim(indice_html_corregido)[1]
for (i in 1:total) {
  busca <- paginas[i, 1]
  match <- busca == indice_html_corregido[, 3]
  indice_html_corregido[match, 5] <- paginas[i, 2]
  # for (j in 1:total2){
  #   if (busca == indice_html_corregido[j, 3]){
  #     indice_html_corregido[j,5] <- paginas[i,2]
  #   }
  #} # no vectorizado se  tarda lo que quiere
}
save(indice_html_corregido, file = "indice-html-corregido.RData")
write.csv(indice_html_corregido, file = "indice-html-corregido.csv")
# el exportado se corrigio a mano por las inconsistencias en el índice del manual
# así como en el contenido de los html
# 