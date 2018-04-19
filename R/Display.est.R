Display.est<-function(est, varest, digits = 4, ...){
  Disp<-cbind(est, sqrt(varest), est-1.96*sqrt(varest), est+1.96*sqrt(varest))
  colnames(Disp)<-c("Est","Std.err","Lower","Upper")
  return(Disp)
}
