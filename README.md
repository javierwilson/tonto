tonto, silly IP monitoring
==========================

The basic idea of tonto is you write a list of IP numbers, and tonto does the rest.

What does tonto do?
-------------------

Tonto gets a list of hosts (HOSTS variable) and pings each of them, if a host does
not respond it will send and alert (to EMAIL variable), it will also notify when the
host is responsive again.  It will also keep a log file with this information and
response times (RRT) from ping.

Addionally, if RRDTOOL is available, it will save all this information (RRT and
packet loss, evetually) in an RRD database file, and create a pretty graph every 5
minutes.

How do I install tonto?
-----------------------

Just copy tonto.sh and tonto.config.sh somewhere in your filesyste, for instance
/usr/local/tonto and setup a cron job to run it every minute. See tonto.cron.sample

Also, install RRDTOOL if you want to create the rrdtool graphs.

How do I configure tonto?
-------------------------

You can configure all options in tonto.sh itself, but you better do it in
tonto.config.sh, you basically need to set the array HOSTS with the lists of hosts
you want to monitor, and the EMAIL address you want to get the alerts.

    HOSTS=( server1 server2 example.com example.org )
    EMAIL=bob@example.com

Other options available include ping deadline, ping packet count, etc.
