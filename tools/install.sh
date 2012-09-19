#!/usr/bin/env sh

# install.sh

# Copy pub directory to user's public_html

SRCDIR=../pub
<<<<<<< HEAD:tools/install.sh
DESTDIR=../www
=======
DESTDIR=${HOME}/public_html
>>>>>>> master:tools/install.sh

process() {
  rm -rf ${DESTDIR}/* && cp -r ${SRCDIR}/* ${DESTDIR} && echo "...installed!"
}

echo "INSTALL to ${DESTDIR}..."

if ! test -d ${SRCDIR}
then
  echo "${SRCDIR} directory not found!"
  exit 1
fi

if ! test -d ${DESTDIR}
then
  echo "${DESTDIR} directory not found!"
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
