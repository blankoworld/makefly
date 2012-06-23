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
article ?= ${TMPLDIR}/article.xhtml

SRCDIR  = ./src
DESTDIR = ./pub
DBDIR   = ./db
TMPDIR  = ./tmp

parser ?= ${BINDIR}/parser.lua

FILES != cd ${SRCDIR}; ls

.include "makefly.rc"

DBFILES != cd ${DBDIR}; ls|sort -r|sort -r
MAINDBFILES != cd ${DBDIR}; ls|sort -r|head -n ${MAXPOST}

all: ${FILES:S/.md/.xhtml/g:S/^/${DESTDIR}\//} ${DESTDIR}/simple.css ${DESTDIR}/index.xhtml ${DESTDIR}/rss.xml ${DESTDIR}/list.xhtml

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
			cat ${header} | ${lua} ${parser} "BLOGTITLE=${BLOGTITLE}" "BASEURL=${BASEURL}" "HOMETITLE=${HOMETITLE}" "POST_LIST_TITLE=${POST_LIST_TITLE}" && \
			echo "      <article>" && \
			${markdown} ${SRCDIR}/${FILE} |sed "s|^|        |g" && \
			echo "      </article>" && \
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
CONTENT_${FILE} != ${markdown} ${SRCDIR}/${NAME_${FILE}:S/.xhtml$/.md/}
${TMP_${FILE}}: ${TARGET_${NAME_${FILE}}}
# Adapt article's content with some values
	$Qcat ${element} | ${lua} ${parser} "TITLE=${TITLE_${FILE}}" "DATE=${POSTDATE_${FILE}}" "FILE=${NAME_${FILE}}" > ${TMPDIR}/${FILE}.list
# Adapt article's content with some values
	$Qcat ${article} | ${lua} ${parser} "CONTENT=${CONTENT_${FILE}}" "TITLE=${TITLE_${FILE}}" "FILE=${NAME_${FILE}}" "DATE=${POSTDATE_${FILE}}" "PERMALINKTITLE=${PERMALINKTITLE}"> ${TMPDIR}/${FILE}
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
		cat ${MAINDBFILES:S/^/${TMPDIR}\//} >> ${TMPDIR}/index.xhtml ; \
		rm -f ${DBFILES:S/^/${TMPDIR}\//} ; \
		cat ${footer} >> ${TMPDIR}/index.xhtml ; \
		cat ${TMPDIR}/index.xhtml |${lua} ${parser} "BASEURL=${BASEURL}" "BLOGTITLE=${BLOGTITLE}" "TITLE=${HOMETITLE}" "RSSFEED_NAME=${RSSFEEDNAME}" "HOMETITLE=${HOMETITLE}" "POST_LIST_TITLE=${POST_LIST_TITLE}" > ${TMPDIR}/index.xhtml.tmp; \
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

${DESTDIR}/list.xhtml: ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		cat ${header} >> ${TMPDIR}/list.xhtml ; \
		cat ${DBFILES:S/^/${TMPDIR}\//:S/$/.list/} >> ${TMPDIR}/list.xhtml ; \
		rm -f ${DBFILES:S/^/${TMPDIR}\//:S/$/.list/} ; \
		cat ${footer} >> ${TMPDIR}/list.xhtml ; \
		cat ${TMPDIR}/list.xhtml | ${lua} ${parser} "BLOGTITLE=${BLOGTITLE}" "BLOGDESCRIPTION=${BLOGDESCRIPTION}" "BASEURL=${BASEURL}" "RSSFEED_NAME=${RSSFEEDNAME}" "HOMETITLE=${HOMETITLE}" "POST_LIST_TITLE=${POST_LIST_TITLE}" "TITLE=${POST_LIST_TITLE}" > ${DESTDIR}/list.xhtml ; \
    rm ${TMPDIR}/list.xhtml ; \
	}

clean: ${FILES:S/.md$/.xhtml/:S/^/${DESTDIR}\//} ${DESTDIR}/simple.css ${DESTDIR}/index.xhtml ${DESTDIR}/rss.xml
	$Q{ \
		rm -f ${DESTDIR}/* ; \
		rm -f ${TMPDIR}/* ; \
	}

.MAIN: all

#vim :tabstop=2:softtabstop=2:shiftwidth=2:noexpandtab
