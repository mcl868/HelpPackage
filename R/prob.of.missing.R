prob.of.missing<-function(object, regression, augspace = TRUE, completecase = FALSE, regList, ...){
  if(inherits(object,"DataToMonotoneMissing")){
    
    objdata<-object$data
    covariatesObj<-object$covariatesObj
    missingObj<-object$missingObj
    responseObj<-object$responseObj
    
    if(missing(regList)){
      if(missing(regression)){
        regression<-"simple"
        message("regression is simple")
      }
    }
    
    if(all(objdata$MONOTONE) & !is.null(objdata$MONOTONE)){
      orderSeqObj<-missingObj
      for(cV in 1:(length(orderSeqObj)-1)){
        if(missing(regList)){
          LV<-1:cV
          
          objdata$R<-1*(objdata$C==cV)
          
          if(regression=="simple")
            formCharac<-paste0("R ~ ",paste0(orderSeqObj[LV],collapse=" + "))
          if(regression=="interaction")
            formCharac<-paste0("R ~ ",paste0(orderSeqObj[LV],collapse=" * "))
          if("higherorder" %in% unlist(strsplit(regression,split = "[.]"))){
            order<-as.numeric(unlist(strsplit(regression,split = "[.]"))[!unlist(strsplit(regression,split = "[.]")) %in% "higherorder"])
            formCharac<-paste0("R ~ ",paste0(unlist(lapply(1:order, function(i)paste0("I(",orderSeqObj[LV],"^",i,")"))),collapse=" + "))
          }
          
          form<-as.formula(formCharac)
        } else {
          form<-as.formula(regList[[cV]])
          objdata$R<-1*(objdata$C==cV)
        }
        p<-predict(glm(form, data=objdata[objdata$C>=cV,],family = binomial(link = "logit")),type="response")
        
        eval(parse(text=paste0("objdata$lambda",cV,"[objdata$C>=cV]<-p")))
      }
      eval(parse(text=paste0("objdata$varpiInf<-",paste0("(1-objdata$lambda",c(1:(length(orderSeqObj)-1)),")",collapse = "*"))))
      
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
      
      objdata$varpiInfINV<-1/objdata$varpiInf
    }
    if(object$DataSetformat=="OneResponse"){
      if(missing(regList)){
        if(regression=="simple"){
          Model<-paste0(c(A$covariatesObj,A$responseObj)[!c(A$covariatesObj,A$responseObj) %in% A$missingObj],collapse=" + ")
        }
        if(regression=="interaction"){
          Model<-paste0(c(A$covariatesObj,A$responseObj)[!c(A$covariatesObj,A$responseObj) %in% A$missingObj],collapse=" * ")
        }
        if("higherorder" %in% unlist(strsplit(regression,split = "[.]"))){
          order<-as.numeric(unlist(strsplit(regression,split = "[.]"))[!unlist(strsplit(regression,split = "[.]")) %in% "higherorder"])
          ListVar<-c(A$covariatesObj,A$responseObj)[!c(A$covariatesObj,A$responseObj) %in% A$missingObj]
          Model<-paste0(paste0(unlist(lapply(1:order, function(i)paste0("I(",ListVar,"^",i,")"))),collapse=" + "))
        }} else { 
          if(length(regList)<2){
            Model<-regList[[1]]
          } else {
            message("regList is too long. Regression is simple.")
            Model<-paste0(c(A$covariatesObj,A$responseObj)[!c(A$covariatesObj,A$responseObj) %in% A$missingObj],collapse=" + ")
          }}
      
      objdata$Pi<-predict(glm(as.formula(paste0("1*(objdata$C==Inf) ~ ",Model,collapse="")), data=objdata,family = binomial()),type="response")
      objdata$PiINV<-1/objdata$Pi
      if(augspace){
        objdata$aug<-(1*(objdata$C==Inf)-objdata$Pi)/objdata$Pi
      }
    }
    if(!(all(objdata$MONOTONE) & !is.null(objdata$MONOTONE)) & !object$DataSetformat=="OneResponse"){
      message("Not all object are MONOTONE missing. Change redu to TRUE")
    }
    if(completecase){
      objdata<-objdata[objdata$C==Inf,]
    }
    out<-objdata
    return(out)
  }
}
