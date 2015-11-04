# linuxshell
some linux shell I use.

=====================
## Tmux2.0
我的linux都是以开发人员模式安装的，所以常用的编译gcc之类的都是有的，这个脚本是在我实际安装过程中的一个过程记录吧。主要是下载安装了Tmux依赖的libevent，另外就是安装了ncurses，最后就是下载安装tmux了。挺简单的，只是为了方便在我其他的linux使用而做的一个脚本。


## tomcat重启脚本
主要是用来在linux中重启tomcat服务的，可以用来做定时任务，定时重启，也可以手动一键重启。
> 注意，脚本名称不能包含tomcat字符串，否则会被重启脚本误以为是tomcat进程而干掉。
