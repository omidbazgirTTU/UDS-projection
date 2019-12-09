rm(list=ls())
####################################
##    Loading required packages   ##
####################################
library(fdapace)
# Setting the work directory
setwd('/Users/omidbazgir/Google Drive/UDS projection')
# Reading the GDSC drugs and their descriptors
Drug_descriptors_DF <- read.csv('gdsc_v7_padel_descriptors_normalized_SRD_02_07_2019.csv')
# Converting the drug dataframe into matrix and transposing to to 
# be used as the input of the stringing function
Drug_names_from_Descriptos = Drug_descriptors_DF$Name
X = Drug_descriptors_DF[,2:ncol(Drug_descriptors_DF)]
X <- matrix(unlist(X), ncol = ncol(X), byrow = TRUE)
X <- t(X)
p = ncol(X)

####################################
##            Stringing           ##
####################################
# Using euclidean distance matrix to project drugs on a compact subset of R^1.
# Once, the projection is performed then each drug has a location in R^1.

stringingfit = Stringing(X = X, disOptns = "euclidean")
CreateStringingPlot(stringingfit, 1:20)
# Plot the string
plot(1:p,stringingfit$StringingOrder, pch=18, main = "GDSC drug stringing",
     xlab = "Regular order",
     ylab = "Stringing order"); 
abline(a=0,b=1)

# Stringing order
Order = stringingfit$StringingOrder
# Orders to be saved
DF = list("Drugs" = Drug_names_from_Descriptos, "StringingOrder" = Order)
DF = as.data.frame(DF)
colnames(DF) <- c('DRUG_NAME', 'StringingOrder')
#write.csv(DF, file = "Stringing_Order.csv")
####################################
##            Drug resonse        ##
####################################
library(plyr)
# Reading the GDSC drug responses
Response_DF <- read.csv('GDSC_fitted_dose_response_NameCorrected.csv')
Cell_names= unique(Response_DF$CELL_LINE_NAME)
Drug_names= unique(Response_DF$DRUG_NAME)
LNIC50 = Response_DF$LN_IC50
# Select a cell line for ACF plot
for(i in 1:length(Cell_names)) {
  #dev.off()
  i = 1
  Cell_Response = Response_DF[Response_DF$CELL_LINE_NAME == Cell_names[i],]
  
  Cell_Response_intersect <- match_df(Cell_Response, DF, on="DRUG_NAME")
  Drug_intersect_order <- match_df(DF, Cell_Response, on="DRUG_NAME")
  Work = Cell_Response_intersect[,c("DRUG_NAME","LN_IC50")]
  source("Matcher.R")
  Work = Matcher(Drug_work, DF,Work)
  Work <- Work[order("StringOrder"),] 
  X = Work$LN_IC50
  jpeg(paste(Cell_names[i],'.jpg'))
  #pdf(paste(Cell_names[i],'.pdf'))
  acf(X, lag.max = length(X)-1,ylab = "Correlation", main = paste("ACF of " ,Cell_names[1]))
  dev.off()
}
# Plot LNIC50 or AUC for each drug on its location
#Response_DF$DRUG_NAME = Drug_names_from_Descriptos[1]



