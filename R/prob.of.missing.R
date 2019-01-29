prob.of.missing<-function(object, regression, list.out = TRUE, completecase = FALSE, regList, order=NULL, ...){

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
  levels<-as.numeric(rownames(table(objdata$C))[!rownames(table(objdata$C)) %in% Inf])
  qq<-c(1:length(covariatesObj))
  eval(parse(text=paste0("objdata$lambda",qq[!(qq %in% levels)],"<-0")))
  CoefList<-vector("list",length(covariatesObj))
  if(!missing(regList)){
  	for(iii_ in levels){
  	lambdamodel<-paste0("1*(C==",iii_,") ~ ",regList[[iii_]])
    CoefList[[iii_]]<-coef(glm(lambdamodel, data= objdata[objdata$C>=iii_,],family=binomial()))
 	  lambda<-predict(glm(lambdamodel, data= objdata[objdata$C>=iii_,],family=binomial()),type="response", newdata=objdata)
  	eval(parse(text=paste0("objdata$lambda",iii_,"<-lambda")))
  	}
  } else {
  	if(missing(regression)){message("regression is simple")}
    regList<-vector("list",length(covariatesObj))
   	if(is.null(order))order<-covariatesObj
  	for(iii_ in levels){
  	  lambdamodel<-paste0("1*(C==",iii_,") ~ ",paste0(order[1:iii_],collapse=" + "))
      regList[[iii_]]<-lambdamodel
      CoefList[[iii_]]<-coef(glm(lambdamodel, data= objdata[objdata$C>=iii_,],family=binomial()))
      lambda<-predict(glm(lambdamodel, data= objdata[objdata$C>=iii_,],family=binomial()),type="response", newdata=objdata)
  	  eval(parse(text=paste0("objdata$lambda",iii_,"<-lambda")))
      }
    }
  objdatalambda<-objdata[,paste0("lambda",qq)]
  objdatalambda[is.na(objdata[,covariatesObj])]<-NA
  eval(parse(text=paste0("objdata$lambda",qq,"<-NULL")))
  objdata<-cbind(objdata,objdatalambda)
  objdata$K0<-1
  for(iiii_ in qq){eval(parse(text=paste0("objdata$K",iiii_,"<-objdata$K",iiii_-1,"*(1-objdata$lambda",iiii_,")")))}
  objdata$K0<-NULL
  eval(parse(text=paste0("objdata$varpi<-objdata$K",length(regList))))
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
      out$pattern<-patternObj
      out$varpimodel<-varpimodel
      out$CoefList<-CoefList
    }
    if(patternObj=="Monotone"){
      out$pattern<-patternObj
      out$regList<-regList
      out$CoefList<-CoefList
    }
    attr(out, "class")<-"ProbToData"
    output<-structure(out, class = "ProbToData")
  } else {
  	if(completecase){
      objdata<-objdata[objdata$C==Inf,]
      message("Complete Case")
    }
    output<-objdata
  }
  

  return(output)
  }
}
