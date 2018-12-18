#!/bin/bash

dropboxUploader=~/Dropbox-Uploader/dropbox_uploader.sh

if [ -z "$1" ]
then
  echo "Give URL to calendar as first param"
  exit 1
fi

if [ -z "$2" ]
then
  echo "Give output name as second param"
  exit 1
fi

if [ -z "$3" ]
then
  echo "Give Dropbox dir as third param"
  exit 1
fi

outfile=${2}"_"`date +"%Y%m%d"`".ics"

wget -O "/tmp/${outfile}" $1

${dropboxUploader} upload /tmp/${outfile} "${3}/${outfile}"

rm /tmp/${outfile}

