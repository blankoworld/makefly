#!/usr/bin/env pmake -f
# XXX
markdown ?= markdown
lua ?= lua

# use make Q= to enable the debug mode.
Q ?= @

TMPLDIR = ./template
STYLEDIR = ./style
BINDIR = ./bin

header ?= ${TMPLDIR}/header.xhtml
footer ?= ${TMPLDIR}/footer.xhtml
element ?= ${TMPLDIR}/element.xhtml

SRCDIR  = ./src
DESTDIR = ./pub
DBDIR   = ./db
TMPDIR  = ./tmp

parser ?= ${BINDIR}/parser.lua

FILES != cd ${SRCDIR}; ls
DBFILES != cd ${DBDIR}; ls|sort -r

.include "makefly.rc"

all: ${FILES:S/.md/.xhtml/g:S/^/${DESTDIR}\//} ${DESTDIR}/simple.css ${DESTDIR}/index.xhtml ${DESTDIR}/rss.xml

.for FILE in ${FILES}
TARGET_${FILE} = ${FILE:S/.md$/.xhtml/:S/^/${DESTDIR}\//}
.endfor

.for FILE in ${DBFILES}
TMP_${FILE} = ${FILE:S/^/${TMPDIR}\//}
.endfor

.for FILE in ${FILES}
${TARGET_${FILE}}: ${SRCDIR}/${FILE}
	$Q{ \
		{ \
			cat ${header} | ${lua} ${parser} "BLOGTITLE=${BLOGTITLE}" "BASEURL=${BASEURL}" "HOMETITLE=${HOMETITLE}" && \
			${markdown} ${SRCDIR}/${FILE}  && \
			cat ${footer}                   ; \
		} > ${TARGET_${FILE}} || { \
			rm -f ${TARGET_${FILE}}                           ; \
			echo "-- Error while building ${TARGET_${FILE}}." ; \
			false                                             ; \
		} ; \
	} && echo "-- Page built: ${TARGET_${FILE}}."
.endfor

.for FILE in ${DBFILES}
.include "${DBDIR}/${FILE}"
TITLE_${FILE} != echo ${TITLE}
TMSTMP_${FILE} != echo ${FILE}| cut -d ',' -f 1
POSTDATE_${FILE} != date -d "@${TMSTMP_${FILE}}" +'%Y-%m-%d %H:%M:%S'
NAME_${FILE} != echo ${FILE}| sed -e 's|.mk$$|.xhtml|' -e 's|^.*,||'
DESC_${FILE} != echo ${DESCRIPTION}
${TMP_${FILE}}: ${TARGET_${NAME_${FILE}}}
# Adapt article's content with some values
	$Qcat ${element} | ${lua} ${parser} "TITLE=${TITLE_${FILE}}" "DATE=${POSTDATE_${FILE}}" "FILE=${NAME_${FILE}}" > ${TMPDIR}/${FILE}
# Add article's title to page's header
	$Qcat ${DESTDIR}/${NAME_${FILE}} | ${lua} ${parser} "TITLE=${TITLE_${FILE}}" "RSSFEED_NAME=${RSSFEEDNAME}" > ${TMPDIR}/${NAME_${FILE}}
	$Qmv ${TMPDIR}/${NAME_${FILE}} ${DESTDIR}/${NAME_${FILE}}
	$Qcat ${TMPLDIR}/feed.element.rss | ${lua} ${parser} "TITLE=${TITLE_${FILE}}" "DESCRIPTION=${DESC_${FILE}}" "LINK=${BASEURL}/${NAME_${FILE}}" > ${TMPDIR}/${FILE}.rss
.endfor

${DESTDIR}/simple.css: ${STYLEDIR}/simple.css
	$Q{ \
		cp ${STYLEDIR}/simple.css ${DESTDIR}/simple.css ; \
	} && echo "-- CSS: ${DESTDIR}/simple.css."

${DESTDIR}/index.xhtml: ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		cat ${header} >> ${TMPDIR}/index.xhtml ; \
		cat ${DBFILES:S/^/${TMPDIR}\//} >> ${TMPDIR}/index.xhtml ; \
		rm -f ${DBFILES:S/^/${TMPDIR}\//} ; \
		cat ${footer} >> ${TMPDIR}/index.xhtml ; \
		cat ${TMPDIR}/index.xhtml |${lua} ${parser} "BASEURL=${BASEURL}" "BLOGTITLE=${BLOGTITLE}" "TITLE=${HOMETITLE}" "RSSFEED_NAME=${RSSFEEDNAME}" "HOMETITLE=${HOMETITLE}" > ${TMPDIR}/index.xhtml.tmp; \
		mv ${TMPDIR}/index.xhtml.tmp ${DESTDIR}/index.xhtml ; \
		rm ${TMPDIR}/index.xhtml ; \
	}

${DESTDIR}/rss.xml: ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		cat ${TMPLDIR}/feed.header.rss | ${lua} ${parser} "BLOGTITLE=${BLOGTITLE}" "BLOGDESCRIPTION=${BLOGDESCRIPTION}" "BASEURL=${BASEURL}" > ${DESTDIR}/rss.xml ; \
		cat ${DBFILES:S/^/${TMPDIR}\//:S/$/.rss/} >> ${DESTDIR}/rss.xml ; \
		rm -f ${DBFILES:S/^/${TMPDIR}\//:S/$/.rss/} ; \
		cat ${TMPLDIR}/feed.footer.rss >> ${DESTDIR}/rss.xml ; \
	}

clean: ${FILES:S/.md$/.xhtml/:S/^/${DESTDIR}\//} ${DESTDIR}/simple.css ${DESTDIR}/index.xhtml ${DESTDIR}/rss.xml
	$Q{ \
		rm -f ${DESTDIR}/* ; \
		rm -f ${TMPDIR}/* ; \
	}

.MAIN: all
