#!/bin/bash

# AWS EMR step script 
# for changing HDFS /tmp permission
#
# tested with AMI 3.1.1 (hadoop 2.4.0)
#
# schmidbe@amazon.de
# 26. August 2014
##############################
#Added some user permissions for rstudio to call spark
#Eliano Marques 01 April 2015
#
# change HDFS /tmp permissions to r+w everyone
# this is required for R tmp data in hadoop streaming jobs
hadoop fs -chmod -R 777 /tmp
hadoop fs -chmod -R 777 /mnt
sudo chown -R rstudio /mnt
sudo groupadd supergroup
sudo usermod -a -G supergroup rstudio
