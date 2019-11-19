rangeCol<-function(x, na.rm = FALSE){
  rancol<-matrix(NA,nrow=2,ncol=ncol(x))
  for(i in 1:ncol(x)){rancol[,i]<-range(x, na.rm = na.rm)}
  rownames(rancol)<-c("min","max")
  return(rancol)
}