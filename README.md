# simple\_wpa
A barebones script for connecting to a wireless access point using
wpa\_supplicant, without needing to write a configuration file.

This script creates the same configuration as the first example of the
wpa\_supplicant.conf(5) manpage. It will work for most basic home networks
secured with WPA

Requirements:
- root privileges (for setting up interface)
- wpa\_supplicant and wpa\_cli (for wireless link)
- dhclient (for obtaining IP address automatically)

Usage: ./simple\_wpa.sh ssid device
