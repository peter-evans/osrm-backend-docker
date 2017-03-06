#!/bin/bash

WFH_TIMEOUT=600
WFH_ELAPSED=0

echo "Waiting for a response from http://$1:$2"

until $(curl --output /dev/null --silent --head --fail http://$1:$2); do
    sleep 5
    WFH_ELAPSED=$((WFH_ELAPSED+5))
    if [ "$WFH_ELAPSED" -gt "$WFH_TIMEOUT" ]; then
    	echo "Timed out waiting for a response from http://$1:$2"
    	exit 1
    fi
done

echo "Received response from http://$1:$2"
exit 0
