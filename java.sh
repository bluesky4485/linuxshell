#!/bin/bash
mkdir jdk
cd jdk
yum install wget -y
#mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
#wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#yum makecache

wget http://mirrors.hust.edu.cn/apache/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz
tar zxvf apache-tomcat-8.5.20.tar.gz
mv apache-tomcat-8.5.20 /usr/

wget http://dl.huangketech.com/jdk-8u144-linux-x64.rpm
rpm -ivh jdk-8u144-linux-x64.rpm

echo export JAVA_HOME=/usr/java/jdk1.8.0_144 >>/etc/profile
echo export CLASSPATH=.:\$JAVA_HOME/jre/lib/rt.jar:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar >>/etc/profile
echo export PATH=\$PATH:\$JAVA_HOME/bin >>/etc/profile
source /etc/profile

cat > /etc/yum.repos.d/nginx.repo<<-EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/\$basearch/
gpgcheck=0
enabled=1
EOF

#curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash

wget https://setup.ius.io/ -O ius.sh
chmod +x ius.sh
./ius.sh
yum remove mariadb* -y
yum update -y

yum install git2u -y
yum install mariadb101u-server -y
yum install nginx -y
yum install tmux2u -y
service mariadb start