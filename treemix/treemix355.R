install.packages("RCircos")#version==1.1
install.packages("GenABEL")#download by youself
install.packages("car")
install.packages("rmarkdown")
install.packages("kableExtra")
install.packages("beanplot")

library("BITE")#github 下载，手动安装
setwd("F:/yangyang/projects/dangxiaojing/treemix/350sample/")

#source("F:/yangyang/software/treemix-1.13/src/plotting_funcs.R")
plot_resid("best.m_0",  "poporder",wcols = "rb")
plot_resid("best.m_1",  "poporder",wcols = "rb")
plot_resid("best.m_2",  "poporder",wcols = "rb")
plot_resid("best.m_3",  "poporder",wcols = "rb")
plot_resid("best.m_4",  "poporder",wcols = "rb")

plot_tree("best.m_0",xbar=0.2,ybar = 0.5)
plot_tree("best.m_1",xbar=0.35,ybar = 0.5)
plot_tree("best.m_2",xbar=0.2,ybar = 0.5)
plot_tree("best.m_3",xbar=0,ybar = 0.5)
plot_tree("best.m_4",xbar=0.05,ybar = 0.5)

plot_tree("rmNIW_bsp1000_m1",xbar=0.05,ybar = 0.17)
plot_tree("best.m_1",xbar=0.35,ybar = 0.5)
plot_tree("best.m_2",xbar=0.2,ybar = 0.5)
plot_tree("best.m_3",xbar=0,ybar = 0.5)
plot_tree("best.m_4",xbar=0.05,ybar = 0.5)

treemix.fit("best.m_", m.end = 4)
treemix.fit("best.m_", out.file = "best.m", m.end = 4)

treemix.fit(in.file = "HapMap3_chr2_subsample_treemix_", out.file = "test", m.start = 0, m.end = 5)


treemix.bootstrap(in.file = "rmNIW_bsp1000_m2", 
                  phylip.file = "rmNIW_bsp1000_m2_outtree.newick", 
                  nboot = 1000,
                  boot.legend.location = NA,
                  xbar=0,ybar = 0.5,cex=1, boot.legend.cex = 0.8, xmin = -0.009, disp = 0.002)
plot_resid("rmNIW_bsp1000_m2",  "poporder_rmNIW",wcols = "rb")

treemix.bootstrap(in.file = "rmRUM_bsp1000_m2", 
                  phylip.file = "rmRUM_bsp1000_m2_outtree.newick", 
                  nboot = 1000,
                  boot.legend.location = NA,
                  xbar=0,ybar = 0.5,cex=1, boot.legend.cex = 0.8, xmin = -0.009, disp = 0.002)
plot_resid("rmRUM_bsp1000_m2",  "poporder_rmRUW",wcols = "rb")
