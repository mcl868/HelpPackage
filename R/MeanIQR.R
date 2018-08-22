MeanIQR<-function(x,p=c(1/3,2/3)){VEC<-c(mean(x),quantile(x,p));return(VEC)}
