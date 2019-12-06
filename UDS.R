rm(list=ls())
library(RWiener)
library(fdapace)
setwd('/Users/omidbazgir/Google Drive/UDS projection')
Drug_descriptors_DF <- read.csv('gdsc_v7_padel_descriptors_normalized_SRD_02_07_2019.csv')

X = Drug_descriptors_DF[,2:ncol(Drug_descriptors_DF)]
X <- matrix(unlist(X), ncol = ncol(X), byrow = TRUE)

set.seed(1)
n <- 50
wiener = Wiener(n = n)[,-1]
p = ncol(wiener)

matris=matrix(rnorm(10),5,20)
d <- dist(matris)
p = ncol(matris)
stringingfit = Stringing(X = matris, disOptns = "euclidean")
plot(1:p,stringingfit$StringingOrder, pch=18); abline(a=0,b=1)

