#install.packages(c("devtools","ggplot2","gridExtra","gtable","tidyr"),dependencies=T)
devtools::install_github('royfrancis/pophelper')
library(pophelper)
library(gridExtra)
setwd("F:/yangyang/projects/qizengjun/admixture/")


afiles <- list.files(path="Q/",pattern="Q$", full.names = T)
afiles

#这种添加样本名称的方法好像不行了！！官网说indlabfromfile 函数只能在STRUCTURE上能用，而且是布尔值！！！以前怎么这样可以？
sample.name=read.table("sample.classify.txt",as.is = T,row.names = 1)
head(sample.name)
slist <- readQ(files = afiles,indlabfromfile = sample.name)
#用官网方法：
inds <- read.delim(system.file("files/structureindlabels.txt",package="pophelper"),header=FALSE,stringsAsFactors=F)
# add indlab to one run
rownames(slist[[1]]) <- inds$V1
# if all runs are equal length, add indlab to all runs
if(length(unique(sapply(slist,nrow)))==1) slist <- lapply(slist,"rownames<-",inds$V1)
# show row names of all runs and all samples
lapply(slist, rownames)
#分别画一个和多个方法：
	p1 <- plotQ(slist1[1],
	returnplot=T,#必须要有返回画图，否则没有图产生
	exportplot=F,quiet=T,basesize=11,
            showindlab=T,#若单独使用这个参数，将会使用序号作为标签
	            useindlab=T,#使用rowname作为标签
	            showyaxis=T)
	p2 <- plotQ(slist1[c(1,3)],imgoutput="join",returnplot=T,exportplot=F,quiet=T,basesize=11,
            showindlab=T,useindlab=T,showyaxis=T,panelspacer=0.3)

##所有的K值结果画在一起
plotQ(slist[7:9], sortind = "all", imgtype = "pdf", ordergrp = F, 
      imgoutput = "join", width = 100, outputfilename = paste0("structure_barplot1"), 
      showindlab=T, indlabsize = 0.5, indlabheight = 0.1,sharedindlab=F)
##画指定K值的结果
##现在无效了
rownames(slist[[7]])=sample.name

onelabset1 <- sample.name[,2,drop=FALSE]
head(onelabset1)
plotQMultiline(slist[7], imgtype = "pdf", sortind = "all", grplab=onelabset1,
               useindlab = T, width = 80, height = 15, indlabsize = 6, spl = 453)

#批量写入标签到文件两种方法代码：
	x=p2$data$qlist
	x
	lapply(x,write.table,"test.txt",
	append=T, #写入同一个文件
	quote = F,sep="\t")
	
	for(i in 1:length(x)){
	  write.table(x[[i]], file=paste0(names(x)[i],"_ind.txt"), #写入多个文件
	quote = F,sep = "\t",col.names = F) 
}


# sorted by cluster 1
plotQ(slist[c(7,9)], sortind="Cluster1")
# sorted by cluster 2
plotQ(slist[7], sortind="Cluster2")
# sorted by all
plotQ(slist[c(7,9)], sortind="all")


# sorted by cluster 1, three files joined plot
plotQ(slist[7:9], sortind="Cluster1", imgoutput="join",sharedindlab=F)
plotQ(slist[7:9], sortind="all", imgoutput="join",sharedindlab=F)

# modified for this document
p1 <- plotQ(slist[7],returnplot=T,exportplot=F,quiet=T,basesize=11,
            sortind="all",showindlab=T,showyaxis=T,showticks=T)

p2 <- plotQ(slist[8:9],imgoutput="join",returnplot=T,exportplot=F,quiet=T,basesize=11,
            sortind="all",sharedindlab=F,showindlab=T,showyaxis=T,showticks=T)

grid.arrange(p1$plot[[1]])

p2 <- plotQ(slist[c(8,9)],imgoutput="join",returnplot=T,exportplot=F,quiet=T,basesize=11,
            grplab=onelabset1,grplabsize=3.5,linesize=0.8,pointsize=3,
            sharedindlab=F,sortind="all",ordergrp = T)
grid.arrange(p2$plot[[1]])

# modified for this document
p1 <- plotQ(slist[c(7,8)],imgoutput="join",returnplot=T,exportplot=F,quiet=T,basesize=11,
            grplab=onelabset1,grplabsize=3.5,linesize=0.8,pointsize=3,
            sharedindlab=T,sortind="label",showindlab=T,useindlab=F,ordergrp = T)

