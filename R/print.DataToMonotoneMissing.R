print.DataToMonotoneMissing<-function(x){
  cat("head:\n")
  cat("Reduced: ",x$reduObj,".\n")
  if(x$reduObj){
    cat("Montone:\n")
    print(table(x$C))
  }
  print(table(x$C))
}
