
----
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
----

 #Edit Core-site.xml 
 #/usr/local/Cellar/hadoop/2.6.0/libexec/etc/hadoop/core-site.xml 
 
---
   <property>
     <name>hadoop.tmp.dir</name>
     <value>/usr/local/Cellar/hadoop/hdfs/tmp</value>
     <description>A base for other temporary directories.</description>
  </property>
  <property>
     <name>fs.default.name</name>                                     
     <value>hdfs://localhost:9000</value>                             
  </property> 
---
  
#Edit mapred-site.xml
#/usr/local/Cellar/hadoop/2.6.0/libexec/etc/hadoop/mapred-site.xml
  
  ---
  <configuration>
  <property>
  <name>mapred.job.tracker</name>
  <value>localhost:9010</value>
  </property>
  </configuration>
  ---
  
#Edit hdfs-site.xml
  <configuration>
  <property>
  <name>dfs.replication</name>
  <value>1</value>
  </property>
  </configuration>

#Assuming hadoop higher than 2.5 
vim ~/.profile 
alias hstart="/usr/local/Cellar/hadoop/x.x.x/sbin/start-dfs.sh;/usr/local/Cellar/hadoop/x.x.0/sbin/start-yarn.sh"
alias hstop="/usr/local/Cellar/hadoop/x.x.x/sbin/stop-yarn.sh;/usr/local/Cellar/hadoop/x.x.0/sbin/stop-dfs.sh"
