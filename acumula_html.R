# junta todos los indices html en uno solo
# 
indice_html_acumulado <- data.frame(func = "", def = "", fungen = "",
                                    pkg = "", pag = "")
load("pkg_baseyreco-index.RData")
instala_base <- c(ord_base, ord_reco)
num_mod <- length(instala_base)
for (i in 1:num_mod){
  modulo <- instala_base[i]
  tabla_modulo <- paste0("indice_html_", modulo, ".RData")
  load(tabla_modulo)
  indice_html_acumulado <- rbind(indice_html_acumulado, tabla_indice_html)
}
indice_html_acumulado <- indice_html_acumulado[-1,]

save(indice_html_acumulado, file = "indice_html_acumulado.RData")

