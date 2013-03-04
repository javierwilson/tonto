#!/bin/bash

#
# silly ip monitoring
#

# read IP numbers from tonto.config.sh
source tonto.config.sh

# loop
for ip in "${IPS[@]}"; do
	ping -c 1 $ip 1>/dev/null
	rc=$?
	if [ $rc = 0 ]; then
		rc_str="OK"
		if [ -f $TMP/ip.down ]; then
			mail -s "$ip OK" "$EMAIL" < "$ip OK"
			rm $TMP/$ip.down
		fi
		touch $TMP/$ip.up
	else
		rc_str="FAILED"
		if [ -f $TMP/ip.up ]; then
			mail -s "$ip DOWN" "$EMAIL" < "$ip DOWN"
			rm $TMP/$ip.up
		fi
		touch $TMP/$ip.down
	fi
	echo $ip $rc_str
done


