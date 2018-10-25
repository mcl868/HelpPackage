# HelpPackage

```markdown
install.packages("devtools")
devtools::install_github('mcl868/HelpPackage')
```


## This package contains following functions
- [listMean](https://github.com/mcl868/HelpPackage/blob/master/README.md#listmean-and-listvar)
- [listVar](https://github.com/mcl868/HelpPackage/blob/master/README.md#listmean-and-listvar)
- [listSums](https://github.com/mcl868/HelpPackage/blob/master/README.md#listsums)
- [mean.matrix](https://github.com/mcl868/HelpPackage/blob/master/README.md#meanmatrix)
- [indicator](https://github.com/mcl868/HelpPackage/blob/master/README.md#indicator)
- [missing.pattern](https://github.com/mcl868/HelpPackage/blob/master/README.md#missingpattern)
- [prob.of.missing](https://github.com/mcl868/HelpPackage/blob/master/README.md#probofmissing)

### listMean and listVar
Evaulate the mean and variance across a list 
```markdown
N<-1000
set.seed(3)
ListOfNorm<-list()
for(jj in 1:N){
  ListOfNorm[[jj]]<-matrix(rnorm(2,2),dimnames = list(c("a","b"),"value"))
}
  
listMean(ListOfNorm)
     value
a 1.996752
b 1.988997

listVar(ListOfNorm)
      value
a 1.0101092
b 0.9807797
```
### listSums
Evaulate the sum across a list 
```markdown
N<-100
ListOfSum<-list()
for(jj in 1:N){
  ListOfSum[[jj]]<-matrix(c((1/2)^jj,jj),dimnames = list(c("a","b"),"value"))
}
  
listSums(ListOfSum)
  value
a     1
b  5050
```
### mean.matrix
<a href="http://www.codecogs.com/eqnedit.php?latex=\bar{X}=((X_{1,1},X_{2,1},\ldots,X_{n,1})^T,(X_{1,2},X_{2,2},\ldots,X_{n,2})^T,\ldots(X_{1,k},X_{2,k},\ldots,X_{n,k})^T)" target="_blank"><img src="http://latex.codecogs.com/gif.latex?\bar{X}=((X_{1,1},X_{2,1},\ldots,X_{n,1})^T,(X_{1,2},X_{2,2},\ldots,X_{n,2})^T,\ldots(X_{1,k},X_{2,k},\ldots,X_{n,k})^T)" title="\bar{X}=((X_{1,1},X_{2,1},\ldots,X_{n,1})^T,(X_{1,2},X_{2,2},\ldots,X_{n,2})^T,\ldots(X_{1,k},X_{2,k},\ldots,X_{n,k})^T)" /></a>

where k is the number of variable and n is the samplesize

<a href="http://www.codecogs.com/eqnedit.php?latex=E(\bar{X}^T\bar{X})" target="_blank"><img src="http://latex.codecogs.com/gif.latex?E(\bar{X}^T\bar{X})" title="E(\bar{X}^T\bar{X})" /></a>
```markdown
Xbar<-matrix(c(1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2),10)

mean.matrix(Xbar)
     [,1] [,2]
[1,] 28.6 25.1
[2,] 25.1 28.9

Xbar[13]<-NA
mean.matrix(Xbar)
     [,1] [,2]
[1,] 28.6   NA
[2,]   NA   NA

mean.matrix(Xbar,na.rm=TRUE)
         [,1]     [,2]
[1,] 30.77778 26.55556
[2,] 26.55556 30.33333
```
### indicator
```markdown
indicator(condition, x)
```
### missing.pattern
```markdown
missing.pattern(response, 
                covariates, 
                data, 
                pattern, ...)
```

### prob.of.missing
```markdown
prob.of.missing(object,
                regression,
                list.out = TRUE,
                completecase = FALSE,
                regList,
                order=NULL, ...)
```
