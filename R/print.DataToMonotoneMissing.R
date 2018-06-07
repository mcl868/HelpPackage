print.DataToMonotoneMissing<-function(x){
  cat("head:\n")
  cat(paste0("Reduced: ",x$reduObj,".\n"))
  if(isTRUE(x$reduObj)){
    cat("Montone:\n")
    print(table(x$data$C))
  } else {
    print(table(x$data$C))
  }
}
