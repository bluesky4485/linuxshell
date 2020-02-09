#!/bin/bash
mkdir demo 
cd demo
wget https://trans-1256163271.cos.ap-shanghai.myqcloud.com/caddy
chmod +x caddy
echo "0.0.0.0:80 {
  tls off
  proxy / http://baidu.com
  }
  " > Caddyfile
  
 ./caddy
