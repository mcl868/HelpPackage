head.ProbToData<-function(x, n,...){
  object-x
  rm(x)
  if(inherits(object,ProbToData)){
  head(object$data,n=n)
  }}