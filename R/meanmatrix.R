mean.matrix<-function(x){
  if(is.matrix(x)){
    SampleSize<-nrow(x)
    out<-(t(x)%*%x)/SampleSize
    return(out)
  } else {warning("x has to be a matrix")}
}
