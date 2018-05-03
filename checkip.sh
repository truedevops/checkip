#!/bin/bash
HOST_PATH=/etc/hosts
string=`grep 'myhost' $HOST_PATH`
OLD_VARIABLE=$(grep myhost $HOST_PATH | grep -oE '\b[0-9]{1,3}(\.[0-9]{1,3}){3}\b')

# Get ip-adcdress
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
   echo "$variable myhost" >> $HOST_PATH && echo "Added the new string into the file '/etc/hosts': "$variable myhost"" 2>&1|perl -e "while(<>){s/^/`date`  /g; print;}" >>/var/log/myhostip.log
   exit 0
   fi
     if [ $variable != $OLD_VARIABLE ]
          then
            sed -i "s/$string/$variable myhost/g" $HOST_PATH
echo "old ip-address: "$OLD_VARIABLE 2>&1|perl -e "while(<>){s/^/`date`  /g; print;}" >>/var/log/myhostip.log
echo "new ip-address: "$variable 2>&1|perl -e "while(<>){s/^/`date`  /g; print;}" >>/var/log/myhostip.log
   exit
     fi

