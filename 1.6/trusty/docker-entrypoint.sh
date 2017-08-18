#!/bin/bash

# Defaults
OSRM_DATA_PATH=${OSRM_DATA_PATH:="/osrm-data"}
OSRM_DATA_LABEL=${OSRM_DATA_LABEL:="data"}
OSRM_GRAPH_PROFILE=${OSRM_GRAPH_PROFILE:="car"}
OSRM_PBF_URL=${OSRM_PBF_URL:="http://download.geofabrik.de/asia/maldives-latest.osm.pbf"}


_sig() {
  kill -TERM $child 2>/dev/null
}
trap _sig SIGKILL SIGTERM SIGHUP SIGINT EXIT


# Retrieve the PBF file
curl $OSRM_PBF_URL --create-dirs -o $OSRM_DATA_PATH/$OSRM_DATA_LABEL.osm.pbf

# Build the graph
osrm-extract $OSRM_DATA_PATH/$OSRM_DATA_LABEL.osm.pbf -p /osrm-profiles/$OSRM_GRAPH_PROFILE.lua
osrm-contract $OSRM_DATA_PATH/$OSRM_DATA_LABEL.osrm

# Start serving requests
osrm-routed $OSRM_DATA_PATH/$OSRM_DATA_LABEL.osrm --max-table-size 1000 &
child=$!
wait "$child"
