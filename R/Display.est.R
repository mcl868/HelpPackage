Display.est<-function(est, sdest, p=0.95, prob=T, digits = 3, ...){
  if(nrow(sdest)==ncol(sdest)){
  sdestM<-matrix(sapply(1:nrow(sdest),function(i)sdest[i,i]))
  } else {
  sdestM<-sdest
  }
  if(prob){pest<-2*(1-pnorm(abs(est/sdestM)))} else {pest<-NULL}
  Disp<-cbind(est, sdestM, est-qnorm((p+1)/2)*sdestM, est+qnorm((p+1)/2)*sdestM,pest)
  if(prob){colnames(Disp)<-c("Est","Std.err","Lower","Upper","pValue")
    } else {
  colnames(Disp)<-c("Est","Std.err","Lower","Upper")}
  rownames(Disp)<-rownames(est)
  return(round(Disp,digits))
}