indicator<-function(condition, x){
  sapply(1:length(condition),function(i) ifelse(condition[i]==1,x[i],0))
  }
