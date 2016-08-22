#!/bin/bash
mkdir tmux
cd tmux
wget https://sourceforge.net/projects/levent/files/libevent/libevent-2.0/libevent-2.0.22-stable.tar.gz
tar zxvf libevent-2.0.22-stable.tar.gz
cd libevent-2.0.22-stable
./configure
make
make install 
cd ..
yum install ncurses-devel -y
wget https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz
tar zxvf tmux-2.2.tar.gz
cd tmux-2.2
./configure
make
make install 
