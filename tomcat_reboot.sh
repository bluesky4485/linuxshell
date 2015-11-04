#!/bin/sh  
pid=`ps aux | grep tomcat | grep -v grep | grep -v retomcat | awk '{print $2}'`  
echo $pid  
if [ -n "$pid" ]  
then  
{  
   echo ===========shutdown================  
   /usr/local/tomcat/bin/shutdown.sh  
   sleep 10  
   pid=`ps aux | grep tomcat | grep -v grep | grep -v retomcat | awk '{print $2}'`  
   if [ -n "$pid" ]  
   then  
    {  
      sleep 2  
      echo ========kill tomcat begin==============  
      echo $pid  
      kill -9 $pid  
      echo ========kill tomcat end==============  
    }  
   fi  
   sleep 2  
   echo ===========startup.sh==============  
   /usr/local/tomcat/bin/startup.sh  
}  
else  
echo ===========startup.sh==============  
/usr/local/tomcat/bin/startup.sh  
fi
