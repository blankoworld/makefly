#!/usr/bin/env bash

#####
## VARIABLES
###

DBDIR=`cat Makefile |grep "^DBDIR[ ]*="|cut -d'=' -f2`
SRCDIR=`cat Makefile |grep "^SRCDIR[ ]*="|cut -d'=' -f2`
LIMIT='255'

#####
## TEST
###

if ! test -d ${DBDIR};then
  echo "Database directory is missing! It's useful for posts data."
  exit 1
elif ! test -d ${SRCDIR};then
  echo "Source directory is missing! It's useful for posts."
fi

#####
## BEGIN
###

# Fetch data
read -p "Title: " title
read -p "Description: " desc
read -p "Date: " date
timestamp=`date +'%s'`

# code retrived from Nanoblogger translit_text method with a little improvement for double "_"
nonascii="${title//[a-zA-Z0-9_-]/}" # isolate all non-printable/non-ascii characters
new_name=$(echo "${title:0:$LIMIT}" |sed -e "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/; s/[\`\~\!\@\#\$\%\^\*\(\)\+\=\{\}\|\\\;\:\'\"\,\<\>\/\?]//g; s/ [\&] / and /g; s/^[ ]//g; s/[ ]$//g; s/[\.]/_/g; s/\[//g; s/\]//g; s/ /_/g; s/[$nonascii ]/_/g" |sed -e '/[\_\-]*$/ s///g; /[\_\-]$/ s///g' |sed -e 's/__/_/g')

# db filename
dbfile="${DBDIR}/${timestamp},${new_name}.mk"
echo ${dbfile}
# filename
file="${SRCDIR}/${new_name}.md"
# test that files doesn't exists
if test -f ${dbfile};then
  echo "This post already exists: '${title}'"
  exit 1
elif test -f ${file};then
  echo "This post already exists: '${title}'"
  exit 1
fi

# create db file
echo "TITLE=\"${title}\"" > ${dbfile}
echo "DESCRIPTION=\"${desc}\"" >> ${dbfile}
echo "DATE=\"${date}\""

# create src file
echo "# ${title}" >> ${file}
echo "" >> ${file}
echo "Type your text in markdown format here" >> ${file}
vi ${file}

#####
## END
###

exit 0
