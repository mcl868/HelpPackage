Lambdaprob<-function(object, ...){
  if(inherits(object,"DataToMonotoneMissing")){

    objdata<-object$data
    orderSeqObj<-object$orderSeqObj
    
    if(all(objdata$MONOTONE)){

  
      for(cV in 1:(length(orderSeqObj)-1)){
        LV<-length(orderSeqObj):((length(orderSeqObj)+1)-cV)
  
        objdata$R<-1*(objdata$C==cV)
  
        p<-predict(
          glm(as.formula(paste0("R ~ ",paste0(orderSeqObj[LV],collapse=" + "))), data=objdata[objdata$C>=cV,],family = binomial(link = "logit")),
          type="response")
        eval(parse(text=paste0("objdata$lambda",cV,"[objdata$C>=cV]<-p")))
        }
      eval(parse(text=
                   paste0("objdata$varpiInf<-",paste0("(1-objdata$lambda",c(1:(length(orderSeqObj)-1)),")",collapse = "*"))
      ))
      objdata$R<-NULL
      eval(parse(text=paste0("objdata$varpiInf[objdata$C<Inf]<-NA")))
     
    } else message("Not all object of MONOTONE are TRUE")}
  out<-objdata
  return(out)
}
