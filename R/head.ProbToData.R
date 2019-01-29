head.ProbToData<-function(x, ...){
  object<-x
  rm(x)
  if(inherits(object,"ProbToData")){
  head(object$data)
  }}