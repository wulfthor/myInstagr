#!/usr/bin/bash

curl https://api.instagram.com/v1/locations/search?client_id=123123123123\&lat=55.68889\&lng=12.57844 -s | python -mjson.tool | jq '.data | {id: .[].id, name: .[].name}' | perl -p -e 's/,\n/,/g' | egrep -i 'smk|mus' | awk '{print $2}' | sed -e  's/"\([0-9]*\)",/\1/p' | sort | uniq > runLocs
