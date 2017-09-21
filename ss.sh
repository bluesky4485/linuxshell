#!/bin/bash
yum install wget unzip vim -y
wget https://raw.github.com/sivel/speedtest-cli/master/speedtest.py
chmod a+rx speedtest.py
mv speedtest.py /usr/local/bin/speedtest
chown root:root /usr/local/bin/speedtest
speedtest
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
chmod +x shadowsocks-all.sh
yum install gcc libnet libpcap libnet-devel libpcap-devel -y
wget https://github.com/snooda/net-speeder/archive/master.zip
unzip master.zip
cd net-speeder-master
sh build.sh -DCOOKED
cp net_speeder /usr/bin/
echo 'nohup /usr/bin/net_speeder venet0 "ip" >/dev/null 2>&1 &' >> /etc/rc.local
nohup /usr/bin/net_speeder venet0 "ip" >/dev/null 2>&1 &
cd ..
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
