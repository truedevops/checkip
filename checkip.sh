#!/bin/bash
HOST_PATH=/etc/hosts
string=`grep 'myhost' $HOST_PATH`


ip=`wget -qO - icanhazip.com`
op=`wget -qO - http://ipecho.net/plain ; echo`
tp=`wget -qO - 2ip.ru|egrep -m 1 -o "([0-9]+\.){3}[0-9]+"`
np=`wget -qO - ip.ru|egrep -m 1 -o "([0-9]+\.){3}[0-9]+"`
lp=`wget -qO - http://formyip.com/ | awk '/The/{print $5}'`
jp=`wget -qO - http://checkip.dyndns.com/ | awk '{print $6}' | sed 's/<.*>//'`

for variable in $ip $op $tp $np $lp $jp
do
    if  [[ $variable =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
        then
break
fi
done
   if [[ $string = '' ]];then
   echo "$variable myhost" >> $HOST_PATH
   exit 0
   fi
     b=$(grep myhost $HOST_PATH | grep -oE '\b[0-9]{1,3}(\.[0-9]{1,3}){3}\b')
     if [ $variable != $b ]
          then
            sed -i "s/$string/$variable myhost/g" $HOST_PATH
	    c=$(grep 'myhost' $HOST_PATH | grep -oE '\b[0-9]{1,3}(\.[0-9]{1,3}){3}\b')
   exit
     fi
       echo "'$variable' myhost" | mail -s "IP-Address" Zhora3tonn@ukr.net
