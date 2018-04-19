Display.est<-function(est, varest, digits = 4, ...){
  if(nrow(varest)==ncol(varest)){
  varestM<-matrix(sapply(1:nrow(varest),function(i)varest[i,i]))
  } else {
  varestM<-varest
  }
  Disp<-cbind(est, sqrt(varestM), est-1.96*sqrt(varestM), est+1.96*sqrt(varestM))
  colnames(Disp)<-c("Est","Std.err","Lower","Upper")
  rownames(Disp)<-rownames(est)
  return(round(Disp,digits))
}
