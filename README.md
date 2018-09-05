# HelpPackage

```markdown
install.packages("devtools")
library(devtools)
install_github('mcl868/HelpPackage')
```



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
