print.aipwgcompdicho<-function(x, digits=3, ...){
  object<-x
  rm(x)
  if(inherits(object,"aipwgcompdicho")){
    
    Eobjects<-paste0("object$",names(object)[!names(object) %in% c("N","NCC","exposure")])
    Est<-matrix(round(sapply(1:length(Eobjects),function(i)eval(parse(text=Eobjects[i]))),digits),nrow=1)
    colnames(Est)<-paste("  ",names(object)[!names(object) %in% c("N","NCC","exposure")])
    rownames(Est)<-"Est"
    cat("\n")
    print(Est)
    cat("\n")
    if(object$N>object$NCC){
      cat("Used",object$NCC,"observations to estimation and",object$N-object$NCC,"records have been deleted.\n")
    }else{
      cat("Used",object$NCC,"observations to estimation.\n")}
    
  }
}

