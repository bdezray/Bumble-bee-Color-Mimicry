#Extract cell values for points and normalize template X and Y values

#load libraries
library(raster)
library(BBmisc)
library(data.table)


#set values
min_count<-10
rast_size<-30

#read in raw data
pts1<-fread("Females2_1_emb9-17-18.csv")

#normalize data
pts1$TemplateX<-normalize(pts1$TemplateX, method="range", range= c(-1,1))
pts1$TemplateY<-normalize(pts1$TemplateY, method="range", range= c(-1,1))

#function that calculats a color
color_xy <- function(x, y){
    if (is.na(x)){
        color<-"#FFFFFF"
    }else{
    R <- (1+y)/2
 	G <- (1-x)/2
  	B <- (1-y)/2
    A <- 1- 0.5*exp(-(x^2+y^2)/0.2)
    color<-rgb(R, G, B, A)
    }
return(color)
}


#get raster elements
coordinates(pts1)<-~X+Y
rast<-raster(ncol=rast_size,nrow=rast_size)
extent(rast)<-extent(pts1)
x_rast<-rasterize(pts1, rast, pts1$TemplateX, fun=mean)
y_rast<-rasterize(pts1, rast, pts1$TemplateY, fun=mean)

#get the values out of the rasterized objects
x_vals<-x_rast@data@values
y_vals<-y_rast@data@values


#Read in Point data to extract values for
#fread("RasterBifarius.csv")
			
#Get the cell value for each point
cellFromXY(rast,cbind(c(data$Lon),c(data$Lat)))->samp_cell
length(samp_cell)
dim(data)
#Add cell value to dataset
data$cell_num<-samp_cell
head(data)

		
