#!/usr/bin/env sh

# install.sh

# Copy pub directory to user's public_html

SRCDIR=../pub
DESTDIR=`grep INSTALLDIR ../makefly.rc|cut -d'=' -f 2|sed -e "s/^ //g"`

process() {
  rm -rf ${DESTDIR}/* && cp -r ${SRCDIR}/* ${DESTDIR} && echo "...installed!"
}

if [ -z "$DESTDIR" ]; then
  echo "No DESTDIR found. Please add DESTDIR= in your makefly.rc"
  exit 1
fi

echo "INSTALL to ${DESTDIR}..."

if ! test -d ${SRCDIR}
then
  echo "${SRCDIR} directory not found!"
  exit 1
fi

if ! test -d ${DESTDIR}
then
  echo "${DESTDIR} directory not found!"
  exit 1
fi

echo "This will delete ${DESTDIR} content and copy ${SRCDIR} into. Are you sure [y/n]?"
read response
if [ "${response}" = "y" ]
then
  process
  exit 0
elif [ "${response}" = "Y" ]
then
  process
  exit 0
else
  exit 1
fi
