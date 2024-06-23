#!/bin/bash

while true
do
  echo "[`date`] Monitoring..."
  DATA=$(curl $WG_EASY_URL/api/wireguard/client --header "Authorization: $WG_EASY_UI_PASSWORD" | jq '.[] | [.id,.latestHandshakeAt] | @csv' | tr -d '"\\')

  for line in $(echo -e "$DATA");do
    CLIENT=$(echo $line | cut -d ',' -f 1)
    CURRENT_TIMESTAMP=$(date +%s)
    HANDSHAKE_DATA=$(echo -n $line | cut -d ',' -f 2)
    if [ "$HANDSHAKE_DATA" != "" ]; then
      HANDSHAKE_TIMESTAMP=$(date -d "$HANDSHAKE_DATA" +%s)
      ((DIFF=$CURRENT_TIMESTAMP-$HANDSHAKE_TIMESTAMP))
      if [ $DIFF -ge 300  ]; then
        curl -X POST --header "Authorization: $WG_EASY_UI_PASSWORD" "$WG_EASY_URL/api/wireguard/client/$CLIENT/disable"
        sleep 5
        curl -X POST --header "Authorization: $WG_EASY_UI_PASSWORD" "$WG_EASY_URL/api/wireguard/client/$CLIENT/enable"
      fi
    fi
  done
  sleep 10
done