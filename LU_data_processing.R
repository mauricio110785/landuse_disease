## import the files into the shared space

# read the files 
library(raster)
library(dbplyr)
library(plyr)
LU<-raster('/nfs/infectiousdiseases-data/RasterAllYears/ACRE_2014/AC_2014_RASTER.tif')

## read csv files
covar<-read.table('/nfs/infectiousdiseases-data/_fillBuffer500m/Loc_Tipo_SIGLA.csv',header = T,sep=",")
#covar<-read.table('~/landuse_disease/Raster/UTM_pontosColeta.csv',header = T,sep=",")
## overlap raster with database
#create a spatil point object
#covar=covar[-which(is.na(covar$Leste)),]
#coordinates(covar)<- ~ Leste + Norte 
coordinates(covar)<- ~ longitude  + latitude 
plot(LU)
points(covar,add=T,col='red')
#add a projection
#crs(covar)<-CRS("+proj=longlat +datum=WGS84")

#change the projection
#covar_trs=spTransform(covar,CRSobj = crs(LU))

#extract land-use types from raster image
new_ext=raster::extract(LU,covar)

# add new column with LU to the table
covar=dplyr::mutate(covar@data,LU=new_ext)

# merge the two data sets 
# read the dataset of the sruvey 

survey=read.csv('/nfs/infectiousdiseases-data/SurveyData/variables_survey.csv',sep=",",header=T)

survey_LU<-join(covar,survey,by= 'cod_domicilio') 

#write.table(survey_LU,'/nfs/infectiousdiseases-data/SurveyData/survey_LU.csv',sep=',')

###

### plot survey data vs covariates 

library(tidyr)
library(dplyr)

survey_chi=read.csv('/nfs/infectiousdiseases-data/SurveyData/variables_LU.csv',sep=",",header=T)
#i<-10
#b<-names(survey_chi)[-(1:9)][i]
a<-count(survey_chi,c('LU.acron','agricultura'))
ggplot(data=a, aes(x=(LU.acron), y=(freq),color=agricultura,fill=agricultura)) +
  geom_bar(stat="identity")+theme_minimal()+
  scale_fill_brewer(palette="Dark2")

  

survey_LU %>%  count('Localidade_Moradia','Localidade_Moradia') %>% count('analf.adultos1','banho')
