# ensayo para leer el manual de R en PDF
# 
library(pdftools)
library(stringr)
library(dplyr)
# todo el documento queda en un solo vector
  elpdf2text <- pdf_text("The R Reference Index V4.2.0 indice.pdf")
# cada página es un elemento del vector
# el patrón es:
#   5 \n\n\n\n\n, dos espacios y el nombre de la función
#   seguido por espacios varios y la explicación resumida de la función
#   termina con 4 \n\n\n\n
lafun <- "\n{5}\\s{2}.*\n{4}"

# luego se buscan las líneas individuales de la(s) forma(s) de la función
# entre
#   \n\nUsage\n
# y
#   \n\nArguments\n
#   
uso <- "\n{2}Usage\n.*\n{2}Arguments\n"

print(elpdf2text[3])
str_split(elpdf2text[3],"\n")

# probar si hay mas de una instancia de función y Usage en la página
# con str_count y luego, si es necesario partir la página para poder
# extraer esas instancias de una u de otra con str_locate y str_sub
# si no hay, brinca a la siguiente página

# para sacar la función y su explicación; si hay mas de una instancia de la
# función dos_comomat[1,1], llevan la misma explicación dos_comomat[1,2]
# 
lafun <- "\n{5}\\s{2}.*\n{4}"
lineafun <- str_extract(elpdf2text[3], lafun)
#
# si no hay lineafun (NA), pasar a probar Usage
# 
lineafunclean <- str_trim(str_remove_all(lineafun, "\n"), side = "both")
dos_comomat <- str_split_fixed(lineafunclean, "\\s",2)
dos_comomat[1,2] <- str_trim(dos_comomat[1,2], side = "left")

# para sacar los usos de la función (familia de); como tiene \n embebidos
# se tiene que usar la modalidad de regex
uso <- "\n{2}Usage\n.*\n{2}Arguments\n" 
losusos <- str_extract(elpdf2text[3], regex(uso, dotall = TRUE))
#
## si no hay los usos (NA) pasa a la siguiente página

# limpiar Usage y Arguments, así como los \s y \n repetidos
losusos <- str_replace(losusos, "\n\nUsage\n","")
losusos <- str_replace(losusos, "\n\nArguments\n","")
#losusos <- str_replace_all(losusos, "\\s","")
losusos <- str_replace_all(losusos, "\n\n","\n")
# se separan las instancias de la función
lasfun <- str_split(losusos, "\n")
# y se limpia de \s (es un vector dentro de una lista)
lasfun[[1]] <- str_trim(lasfun[[1]], side = "both")
# meterlas en la tabla con pkg, nomfun y def

ejem <- "KKS Identification\n    Power Plants\n                   System for\n                                                    Function Key\n     Function Key, Main Groups\nA    Grid and distribution systems\nB    Power transmission and auxiliary power supply\nC    Instrumentation and control equipment\nE    Fuel supply and residues disposal\nG    Water supply and disposal\nH    Heat generation\nL    Steam, water, gas cycles\nM    Main machine sets\nN    Process energy/fluid supply for external users\n     (e.g. district heating)\nP    Cooling water systems\nQ    Auxiliary systems\nR    Gas generation and treatment\nS    Ancillary systems\nU    Structures\nW    Renewable energy plants\nX    Heavy machinery (not main machine sets)\n     (e.g. emergency diesel and generator sets)\n                              2\n"

my_page <- ejem
datos <- str_split(my_page,"\n")[[1]]
limpios <- str_subset(datos,"^[A-Z]\\s")
tablita <- as.data.frame(str_split_fixed(limpios, "\\s{2}", n = 2))
colnames(tablita) <-  c("Codigo","Descrip")

# Extrae de la tablita un elemento en consulta
# 
tablita %>% right_join(data_frame(Codigo = 'A'))

# varios elementos
tablita %>% right_join(data_frame(Codigo = c('E', 'F', 'G')))
                       