setwd("/gss1/home/xjdang/GATK_calling_SNP/381Rice_ann/grep381sampleAllele/")
setwd("/gss1/home/xjdang/GATK_calling_SNP/381Rice_ann/grep381sampleAllele/PHYB.C")
mysnpcon=read.table("new2gene.snpContent.plot.txt")
mysnpcon=read.table("PHYB.C.targetSNPcontent.txt")
head(mysnpcon)
#dt=head(mysnpcon,359)
library(ggplot2)
levels(factor(mysnpcon$V2))
dat <- within(mysnpcon, 
              V2 <- factor(V2, levels = c("wild","IndicaLandrace","IndicaCultivar",
                                                "JaponicaLandrace","JaponicaCultivar","JaponicaNE",
                                                "javanica")))
#with(dat, levels(V2))
#head(dat)
ggplot(data=dat, mapping=aes(x="V3",fill=V3))+
  geom_bar(stat="count",width=0.5,position='fill')+
  facet_grid(V2~V1)+
  coord_polar(theta = "y") + 
  labs(x = "", y = "", title = "") +
  theme(axis.ticks = element_blank()) + 
  theme(legend.title = element_blank(), legend.position = "left") + 
  theme(axis.text.x = element_blank())+
  theme(axis.text.y = element_blank())+
  theme(panel.grid=element_blank()) +    ## 去掉白色圆框和中间的坐标线
  theme(panel.border=element_blank())+   ## 去掉最外层正方形的框框
  scale_fill_manual(values=c("#56B4E9","red","#999999" ,"blue"))
 