#!/usr/bin/env bash

#####
## VARIABLES
###

DBDIR=`cat Makefile |grep "^DBDIR[ ]*="|cut -d'=' -f2 |sed -e "s/^ //g"` # sed delete useless space
SRCDIR=`cat Makefile |grep "^SRCDIR[ ]*="|cut -d'=' -f2 |sed -e "s/^ //g"` # sed delete useless space
LIMIT='255'
YOUR_EDITOR=`which nano`
TAGFILELIST="${DBDIR}/tags.list"

#####
## TEST
###

edit=${EDITOR:-$YOUR_EDITOR}

if [ -z "$edit" ]; then
  echo "No editor found! Please config EDITOR in your .bashrc or edit YOUR_EDITOR in '`basename $0`' script."
  exit 1
fi

if ! test -d ${DBDIR};then
  echo "Database directory is missing! It's useful for posts data."
  exit 1
elif ! test -d ${SRCDIR};then
  echo "Source directory is missing! It's useful for posts."
fi

if ! test -f ${TAGFILELIST}; then
  echo "'${TAGFILELIST}' doesn't exists!"
  exit 1
fi

#####
## BEGIN
###

# Fetch data
while [ -z "$title" ]; do
  read -p "Title: " title
done
read -p "Description: " desc
read -p "Date: " date
while [ -z "$tags" ]; do
  read -p "Tags (use comma as separator): " tags
done
timestamp=`date +'%s'`

# code retrived from Nanoblogger translit_text method with a little improvement for double "_"
nonascii="${title//[a-zA-Z0-9_-]/}" # isolate all non-printable/non-ascii characters
new_name=$(echo "${title:0:$LIMIT}" |sed -e "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/; s/[\`\~\!\@\#\$\%\^\*\(\)\+\=\{\}\|\\\;\:\'\"\,\<\>\/\?]//g; s/ [\&] / and /g; s/^[ ]//g; s/[ ]$//g; s/[\.]/_/g; s/\[//g; s/\]//g; s/ /_/g; s/[$nonascii ]/_/g" |sed -e '/[\_\-]*$/ s///g; /[\_\-]$/ s///g' |sed -e 's/__/_/g')

# db filename
dbfile="${DBDIR}/${timestamp},${new_name}.mk"
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
echo "DATE=\"${date}\"" >> ${dbfile}
echo "TAGS=\"${tags}\"" >> ${dbfile}

# Write tags to tag list file
IFS=","
for tag in ${tags}; do
  # delete not wanted chars
  nonasciitag="${tag//[a-zA-Z0-9_-]/}"
  new_tagname=$(echo "${tag:0:$LIMIT}" |sed -e "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/; s/[\`\~\!\@\#\$\%\^\*\(\)\+\=\{\}\|\\\;\:\'\"\,\<\>\/\?]//g; s/ [\&] / and /g; s/^[ ]//g; s/[ ]$//g; s/[\.]/_/g; s/\[//g; s/\]//g; s/ /_/g; s/[$nonasciitag ]/_/g" |sed -e '/[\_\-]*$/ s///g; /[\_\-]$/ s///g' |sed -e 's/__/_/g')
  # search this tag
  findtag=$(grep -E "^${new_tagname}:" ${TAGFILELIST})
  if [ -z "${findtag}" ]; then
    echo "Create new tag: ${new_tagname}"
    echo "${new_tagname}:${new_name}.md" >> ${TAGFILELIST}
  else
    sed "/^${new_tagname}:/{s/$/,${new_name}.md/}" ${TAGFILELIST} > ${TAGFILELIST}.tmp
    mv ${TAGFILELIST}.tmp ${TAGFILELIST}
  fi
done

# create src file
touch ${file}
echo "# ${title}" >> ${file}
echo "" >> ${file}
echo "Type your text in markdown format here" >> ${file}
${edit} ${file}

#####
## END
###

exit 0
