#!/bin/bash

wget https://setup.ius.io/ -O ius.sh
chmod +x ius.sh
./ius.sh

yum install git2u tmux2u -y

wget http://dl.huangketech.com/jdk-8u241-linux-x64.rpm
rpm -ivh jdk-8u241-linux-x64.rpm

echo export JAVA_HOME=/usr/java/jdk1.8.0_241-amd64 >>/etc/profile
echo export CLASSPATH=.:\$JAVA_HOME/jre/lib/rt.jar:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar >>/etc/profile
echo export PATH=\$PATH:\$JAVA_HOME/bin >>/etc/profile
source /etc/profile
