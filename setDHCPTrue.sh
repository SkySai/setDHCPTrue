#!/bin/bash

auth="admin:admin"

if [ "$#" -eq 1 ]; then
    ip=$1
elif [ "$#" -eq 2 ]; then
    auth=admin:$1
    ip=$2
else
    echo "USAGE: setSipDetails [auth] ip"
    echo "auth: specify username and password when non default (admin:admin) include the colon to separate the username from the password"
    echo "ip: specify endpoint IP address"
    exit 1
fi

./getNetwork.sh $ip

#port=1
dhcp="true"
address=""
netmask=""

broadcast=""

gateway=""
vlan=$(cat tempNetwork.txt | awk '{print $16}' | awk -F '\' '{print $1}')
#vlan=5
#echo $vlan



#echo "AUTH is ${auth}"
b64auth=$(echo -n ${auth} | base64)
#echo "IP is ${ip}"

session=$( curl -H "Authorization: LSBasic ${b64auth}" -H "Content-Type: application/json" http://$ip/rest/new | awk -F\" '/session/ { print $4 }' )
#echo "SESSION is ${session}"

curl -X POST -H "Authorization: LSBasic ${b64auth}" -H "Content-Type: application/json" -d "{\"call\":\"SysAdmin_setNetworkConfig\",\"params\" :  {\"json\": '[{\"ifnum\":0,\"dhcp\":\"true\",\"address\":"",\"netmask\":"",\"broadcast\":"",\"gateway\":"",\"vlan\":$vlan}]'}  }" http://${ip}/rest/request/${session} 
#curl -X POST -H "Authorization: LSBasic ${b64auth}" -H "Content-Type: application/json" -d "{\"call\":\"SysAdmin_setNetworkConfig\",\"params\":{\"json\":{\"port\":${port},\"dhcp\"":"\"${dhcp}\",\"address\":\"${address}\",\"netmask\":\"${netmask}\",\"broadcast\":\"${broadcast}\",\"gateway\":\"${gateway}\",\"vlan\":\"${vlan}\"}}}" http://${ip}/rest/request/${session} 


#curl -H "Authorization: LSBasic ${b64auth}" -X POST -H "Content-Type: application/json" -d '{"call":"SysAdmin_setNetworkConfig","params":{"json":{"port":${port},"dhcp"":""${dhcp}","address":"${address}","netmask":"${netmask}","broadcast":"${broadcast}","gateway":"${gateway}","vlan":"${vlan}"}}}' http://${ip}/rest/request/${session} 


#{"call":"SysAdmin_setNetworkConfig","params" :  {"json": '[{"ifnum":0,"port":1,"dhcp":true,"address":"174.46.3.70","netmask":"255.255.255.225","broadcast":"1.1.1.1","gateway":"174.46.3.65","vlan":5}]'}  }