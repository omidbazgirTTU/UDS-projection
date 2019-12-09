Matcher <- function(Drug_work, DF,Work){
  Drug_work = Work$DRUG_NAME
  
  Work_Order <- 0
  for(i in 1:length(Drug_work)) {
    # i-th element of `u1` squared into `i`-th position of `usq`
    temp = DF[DF$DRUG_NAME == as.character(Drug_work[i]),]
    Work_Order[i] <- temp$StringingOrder
  }
  Work$StringOrder = Work_Order
  
  return(Work)
}
