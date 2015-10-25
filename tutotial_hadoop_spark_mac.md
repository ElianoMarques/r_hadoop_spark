# Install Hadoop

````shell
#Install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#Install java
brew install Caskroom/cask/java
#Install latest version of hadoop
brew install hadoop
#Edit Edit hadoop-env.sh - file located at /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/hadoop-env.sh
#to check hadoop version simply run "hadoop version" on shell and check the version in the first line
#find export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true" and replace with
export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true -Djava.security.krb5.realm= -Djava.security.krb5.kdc="
````

###Edit Core-site.xml 
located here: /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/core-site.xml 

````shell
vim /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/core-site.xml
Press I then copy paste the below 
  <configuration>
   <property>
     <name>hadoop.tmp.dir</name>
     <value>/usr/local/Cellar/hadoop/hdfs/tmp</value>
     <description>A base for other temporary directories.</description>
  </property>
  <property>
     <name>fs.default.name</name>                                     
     <value>hdfs://localhost:9000</value>                             
  </property> 
 </configuration>
Press esc :x
````
###Edit mapred-site.xml
located here: /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/mapred-site.xml

````shell
vim /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/mapred-site.xml
Press I then copy paste the below
  <configuration>
  <property>
  <name>mapred.job.tracker</name>
  <value>localhost:9010</value>
  </property>
  </configuration>
Press esc + :x
````
###Edit hdfs-site.xml
located here: /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/hdfs-site.xml
````shell
vim /usr/local/Cellar/hadoop/x.x.x/libexec/etc/hadoop/hdfs-site.xml
Press I then copy paste the below
  <configuration>
  <property>
  <name>dfs.replication</name>
  <value>1</value>
  </property>
  </configuration>
Press esc + :x 
````
####Assuming hadoop higher than 2.5 
```shell
vim ~/.profile 
alias hstart="/usr/local/Cellar/hadoop/x.x.x/sbin/start-dfs.sh;/usr/local/Cellar/hadoop/x.x.0/sbin/start-yarn.sh"
alias hstop="/usr/local/Cellar/hadoop/x.x.x/sbin/stop-yarn.sh;/usr/local/Cellar/hadoop/x.x.0/sbin/stop-dfs.sh"
````
###Format hdfs
```shell
hdfs namenode -format
````
### SSH Localhost settings
Nothing needs to be done here if you have already generated ssh keys. To verify just check for the existance of ~/.ssh/id_rsa and the ~/.ssh/id_rsa.pub files. If not the keys can be generated using
````shell
ssh-keygen -t rsa
````
#####Enable Remote Login
“System Preferences” -> “Sharing”. Check “Remote Login”
#####Authorize SSH Keys
To allow your system to accept login, we have to make it aware of the keys that will be used
````shell
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
````

####Please restart shell (close and open new one) and test
```shell
ssh localhost
```

###Test Hadoop
```shell
source ~/.profile
hstart
```


