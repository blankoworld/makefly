#!/usr/bin/env bash

# flush.sh
#
# Permit to drop all files from DB and SRC directories

#####
## LICENSE
###

# Makefly, a static weblog engine using Lua
# Copyright (C) 2012-2015 DOSSMANN Olivier, <olivier+makefly@dossmann.net>
#
# This file is part of Makefly.
# 
# Makefly is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# Makefly is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


files=`ls ../src/`
dbfiles=`ls ../db/`
RM_OPT='-f'
if ! [ -z "$files" ]; then
  rm $RM_OPT ../src/*
  echo "Files from 'src' directory deleted successfully"
else
  echo "No files found!"
fi

if ! [ -z "$dbfiles" ]; then
  rm $RM_OPT ../db/*
  echo "Files from 'db' directory deleted successfully"
else
  echo "No DB files found!"
fi

exit 0
