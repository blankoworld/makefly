#!/usr/bin/env bash

# migrate_domain_from.sh
#
# Migrate all DB files from an old domain to be used in new one

#####
## LICENSE
###

# Makefly, a static weblog engine using a BSD Makefile
# Copyright (C) 2013 DOSSMANN Olivier
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

#####
## TEST
###

if [ -z "$DBDIR" ]; then
  echo "No database directory found. Please use 'migratefrom' command"
  exit 1
fi

if ! test -d ${DBDIR};then
  echo "Database directory is missing! It's useful for posts data."
  exit 1
fi

if test $# -ne 1
then
  echo "Should have ONLY ONE parameter: old domain name. Those from which you come."
  exit 1
fi

domain=$1

#####
## BEGIN
###

for f in `ls ${DBDIR} |grep -E '*.mk$'`; do
  jskomment=`grep 'JSKOMMENT_PREFIX' ${DBDIR}/${f}`
  if [ -z "$jskomment" ]; then
    # JSKOMMENT_PREFIX not present => Add new one
    echo "JSKOMMENT_PREFIX = ${domain}" >> ${DBDIR}/${f}
    echo "$f: domain added"
  else
    # Check if variable is empty or not
    content=`echo "$jskomment" | sed -e 's#JSKOMMENT_PREFIX.*= *\(.*\)$#\1#g'`
    if [ -z "$content" ]; then
      # variable empty, update existing variable in DB file
      sed -i 's#\(JSKOMMENT_PREFIX\).*#\1 = $domain#g' ${DBDIR}/${f}
      echo "$f: domain updated"
    else
      echo "$f: NO changes"
    fi
  fi
done

#####
## END
###

exit 0
