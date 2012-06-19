#!/usr/bin/env sh

file=$1
element=`cat "template/element.xhtml"`
htmlfile=`echo ${file}|sed -e "s|.mk$|.xhtml|"|sed -e "s|^.*,||"`
timestamp=`echo ${file}|cut -d ',' -f 1`
timestampdate=`date -d "@${timestamp}" +'%Y-%m-%d %H:%M:%S'`

echo "Using ${file} dbfile."

. "db/${file}"
echo ${element} |sed -e "s|@@TITLE@@|${TITLE}|"|sed -e "s|@@DATE@@|${timestampdate}|"|sed -e "s|@@FILE@@|${htmlfile}|" >> "tmp/${file}"
