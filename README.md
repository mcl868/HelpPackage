# HelpPackage

```markdown
install.packages("devtools")
library(devtools)
install_github('mcl868/HelpPackage')
```


## This package contains following functions
- [listMean(x)](https://github.com/mcl868/HelpPackage/blob/master/README.md#listmean-and-listvar)
- [listVar(x)](https://github.com/mcl868/HelpPackage/blob/master/README.md#listmean-and-listvar)
- [listSums(x)](https://github.com/mcl868/HelpPackage/blob/master/README.md#listsums)
- []
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

### prob.of.missing
```markdown
  
```
