#!/bin/bash

#set defaults
configfile="./config"
dropboxUploader=dropbox_uploader.sh
url=""
filename=""
dir=""

while getopts "c:u:f:d:" optname
do
  case "$optname" in
    "c")
      configfile=$OPTARG
      ;;
    "u")
      url=$OPTARG
      ;;
    "f")
      filename=$OPTARG
      ;;
    "d")
      dir=$OPTARG
      ;;
  esac
done

source ${configfile}


if [ -z "$url" ]
then
  echo "Give URL to calendar with param -u"
  exit 1
fi

if [ -z "$filename" ]
then
  echo "Give output filename prefix with param -f"
  exit 1
fi

if [ -z "$dir" ]
then
  echo "Give Dropbox dir with param -d"
  exit 1
fi

#check wheter dropbox uploader is executable
if ! which ${dropboxUploader} 1>/dev/null 2>/dev/null; then
  echo "dropbox command <${dropboxUploader}> not found or not executable"
  exit 1
fi


outfile=${filename}"_"`date +"%Y%m%d"`".ics"

wget -O "/tmp/${outfile}" ${url}

${dropboxUploader} upload /tmp/${outfile} "${dir}/${outfile}"

rm /tmp/${outfile}

