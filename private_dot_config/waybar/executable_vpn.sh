#!/usr/bin/sh
VPN=$(nmcli connection show --active | grep -e wireguard -e Prisjakt |
      cut -d ' ' -f1 | tr '[:upper:]' '[:lower:]')
if [ -z "$VPN" ]; then
  echo -e "{\"text\":\"<span color='#ff5370'>  no vpn</span>\"}"
else
  echo -e "{\"text\":\"<span color='#7cd380'>  $VPN</span>\"}"
fi
