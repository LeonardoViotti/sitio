#------------------------------------------------------------------------------#

#			Vegetacao e biomas em Minas gerais

#------------------------------------------------------------------------------#

library(sp)
library(rgeos)


GIS <- "C:/Users/wb519128/Dropbox/Sitio/GIS/Minas Gerais"


veg <- readOGR(file.path(GIS,"Raw"), "MG_vegetacao_zee", pointDropZ = T)



mun <- readOGR(file.path(GIS,"Raw"), "31MUE250GC_SIR", pointDropZ = T)
mun <- spTransform(mun, veg@proj4string)


#### Select only interest area



muni <- mun[mun@data$NM_MUNICIP %in%  c("ITUTINGA", "CARRANCAS", "NAZARENO"), ]
vegi <- veg[!is.na(sp::over(veg, muni)[,1]),]


#### Export

writeOGR(muni,
         dsn=file.path(GIS, "municipios.shp"),
         layer="municipios",
         overwrite_layer=T,
         driver="ESRI Shapefile")

writeOGR(vegi,
         dsn=file.path(GIS, "vegetacao.shp"),
         layer="vegetacao",
         overwrite_layer=T,
         driver="ESRI Shapefile")

