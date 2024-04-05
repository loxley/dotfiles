#!/usr/bin/sh
VPN=$(nmcli connection show --active | grep -e wireguard -e Prisjakt |
      cut -d ' ' -f1 | tr '[:upper:]' '[:lower:]')
if [ -z "$VPN" ]; then
  echo "{\"text\":\"  no vpn\"}"
else
  echo "{\"text\":\" $VPN\"}"
fi
