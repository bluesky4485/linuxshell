#!/bin/bash
adduser git
su git
cd

wget https://dl.gogs.io/0.11.91/gogs_0.11.91_linux_amd64.tar.gz
tar zxvf gogs_0.11.91_linux_amd64.tar.gz
sudo
cp gogs/scripts/systemd/gogs.service /usr/lib/systemd/system
service gogs start
