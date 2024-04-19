#!/bin/bash

disk=$1

convert_bytes() {
    bytes=$1
    if [ $bytes -ge 1073741824 ]; then
        echo "$(( bytes / 1073741824 ))GB"
    elif [ $bytes -ge 1048576 ]; then
        echo "$(( bytes / 1048576 ))MB"
    elif [ $bytes -ge 1024 ]; then
        echo "$(( bytes / 1024 ))KB"
    else
        echo "${bytes} bytes"
    fi
}

number=$(curl -s 'http://foobar.loxley.se:9100/metrics' | grep node_filesystem_free_bytes | grep $disk | cut -d ' ' -f2)
stripped_number=$(printf "%.0f" "$number")
converted=$(convert_bytes $stripped_number)

if [ "$(echo "$converted" | grep -oE '[0-9]+')" -lt 50 ]; then
  echo "{\"text\":\"<span color='#ff5370'>  $disk $converted free</span>\"}"
fi
