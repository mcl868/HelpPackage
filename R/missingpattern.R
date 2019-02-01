missing.pattern<-function(response, covariates, data, pattern, ...){
  result<-list()
  
  variables<-c(covariates, response)
  lengthVar<-length(variables)
  
  data1<-data[, variables]
  data1$C<-rowSums(1*!is.na(data1))
  data1$C[data1$C==lengthVar]<-Inf

  if(!missing(pattern)){
    if(tolower(pattern) %in% c("twolevel", "monotone")){
      if(tolower(pattern) == "twolevel") pattern = "TwoLevel"
      if(tolower(pattern) == "monotone") pattern = "Monotone"
    }
  }

  if(missing(pattern)){
    if(length(unique(data1$C))>3){
        pattern = "Monotone"
      } else {
        pattern = "TwoLevel"
      }
  }
  if(pattern=="Monotone"){
    data2<-data1[rowSums((1*is.na(data1[1:(lengthVar-1)]))<=(1*is.na(data1[2:lengthVar])))==(lengthVar-1),]}
  if(pattern=="TwoLevel"){
    data2<-data1[data1$C %in% c((lengthVar-1),Inf),]}
  
  result$data<-data2
  result$covariatesObj<-covariates
  result$pattern<-pattern
  result$responseObj<-response
  result$count<-addmargins(table(data2$C))
  result$percent<-table(data2$C)/nrow(data2)

  attr(result, "class")<-"DataToPattern"
  out<-structure(result, class = "DataToPattern")
  
  return(out)}
