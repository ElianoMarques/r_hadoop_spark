mtcars
bind.cols(mtcars, carb.per.cyl = carb/cyl)
bind.cols(input("/tmp/mtcars"), carb.per.cyl = carb/cyl)

hdfs.init()
hdfs.ls("/tmp")
#
rm(list=c(ls()))
# load library
library(rmr2)
rmr.options(backend="hadoop")
# write some data to hdfs
small.ints <- to.dfs(keyval(1, 1:10000))
out <- mapreduce(
  input = small.ints, 
  map = function(k, v) cbind(v, v^2))

res <- from.dfs(out)
class(res)



##Linear Regression##
library(car)
str(Prestige)
attach(Prestige)
ds=cbind(education,women,income)
prest_moddel=lm(prestige~education+women+income, data=Prestige)
## X Matrix##
X=as.matrix(cbind(1,ds))
View(X)
## X Matrix in hadoop ##
X.Index=to.dfs(cbind(1:nrow(X),X))
checkX <- matrix(values(from.dfs(X.Index)),nrow(X), ncol(X)+1)

##y Matrix ##
y=matrix(prestige)

##Sum function ##
Sum=function(.,YY) keyval(1, list(Reduce('+',YY)))
Sum(,c(10,10,10))

## Map functions ##
## 1 ## - Covariance Matrix for the Explanatory Matrix - X'X
Map1 = function (., Xi) {
      yi=y[Xi[,1],]
      Xi=Xi[,-1]
      keyval(1,list(t(Xi)%*%Xi))}
Map1(,checkX)
y[checkX[,1],]

## 2 ## - Covariance Matrix between Factors and Dependent Variable - X'Y
Map2 = function (., Xi) {
  yi=y[Xi[,1],]
  Xi=Xi[,-1]
  keyval(1,list(t(Xi)%*%yi))}
Map2(,)

## Map reduce for X'X and X'y ##

XtX = values (
  from.dfs(
    mapreduce(
    input=X.Index,
    map=Map1,
    reduce=Sum,
    combine=T)))[[1]]

Xty = values (
  from.dfs(
    mapreduce(
    input=X.Index,
    map=Map2,
    reduce=Sum,
    combine=T)))[[1]]
  
## Calculate (X'X)-1 (X'y)  ##

coefs_standard=solve(t(X)%*%X)%*%t(X)%*%y

coefs=solve(XtX,Xty)

## Missing Calculation of Standard Errors, T-stats and P-values ##







