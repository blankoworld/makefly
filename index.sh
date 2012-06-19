#!/usr/bin/env sh

file=$1
element=`cat "template/element.xhtml"`
htmlfile=`echo ${file}|sed -e "s|.mk$|.xhtml|"`

echo "Using ${file} dbfile."

. "db/${file}"
echo ${element} |sed -e "s|@@TITLE@@|${TITLE}|"|sed -e "s|@@DATE@@|${DATE}|"|sed -e "s|@@FILE@@|${htmlfile}|" >> "tmp/${file}"
