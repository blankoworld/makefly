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

FILES != cd ${SRCDIR}; ls
#FILES = a.md b.md c.md

all: ${FILES:S/.md/.xhtml/g:S/^/${DESTDIR}\//} ${DESTDIR}/simple.css

.for FILE in ${FILES}
TARGET_${FILE} = ${FILE:S/.md$/.xhtml/:S/^/${DESTDIR}\//}
.endfor

.for FILE in ${FILES}
${TARGET_${FILE}}: ${SRCDIR}/${FILE}
	$Q{ \
		{ \
			cat ${header}                  && \
			${markdown} ${SRCDIR}/${FILE}  && \
			cat ${footer}                   ; \
		} > ${TARGET_${FILE}} || { \
			rm -f ${TARGET_${FILE}}                           ; \
			echo "-- Error while building ${TARGET_${FILE}}." ; \
			false                                             ; \
		} ; \
	} && echo "-- Page built: ${TARGET_${FILE}}."
.endfor

${DESTDIR}/simple.css: ${STYLEDIR}/simple.css
	$Q{ \
		cp ${STYLEDIR}/simple.css ${DESTDIR}/simple.css ; \
	}

clean: ${FILES:S/.md$/.xhtml/:S/^/clean-${DESTDIR}\//}

.for ${FILE} in ${FILES}
	.warning clean-${TARGET_${FILE}} ${FILE}
	clean-${TARGET_${FILE}}:
	$Qrm -f ${TARGET_${FILE}} && \
	echo "${TARGET_${FILE}} removed."
.endfor

