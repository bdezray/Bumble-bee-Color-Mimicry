#load libraries
library(raster)
library(BBmisc)
library(data.table)
library(maps)


#set working directory
setwd("/Users/brianaezray/Desktop/CH1/Data Files")


#Raster of Perceptual Average Color
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
n_rast<-rasterize(pts1, rast, pts1$TemplateY, fun='count')
#get the values out of the rasterized objects
x_vals<-x_rast@data@values
y_vals<-y_rast@data@values
n_vals<-n_rast@data@values
n_vals[is.na(n_vals)]<-0

#start making a custom raster
valT <- c(1:(rast_size^2))
#get a list of colors
colT<-apply(matrix(valT),1,function(x){color_xy(x_vals[x],y_vals[x])})
#make all the values below the min white
colT[n_vals<min_count]<-"#FFFFFF"
#make new raster of correct size
r <- raster(ncol=rast_size,nrow=rast_size)
r[]<-0
r@data@values[1:(rast_size^2)]<-valT
#open connection to output .jpg file
jpeg('raster_plot.jpg')
#plot while supplying the custom colors as an vector
plot(r,breaks=valT,col=colT,legend=FALSE)
#close connection
dev.off()







#Raster of Perceptual Average Color w/o species in decline
#set values
min_count<-10
rast_size<-30

#read in raw data
pts1<-fread("Females2_1_embnocon.csv")

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
n_rast<-rasterize(pts1, rast, pts1$TemplateY, fun='count')
#get the values out of the rasterized objects
x_vals<-x_rast@data@values
y_vals<-y_rast@data@values
n_vals<-n_rast@data@values
n_vals[is.na(n_vals)]<-0

#start making a custom raster
valT <- c(1:(rast_size^2))
#get a list of colors
colT<-apply(matrix(valT),1,function(x){color_xy(x_vals[x],y_vals[x])})
#make all the values below the min white
colT[n_vals<min_count]<-"#FFFFFF"
#make new raster of correct size
r <- raster(ncol=rast_size,nrow=rast_size)
r[]<-0
r@data@values[1:(rast_size^2)]<-valT
#open connection to output .jpg file
jpeg('raster_plot.jpg')
#plot while supplying the custom colors as an vector
plot(r,breaks=valT,col=colT,legend=FALSE)
#close connection
dev.off()





#Average by unique species color patterns
#Set values
min_count<-2
rast_size<-30
#read in raw data
pts1<-fread("Females2_1_emb9-17-18.csv")
data<-pts1
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
#Get the cell value for each point
cellFromXY(rast,cbind(c(data$X),c(data$Y)))->samp_cell
length(samp_cell)
dim(data)
#Add cell value to dataset
data$cell_num<-samp_cell
head(data)
#group by unique cell value and by unique species
data[!duplicated(data[,c('TemplateX','TemplateY','cell_num')]),]->l
dim(l)
#get raster elements
coordinates(l)<-~X+Y
x_rast<-rasterize(l, rast, l$TemplateX, fun=mean)
y_rast<-rasterize(l, rast, l$TemplateY, fun=mean)
n_rast<-rasterize(l, rast, l$TemplateY, fun='count')
#get the values out of the rasterized objects
x_vals<-x_rast@data@values
y_vals<-y_rast@data@values
n_vals<-n_rast@data@values
n_vals[is.na(n_vals)]<-0
#start making a custom raster
valT <- c(1:(rast_size^2))
#get a list of colors
colT<-apply(matrix(valT),1,function(x){color_xy(x_vals[x],y_vals[x])})
#make all the values below the min white
colT[n_vals<min_count]<-"#FFFFFF"
#make new raster of correct size
r <- raster(ncol=rast_size,nrow=rast_size)
r[]<-0
r@data@values[1:(rast_size^2)]<-valT
#plot while supplying the custom colors as an vector
plot(r,breaks=valT,col=colT,legend=FALSE)
#open connection to output .jpg file
jpeg('raster_plot.jpg')
#close connection
dev.off()


#Plot raster with US outline Map
map.US <- borders("usa", colour='black',fill='NA', lwd=0.4)
r.spdf<-as(x_rast,"SpatialPixelsDataFrame")
r.df<-as.data.frame(r.spdf)
head(r.df)
g<-ggplot(r.df,aes(x=x, y=y))+geom_tile(aes(fill=layer))+coord_equal()
g+map.US->p
plot(p)
