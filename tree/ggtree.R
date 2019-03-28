library(treeio)
library(ggtree)
library(ape)
library(ggplot2)
require(RColorBrewer)

setwd("F:/yangyang/projects/dangxiaojing/Tree/")
mytree <- read.tree("365_nj_tree.out")

mycolorClass<-read.table("colorClass.txt",row.names = 1)
head(mycolorClass)

#set group message
groupInfo <- split(row.names(mycolorClass), mycolorClass$V2)
mytree <- groupOTU(mytree, groupInfo)

#set col
mycol=c("black","#FF0000","#008200","#0000FF","#A5A5A5",
        "#FF0000","#00FFFF",
        "#C3B69D","#008200",
        "#FF00FF","#0000FF","#FFFF00","#00FF00"
)
names(mycol)=c("0","IND", "W","JAP","UNKNOWN",
               "IND-I","IND-II",
               "NIW", "RUW",
               "TEJ-I",   "TEJ-II",   "TEJ-III","TRJ")

mycol
#show tree with colour
tr=ggtree(mytree, layout="rectangular", aes(color=group))+  theme(legend.position = "right") + theme_tree() +
  geom_tiplab(align=TRUE, linetype="dotted", size=0, linesize=.1)+
  scale_color_manual(values = mycol)+
  geom_rootedge(0.01) 
tr


#add classify col
trc=gheatmap(tr,mycolorClass[,"V2",drop=F],colnames =F, color=NULL,offset = .01,width = .1)

#show all
gheatmap(trc,mycolorClass[,"V3",drop=F],colnames =F, color=NULL,offset = .07,width = .1)+
  scale_fill_manual(values=mycol)

#show tree in fan shap
tr=ggtree(mytree, layout="fan", aes(color=group))+  theme(legend.position = "right") + theme_tree() +
  geom_tiplab(aes(lable=),align=TRUE, linetype="dotted", size=0.01, linesize=.1)+
  scale_color_manual(values = mycol)+
  geom_rootedge(0.01) 
tr



info=read.table("sample2name.txt",sep = "\t")
ggtree(mytree, layout="fan", aes(color=group)) %<+% info + 
  geom_tiplab2(aes(label=V2), align=T, linetype="dotted", size=4, offset=0.03)+
  scale_color_manual(values = mycol)
                                     
 # theme(legend.position=c(.1, .9)) +  xlim(NA, 40) +
  #geom_tippoint(aes(color=location)) + scale_color_manual(values=cols) +
  #geom_tiplab(aes(label=location), align=T, linetype=NA, size=2, hjust=0.5, offset=3)# +
#geom_tiplab(aes(label=name), align=T, linetype=NA, size=2, offset=6, hjust=0.5) #+
#geom_tiplab(aes(label=year), align=T, linetype=NA, size=2, offset=9, hjust=0.5)


a = a %<+% pheno
as.treedata(a)
b=gheatmap(a,mycolorClass[,"V2",drop=F],colnames =F, color=NULL,offset = .01,width = .1)

gheatmap(a,pheno,colnames =T, color=NULL,offset = -0.1,width = 5)+xlab("") + ylab("")


mycolorClass<-read.table("colorClass.txt")
rownames(mycolorClass)<-mycolorClass$V1

mycolFirst=c("#FF0000", "#008200","#0000FF","#D2D2D2" )
names(mycolFirst)=c("IND", "W","JAP","UNKNOWN")
mycolSecond=c("#FF0000","#00FFFF", "yellowgreen","#008200","#00FF00", "#FF00FF","DarkVoilet","#0000FF","#D2D2D2" )
names(mycolSecond)=c("IND-I","IND-II","NIW", "RUW","TRJ","TEJ-I",   "TEJ-II",   "TEJ-III","UNKNOWN")

mycol=c(brewer.pal(4,"Dark2"),brewer.pal(8,"Pastel1"))
names(mycol)=c("IND", "W","JAP","UNKNOWN","IND-I","IND-II","NIW", "RUW","TRJ","TEJ-I",   "TEJ-II",   "TEJ-III")

rgb(r=255,g=0,b=0,maxColorValue = 255)
#FF0000 red

rgb(r=0,g=255,b=255,maxColorValue = 255)
#00FFFF watergreen

rgb(r=0,g=130,b=0,maxColorValue = 255)
#008200 darkgreen

rgb(r=0,g=255,b=0,maxColorValue = 255)
#00FF00 green

rgb(r=0,g=0,b=255,maxColorValue = 255)
#0000FF blue

rgb(r=210,g=210,b=210,maxColorValue = 255)
#D2D2D2 lightgray

c1=gheatmap(mytree,mycolorClass[,"V3",drop=F],colnames =F, color=NULL,offset = .01,width = .1)#+
  scale_fill_manual(values=mycolFirst)
c1

#install.packages("ggpubr", repo="http://cran.us.r-project.org")
library(ggpubr)
ggarrange(c1, myheatmap, ncol = 2, nrow = 1) 
c2<-gheatmap(c1,mycolorClass[,"V2",drop=F],colnames =F, color=NULL,offset = .1,width = .1)#+
  scale_fill_manual(values=mycolSecond)

pheno=read.table("phenotype.txt",row.names = 1, header = 1)
rownames(pheno)=pheno$V1
c3<-gheatmap(c2,pheno[,"V4",drop=F],colnames =F, color=NULL,offset = .1,width = .1)

gheatmap(mytree,mycolorClass[,"V3",drop=F],colnames =F, color=NULL,offset = .01,width = .1)
gheatmap(mytree,pheno,colnames =F, color=NULL,offset = 1,width = 1, 
         low = "green", high = "red")
gheatmap(p, heatmapData, low="white", high="black", color=NULL, width=3, colnames_position="top", 
         font.size=.5, colnames_angle=90, colnames_offset_y = 1, hjust=0)
cc<-c2+scale_fill_manual(values=mycol)
  print(cc)


  
  
  nwk <- system.file("extdata", "sample.nwk", package = "ggtree")
  library(ape)
  tree <- read.tree(nwk)
  library(ggplot2)
  require(RColorBrewer)
  ggplot(tree, aes(x, y)) + geom_tree() + theme_tree() #+ xlab("") + ylab("")
  
col<-c(brewer.pal(5,"Dark2"),brewer.pal(4,"Pastel1"))
names(col)=c(letters[1:6],letters[24:26])


names=mytree$tip.label

circ<-ggtree(tree,layout="circular")
circ<-ggtree(tree,layout="rectangular")+geom_tiplab(size=3)
circ + geom_tiplab(size=3)

df<-data.frame(first=c("a","b","a","c","d","d","a","b","e","e","f","c","f"),
                 second=c("z","z","z","z","y","y","y","y","x","x","x","a","a"))
rownames(df)<-tree$tip.label
p1<-gheatmap(circ,df[,"first",drop=F],offset=.8,width=.1)
             #  colnames_angle=90,colnames_offset_y=.25)
p2<-gheatmap(p1,df[,"second",drop=F],offset=5,width=.1)
     #        colnames_angle=90,colnames_offset_y=.25)

require(RColorBrewer)
col<-c(brewer.pal(5,"Dark2"),brewer.pal(4,"Pastel1"))
names(col)=c(letters[1:6],letters[24:26])
pp<-p2+scale_fill_manual(values=col)
print(pp)

p1=gheatmap(circ,df[,"first",drop=F],color = NULL,offset = .8, width = .01)+scale_fill_manual(values=col)
p1
p2=gheatmap(p1,df[,"second",drop=F],color = NULL,offset=1.5,width=.01)+scale_fill_manual(values=col)
p2
