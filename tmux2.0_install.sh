#!/bin/bash
yum install gcc -y
mkdir tmux
cd tmux
wget https://github.com/libevent/libevent/releases/download/release-2.1.10-stable/libevent-2.1.10-stable.tar.gz
tar zxvf libevent-2.1.10-stable.tar.gz
cd libevent-2.1.10-stable
./configure
make
make install 
cd ..
yum install ncurses-devel -y
wget https://github.com/tmux/tmux/releases/download/2.9/tmux-2.9.tar.gz
tar zxvf tmux-2.9.tar.gz
cd tmux-2.9
./configure
make
make install 

ln -s /usr/local/lib/libevent-2.1.so.6 /usr/lib64/libevent-2.1.so.6
