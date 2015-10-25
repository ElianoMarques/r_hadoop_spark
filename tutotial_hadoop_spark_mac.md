# Install Hadoop

````shell
#Install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#Install java
brew install Caskroom/cask/java
#Install latest version of hadoop
brew install hadoop
#Edit Edit hadoop-env.sh - file located at /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/hadoop-env.sh
#to check hadoop version simply run hadoop and check the version in the first line
#find export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true" and replace with
export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true -Djava.security.krb5.realm= -Djava.security.krb5.kdc="
````

Edit Core-site.xml 
located here: /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/core-site.xml 

````shell
vim /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/core-site.xml
Press I
   <property>
     <name>hadoop.tmp.dir</name>
     <value>/usr/local/Cellar/hadoop/hdfs/tmp</value>
     <description>A base for other temporary directories.</description>
  </property>
  <property>
     <name>fs.default.name</name>                                     
     <value>hdfs://localhost:9000</value>                             
  </property> 
Press esc + x + q
````
Edit mapred-site.xml
located here: /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/mapred-site.xml

````shell
vim /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/mapred-site.xml
Press I
  <configuration>
  <property>
  <name>mapred.job.tracker</name>
  <value>localhost:9010</value>
  </property>
  </configuration>
Press esc + x + q
````
Edit hdfs-site.xml
located here: /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/hdfs-site.xml
````shell
vim /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/hdfs-site.xml
Press I
  <configuration>
  <property>
  <name>dfs.replication</name>
  <value>1</value>
  </property>
  </configuration>
Press esc + x + q
````
Assuming hadoop higher than 2.5 
```shell
vim ~/.profile 
alias hstart="/usr/local/Cellar/hadoop/x.x.x/sbin/start-dfs.sh;/usr/local/Cellar/hadoop/x.x.0/sbin/start-yarn.sh"
alias hstop="/usr/local/Cellar/hadoop/x.x.x/sbin/stop-yarn.sh;/usr/local/Cellar/hadoop/x.x.0/sbin/stop-dfs.sh"
````
Test Hadoop
```shell
source ~/.profile
hstart
```


