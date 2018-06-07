#!/bin/bash

wget http://dl.huangketech.com/jdk-8u171-linux-x64.rpm
rpm -ivh jdk-8u171-linux-x64.rpm

echo export JAVA_HOME=/usr/java/jdk1.8.0_171 >>/etc/profile
echo export CLASSPATH=.:\$JAVA_HOME/jre/lib/rt.jar:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar >>/etc/profile
echo export PATH=\$PATH:\$JAVA_HOME/bin >>/etc/profile
source /etc/profile

wget https://setup.ius.io/ -O ius.sh
chmod +x ius.sh
./ius.sh
yum remove mariadb* -y
yum update -y

yum install git2u nginx tmux2u -y

yum install -y yum-utils device-mapper-persistent-data  lvm2
yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce

systemctl start docker

curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
