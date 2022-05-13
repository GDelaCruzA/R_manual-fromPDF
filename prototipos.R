# prototipos para procesar el pdf del manual de R
# 
elpdf2text <- pdf_text("R_Reference-53-60.pdf")
lafun <- "\n{5}\\s{2}.*\n{4}"
pags <- length(elpdf2text)
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
}
donde <- str_locate(elpdf2text[3], lafun)
origen <- donde[1,"start"]
final <- donde[1,2]
cualfun <- str_sub(elpdf2text[3], origen, final)
#terminar con lineafunclean

