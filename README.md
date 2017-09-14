# linuxshell
some linux shell I use.
大部分脚本如未说明操作系统版本，皆为centos7系列，本人也仅在centos7下面进行安装测试，其他系统部分脚本是否可用请自行测试。

=====================
## Tmux2.0
我的linux都是以开发人员模式安装的，所以常用的编译gcc之类的都是有的，这个脚本是在我实际安装过程中的一个过程记录吧。主要是下载安装了Tmux依赖的libevent，另外就是安装了ncurses，最后就是下载安装tmux了。挺简单的，只是为了方便在我其他的linux使用而做的一个脚本。


## tomcat重启脚本
主要是用来在linux中重启tomcat服务的，可以用来做定时任务，定时重启，也可以手动一键重启。
> 注意，脚本名称不能包含tomcat字符串，否则会被重启脚本误以为是tomcat进程而干掉。


## jdk&tomcat&nginx下载安装
由于jdk的下载需要登陆，所以将最新的centos的linux版本的jdk下载下来放到了七牛云，用于解决文件下载问题。

tomcat直接使用压缩包形式下载下来解压即可。

nginx使用增进repo源形式，增进一个nginx的yum repo，再进行yum安装。

## git&mariadb安装
默认centos源里面的git版本比较老，需要使用第三方源进行安装。

使用官方提供的rpm添加repo形式进行安装，添加官方的源，国内速度会比较慢。
