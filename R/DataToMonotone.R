DataToMonotone<-function(data, orderSeq, ...){
  data1<-data[,orderSeq]
  ma<-length(orderSeq)
  for(i in 1:ma){
    for(j in 1:nrow(data1)){
      eval(parse(text=paste0("data1$",orderSeq[i],"_R[j]<-1*(!is.na(","data1$",orderSeq[i],"[j]))")))
    }}
  
  data2<-data1[eval(parse(text=paste0("data1$",orderSeq[ma],"_R==1"))),]
  data2$MONOTONE<-NA
  
 for(j in 1:nrow(data2)){
   data2$MONOTONE[j]<-
   all(sapply(1:(ma-1),function(i)eval(parse(text=paste0("data2$",orderSeq[i],"_R[j]<=","data2$",orderSeq[i+1],"_R[j]")))))
    }
  return(data2)
}
