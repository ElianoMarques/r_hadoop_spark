rm(list=c(ls()))
if(!require(rJava)) {install.packages("rJava"); require(rJava)}
if(!require(Rcpp)) {install.packages("Rcpp"); require(Rcpp)}
if(!require(RJSONIO)) {install.packages("RJSONIO"); require(RJSONIO)}
if(!require(bitops)) {install.packages("bitops"); require(bitops)}
if(!require(digest)) {install.packages("digest"); require(digest)}
if(!require(functional)) {install.packages("functional"); require(functional)}
if(!require(stringr)) {install.packages("stringr"); require(stringr)}
if(!require(plyr)) {install.packages("plyr"); require(plyr)}
if(!require(reshape2)) {install.packages("reshape2"); require(reshape2)}
if(!require(dplyr)) {install.packages("dplyr"); require(dplyr)}
if(!require(R.methodsS3)) {install.packages("R.methodsS3"); require(R.methodsS3)}
if(!require(caTools)) {install.packages("caTools"); require(caTools)}
if(!require(Hmisc)) {install.packages("Hmisc"); require(Hmisc)}
if(!require(data.table)) {install.packages("data.table"); require(data.table)}
if(!require(bit64)) {install.packages("bit64"); require(bit64)}
if(!require(rjson)) {install.packages("rjson"); require(rjson)}

#Sys.unsetenv("HADOOP_HOME")
# Sys.setenv("HADOOP_HOME"="/home/ubuntu/hadoop")
Sys.setenv("HADOOP_PREFIX"="/home/ubuntu/hadoop")
Sys.setenv("HADOOP_CMD"="/home/ubuntu/hadoop/bin/hadoop")
Sys.setenv("HADOOP_STREAMING"="/home/ubuntu/hadoop/contrib/streaming/hadoop-streaming-1.2.1.jar")
if(!require(rhdfs)){install.packages("~/rhdfs_1.0.8.tar.gz", repos=NULL, type="source", dependencies=T)}; require(rhdfs)
if(!require(ravro)){install.packages("~/ravro_1.0.4.tar.gz", repos=NULL, type="source", dependencies=T)}; require(ravro)
if(!require(rmr2)){install.packages("~/rmr2_3.3.0.tar.gz", repos=NULL, type="source", dependencies=T)}; require(rmr2)
if(!require(plyrmr)){install.packages("~/plyrmr_0.4.0.tar.gz", repos=NULL, type="source", dependencies=T)}; require(plyrmr)
#install.packages("~/rhbase_1.2.1.tar.gz", repos=NULL, type="source", dependencies=T)

