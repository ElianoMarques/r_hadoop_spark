library(SparkR)
if(!require(rpart)) {install.packages('rpart');require(rpart)}
if(!require(nnet)) {install.packages('nnet');require(nnet)}
if(!require(randomForest)) {install.packages('randomForest');require(randomForest)}
if(!require(rpart.plot)) {install.packages('rpart.plot');require(rpart.plot)}
if(!require(MASS)) {install.packages('MASS');require(MASS)}
if(!require(rattle)) {install.packages('rattle');require(rattle)}
if(!require(rpart.utils)) {install.packages('rpart.utils');require(rpart.utils)}
if(!require(XML)) {install.packages('XML');require(XML)}
if(!require(xtable)) {install.packages('xtable');require(xtable)}
if(!require(ggplot2)) {install.packages('ggplot2');require(ggplot2)}
if(!require(scales)) {install.packages('scales');require(scales)}
if(!require(sqldf)) {install.packages('sqldf');require(sqldf)}
if(!require(stringr)) {install.packages('stringr');require(stringr)}
if(!require(mfx)) {install.packages('mfx');require(mfx)}
if(!require(tabplot)) {install.packages('tabplot');require(tabplot)}
if(!require(RCurl)) {install.packages('RCurl');require(RCurl)} 
if(!require(devtools)) {install.packages('devtools');require(devtools)} 
if(!require(coefplot)) {install.packages('coefplot');require(coefplot)} 
if(!require(vcd)) {install.packages('vcd');require(vcd)} 
if(!require(ROCR)) {install.packages('ROCR');require(ROCR)} 


Sys.setenv(HADOOP_CONF_DIR="/home/hadoop/conf/")
Sys.setenv(YARN_CONF_DIR="/home/hadoop/conf/")
Sys.setenv(JAVA_HOME="/usr/java/latest")
#Sys.getenv("JAVA_HOME")

sc <- sparkR.init(master="yarn-client",
                  sparkEnvir=list(spark.executor.memory="2g"))

iterations <- 85
D <- 8

readPartition <- function(part){
  part = as.vector(part, mode = "character")
  part = strsplit(part, "/", fixed = T)
  list(matrix(as.numeric(unlist(part)), ncol = 9))
}


ModelData <- read.delim("~/ModelData.txt", header=T)
lines=parallelize(sc, list(ModelData), numSlices = 8)

points <- cache(lapplyPartition(lines, readPartition))
points = cache(lines)
# Initialize w to a random value
w <- runif(n=D, min = -1, max = 1)
cat("Initial w: ", w, "\n")

# Compute logistic regression gradient for a matrix of data points
gradient <- function(partition) {
 partition = partition[[1]]
  partition=as.matrix(partition)
  Y <- partition[, 1]  # point labels (first column of input file)
  X <- partition[, -1] # point coordinates
  
  # For each point (x, y), compute gradient function
  dot <- X %*% w
  logit <- 1 / (1 + exp(-Y * dot))
  grad <- t(X) %*% ((logit - 1) * Y)
  list(grad)
}


w0=w
for (i in 1:iterations) {
  cat("On iteration ", i, "\n")
  w <- w - reduce(lapplyPartition(points, gradient), "+")
  if(i==1){coefs=cbind(w0,w)} else {coefs=cbind(coefs,w)}
}
head(ModelData)
options('scipen'=100,'digits'=8)
fit.logitTemp <- glm(Flag_False_Alert~0+ENG_HOURS+ENG_STARTS+NGP+POWER+PCD+T5_1_SPR+
                       ENG_HOURS_Plus2+ENG_STARTS_Plus2, ModelData, family = binomial(link = "logit"))
fit.logit <- stepAIC(fit.logitTemp, direction = "both")
summary(fit.logitTemp)

coefs=cbind(coefs,exp(coef(fit.logitTemp)))
cat("Final w: ", w, "\n")
cbind(w,w0)
View(coefs)
Spark.stop()
