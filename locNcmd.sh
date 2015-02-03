#!/bin/bash 
fhout="/tmp/newlocout"
fhlog="/tmp/newlocoutlog"
access_token="279820581.111aee2.123123"
counter=0

function doNLoc {
  tmpRes=$(( $2 + 1 ))
  counter=$(( counter + 1 ))
  echo "$1 and $2 and $3 and c $counter a $tmpRes" >> $fhlog
  if [ $counter == 1 ]; then
    res=`curl -s https://api.instagram.com/v1/locations/$3/media/recent?access_token=$access_token`
  else
    res=`curl -s https://api.instagram.com/v1/locations/$3/media/recent?access_token=$access_token\&max_id=$2\&next_max_id=$2`
  fi
  echo $cmd >> $fhlog
  if [ $tmpRes -gt 0 ]; then
    echo $res | python -mjson.tool | jq ".data"  > ${fhout}_${counter}
    mres=`echo $res | python -mjson.tool | jq "${1}" | sed 's/"//g'`
    echo "NEXT $mres" >> $fhlog
  doNLoc $1 $mres $3
  else
    echo "done .."
  fi
}

doNLoc $1 $2 $3
