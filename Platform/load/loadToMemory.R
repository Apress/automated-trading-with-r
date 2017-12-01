# Listing 2.5
setwd(DIR[["data"]]) 
S <- sub(".csv", "", list.files())

library(data.table)

DATA <- list()
for(i in S){
  if (i != "invalid.R"){
  suppressWarnings(
  DATA[[i]] <- fread(paste0(i, ".csv"), sep = ","))
  DATA[[i]] <- (DATA[[i]])[order(DATA[[i]][["Date"]], decreasing = FALSE)]
  }
} 
