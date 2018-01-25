#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector gestimation(NumericMatrix YX) {
  int nYX = YX.nrow();
  int kYX = YX.ncol();
  NumericVector Y(nYX);
  for (int ll = 0; ll < nYX; ll++) {Y[ll]=YX(ll,0);}
  NumericMatrix X(nYX, kYX-1);
  for (int ii = 0; ii < nYX; ii++){
    for (int jj = 0; jj < kYX-1; jj++){X(ii,jj)=YX(ii,jj+1);}}

  int n = Y.size();
  int k = X.ncol();
  NumericMatrix out(k,k);
  NumericMatrix outtemp(n,k+1);
  Function solve("solve");
  Function t("t");
  for (int l = 0; l < n; l++) {outtemp(l,0)=1;}
  for (int j = 0; j < k; j++) {
    for (int i = 0; i < n; i++) {outtemp(i,j+1)=X(i,j);}}
  NumericMatrix Xtotal(k+1,k+1);
  for (int j = 0; j < k+1; j++) {
    for (int l = 0; l < k+1; l++) {
      for (int i = 0; i < n; i++) {Xtotal(j,l) += outtemp(i,j)* outtemp(i, l);}}}
  NumericVector Ytotal(k+1);
  for (int j = 0; j < k+1; j++) {
    for (int i = 0; i < n; i++) {Ytotal[j] += outtemp(i,j)*Y[i];}}
  return solve(Xtotal, Ytotal);}
