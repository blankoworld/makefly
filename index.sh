#!/usr/bin/env sh

file=$1
element=`cat "template/element.xhtml"`

echo "SCRIPT ${file}"

. "db/${file}"
echo ${element} |sed -e "s/\@\@TITLE\@\@/${TITLE}/" >> "tmp/${file}"
