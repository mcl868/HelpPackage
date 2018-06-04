prob.of.missing<-function(object, regression, augspace = FALSE, regList, ...){
  if(inherits(object,"DataToMonotoneMissing")){
    
    objdata<-object$data
    orderSeqObj<-object$orderSeqObj
    
    if(all(objdata$MONOTONE)){
      eval(parse(text=paste0("objdata$",orderSeqObj,"_R<-NULL")))
      
      if(missing(regression)){
        regression<-"simple"
        message("regression is simple")
      }
      
      for(cV in 1:(length(orderSeqObj)-1)){
        if(missing(regList)){
        LV<-length(orderSeqObj):((length(orderSeqObj)+1)-cV)
        
        objdata$R<-1*(objdata$C==cV)
        
        if(regression=="simple")
          form<-as.formula(paste0("R ~ ",paste0(orderSeqObj[LV],collapse=" + ")))
        if(regression=="interaction")
          form<-as.formula(paste0("R ~ ",paste0(orderSeqObj[LV],collapse=" * ")))
        if("higherorder" %in% unlist(strsplit(regression,split = "[.]"))){
          order<-as.numeric(unlist(strsplit(regression,split = "[.]"))[!unlist(strsplit(regression,split = "[.]")) %in% "higherorder"])
          form<-as.formula(paste0("R ~ ",paste0(unlist(lapply(1:order, function(i)paste0("I(",orderSeqObj[LV],"^",i,")"))),collapse=" + ")))
        }} else {
          form<-regList[[cV]]
        }
        p<-predict(glm(form, data=objdata[objdata$C>=cV,],family = binomial(link = "logit")),type="response")
        }
       

        eval(parse(text=paste0("objdata$lambda",cV,"[objdata$C>=cV]<-p")))
      }
      eval(parse(text=
                   paste0("objdata$varpiInf<-",paste0("(1-objdata$lambda",c(1:(length(orderSeqObj)-1)),")",collapse = "*"))
      ))
      if(augspace){
        for(jj in 1:(length(orderSeqObj)-1)){
          eval(parse(text=paste0("objdata$K",jj,"<-",paste0("(1-objdata$lambda",c(1:jj),")",collapse = "*"))))
        }
      r<-1:(length(orderSeqObj)-1)
      eval(parse(text=paste0("objdata$aug",r,"<-(1*(objdata$C==",r,")-objdata$lambda",r,"*1*(objdata$C>=",r,"))/objdata$K",r)))
      }
      if(!augspace){
          for(jj in (length(orderSeqObj)-1):2){
            eval(parse(text=paste0("objdata$varpi",jj,"<-",paste0("(1-objdata$lambda",c(1:(jj-1)),")",collapse = "*"),"*objdata$lambda",jj)))
            eval(parse(text=paste0("objdata$lambda",jj,"<-NULL")))
          }
        objdata$varpi1<-objdata$lambda1;objdata$lambda1<-NULL
      }

      objdata$R<-NULL
      eval(parse(text=paste0("objdata$varpiInf[objdata$C<Inf]<-NA")))
      
    } else message("Not all object of MONOTONE are TRUE")}
  out<-objdata
  return(out)
}
