#!/bin/bash
mkdir jdk
cd jdk
yum install wget unzip vim -y
#mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
#wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#yum makecache

#wget http://apache.claz.org/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz
wget http://mirrors.hust.edu.cn/apache/tomcat/tomcat-8/v8.5.29/bin/apache-tomcat-8.5.29.tar.gz
tar zxvf apache-tomcat-8.5.29.tar.gz
mv apache-tomcat-8.5.29 /usr/

#wget http://192.161.179.139/jdk-8u144-linux-x64.rpm
wget http://dl.huangketech.com/jdk-8u181-linux-x64.rpm
rpm -ivh jdk-8u181-linux-x64.rpm

echo export JAVA_HOME=/usr/java/jdk1.8.0_181 >>/etc/profile
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

yum install git2u mariadb101u-server nginx tmux2u -y

sed -i '/pid-file/a\lower_case_table_names=1' /etc/my.cnf.d/mariadb-server.cnf
nginx
service mariadb start

wget https://raw.github.com/sivel/speedtest-cli/master/speedtest.py
chmod a+rx speedtest.py
mv speedtest.py /usr/local/bin/speedtest
chown root:root /usr/local/bin/speedtest

#wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
#chmod +x shadowsocks-all.sh

#yum install gcc libnet libpcap libnet-devel libpcap-devel -y
#wget https://github.com/snooda/net-speeder/archive/master.zip
#unzip master.zip
#cd net-speeder-master
#sh build.sh -DCOOKED
#cp net_speeder /usr/bin/
#echo 'nohup /usr/bin/net_speeder venet0 "ip" >/dev/null 2>&1 &' >> /etc/rc.local
#nohup /usr/bin/net_speeder venet0 "ip" >/dev/null 2>&1 &
#cd ..
#./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
