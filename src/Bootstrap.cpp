#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
List Bootstrap(NumericMatrix X, int k) {
  int n = X.nrow();
  int m = X.ncol();
  List out(k);
  NumericVector tmp(n);
  for (int jj = 0; jj < n; jj++) {tmp[jj]=jj+1;}
  Function sample("sample");
  Function gestimation("gestimation");
  for (int i = 0; i < k; i++) {
    NumericVector outtemp = as<NumericVector>(sample(tmp,n,true));
    NumericMatrix temp(n,m);
    for (int j = 0; j < n; j++) {
      for (int l = 0; l < m; l++) {temp(j,l)=X(outtemp(j)-1,l);}}
    out[i]= as<NumericVector>(gestimation(temp));}
  return out;}
