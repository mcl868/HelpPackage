# Estimator

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
