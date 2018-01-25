listVar<-function(x)
listSums(lapply(1:length(x),function(i) (x[[i]]-listMean(x))^2))/(length(x)-1)
