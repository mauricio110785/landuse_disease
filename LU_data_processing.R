## import the files into the shared space
file.symlink('/nfs/infectiousdiseases-data/_fillBuffer500m','Raster')

# read the files 
library(raster)
LU<-raster('~/landuse_disease/Raster/ComposicaoBuffer500m_TC14.tif')

## read csv files
covar<-read.table('~/landuse_disease/Raster/Loc_Tipo_SIGLA.csv',header = T,sep=",")
#covar<-read.table('~/landuse_disease/Raster/UTM_pontosColeta.csv',header = T,sep=",")
## overlap raster with database
#create a spatil point object
#covar=covar[-which(is.na(covar$Leste)),]
coordinates(covar)<- ~ Leste + Norte 

#add a projection
#crs(covar)<-CRS("+proj=longlat +datum=WGS84")

#change the projection
#covar_trs=spTransform(covar,CRSobj = crs(LU))

#extract land-use types from raster image
new_ext=extract(LU,covar)

# add new column with LU to the table
covar=mutate(covar@data,LU=new_ext)
