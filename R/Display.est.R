Display.est<-function(est, sdest, p=0.95, digits = 3, ...){
  if(nrow(sdest)==ncol(sdest)){
  sdestM<-matrix(sapply(1:nrow(sdest),function(i)sdest[i,i]))
  } else {
  sdestM<-sdest
  }
  pest<-2*(1-pnorm(abs(est/sdestM)))
  Disp<-cbind(est, sdestM, est-qnorm((p+1)/2)*sdestM, est+qnorm((p+1)/2)*sdestM,pest)
  colnames(Disp)<-c("Est","Std.err","Lower","Upper","pValue")
  rownames(Disp)<-rownames(est)
  return(round(Disp,digits))
}