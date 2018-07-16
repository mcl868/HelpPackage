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
print("missing")
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

print(glm(as.formula(paste0("1*(objdata$C==Inf) ~ ",Model,collapse="")), data=objdata,family = binomial()))
      objdata$Pi<-predict(glm(as.formula(paste0("1*(objdata$C==Inf) ~ ",Model,collapse="")), data=objdata,family = binomial()),type="response")
      objdata$PiINV<-1/objdata$Pi
      if(augspace){
        objdata$aug<-(1*(objdata$C==Inf)-objdata$Pi)/objdata$Pi
      }
    }
    if((all(objdata$MONOTONE) & !is.null(objdata$MONOTONE)) | !object$DataSetformat=="OneResponse"){
      message("Not all object are MONOTONE missing. Change redu to TRUE")
    }
    if(completecase){
      objdata<-objdata[objdata$C==Inf,]
    }
  out<-objdata
  return(out)
  }
}
