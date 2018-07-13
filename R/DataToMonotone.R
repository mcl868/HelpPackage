DataToMonotone<-function(response, covariates, missing, data, redu, ...){
  result<-list()
  data1<-data[, c(covariates, response)]
  if(length(response)>1){
    DataSetformat<-"Longitudinal"
    ma<-length(missing)
    for(i in 1:ma){
      for(j in 1:nrow(data1)){
        eval(parse(text = paste0("data1$", missing[i], "_R[j]<-1*(!is.na(","data1$", missing[i], "[j]))")))
      }
    }
    data2<-data1[eval(parse(text = paste0("data1$", missing[1],"_R==1"))), ]
  } else {
    ma<-1
    DataSetformat<-"OneResponse"
    data2<-data1
  }

  
  data2$C<-rowSums(data2[, c(paste0(missing, "_R"))])
  data2$C[data2$C==ma]<-Inf
  data2$MONOTONE <- NA
  for(j in 1:nrow(data2)){
    data2$MONOTONE[j]<-all(sapply(1:(ma - 1), function(i) eval(parse(text = paste0("data2$", 
                                                                                     missing[i], "_R[j]>=", "data2$", missing[i + 1], 
                                                                                     "_R[j]")))))
  }

  result$reduObj<-"Not defined"
  if(!missing(redu)){
    data2<-data2[data2$MONOTONE == redu, ]
    result$reduObj<-redu
  }
  result$data<-data2
  result$covariatesObj<-covariates
  result$missingObj<-missing
  result$responseObj<-response
  result$DataSetformat<-DataSetformat

  attr(result, "class")<-"DataToMonotoneMissing"
  out<-structure(result, class = "DataToMonotoneMissing")

  return(out)
}
