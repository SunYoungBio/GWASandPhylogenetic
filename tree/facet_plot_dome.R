tr <- rtree(30)

p <- ggtree(tr)
p
d1 <- data.frame(id=tr$tip.label, location=sample(c("GZ", "HK", "CZ"), 30, replace=TRUE))
d1
p1 <- p %<+% d1 + geom_tippoint(aes(color=location))
p1
d2 <- data.frame(id=tr$tip.label, val=rnorm(30, sd=3))
d2
p2 <- facet_plot(p1, panel="dot", data=d2, geom=geom_point, 
                 aes(x=val), color='firebrick') + theme_tree2()
p2
library(ggbio)
#install.packages("ggstance")
library(ggstance)
library(ggplot2)
library(ape)
library(ggtree)
library(treeio)

update.packages(repos = "https://mirrors.ustc.edu.cn/CRAN/",ask='graphics',checkBuilt=TRUE)
BiocManager::install("ggtree")

## try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install("BiocUpgrade") ## you may need this
BiocManager::install("treeio")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("treeio", version = "3.8")

## install.packages("devtools")
devtools::install_github("GuangchuangYu/ggimage")

.libPaths('D:/Program Files/Rpackages')
.libPaths()
