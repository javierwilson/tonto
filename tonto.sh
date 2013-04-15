#!/bin/bash

#
# silly ip monitoring
#

LOG=/var/log/tonto
IPS=( server1 server2 printer1 printer2 )
EMAIL="root@example.com"
PING_BIN=/usr/bin/ping
PING_COUNT=1

# read IP numbers from tonto.config.sh
source `dirname $0`/tonto.config.sh
mkdir -p $LOG

# loop
for ip in "${IPS[@]}"; do
	date=`date +%Y%m%d%H%M%S`
	rt=`$PING_BIN -c $PING_COUNT $ip | tail -1| awk -F '/' '{print $5}'`
	rc=$?
	echo "$ip RC = $rc RT = $rt"
	if [ $rc = 0 ]; then
		rc_str="OK"
		if [ -f $LOG/$ip.down ]; then
			echo "$ip OK" | mail -s "$ip OK" "$EMAIL"
			rm $LOG/$ip.down
		fi
		touch $LOG/$ip.up
	else
		rc_str="FAILED"
		if [ -f $LOG/$ip.up ]; then
			echo "$ip DOWN" | mail -s "$ip DOWN" "$EMAIL"
			rm $LOG/$ip.up
		fi
		touch $LOG/$ip.down
	fi
	echo "$date $ip $rc $rt" >> $LOG/tonto.log
	logger "$date $ip $rc_str $rt"
done


