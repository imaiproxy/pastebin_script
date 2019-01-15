#!/bin/sh


CMDNAME=`basename $0`

#get data from exist file
err_msg="Usage: $CMDNAME [-e api_paste_expire_date] [-f api_paste_format] [-t api_paste_name] <filename>"
format="text"
api_key="###your api_dev_key ###"
title="Untitled"
expire_date="N"

while getopts e:f:t:h OPT
do
	case $OPT in
		"e" ) expire_date="$OPTARG" ;;
		"f" ) format="$OPTARG" ;;
		"t" ) title="$OPTARG" ;;
		"h" ) echo ${err_msg}
			exit 0 ;;
		* ) echo ${err_msg} 1>&2
          exit 1 ;;
  esac
done
shift `expr $OPTIND - 1`
if [ $# -lt 1 ]; then
	echo ${err_msg} 1>&2
	exit 1 
fi
INPUT="$(<./$1)"

querystring="api_paste_code=${INPUT}&api_option=paste&api_dev_key=${api_key}&api_paste_format=${format}&api_paste_name=${title}&api_paste_expire_date=${expire_date}"

#post data to pastebin.com API
curl -w '\n' -X POST -d "${querystring}" http://pastebin.com/api/api_post.php
