#!/usr/bin/env pmake -f
# XXX
markdown ?= markdown

# use make Q= to enable the debug mode.
Q ?= @

TMPLDIR = ./template
STYLEDIR = ./style

header ?= ${TMPLDIR}/header.xhtml
footer ?= ${TMPLDIR}/footer.xhtml

SRCDIR  = ./src
DESTDIR = ./pub
DBDIR   = ./db
TMPDIR  = ./tmp

FILES != cd ${SRCDIR}; ls

.include "makefly.rc"

all: ${FILES:S/.md/.xhtml/g:S/^/${DESTDIR}\//} ${DESTDIR}/simple.css ${DESTDIR}/index.xhtml

.for FILE in ${FILES}
TARGET_${FILE} = ${FILE:S/.md$/.xhtml/:S/^/${DESTDIR}\//}
TMP_${FILE} = ${FILE:S/.md$/.mk/:S/^/${TMPDIR}\//}
.endfor

.for FILE in ${FILES}
${TARGET_${FILE}}: ${SRCDIR}/${FILE}
	$Q{ \
		{ \
			cat ${header} |sed -e "s|@@BLOGTITLE@@|${BLOGTITLE}|g" |sed -e "s|@@BASEURL@@|${BASEURL}|g" && \
			${markdown} ${SRCDIR}/${FILE}  && \
			cat ${footer}                   ; \
		} > ${TARGET_${FILE}} || { \
			rm -f ${TARGET_${FILE}}                           ; \
			echo "-- Error while building ${TARGET_${FILE}}." ; \
			false                                             ; \
		} ; \
	} && echo "-- Page built: ${TARGET_${FILE}}."

${TMP_${FILE}}: ${TARGET_${FILE}}
	$Q{ \
		sh index.sh ${FILE:S/.md$/.mk/}; \
	}

.endfor

${DESTDIR}/simple.css: ${STYLEDIR}/simple.css
	$Q{ \
		cp ${STYLEDIR}/simple.css ${DESTDIR}/simple.css ; \
	} && echo "-- CSS: ${DESTDIR}/simple.css."

${DESTDIR}/index.xhtml: ${FILES:S/.md$/.mk/:S/^/${TMPDIR}\//}
	$Q{ \
		cat ${header} >> ${TMPDIR}/index.xhtml ; \
		cat ${FILES:S/.md$/.mk /:S/^/${TMPDIR}\//} >> ${TMPDIR}/index.xhtml ; \
		rm -f ${FILES:S/.md$/.mk /:S/^/${TMPDIR}\//} ; \
		cat ${footer} >> ${TMPDIR}/index.xhtml ; \
		sed -e "s|@@BASEURL@@|${BASEURL}|g" -e "s|@@BLOGTITLE@@|${BLOGTITLE}|g" ${TMPDIR}/index.xhtml > ${TMPDIR}/index.xhtml.tmp; \
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
