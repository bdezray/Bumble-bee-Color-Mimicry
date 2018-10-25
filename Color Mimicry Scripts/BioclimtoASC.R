#Import raster layer file
sbio1<-raster("/Users/brianaezray/Downloads/wc2-2/wc2.0_30s_srad_01.tif")
#Crop raster layer to specific extent
cbio1<-crop(sbio1,extent(-125,-100,30,50))
#Write out raster layer as ASCII file
writeRaster(cbio1,filename="solarbio1.asc")

