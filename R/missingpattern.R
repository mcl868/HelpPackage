missing.pattern<-function(response, covariates, data, pattern, ...){
  result<-list()
  
  variables<-c(covariates, response)
  lengthVar<-length(variables)
  
  data1<-data[, variables]
  data1$C<-rowSums(1*is.na(data1))
  data1$C[data1$C==0]<-Inf

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
    data2<-data1[data1$C %in% c(1,Inf),]}
  
  result$data<-data2
  result$covariatesObj<-covariates
  result$pattern<-pattern
  result$responseObj<-response

  attr(result, "class")<-"DataToPattern"
  out<-structure(result, class = "DataToPattern")
  
  return(out)}
