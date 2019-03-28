## try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
## BiocManager::install("BiocUpgrade") ## you may need this
BiocManager::install("treeio")
library(treeio)
setwd("F:/yangyang/projects/dangxiaojing/Tree/")
tree <- read.newick("C:/Users/DELL/Documents/R/win-library/3.5/ggtree/extdata/pa.nwk", node.label='support')
root <- getRoot(tree@phylo)

p <- ggtree(tree, color="black", size=1.5, linetype=1,  ladderize=TRUE)# + 
  ggtitle(label="Figure A") + 
  geom_tiplab(size=4.5, hjust = -0.060, fontface="bold") +  xlim(0, 0.09)

ggtree(tree)
#==============================================
library("treeio")
library("ggtree")

nwk <- system.file("extdata", "sample.nwk", package="treeio")
tree <- read.tree(nwk)
tree
ggplot(tree, aes(x, y)) + geom_tree() + theme_tree()
ggtree(tree, color="firebrick", size=1, linetype="dotted")
ggtree(tree, ladderize=FALSE)
ggtree(tree, branch.length="none")

set.seed(2017-02-16)
tr <- rtree(50)
ggtree(tr)
ggtree(tr, layout="slanted")
ggtree(tr, layout="circular")
ggtree(tr, layout="fan", open.angle=120)
ggtree(tr, layout="equal_angle")
ggtree(tr, layout="daylight")
ggtree(tr, branch.length='none')
ggtree(tr, branch.length='none', layout='circular')
ggtree(tr, layout="daylight", branch.length='none')


setwd("C:/Users/DELL/Desktop/frog_tree-master")
require(ggtree)
require(ggimage)

nwk <- "((((bufonidae, dendrobatidae), ceratophryidae), (centrolenidae, leptodactylidae)), hylidae);"

x = read.tree(text = nwk)
p <- ggtree(x) + xlim(NA, 7) + ylim(NA, 6.2) +
  geom_tiplab(aes(image=paste0(label, '.jpg')), geom="image", offset=2, align=2, size=.2)  + 
  geom_tiplab(geom='label', offset=0.5, hjust=.5) + 
  geom_image(x=.8, y=5.5, image="frog.jpg", size=.2)  + 
  ggtitle("Y叔不想养蛙", subtitle="只想养你，毕竟养猪能致富")
p

p <- p + theme(plot.title=element_text(family="STHeiti"), plot.subtitle=element_text(family="STHeiti"))
ggsave(p, file="ggtree_frog.png", width=8.5, height=7.5)
