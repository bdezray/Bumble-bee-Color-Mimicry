###########################################################################
Generate dendrograms from distance matrices and conduct Mantel Test and Tanglegram
###########################################################################

library(data.table)
library(ade4)
library(ape)
library(dendextend)

col_mtx<-fread("ColorDistanceMatrix.csv")
phy_mtx<-fread("NAphylodistance.csv")

# make the dimensions of the NAphylodistance matrix match those of the ColorDistanceMatrix
 
#NAphylodistance instructions
#Add an additional
#auricomus column labeled auricomus1
phy_mtx$auricomus1<-phy_mtx$auricomus
#balteatus columns labeled balteatus1 and balteatus2
phy_mtx$balteatus1<-phy_mtx$balteatus
phy_mtx$balteatus2<-phy_mtx$balteatus
#bifarius columns labeled bifarius2, bifarius3, bifarius4
phy_mtx$bifarius2<-phy_mtx$bifarius
phy_mtx$bifarius3<-phy_mtx$bifarius
phy_mtx$bifarius4<-phy_mtx$bifarius
#borealis column labeled borealis2
phy_mtx$borealis2<-phy_mtx$borealis
#californicus columns labeled californicus2, californicus3,
phy_mtx$californicus2<-phy_mtx$californicus
phy_mtx$californicus3<-phy_mtx$californicus
#caliginosus column labeled caliginosus2
phy_mtx$caliginosus2<-phy_mtx$caliginosus
#crotchii columns labeled crotchii1 and crotchii2
phy_mtx$crotchii1<-phy_mtx$crotchii
phy_mtx$caliginosus2<-phy_mtx$crotchii
#flavifrons columns labeled flavifrons2, flavifrons3, flavifrons4,flavifrons5, flavifrons6
phy_mtx$flavifrons2<-phy_mtx$flavifrons
phy_mtx$flavifrons3<-phy_mtx$flavifrons
phy_mtx$flavifrons4<-phy_mtx$flavifrons
phy_mtx$flavifrons5<-phy_mtx$flavifrons
phy_mtx$flavifrons6<-phy_mtx$flavifrons
#melanopygus columns labeled melanopygus2 and melanopygus3
phy_mtx$melanopygus2<-phy_mtx$melanopygus
phy_mtx$melanopygus3<-phy_mtx$melanopygus
#occidentalis columns labeled occidentalis2 and occidentalis3
phy_mtx$occidentalis2<-phy_mtx$occidentalis
phy_mtx$occidentalis3<-phy_mtx$occidentalis
#pennsylvanicus column labeled pennsylvanicus3
phy_mtx$pennsylvanicus3<-phy_mtx$pennsylvanicus
#rufocinctus columns labeled rufocinctus2, rufocinctus3, and rufocinctus4
phy_mtx$rufocinctus2<-phy_mtx$rufocinctus
phy_mtx$rufocinctus3<-phy_mtx$rufocinctus
phy_mtx$rufocinctus4<-phy_mtx$rufocinctus
#sylvicola columns labeled sylvicola2 and sylvicola3
phy_mtx$sylvicola2<-phy_mtx$sylvicola
phy_mtx$sylvicola3<-phy_mtx$sylvicola
#terricola column labeled terricola2
phy_mtx$terricola2<-phy_mtx$terricola

#melt both distance matrix
m_phy_mtx<-melt(phy_mtx,id="V1")
m_col_mtx<-melt(col_mtx,id="V1")

setnames(m_col_mtx,c("V1","variable"),c("Species1","Species2"))
setnames(m_phy_mtx,c("V1","variable"),c("Species1","Species2"))

#remove .png from names in ColorDistanceMatrix
m_col_mtx$Species1<-sub(".png","",m_col_mtx$Species1)
m_col_mtx$Species2<-sub(".png","",m_col_mtx$Species2)

#make sure you have every pairwise pair
#in the phy_mtx
m_phy_mtx2<-copy(m_phy_mtx)
setnames(m_phy_mtx2,c("Species1","Species2"),c("Species2","Species1"))
setcolorder(m_phy_mtx2,c("Species1","Species2","value"))
m_phy_mtx<-rbind(m_phy_mtx,m_phy_mtx2)
m_phy_mtx<-m_phy_mtx[!duplicated(m_phy_mtx),]
m_phy_mtx<-m_phy_mtx[order(Species1,Species2)]
#in the col_mtx
m_col_mtx2<-copy(m_col_mtx)
setnames(m_col_mtx2,c("Species1","Species2"),c("Species2","Species1"))
setcolorder(m_col_mtx2,c("Species1","Species2","value"))
m_col_mtx<-rbind(m_col_mtx,m_col_mtx2)
m_col_mtx<-m_col_mtx[!duplicated(m_col_mtx),]
m_col_mtx<-m_col_mtx[order(Species1,Species2)]

all_pairs<-expand.grid(levels(m_phy_mtx$Species1),levels(m_phy_mtx$Species1))
all_pairs<-data.table(all_pairs)

all_pairs$Species1<-gsub('[0-9]+', "", all_pairs$Var1)
all_pairs$Species2<-gsub('[0-9]+', "", all_pairs$Var2)

all_pairs<-merge(all_pairs,m_phy_mtx,all.x=T)

all_pairs<-all_pairs[,c("Var1","Var2","value")]

setnames(all_pairs,c("Var1","Var2"),c("Species1","Species2"))

all_pairs<-all_pairs[order(Species1,Species2)]
phy_dist<-dcast(all_pairs,Species1~Species2)
col_dist<-dcast(m_col_mtx,Species1~Species2)

phy_dist[is.na(phy_dist)]<-0
col_dist[is.na(col_dist)]<-0

as.dist(phy_dist[,-1])->pdist
as.dist(col_dist[,-1])->cdist


#run Mantel Test between two distance matrices
mantel.rtest(cdist,pdist,nrepet=9999)

#Create dendrograms of matrices
> hclust(cdist, method="average")->cc
> #Create dendrograms of matrices
> hclust(pdist, method="average")->pc
> dend1<-as.dendrogram(cc)
> dend2<-as.dendrogram(pc)
> dendlist<-dendlist(dend1,dend2)

#Make tanglegram between two dendrograms
tanglegram(dendlist, highlight_distinct_edges=FALSE, common_subtrees_color_lines=FALSE, common_subtrees_color_branches=TRUE)