p2 <- plotQ(slist[c(7,8)],imgoutput="join",returnplot=T,exportplot=F,quiet=T,basesize=11,
            grplab=onelabset1,grplabsize=3.5,linesize=0.8,pointsize=3,
            sharedindlab=T,sortind="label",showindlab=T,useindlab=T,ordergrp = T)

grid.arrange(p1$plot[[1]],p2$plot[[1]],ncol=2)


p1 <- plotQ(slist[7],returnplot=T,exportplot=F,quiet=T,basesize=11,
            grplab=onelabset1,grplabsize=4,linesize=0.8,pointsize=4)

p2 <- plotQ(slist[c(8,9)],imgoutput="join",returnplot=T,exportplot=F,quiet=T,basesize=11,sortind="label",
            grplab=onelabset1,grplabsize=4,linesize=0.8,pointsize=4)

#multip group
p <- plotQ(slist[8],returnplot=T,exportplot=F,basesize=11,
           showindlab = F,
           grplabsize=3.5,linesize=0.8,pointsize=3,
           grplab=sample.name,
           selgrp = "V4",
           ordergrp = T,
           grplabangle=-90, grplabjust=0.6,grplabheight=2, grplabpos=0.6)
grid.arrange(p$plot[[1]])

#subgrep group
p2 <- plotQ(slist[7],returnplot=T,exportplot=F,quiet=T,basesize=11,
            grplab=sample.name,grplabsize=3.5,linesize=0.8,pointsize=3,
            useindlab = T,showindlab=T,#if want show mysefe indlab, using the two para
            subsetgrp="5000",selgrp="V4",ordergrp = T)
grid.arrange(p2$plot[[1]])

grid.arrange(p1$plot[[1]],p2$plot[[1]],nrow=2)


# adjust label angle and justification
plotQ(slist1[1], grplab=threelabset1, grplabangle=-90, grplabjust=0.5)

# adjust grplabheight to fit labels
plotQ(slist1[1], grplab=threelabset1, grplabangle=-90, grplabjust=0.4, grplabheight=3)

# when grplabheight is high enough, use grplabpos to move labels vertically
plotQ(slist1[1], grplab=threelabset1, grplabheight=3, grplabpos=0.5)
plotQ(slist1[1], grplab=threelabset1, grplabheight=3, grplabpos=0.3)

# adjust grplabel colour
plotQ(slist1[1] ,grplab=threelabset1, grplabcol="green")

# adjust marker points
plotQ(slist1[1], grplab=threelabset1, pointtype=21, pointsize=0.4, pointcol="steelblue", pointbgcol="red")
plotQ(slist1[1], grplab=threelabset1, pointtype="$", pointcol="green", pointsize=2)

# adjust marker line
plotQ(slist1[1], grplab=threelabset1, linesize=0.5, linecol="steelblue")
plotQ(slist1[1], grplab=threelabset1, linecol="steelblue", linetype=3, linesize=0.2)


p1 <- plotQ(slist[8],returnplot=T,exportplot=F,quiet=T,basesize=11,
            returndata=TRUE,#you can write.table the sorted date
            #grplab=onelabset1,grplabsize=3.5,pointsize=6,linesize=7,linealpha=0.2,
            pointcol="white",grplabpos=0.5,linepos=0.5,grplabheight=0.75,
            sortind = "all",
            showindlab = T,useindlab = T,
            ordergrp = T,grplabangle = -90)

grid.arrange(p1$plot[[1]])
aa=p1$data$qlist$Barley.MCR50.snps.mb.3.Q
bb=p1$data$grplab[[1]]


write.table(LS.df,"p2.csv",sep = "\t",quote = F)

p1 <- plotQMultiline(slist[7],exportplot=F,returnplot=T,barsize=1,
                     showindlab = T,
                     grplab=onelabset1,ordergrp = T)
grid.arrange(p1$plot[[1]][[1]])

plotQ(slist[2:3],imgoutput="join",showindlab=T,grplab=twolabset,
      subsetgrp=c("Brazil","Greece"),selgrp="loc",ordergrp=T,showlegend=T,
      showtitle=T,showsubtitle=T,titlelab="The Great Structure",
      subtitlelab="The amazing population structure of your favourite organism.",
      height=1.6,indlabsize=2.3,indlabheight=0.08,indlabspacer=-1,
      barbordercolour="white",barbordersize=0,outputfilename="plotq",imgtype="png")

analyseQ(files=afiles,grplab = sample.name)
