#!/bin/bash

#
# silly ip monitoring
#

# read IP numbers from tonto.config.sh
source `dirname $0`/tonto.config.sh

# loop
for ip in "${IPS[@]}"; do
	ping -c 1 $ip 1>/dev/null
	rc=$?
	if [ $rc = 0 ]; then
		rc_str="OK"
		if [ -f $TMP/$ip.down ]; then
			echo "$ip OK" | mail -s "$ip OK" "$EMAIL"
			rm $TMP/$ip.down
		fi
		touch $TMP/$ip.up
	else
		rc_str="FAILED"
		if [ -f $TMP/$ip.up ]; then
			"$ip DOWN" | mail -s "$ip DOWN" "$EMAIL"
			rm $TMP/$ip.up
		fi
		touch $TMP/$ip.down
	fi
	echo $ip $rc_str
done


