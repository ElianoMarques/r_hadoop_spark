export PYSPARK_PYTHON=python
alias hadoop_start="/usr/local/Cellar/hadoop/2.7.1/sbin/start-dfs.sh;/usr/local/Cellar/hadoop/2.7.1/sbin/start-yarn.sh"
alias hadoop_stop="/usr/local/Cellar/hadoop/2.7.1/sbin/stop-yarn.sh;/usr/local/Cellar/hadoop/2.7.1/sbin/stop-dfs.sh"
alias zeppelin_start="/Users/EM186023/Documents/Tools/zeppelin/incubator-zeppelin-master/bin/zeppelin-daemon.sh start"
alias zeppelin_stop="/Users/EM186023/Documents/Tools/zeppelin/incubator-zeppelin-master/bin/zeppelin-daemon.sh stop"

#export SPARK_HOME="/usr/local/Cellar/apache-spark/1.6.1"
export SPARK_HOME="/Users/EM186023/Documents/Tools/Spark/spark-2.0.0-preview-bin-hadoop2.7"
#export PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.9-src.zip:${PYTHONPATH}"
export PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.1-src.zip:${PYTHONPATH}"
export PATH=$HOME/anaconda/bin:$PATH
export PYSPARK_PYTHON=$HOME/anaconda/bin
#export SPARK_DRIVER_PYTHON_OPTS="notebook --port=8089"

export PYSPARK_SUBMIT_ARGS="--master local --executor-memory 2g --driver-memory 4g --num-executors 4 --conf spark.serializer=org.apache.spark.serializer.KryoSerialize r --conf spark.akka.threads=32 --packages com.databricks:spark-csv_2.11:1.4.0 --conf spark.akka.frameSize=500"

#alias pyspark_nb="sudo IPYTHON_OPTS='notebook --port=8089' pyspark"
alias pyspark_nb="PYSPARK_DRIVER_PYTHON=ipython PYSPARK_DRIVER_PYTHON_OPTS='notebook --port=8099' $SPARK_HOME/bin/pyspark"

# added by Anaconda2 4.0.0 installer
export PATH="/Users/em186023/anaconda/bin:$PATH"
~                                                  
