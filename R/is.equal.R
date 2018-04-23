is.equal<-function(y, x, tol = 1e-14, ...){
  dist<-abs(y-x)<tol
  return(dist)
}
