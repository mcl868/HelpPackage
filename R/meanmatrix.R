mean.matrix<-function(x, na.rm=FALSE, ...){
  if(is.matrix(x)){
    if(na.rm){
      object<-na.omit(x)
    } else {
      object<-x
    }
    SampleSize<-nrow(object)
    out<-(t(object)%*%object)/SampleSize
    return(out)
  } else {warning("x has to be a matrix")}
}
