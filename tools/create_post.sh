#!/usr/bin/env bash

# create_post.sh
#
# Permit to create a new post for Makefly

#####
## LICENSE
###

# Makefly, a static weblog engine using a BSD Makefile
# Copyright (C) 2012 DOSSMANN Olivier
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#####
## VARIABLES
###
LIMIT='255'
YOUR_EDITOR=`which nano`
QUIET=0

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

if test $# -gt 0;then
  if test "$1" == "-q";then
    QUIET=1
  fi
fi

#####
## BEGIN
###

# Fetch data
while [ -z "$author" ]; do
  read -p "Author: " author
done
while [ -z "$title" ]; do
  read -p "Title: " title
done
read -p "Description: " desc
while [ -z "$tags" ]; do
  read -p "Tags (use comma as separator): " tags
done
read -p "Type (normal, special, news, etc.): " post_type
read -p "Keywords: " keywords
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
echo "TITLE = ${title}" > ${dbfile}
echo "DESCRIPTION = ${desc}" >> ${dbfile}
echo "TAGS = ${tags}" >> ${dbfile}
echo "TYPE = ${post_type}" >> ${dbfile}
echo "AUTHOR = ${author}" >> ${dbfile}
echo "KEYWORDS = ${keywords}" >> ${dbfile}

# create src file
touch ${file}
echo "Type your text in markdown format here" > ${file}

if test "$QUIET" -eq 0;then
  ${edit} ${file}
elif ! [ -z "$content" ]; then
  echo -e "$content" > ${file}
fi

# confirm file creation
echo "Post: ${file}"

#####
## END
###

exit 0
