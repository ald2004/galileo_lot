#!/bin/bash
# Run your process in background
echo "Start ppp-on..." >> /tmp/testtemp.log
/bin/ppp-on >> /tmp/testtemp.log 2>&1 &
echo "Ppp started ..." >> /tmp/testtemp.log
echo "connmanctl scan wifi" >> /tmp/testtemp.log
#connmanctl scan wifi
#sleep 20
echo "connmanctl connect wifi_001500651f0f_653031323032_managed_psk" >> /tmp/testtemp.log
nohup connmanctl connect wifi_001500651f0f_653031323032_managed_psk >> /tmp/testtemp.log 2>&1
#sleep 20
echo "connected to wifi" >> /tmp/testtemp.log
#sleep 20
echo "Start data transport ..."  >> /tmp/testtemp.log
pushd ~
nohup quickstart 2>&1 &
echo "data transport started." >> /tmp/testtemp.log
echo "addroute..." >> /tmp/testtemp.log
/sbin/route add -net 192.168.8.0/24 gw 192.168.8.1 metric 10 dev enp0s20f6
/sbin/route add -net 192.168.8.0/24 gw 192.168.8.1 metric 15 dev wlp1s0
/sbin/route add -net default metric 1 dev ppp0
echo "route added." >> /tmp/testtemp.log

# Check if the services started successfully 
if ! kill -0 $! 2>/dev/null; then
    # Return 1 so that systemd knows the service failed to start
    exit 1
fi
