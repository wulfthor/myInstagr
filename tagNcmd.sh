#!/bin/bash


#/tagNcmd .pagination.next_max_id 0 smkmuseum

fhout="/tmp/newtagout"
fhlog="/tmp/newtagoutlog"
access_token="279820581.111aee2.123123"
counter=0

function doNTag {
  tmpRes=$(( $2 + 1 ))
  counter=$(( counter + 1 ))
  echo "$1 and $2 and $3 and c $counter a $tmpRes" >> $fhlog
  if [ $counter == 1 ]; then
    res=`curl -s https://api.instagram.com/v1/tags/$3/media/recent?access_token=$access_token\&count=1000`
  else
    res=`curl -s https://api.instagram.com/v1/tags/$3/media/recent?access_token=$access_token\&count=1000\&max_tag_id=$2`
  fi
  if [ $tmpRes -gt 1 ]; then
    echo $res | python -mjson.tool | jq ".data"  > ${fhout}_${counter}
    mres=`echo $res | python -mjson.tool | jq "${1}" | sed 's/"//g'`
    echo $mres >> $fhlog
  doNTag $1 $mres $3
  else
    echo "done .."
  fi
}

doNTag $1 $2 $3
