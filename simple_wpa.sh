#!/bin/bash

# A barebones script for connecting to a wireless access point using
# wpa_supplicant, without needing to write a configuration file.

# This script creates the same configuration as the first example of the
# wpa_supplicant.conf(5) manpage. It will work for most basic home networks
# secured with WPA

# Requirements:
# - root privileges (for setting up interface)
# - wpa_supplicant and wpa_cli (for wireless link)
# - dhclient (for obtaining IP address automatically)

# Usage: ./simple_wpa.sh ssid device

ssid="$1"
IF="$2"

if [[ -z "$ssid" || -z "$IF" ]]
then
  echo "Usage: ./simple_wpa.sh ssid device"
  exit
fi

echo "Killing wpa_supplicant..."
pkill wpa_supplicant

echo "Setting device up..."
ip link set $IF up

read -s -p "Enter wpa psk: " pass

wpa_supplicant -B -i$IF -C/var/run/wpa_supplicant -P/var/run/wpa_supplicant.pid

wpa_cli -i $IF add_network
wpa_cli -i $IF set_network 0 key_mgmt WPA-PSK
wpa_cli -i $IF set_network 0 scan_ssid 1
wpa_cli -i $IF set_network 0 ssid \"$ssid\"
wpa_cli -i $IF set_network 0 psk \"$pass\"
wpa_cli -i $IF select_network 0
wpa_cli -i $IF reassociate

echo "Getting IP with dhclient..."
dhclient -x $IF
dhclient $IF

echo "Done!"
