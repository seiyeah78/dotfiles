#!/bin/sh

airport_path="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

if air_info=($(eval "$airport_path" -I | grep -E "^ *(agrCtlRSSI|state|SSID):" | awk '{print $2}')) ; then

  rssi=${air_info[0]}
  state=${air_info[1]}
  ssid=${air_info[2]}

  case "$state" in
    "running" )
      signals=(▁ ▂ ▄ ▆ █)
      signal=""
      rssi_=$(expr 5 - ${rssi} / -50)
      for ((i=0; i < $rssi_; i++ )); do
        signal="${signal}${signals[$i]}"
      done
      airport_="${ssid} ${signal} "
    ;;
    "init"    ) airport_=" ... " ;;
    *         ) airport_="#[fg=red] nowifi ✘  " ;;
  esac
    echo "${airport_}"
fi
