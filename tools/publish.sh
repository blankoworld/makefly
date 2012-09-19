#!/usr/bin/env bash
#
# publish.sh

rsync -a --partial --delete ${DESTDIR}/ ${PUBLISH_DESTINATION}/
