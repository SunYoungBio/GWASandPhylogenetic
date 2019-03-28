setwd("f:/yangyang/projects/dangxiaojing/PCA/")
a=read.table("365Samples_GATK_snps_miss0.75Maf0.05.eigenvec")
head(a)
x=a$V3
y=a$V4
z=a$V5
library(ggplot2)
p12=ggplot(a, aes(x=a$V3, y=a$V4, colour = a$V6)) + 
  geom_point(show.legend = T)
p12+xlab("PC1")+ylab("PC2")+ 
  theme(legend.title=element_blank(),
        panel.grid.major =element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"))+
  scale_color_manual(breaks = c("Indica-1", "Indica-2", "Admixed","Japonica-1","Japonica-3",
                                "Japonica-2","Japonica-4","Wild"),
                     values=c(	 "#009900", "#CCCC00", "#0064FF", "#CC00CC", "#00FFFF", 
                                "#FF0000", "#660066","black"))

p13=ggplot(a, aes(x=a$V3, y=a$V5, colour = a$V6)) + 
  geom_point(show.legend = T)
p13+xlab("PC1")+ylab("PC3")+ 
  theme(legend.title=element_blank(),
        panel.grid.major =element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"))+
  scale_color_manual(breaks = c("Indica-1", "Indica-2", "Admixed","Japonica-1","Japonica-3",
                                "Japonica-2","Japonica-4","Wild"),
                     values=c(	 "#009900", "#CCCC00", "#0064FF", "#CC00CC", "#00FFFF", 
                                "#FF0000", "#660066","black"))

p23=ggplot(a, aes(x=a$V4, y=a$V5, colour = a$V6)) + 
  geom_point(show.legend = T)
p23+xlab("PC2")+ylab("PC3")+ 
  theme(legend.title=element_blank(),
        panel.grid.major =element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"))

palette(c( "#009900", "#CCCC00", "#0064FF", "#CC00CC", "#00FFFF", "#FF0000", "#660066","black"))
class=a$V6
plot(a$V3,a$V4,pch=16,,col=a$V6,main="PCA",xlab="pc1",ylab="pc2")
legend(-0.06,0, legend=levels(class), pch=16, col=1:nlevels(class),box.lty=0)
text(x=x+0.003,y=y+0.001,labels=a$V1,cex=0.5)

plot(a$V4,a$V5,pch=16,main="PCA",xlab="pc2",ylab="pc3")
text(x=y+0.003,y=z+0.001,labels=a$V1,cex=0.5)
plot(a$V3,a$V5,pch=16,main="PCA",xlab="pc1",ylab="pc3")
text(x=x+0.003,y=z+0.001,labels=a$V1,cex=0.5)