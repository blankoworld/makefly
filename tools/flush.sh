#!/usr/bin/env bash

# flush.sh

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
