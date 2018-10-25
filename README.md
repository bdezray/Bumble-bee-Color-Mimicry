# Bumble-bee-Color-Mimicry
General Information:

This repository contains datafiles and scripts used in “Müllerian mimicry in bumble bees is a transient continuum.” Specifically, we will provide scripts to plot raster maps of perceptual color averages with and without species that are in decline and color form average to assess color pattern mimicry apart from relative frequencies, to extract point values from raster plot, to calculate distance between template and grid cell values, to create dendrograms and conduct Mantel test, and to convert files to ASCII format.


File List:

a.	Females2_1_emb9-17-18.csv
This file contains GBIF locality information for all social bumble bees found in the contiguous United States (excluding Bombus rufocinctus) with their associated TemplateX and TemplateY values extracted from the t-SNE analysis.

b.	Females2_1_embnocon.csv
This file provides similar data as “Females2_1_emb9-17-18.csv”, however it excludes species that have been in decline over the past 10-15 years: B. affinis, B. pensylvanicus/sonorus, B. terricola/occidentalis.

c.	ColorDistanceMatrix.csv
Perceptual distances between all species pairs in the contiguous United States calculated by the convolutional neural network. 

d.	NAphylodistance.csv
Phylogenetic distances between all species pairs in the contiguous United States based on the bumble bee phylogenetic tree (Hines 2008).

e.	ColorMimicryMelanopygus.csv
Dataset containing newly collected and museum specimen locality and color pattern data for B. melanopygus samples used in transition zone analyses.

f.	ColorMimicryBifarius.csv
Dataset containing newly collected and museum specimen locality and color pattern data for B. bifarius samples used in transition zone analyses.

g.	ColorMimicryFlavifrons.csv
Dataset containing newly collected and museum specimen locality and color pattern data for B. flavifrons samples used in transition zone analyses.

h.	FlavifronsWithinHybridElevation.csv
Locality and extracted elevation data for B. flavifrons samples found within the hybrid zone.

j.	MelanopygusHybridZoneElevation.csv
Locality and extracted elevation data for B. melanopygus samples found within the hybrid zone.

k.	BifariusWithinElevation.csv
Locality and extracted elevation data for B. bifarius samples found within the hybrid zone.

l.	FlavifronsElevation.csv
Locality and extracted elevation data for B. flavifrons samples throughout full range.

m.	MelanopygusElevation.csv
Locality and extracted elevation data for B. melanopygus samples throughout full range.

n.	BifariusElevation.csv
Locality and extracted elevation data for B. bifarius samples throughout full range.

o.	MelanopygusDistance9-27-18.csv
Bombus melanopygus locality and calculated distance between templateX and templateY values from t-SNE analysis for color patterns and the extracted perceptual optimal X and Y values from grid cell where point is located.

p.	FlavifronsDistance9-28-18.csv
Bombus flavifrons locality and calculated distance between templateX and templateY values from t-SNE analysis for color patterns and the extracted perceptual optimal X and Y values from grid cell where point is located.

q.	BifariusDistance9-27-18.csv
Bombus bifarius locality and calculated distance between templateX and templateY values from t-SNE analysis for color patterns and the extracted perceptual optimal X and Y values from grid cell where point is located.

r.	ColorMimicryMelanopygusBlack.csv
Bombus melanopygus black morph used for Maxent climatic niche analyses.

s.	ColorMimicryMelanopygusRed.csv
Bombus melanopygus red morph used for Maxent climatic niche analyses.

t.	ColorMimicryBifariusBlack.csv
Bombus bifarius black morph used for Maxent climatic niche analyses.

u.	ColorMimicryBifariusRed.csv
Bombus bifarius red morph used for Maxent climatic niche analyses.

v.	ColorMimicryFlavifronsBlack.csv
Bombus flavifrons black morph used for Maxent climatic niche analyses.

w.	ColorMimicryFlavifronsRed.csv
Bombus flavifrons red morph used for Maxent climatic niche analyses.



Script List:

a.	ExtractCellValuesbyPoint.R
This script contains code for making the raster and extracting raster grid cell values by locality point data. 
b.	PlotPolymorphicSpeciesDistributions.R
This script contains code for plotting a map of the United States with state boundaries and point data depicting color morph information. 
c.	BioclimtoASC.R
This script contains code for clipping and converting .tiff files to .asc files. 
d.	Plot_Raster.R
This script contains code to create the following raster maps: Perceptual Color Average, Perceptual Color Average w/o Declining Species, and Average Color Forms. 
e.	MantelTest and Tanglegram.R
This script contains code to organize two distance matrices to use for the Mantel Test and to create a tanglegram, plot distance matrices as dendrograms, run the Mantel Test, and create a tanglegram between two dendrograms. 


