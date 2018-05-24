DataToMonotone<-function(data, orderSeq, ...){
  data1<-data[,orderSeq]
  ma<-length(orderSeq)
  for(i in 1:ma){
    for(j in 1:nrow(data1)){
      eval(parse(text=paste0("data1$",orderSeq[i],"_R[j]<-1*(!is.na(","data1$",orderSeq[i],"[j]))")))
    }}
  
  data2<-data1[eval(parse(text=paste0("data1$",orderSeq[ma],"_R==1"))),]
  data2$MONOTONE<-NA
  
  for(i in 2:ma){
    for(j in 1:nrow(data2)){
      eval(parse(text=
                   paste0("data2$MONOTONE[j]<-ifelse(all(c(",paste0(
                     "data2$",orderSeq[c(ma:i)],"_R[j]==1",collapse = ","),")) & (all(c(",
                     paste0("data2$",orderSeq[c((i-1):1)],collapse = "_R[j]==0,"),"_R[j]==0))|all(c(",
                     paste0("data2$",orderSeq[c((i-1):1)],collapse = "_R[j]==1,"),"_R[j]==1))), TRUE , FALSE)")
      ))
    }}

  return(data2)
  
}
