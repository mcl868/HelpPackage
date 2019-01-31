# Estimator

## DAG
![capture](https://user-images.githubusercontent.com/20704019/52067565-209ee480-257b-11e9-9461-d8dd80c3863f.PNG=250x250)



## Binary exposure
```markdown
g.aipw.dicho(mmodels,
             pmodels,
             data,...)
```


### Data
```markdown
p<-function(x)exp(x)/(1+exp(x))

loop<-2000

set.seed(3)
DataSetList<-list()
for(iiii in 1:loop){
  L0<-rnorm(NN)
  X0<-1*(runif(NN,0,1)<=p(0.6*L0))

  L1<--X0+0.2*L0-1*X0*L0+rnorm(NN)
  X1<-1*(runif(NN,0,1)<=p(-1+1.6*X0+1.2*L1-0.8*L0-1.6*L1*X0))

  L2<--X1+1*L1-X0+1.2*L0+rnorm(NN)
  X2<-1*(runif(NN,0,1)<=p(1-0.8*L0+1.6*X0+1.2*L1+1.3*X1+0.5*L2+1.6*L1*X1))

  Y<-2*L0+3*X0+1*L1+2*X1-2*L2+5*X2+L2*X2+rnorm(NN)

  DataSetList[[iiii]]<-data.frame(L0, L1, L2, X0, X1, X2, Y);rm(list=c("L0","L1","L2","X0","X1","X2","Y"))}
rm("iiii")
```

### Model
```markdown
pi1 <- X0 ~ L0
pi2 <- X1 ~ L0 + X0 + L1 + L1*X0
pi3 <- X2 ~ L0 + X0 + L1 + X1 + L2 + L1*X1

model1 <- Y ~ L0 + X0 + L1 + X1 + L2 + X2 + L2*X2
model2 <- model1 ~ X1 + L1 + X0 + L0
model3 <- model2 ~ X0 + L0 + X0*L0

estimation<-list()
for(iiii in 1:loop){
  estimation[[iiii]]<-g.aipw.dicho(mmodels=c(model1,model2,model3), 
                                   pmodels=c(pi1,pi2,pi3), 
                                   data=DataSetList[[iiii]])}
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

### Missing data
```markdown
DataSetListNA<-list()
for(iiii in 1:loop){
  REMOVE1<-with(DataSetList[[iiii]],1*(runif(nrow(DataSetList[[iiii]]),0,1)<=p(-2.2-0.5*L0)))
  updata1<-DataSetList[[iiii]][REMOVE1==1,];upd1<-DataSetList[[iiii]][REMOVE1==0,]
  updata1[,c("X0","L1","X1","L2","X2","Y")]<-NA

  REMOVE2<-with(upd1,1*(runif(nrow(upd1),0,1)<=p(-2.3+0.2*L0-0.2*X0)))
  updata2<-upd1[REMOVE2==1,];upd2<-upd1[REMOVE2==0,]
  updata2[,c("L1","X1","L2","X2","Y")]<-NA
  
  REMOVE3<-with(upd2,1*(runif(nrow(upd2),0,1)<=p(-2.4-0.3*L0+0.2*X0-0.2*L1)))
  updata3<-upd2[REMOVE3==1,];upd3<-upd2[REMOVE3==0,]
  updata3[,c("X1","L2","X2","Y")]<-NA

  REMOVE4<-with(upd3,1*(runif(nrow(upd3),0,1)<=p(-2.3+0.4*L0+0.2*X0+0.8*L1+0.5*X1)))
  updata4<-upd3[REMOVE4==1,];upd4<-upd3[REMOVE4==0,]
  updata4[,c("L2","X2","Y")]<-NA

  REMOVE5<-with(upd4,1*(runif(nrow(upd4),0,1)<=p(-2.2+0.4*L0+0.2*X0+0.7*L1+0.5*X1-0.3*L2)))
  updata5<-upd4[REMOVE5==1,];upd5<-upd4[REMOVE5==0,]
  updata5[,c("X2","Y")]<-NA

  REMOVE6<-with(upd5,1*(runif(nrow(upd5),0,1)<=p(-2+0.4*L0+0.2*X0+0.7*L1-0.5*X1-0.3*L2+1.2*X2-1.4*X1*X2)))
  updata6<-upd5[REMOVE6==1,];updata7<-upd5[REMOVE6==0,]
  updata6[,c("Y")]<-NA

  DataSetListNA[[iiii]]<-rbind(updata1,updata2,updata3,updata4,updata5,updata6,updata7)[sample(1:NN,NN),]}

```

### Missing regression
```markdown
regList<-list()
regList[[1]]<-"L0"
regList[[2]]<-"L0 + X0"
regList[[3]]<-"L0 + X0 + L1"
regList[[4]]<-"L0 + X0 + L1 + X1"
regList[[5]]<-"L0 + X0 + L1 + X1 + L2"
regList[[6]]<-"L0 + X0 + L1 + X1 + L2 + X2 + X1*X2"



DataSetCount<-list()
CountList<-Coef1List<-Coef2List<-Coef3List<-Coef4List<-Coef5List<-Coef6List<-list()
for(iiii in 1:loop){
  misdata<-missing.pattern(response = "Y",
                           covariates = c("L0","X0","L1","X1","L2","X2"),
                           data = DataSetListNA[[iiii]],
                           pattern = "Monotone")

  DataSetobj<-prob.of.missing(misdata, regList = regList)

  DataSetCount[[iiii]]<-misdata$count
  Coef1List[[iiii]]<-DataSetobj$CoefList[[1]]
  Coef2List[[iiii]]<-DataSetobj$CoefList[[2]]
  Coef3List[[iiii]]<-DataSetobj$CoefList[[3]]
  Coef4List[[iiii]]<-DataSetobj$CoefList[[4]]
  Coef5List[[iiii]]<-DataSetobj$CoefList[[5]]
  Coef6List[[iiii]]<-DataSetobj$CoefList[[6]]}

listMean(DataSetCount)
       1        2        3        4        5        6      Inf 
217.2500 151.9170 172.9670 161.1325 203.7540 176.3445 916.6350

round(listMean(Coef1List),1)
(Intercept)          L0 
       -2.2        -0.5 
round(listMean(Coef2List),1)
(Intercept)          L0          X0 
       -2.3         0.2        -0.2 
round(listMean(Coef3List),1)
(Intercept)          L0          X0          L1 
       -2.4        -0.3         0.2        -0.2 
round(listMean(Coef4List),1)
(Intercept)          L0          X0          L1          X1 
       -2.3         0.4         0.2         0.8         0.5 
round(listMean(Coef5List),1)
(Intercept)          L0          X0          L1          X1          L2 
       -2.2         0.4         0.2         0.7         0.5        -0.3 
round(listMean(Coef6List),1)
(Intercept)          L0          X0          L1          X1          L2          X2       X1:X2 
       -2.0         0.4         0.2         0.7        -0.5        -0.3         1.2        -1.4 
```






