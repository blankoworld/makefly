#!/usr/bin/env bash
#
# publish.sh
#
# Command that send your blog/website to the public area

rsync -a --partial --delete ${DESTDIR}/ ${PUBLISH_DESTINATION}/
