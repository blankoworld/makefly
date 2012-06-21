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

all: ${FILES:S/.md/.xhtml/g:S/^/${DESTDIR}\//} ${DESTDIR}/simple.css ${DESTDIR}/index.xhtml

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
			cat ${header} | ${lua} ${parser} "BLOGTITLE=${BLOGTITLE}" "BASEURL=${BASEURL}" && \
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
${TMP_${FILE}}: ${TARGET_${FILE:S/^.*,//:S/.mk$/.md/}}
# Adapt article's content with some values
	$Qcat ${element} | ${lua} ${parser} "TITLE=${TITLE_${FILE}}" "DATE=${POSTDATE_${FILE}}" "FILE=${NAME_${FILE}}" > ${TMPDIR}/${FILE}
# Add article's title to page's header
	$Qcat ${DESTDIR}/${NAME_${FILE}} | ${lua} ${parser} "TITLE=${TITLE_${FILE}}" > ${DESTDIR}/${NAME_${FILE}}
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
		cat ${TMPDIR}/index.xhtml |${lua} ${parser} "BASEURL=${BASEURL}" "BLOGTITLE=${BLOGTITLE}" "TITLE=Home" > ${TMPDIR}/index.xhtml.tmp; \
		mv ${TMPDIR}/index.xhtml.tmp ${DESTDIR}/index.xhtml ; \
		rm ${TMPDIR}/index.xhtml ; \
	}

clean: ${FILES:S/.md$/.xhtml/:S/^/${DESTDIR}\//} ${DESTDIR}/simple.css ${DESTDIR}/index.xhtml
	$Q{ \
		rm ${DESTDIR}/simple.css ; \
		rm ${DESTDIR}/index.xhtml ; \
		rm -f ${FILES:S/.md$/.xhtml /:S/^/${DESTDIR}\//} ; \
		rm -f ${TMPDIR}/index.xhtml ; \
		rm -f ${TMPDIR}/index.xhtml.tmp ; \
	}

.MAIN: all
