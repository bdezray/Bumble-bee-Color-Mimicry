#load libraries
library(ggplot2)
library(maps)
library(ggthemes)
library(data.table)

#set working directory
setwd("/Users/brianaezray/Desktop/CH1/Data Files")

#Map United States with state boundaries
usa<-map_data("usa")
states<-map_data("state")
ggplot(data=states)+geom_polygon(aes(x=long, y=lat,group=group),color="black", fill="white")->usmap

#read in raw data
ptsbifarius<-fread("ColorMimicryBifarius.csv")
ptsmelanopygus<-fread("ColorMimicryMelanopygus.csv")
ptsflavifrons<-fread("ColorMimicryFlavifrons.csv")

#Plot bifarius point distribution of color forms
bifarius<-usmap + geom_point(data=ptsbifarius,mapping=aes(x=Lon, y=Lat, color=ptsbifarius$T2T3Red),size=4)+scale_color_distiller(palette = "RdGy",direction = -1)+ coord_fixed(xlim=c(-125,-100), ylim=c(50,30))+theme_classic()+theme(legend.position=c(0.9,0.3))

#Plot melanopygus point distribution of color forms
melanopygus<-usmap + geom_point(data=ptsmelanopygus,mapping=aes(x=Lon, y=Lat, color=ptsmelanopygus$T2T3Red),size=4)+scale_color_distiller(palette = "RdGy",direction = -1)+ coord_fixed(xlim=c(-125,-100), ylim=c(50,30))+theme_classic()+theme(legend.position=c(0.9,0.3))

#Plot flavifrons point distribution of color forms
flavifrons<-usmap + geom_point(data=ptsflavifrons,mapping=aes(x=Lon, y=Lat, color=ptsflavifrons$T2T3Red),size=4)+scale_color_distiller(palette = "RdGy",direction = -1)+ coord_fixed(xlim=c(-125,-100), ylim=c(50,30))+theme_classic()+theme(legend.position=c(0.9,0.3))

