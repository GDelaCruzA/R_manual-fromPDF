alias <- readRDS("C:/Program Files/R/R-4.2.0/library/datasets/help/aliases.rds")
patt <- readRDS("C:/Program Files/R/R-4.2.0/library/datasets/help/paths.rds")
# aliases es un vector con nombres que tiene la lista de las entradas del
# diccionario de los elementos del módulo en formato de objeto de R
# (.rds). Le acompaña el archivo AnIndex en formato de texto con dos
# columnas: el de la lista del diccionario, acompañado por el de la
# entrada en el manual: esto es, el genérico para las funciones bajo
# ese nombre genérico del índice del manual

# AnIndex se corresponde con el índice (primeras 51 páginas del manual)
# con el nombre genérico de la entrada y la página de caso
# Lo que hay que empatar es el nombre del genérico de la función con 
# su definición, su página y repetirlas en las entradas de las
# funciones correspondientes
# 1. sacar la tabla de funciones y genérica de AnIndex de cada módulo
# 2. sacar la tabla del índice del manual con la genérica y la página
# 3. sacar de cada capítulo (módulo) del manual, el genérico con su
#    definición en una tabla
# 4. empatar la tabla del índice del manual con la tabla del genérico
#    con su definición con funciones de unión
# 5. empatar la tabla del AnIndex con la tabla del índice con unión

print(alias)
print(alias[10:12])
archivo <- "C:/Program Files/R/R-4.2.0/library/datasets/help/AnIndex"
# ensayo para la lectura del AnIndex
tablita <- read.table(archivo, sep = "\t", col.names = c("funcion",
                       "indxdef"))
# perfecto!!!
pkg_instalados <- installed.packages()
colnames(pkg_instalados)
dim(pkg_instalados)
pkg_instalados[,1]
row.names(pkg_instalados)

pkg_instalados <- as.data.frame(pkg_instalados)
pkg_instalados[pkg_instalados$Priority == "base", "Priority"]
pkg_instalados[pkg_instalados$Priority == "base", c("Package", "Priority")]

pkg_base <- as.vector(pkg_instalados[pkg_instalados$Priority == "base",1])
pkg_reco <- as.vector(pkg_instalados[pkg_instalados$Priority == "recommended",1])
ord_base <- c(1, 2, 3, 5, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14)
ord_reco <- c(6, 8, 9, 1, 2, 3, 4, 5, 7, 10, 11, 12, 13, 14, 15)
ord_base <- pkg_base[ord_base]
pkg_reco
ord_reco <- pkg_reco[ord_reco]

save(ord_base, ord_reco, file = "pkg_baseyreco-index.RData")
load("pkg_baseyreco-index.RData")
