prob.of.missing<-function(object, regression, list.out = TRUE ,completecase = FALSE, regList, order=NULL, ...){

  if(inherits(object,"DataToPattern")){
  
  objdata<-object$data
  covariatesObj<-object$covariatesObj
  patternObj<-object$pattern
  responseObj<-object$responseObj	

  
################
# Pattern
  if(patternObj=="TwoLevel"){
  	if(!missing(regList)){varpimodel<-regList[[1]]
  	  } else {
    if(missing(regression)){
      regression<-"simple"
      message("regression is simple")
    }
    if(regression=="simple")varpimodel<-paste0("1*(C==Inf) ~ ",paste0(covariatesObj,collapse=" + "))
    if(regression=="interaction")varpimodel<-paste0("1*(C==Inf) ~ ",paste0(covariatesObj,collapse=" * "))
    if("higherorder" %in% unlist(strsplit(regression,split = "[.]"))){
      orderterm<-unlist(strsplit(regression,split = "[.]"))
      order<-as.numeric(orderterm[!orderterm %in% "higherorder"])
      regterm<-paste0(unlist(lapply(1:order,function(i)paste0("I(", covariatesObj,"^",i,")"))),collapse=" + ")
      varpimodel<-paste0("1*(C==Inf) ~ ", regterm)
      }
    }
  estVarpi<-glm(varpimodel, data=objdata,family=binomial())
  CoefList<-coef(estVarpi)
  objdata$varpi<-predict(estVarpi,type="response", newdata=objdata)
  objdata$varpi[!objdata$C==Inf]<-NA
  }
    
  if(patternObj=="Monotone"){
  	if(!missing(regList)){
  	  for(iii_ in 1:length(regList)){
  	  lambdamodel<-paste0("1*(C==",iii_,") ~ ",regList[[iii_]])
  	  lambda<-predict(glm(lambdamodel, data= objdata[objdata$C>=iii_,],family=binomial()),type="response", newdata=objdata)
  	  eval(parse(text=paste0("objdata$lambda",iii_,"<-lambda")))
  	  kvales<-eval(parse(text=paste0(paste0("(1-objdata$lambda",1:iii_,")"),collapse="*")))
  	  eval(parse(text=paste0("objdata$K",iii_,"<-kvales")))
  	  }
  	  eval(parse(text=paste0("objdata$varpi<-objdata$K",length(regList))))
      objdata$varpi[objdata$C<Inf]<-NA
  	} else {
  	  if(missing(regression)){
      message("regression is simple")
      }
  	  if(is.null(order))order<-covariatesObj
  	  levels<-as.numeric(rownames(table(objdata$C))[!rownames(table(objdata$C)) %in% Inf])
  	  for(iii_ in levels){
  	    lambdamodel<-paste0("1*(C==",iii_,") ~ ",paste0(order[1:iii_],collapse=" + "))
  	    lambda<-predict(glm(lambdamodel, data= objdata[objdata$C>=iii_,],family=binomial()),type="response", newdata=objdata)
  	    eval(parse(text=paste0("objdata$lambda",iii_,"<-lambda")))
  	  }
    }
  }
    
# Pattern
################
  if(list.out){
    out<-list()
      if(completecase){
      objdata<-objdata[objdata$C==Inf,]
      message("Complete Case")
      out$completecase
    }
    out$data<-objdata
    if(patternObj=="TwoLevel"){
      out$varpimodel<-varpimodel
      out$CoefList<-CoefList
    }
    out$count<-table(objdata$C)
    out$percent<-table(objdata$C)/nrow(objdata)
  } else {
  	if(completecase){
      objdata<-objdata[objdata$C==Inf,]
      message("Complete Case")
    }
    out<-objdata
  }
  
  
  return(out)
  }
}
