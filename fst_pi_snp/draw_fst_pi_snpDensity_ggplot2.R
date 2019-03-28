setwd("F:/yangyang/projects/dangxiaojing/fst/")
setwd("F:/yangyang/projects/dangxiaojing/pi/")
dat <- read.table('indica_japonica.windowed.weir.fst', header = T) # or whatever you named your file.
dat <- read.table('indica_japonica_pi.txt', header = T)
head(dat)
library(ggplot2)

#fst
ggplot(dat, aes(x=BIN_START, y=MEAN_FST)) +
  geom_line()+ 
  facet_grid(CHROM~., scales = "free_x",space = "free_x")+
  theme(panel.grid =element_blank())+
  theme(axis.text.x = element_blank())+
  theme(axis.ticks = element_blank())+
  #theme(panel.background = element_blank())+
  ggtitle("Fst between Indica and Japonica")+
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0)) +
  scale_y_continuous(breaks=seq(0,0.8,0.2)) +
  labs(x="",y="")

#pi
ggplot(dat, aes(x=BIN_START, y=PI, colour=var)) +
  geom_line()+ 
  facet_grid(CHROM~., scales = "free_x",space = "free_x")+
  theme(panel.grid =element_blank())+
  theme(axis.text.x = element_blank())+
  theme(axis.ticks = element_blank())+
  #theme(panel.background = element_blank())+
  ggtitle("Pi of Indica and Japonica")+
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0)) +
  #scale_y_continuous(breaks=seq(0,0.8,0.2)) +
  labs(x="",y="")

#SNP density
ggplot(dat, aes(x=BIN_START, y=N_VARIANTS)) +
  geom_bar(position=position_dodge(), stat="identity",width = 0.1,color="black")+ 
  facet_grid(CHROM~., scales = "free_x",space = "free_x")+
  theme(panel.grid =element_blank())+
  theme(axis.text.x = element_blank())+
  theme(axis.ticks = element_blank())+
  #theme(panel.background = element_blank())+
  ggtitle("Fst between Indica and Japonica")+
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0)) +
  #scale_y_continuous(breaks=seq(0,0.8,0.2)) +
  labs(x="",y="")
