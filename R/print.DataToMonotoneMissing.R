print.DataToMonotoneMissing<-function(x){
  cat("head:\n")
  cat("Reduced: ",x$reduObj,".\n")
  if(isTRUE(x$reduObj)){
    cat("Montone:\n")
    print(table(x$data$C))
  }
  print(table(x$data$C))
}
