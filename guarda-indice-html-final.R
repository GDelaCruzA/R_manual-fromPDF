# final con las correcciones en el índice de las funciones base
#
indice_html_corregido_final <- read.csv("indice-html-corregido-final.csv",
                                        header = TRUE,
                                        colClasses = "character")
indice_html_final <- indice_html_corregido_final[, 1:5]

save(indice_html_final, file = "indice-html-final.RData")

