# prototipos para procesar eñ pdf del manual de R
# 
lafun <- "\n{5}\\s{2}.*\n{4}"
pags <- length(elpdf2text)
for (i in 1:pags) {
  print(i)
  str_locate(elpdf2text[i], lafun)
}
str_locate(elpdf2text[3], lafun)
str_extract(elpdf2text[3], lafun)
elpdf2text[3]
