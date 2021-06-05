#!/bin/bash

MAX_AVG_ALLOWED=2000

jq '.servers[] | select(.checkit=="true") | .ip' -r server-list.json | while read line || [[ -n $line ]];
do

  PING_AVG=$({ ping -c 3 -W 5 $line || echo 'ping-failed min/avg/max/stddev = -1/-1/-1/-1 ms'; } | tail -1 | awk '{print $4}' | cut -d '/' -f 2)

  if ! [ -z $PING_AVG ]; then
    if [ "${PING_AVG}" -eq -1 ] || [ "${PING_AVG}" -gt "${MAX_AVG_ALLOWED}" ]; then
      echo "[WARNING] HOST(${line}): $PING_AVG"
      curl -X POST https://pruu.herokuapp.com/dump/:server-monitor -d 'msg=warning' -d "ip=${line}" -d "avg=${PING_AVG}" &> /dev/null
    else
      echo "[INFO] HOST(${line}): $PING_AVG"
    fi
  else
    echo "[ERROR] PING AVG value not valid!"
  fi

done

