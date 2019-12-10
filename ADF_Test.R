rm(list=ls())
####################################
##    Loading required packages   ##
####################################
library(fdapace)
library(tseries)
# Setting the work directory
setwd('/Users/omidbazgir/Google Drive/UDS projection')
# Reading the GDSC drugs and their descriptors
Ordered_Response <- read.csv('Ordered_resp_drop_somelines.csv')
Cell_names = Ordered_Response$X
D = dim(Ordered_Response)
RES = matrix(, nrow = D[1], ncol = 3)
for (i in 1:D[1]) {
  Data = Ordered_Response[i,2:D[2]]
  X = as.matrix(Data[ , colSums(is.na(Data)) == 0])
  X = t(X)
  # jpeg(paste(Cell_names[i],'.jpg'))
  # pdf(paste(Cell_names[i],'.pdf'))
  # acf(X, lag.max = length(X)-1,ylab = "Correlation", main = paste("ACF of " ,Cell_names[1]))
  # dev.off()
  ADF_Results <- adf.test(X)
  P_Value <- ADF_Results$p.value
  STAT <- ADF_Results$statistic
  RES[i,1] = as.character(Cell_names[i])
  RES[i,2] = STAT
  RES[i,3] = P_Value

}
ADF_Test_Res <- data.frame(RES)
colnames(ADF_Test_Res) <- c("Cell name","Statistics","p-value")
