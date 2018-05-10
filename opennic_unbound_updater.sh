#!/bin/bash

###############################

TMP_FILE="/tmp/opennic_unbound_updater.tmp"
UNBOUND_CONF_FILE="/etc/unbound/unbound.conf"
API_REQUEST="https://api.opennicproject.org/geoip/?list&ipv=all&res=200&pct=95&adm=2&anon=true"

###############################

curl $API_REQUEST > $TMP_FILE

if [  $? -ne 0 ]
then
    exit 1
fi

###############################

cat > $UNBOUND_CONF_FILE <<EOF

server:
  interface: 0.0.0.0
  access-control: 10.0.0.0/24 allow
  use-syslog: yes
  do-not-query-localhost: no
  forward-zone:
    name: "."

EOF

###############################

cat $TMP_FILE | while read line
do
    echo "    forward-addr: ${line}" >> $UNBOUND_CONF_FILE
done

rm -f $TMP_FILE

###############################

cat >> $UNBOUND_CONF_FILE <<EOF

    # OpenNIC IPv4 nameservers (Worldwide Anycast)
    forward-addr: 185.121.177.177
    forward-addr: 185.121.177.53

    # OpenNIC IPv6 nameservers (Worldwide Anycast)
    forward-addr: 2a05:dfc7:5::53
    forward-addr: 2a05:dfc7:5::5353
EOF

###############################

systemctl restart unbound
