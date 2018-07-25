## import the files into the shared space
file.symlink('/nfs/infectiousdiseases-data/_fillBuffer500m','Raster')

# read the files 
library(raster)
LU<-raster('~/landuse_disease/Raster/ComposicaoBuffer500m_TC14.tif')

## read csv files
covar<-read.table('~/landuse_disease/Raster/Loc_Tipo_SIGLA.csv',header = T,sep=",")

## overlap raster with database

coordinates(LU)<- ~longitude + latitude 
