Lambdaprob<-function(object, ...){

  objdata<-object$data
  orderSeqObj<-object$orderSeqObj
  
  for(cV in 1:(length(orderSeqObj)-1)){
    LV<-length(orderSeqObj):((length(orderSeqObj)+1)-cV)
  
    objdata$R<-1*(objdata$C==cV)
  
    p<-predict(
      glm(as.formula(paste0("R ~ ",paste0(orderSeqObj[LV],collapse=" + "))), data=objdata[objdata$C>=cV,],family = binomial(link = "logit")),
      type="response")
    eval(parse(text=paste0("objdata$lambda",cV,"[objdata$C>=cV]<-p")))
    }

  eval(parse(text=
               paste0("objdata$lambda",length(orderSeqObj),"<-",paste0("(1-objdata$lambda",c(1:(length(orderSeqObj)-1)),")",collapse = "*"))
             ))
}
