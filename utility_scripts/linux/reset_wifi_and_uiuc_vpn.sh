#!/bin/bash

# On my Ubuntu machine, UIUC VPN gets disconnected once in a while.
# It then doesn't reconnect until I restart wifi and then connect to VPN manually again.
# Restarting wifi and connecting to VPN from UI is LOT of clicks and I am a lazy guy.
# This script resets wifi, waits for it come back up and then connects to VPN.

# Restart wifi
sudo service network-manager restart

echo "Wifi restarted. Waiting for it to get connected again."
# Wait for it to get connected again.
while [ `iwgetid | grep -c '.*'` -eq 0 ]; do 
	sleep 2
done

# Connect to VPN
uiuc_vpn_connect.sh

