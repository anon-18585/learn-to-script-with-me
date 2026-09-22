#!/usr/bin/env bash

set -euo pipefail

firewallrules=(
    'deny - default - incoming'
    'allow - default - outgoing'
    'allow 53317/tcp/udp - local only - for localsend'
    'allow 27036/tcp/udp - local only - for Steam local'
    'deny 3389/tcp/udp - anywhere - for Remote Desktop Protocol (RDP)'
    'deny 4000/tcp/udp - anywhere - for RemoteAnything/Terabase'
    'deny 12345/tcp/udp - anywhere - for NetBus'

)

echo "This Script will setup the following rules for The Uncomplicated Firewall (UFW) : "
printf ' - %s\n' "${firewallrules[@]}"
echo

read -r -p "Continue with the setup? [y/n]" answer

case "$answer" in
  [Yy]|[Yy][Ee][Ss])
    ;;
  [Nn]|[Nn][Oo])
    echo " Setup exited. "
    echo " No changes were made. "
    echo
    exit 0
    ;;

  *)
    echo " Invalid input. "
    echo " Setup exited. "
    echo " No changes were made. "
    echo
    exit 1
esac

echo " Configuring UFW rules..."

# Block all incoming traffic by default
sudo ufw default deny incoming
# Allow all outgoing traffic by default
sudo ufw default allow outgoing

# Allow local steam network traffic
sudo ufw allow from 192.168.8.0/24 to any port 27036 proto tcp
sudo ufw allow from 192.168.8.0/24 to any port 27036 proto udp

# Allow localsend traffic
sudo ufw allow from 192.168.8.0/24 to any port 53317 proto tcp
sudo ufw allow from 192.168.8.0/24 to any port 53317 proto udp

# deny Remote Desktop Protocol (RDP)
sudo ufw deny from any to any port 3389 proto tcp
sudo ufw deny from any to any port 3389 proto udp

# deny RemoteAnything/Terabase
sudo ufw deny from any to any port 4000 proto tcp
sudo ufw deny from any to any port 4000 proto udp

# deny NetBus
sudo ufw deny from any to any port 12345 proto tcp
sudo ufw deny from any to any port 12345 proto udp


#activation on system startup followed by a reload
sudo ufw --force enable
sudo ufw reload

echo
echo " UFW's setup & rules successfully configured. "
