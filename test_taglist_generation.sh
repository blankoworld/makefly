#!/usr/bin/env bash

DBFILES=`ls ./db|grep -v tags.list`

for el in ${DBFILES}; do
  echo "Reading ${el}…"
  . db/${el}
  for tag in `echo ${TAGS}|sed -e 's/,/ /g'`; do
      echo ${tag} >> tmp/taglist.tag
      echo "${el}"|cut -d ',' -f2|sed -e 's/.mk$//g' -e "/$/{s/$/:${TITLE}/}" >> tmp/${tag}.tag
  done
done

cat tmp/taglist.tag |sort -u
cat tmp/test.tag
ls tmp/
rm tmp/* -rf
