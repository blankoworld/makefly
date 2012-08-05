#!/usr/bin/env pmake -f

# Makefile
#
# Static weblog engine

#####
## LICENSE
###

# Makefly, a static weblog engine using a BSD Makefile
# Copyright (C) 2012 DOSSMANN Olivier
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#####

# use make Q= to enable the debug mode.
Q ?= @

# directories
TMPLDIR         = ./template
STYLEDIR        = ./style
BINDIR          = ./bin
LANGDIR         = ./lang
SRCDIR          = ./src
DESTDIR         = ./pub
DBDIR           = ./db
TMPDIR          = ./tmp
TAGDIR_NAME     = tags
POSTDIR_NAME    = posts
SRCCOMMENTS     = ./comments
COMMENTDIR_NAME = comments
STATICDIR       = ./static

# template's files
header  ?= ${TMPLDIR}/header.xhtml
footer  ?= ${TMPLDIR}/footer.xhtml
element ?= ${TMPLDIR}/element.xhtml
article ?= ${TMPLDIR}/article.xhtml

# other files
htmldoc ?= README.html

# programs
markdown ?= markdown
lua      ?= lua
parser   ?= ${lua} ${BINDIR}/parser.lua
echo     ?= echo
cat      ?= cat
mv       ?= mv
rm       ?= rm
cd       ?= cd
ls       ?= ls
sort     ?= sort
head     ?= head
sed      ?= sed
cut      ?= cut
date     ?= date
cp       ?= cp
grep     ?= grep

# include some VARIABLES
# first main variables
.include "makefly.rc"
# then translation variables
.include "${LANGDIR}/translate.${BLOG_LANG}"
# Prepare parser options
parser_opts = "BLOG_TITLE=${BLOG_TITLE}"   \
		"BLOG_DESCRIPTION=${BLOG_DESCRIPTION}" \
		"BASE_URL=${BASE_URL}"                 \
		"HOME_TITLE=${HOME_TITLE}"             \
		"POST_LIST_TITLE=${POST_LIST_TITLE}"   \
		"POSTDIR_NAME=${POSTDIR_NAME}"         \
		"TAG_TITLE=${TAG_TITLE}"               \
		"TAG_LIST_TITLE=${TAG_LIST_TITLE}"     \
		"TAGDIR_NAME=${TAGDIR_NAME}"           \
		"LANG=${BLOG_LANG}"                    \
		"BLOG_CHARSET=${BLOG_CHARSET}"         \
		"POWERED_BY=${POWERED_BY}"             \
		"POSTED=${POSTED}"                     \
    "PERMALINK_TITLE=${PERMALINK_TITLE}"   \
		"RSS_FEED_NAME=${RSS_FEED_NAME}"
# Prepare some directory name
TAGDIR       = ${DESTDIR}/${TAGDIR_NAME}
POSTDIR      = ${DESTDIR}/${POSTDIR_NAME}
COMMENTDIR   = ${DESTDIR}/${COMMENTDIR_NAME}

# some files'list
FILES != ${cd} ${SRCDIR}; ${ls}
DBFILES != ${cd} ${DBDIR}; ${ls}|${sort} -r
MAINDBFILES != ${cd} ${DBDIR}; ${ls}|${sort} -r|${head} -n ${MAX_POST}
STATICFILES := ${STATICDIR}/*
MEDIAFILES != ${echo} ${STATICFILES}

# DIRECTORIES
.for DIR in DESTDIR TMPDIR TAGDIR POSTDIR STATICDIR COMMENTDIR
${${DIR}}:
	$Q[ -d "${${DIR}}" ] || { \
		echo "-- Creating ${${DIR}}..." ; \
		mkdir -p "${${DIR}}" || { \
			echo "-- Error while creating ${${DIR}}" >&2 ; \
			false ; \
		}; \
	}
.endfor

# MEDIA FILES
.for FILE in ${MEDIAFILES:S/^${STATICDIR}/${DESTDIR}\//}

MEDIA_TARGET_${FILE} = ${FILE}

.if defined(MEDIAFILES) && ${MEDIAFILES} != ${STATICDIR}/*

${MEDIA_TARGET_${FILE}}: ${DESTDIR} ${STATICDIR}
	$Q${cp} ${FILE:S/^${DESTDIR}\//${STATICDIR}/} ${MEDIA_TARGET_${FILE}} && \
		${echo} "-- New static file: ${FILE:S/\/\//\//}"

.endif

.endfor

# COMMENTS FILES
.if defined(COMMENTS) && $(COMMENTS)
COMMENTS_LIST != ${cd} ${SRCCOMMENTS}; ${ls}
.endif

# BEGIN
all: ${FILES:S/.md/.xhtml/g:S/^/${POSTDIR}\//} ${DESTDIR}/simple.css ${DESTDIR}/index.xhtml ${DESTDIR}/rss.xml ${POSTDIR}/index.xhtml ${TAGDIR}/index.xhtml ${MEDIAFILES:S/^${STATICDIR}/${DESTDIR}\//} ${COMMENTS_LIST:S/^/${COMMENTDIR}\//:S/$/.xhtml/}

# Create target post file LIST
# EXAMPLE: pub/article1.xhtml
.for FILE in ${FILES}
TARGET_${FILE} = ${FILE:S/.md$/.xhtml/:S/^/${POSTDIR}\//}
.endfor

# Create temporary files LIST (this temporary files will fetch some infos for Post List and Homepage)
# EXAMPLE: tmp/130435,article1.mk
.for FILE in ${DBFILES}
TMP_${FILE} = ${FILE:S/^/${TMPDIR}\//}
.endfor

# Do each FINAL post file
# EXAMPLE: pub/article1.xhtml
.for FILE in ${FILES}
CONTENT_TARGET_${FILE} != ${markdown} ${SRCDIR}/${FILE} |${sed} -e 's|\"|\\"|g'
${TARGET_${FILE}}: ${DESTDIR} ${POSTDIR} ${SRCDIR}/${FILE}
	$Q{ \
		{ \
			${cat} ${header} | ${parser} ${parser_opts} && \
			${cat} ${article} |${parser}                   \
				"CONTENT=${CONTENT_TARGET_${FILE}}" | ${sed} -e "s|^|        |g" && \
			${cat} ${footer} | ${parser} ${parser_opts}; \
		} > ${TARGET_${FILE}} || { \
			${rm} -f ${TARGET_${FILE}}                           ; \
			${echo} "-- Error while building ${TARGET_${FILE}}." ; \
			false                                             ; \
		} ; \
	} && ${echo} "-- Page built: ${TARGET_${FILE}}."
.endfor

# Do each TMP post files
# EXAMPLE: tmp/130435,article1.mk AND tmp/130435,article1.mk.list AND tmp/130435,article1.mk.rss
.for FILE in ${DBFILES}
# Include post information (example title, date, description, etc.)
.include "${DBDIR}/${FILE}"
# Fetch some data for this post
TITLE_${FILE}     != ${echo} ${TITLE}
TMSTMP_${FILE}    != ${echo} ${FILE}| ${cut} -d ',' -f 1
POSTDATE_${FILE}  != ${date} -d "@${TMSTMP_${FILE}}" +'${DATE_FORMAT}'
SHORTDATE_${FILE} != ${date} -d "@${TMSTMP_${FILE}}" +'${SHORT_DATE_FORMAT}'
NAME_${FILE}      != ${echo} ${FILE}| ${sed} -e 's|.mk$$|.xhtml|' -e 's|^.*,||'
DESC_${FILE}      != ${echo} ${DESCRIPTION}
CONTENT_${FILE}   != ${markdown} ${SRCDIR}/${NAME_${FILE}:S/.xhtml$/.md/} |${sed} -e 's/\"/\\"/g'
TAGS_${FILE}      != ${echo} ${TAGS} |${sed} -e 's/,/ /g'

.for TAG in ${TAGS_${FILE}}
TAGLINK_${FILE}_${TAG} != ${cat} "${TMPLDIR}/taglink.xhtml" |${parser} \
	TAG_PAGE=${TAG}.xhtml \
	TAG_NAME=${TAG}
TAGLIST_TMP_${FILE} += ${TAGLINK_${FILE}_${TAG}}
.endfor

TAGLIST_${FILE} != ${echo} "${TAGLIST_TMP_${FILE}}" |${sed} -e 's|</a> <a|</a>, <a|g' -e 's/\"/\\"/g'

${TMP_${FILE}}: ${TMPDIR} ${POSTDIR} ${TARGET_${NAME_${FILE}}}
	@# Template for Post List page
	$Q${cat} ${element} | ${parser}              \
		"POST_TITLE=${TITLE_${FILE}}"              \
		"DATE=${POSTDATE_${FILE}}"                 \
		"POST_FILE=${NAME_${FILE}}"                \
		"SHORT_DATE=${SHORTDATE_${FILE}}"          \
		"TAG_LINKS_LIST=${TAGLIST_${FILE}}"        \
		> ${TMPDIR}/${FILE}.list
	@# Template for Home page
	$Q${cat} ${article} | ${parser} ${parser_opts} \
		"CONTENT=${CONTENT_${FILE}}"                 \
		"TITLE=${TITLE_${FILE}}"                     \
		"POST_FILE=${NAME_${FILE}}"                  \
		"DATE=${POSTDATE_${FILE}}"                   \
		"TAG_LINKS_LIST=${TAGLIST_${FILE}}"          \
		> ${TMPDIR}/${FILE}
	@# Add article's title to page's header
	$Q${cat} ${POSTDIR}/${NAME_${FILE}} | ${parser} ${parser_opts} \
		"TITLE=${TITLE_${FILE}}"                   \
		"DATE=${POSTDATE_${FILE}}"                 \
		"POST_FILE=${NAME_${FILE}}"                \
		"TAG_LINKS_LIST=${TAGLIST_${FILE}}"        \
		> ${TMPDIR}/${NAME_${FILE}}
	@# Move temporary file to pub
	$Q${mv} ${TMPDIR}/${NAME_${FILE}} ${POSTDIR}/${NAME_${FILE}}
	@# Template for RSS Feed
	$Q${cat} ${TMPLDIR}/feed.element.rss | ${parser}     \
		"TITLE=${TITLE_${FILE}}"                           \
		"DESCRIPTION=${DESC_${FILE}}"                      \
		"LINK=${BASE_URL}/${POSTDIR_NAME}/${NAME_${FILE}}" \
		> ${TMPDIR}/${FILE}.rss
	@# Prepare TAGS
	$Qfor TAG in ${TAGS_${FILE}}; do                       \
		${cat} ${TMPLDIR}/tagelement.xhtml | ${parser}       \
			"TAGLINK=${BASE_URL}/${TAGDIR_NAME}/$${TAG}.xhtml" \
			"TAGNAME=$${TAG}"                                  \
		>> ${TMPDIR}/tags.list;                              \
	done
	$Qfor TAG in ${TAGS_${FILE}}; do               \
		${cat} ${element} | ${parser} ${parser_opts} \
			"POST_TITLE=${TITLE_${FILE}}"              \
			"DATE=${POSTDATE_${FILE}}"                 \
			"POST_FILE=${NAME_${FILE}}"                \
			"SHORT_DATE=${SHORTDATE_${FILE}}"          \
			"TAG_LINKS_LIST=${TAGLIST_${FILE}}"        \
		>> ${TMPDIR}/$${TAG}.tag; \
	done
.endfor

# Do CSS file
${DESTDIR}/simple.css: ${DESTDIR} ${STYLEDIR}/simple.css
	$Q${cp} ${STYLEDIR}/simple.css ${DESTDIR}/simple.css && \
		${echo} "-- CSS copied: ${DESTDIR}/simple.css"

# Do Homepage
# EXAMPLE: pub/index.xhtml
${DESTDIR}/index.xhtml: ${DESTDIR} ${TMPDIR} ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		${cat} ${header} >> ${TMPDIR}/index.xhtml &&                       \
		${cat} ${MAINDBFILES:S/^/${TMPDIR}\//} >> ${TMPDIR}/index.xhtml && \
		${rm} -f ${DBFILES:S/^/${TMPDIR}\//} &&                            \
		${cat} ${footer} >> ${TMPDIR}/index.xhtml &&                       \
		${cat} ${TMPDIR}/index.xhtml |${parser} ${parser_opts}             \
			"TITLE=${HOME_TITLE}"                                            \
			> ${TMPDIR}/index.xhtml.tmp &&                                   \
		${mv} ${TMPDIR}/index.xhtml.tmp ${DESTDIR}/index.xhtml &&          \
		${rm} ${TMPDIR}/index.xhtml || {                                   \
			${echo} "-- Could not build index page: $@" ;                    \
			false ;                                                          \
		} ;                                                                \
	} && ${echo} "-- Index page built: $@"

# Do RSS Feed
# EXAMPLE: pub/rss.xml
${DESTDIR}/rss.xml: ${DESTDIR} ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		${cat} ${TMPLDIR}/feed.header.rss | ${parser} ${parser_opts} \
			> ${DESTDIR}/rss.xml &&                \
		${cat} ${DBFILES:S/^/${TMPDIR}\//:S/$/.rss/} >> ${DESTDIR}/rss.xml && \
		${rm} -f ${DBFILES:S/^/${TMPDIR}\//:S/$/.rss/} && \
		${cat} ${TMPLDIR}/feed.footer.rss >> ${DESTDIR}/rss.xml || { \
			${echo} "-- Could not build RSS page: $@" ; \
			false ; \
		} ; \
	} && ${echo} "-- RSS page built: $@"

# Do Post List page
# EXAMPLE: pub/list.xhtml
${POSTDIR}/index.xhtml: ${POSTDIR} ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		${cat} ${header} >> ${TMPDIR}/list.xhtml &&                              \
		${cat} ${DBFILES:S/^/${TMPDIR}\//:S/$/.list/} >> ${TMPDIR}/list.xhtml && \
		${rm} -f ${DBFILES:S/^/${TMPDIR}\//:S/$/.list/} &&                       \
		${cat} ${footer} >> ${TMPDIR}/list.xhtml &&                              \
		${cat} ${TMPDIR}/list.xhtml | ${parser} ${parser_opts}                   \
			"TITLE=${POST_LIST_TITLE}"                                             \
			> ${POSTDIR}/index.xhtml &&                                            \
    ${rm} ${TMPDIR}/list.xhtml || {                                          \
			${echo} "-- Could not build list page: $@" ;                           \
			false ;                                                                \
		} ;                                                                      \
	} && ${echo} "-- List page built: $@"

# Do Tag List page
# EXAMPLE: pub/tags/index.xhtml
${TAGDIR}/index.xhtml: ${TAGDIR} ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		${cat} ${header} > ${TMPDIR}/taglist.xhtml &&             \
		${cat} ${TMPLDIR}/tags.xhtml | ${parser} ${parser_opts}   \
			"TAGLIST_CONTENT=`${cat} ${TMPDIR}/tags.list |${sort} -u`" \
			>> ${TMPDIR}/taglist.xhtml &&                           \
		${cat} ${footer} >> ${TMPDIR}/taglist.xhtml &&            \
		${cat} ${TMPDIR}/taglist.xhtml | ${parser} ${parser_opts} \
			"TITLE=${TAG_LIST_TITLE}"                               \
		> ${TAGDIR}/index.xhtml &&                                \
		${rm} ${TMPDIR}/tags.list &&                              \
		${rm} ${TMPDIR}/taglist.xhtml ||                          \
		{                                                         \
			${echo} "-- Could not build tag list page: $@" ;        \
			false ;                                                 \
		} ;                                                       \
	} && ${echo} "-- Tag list built: $@"
	$Qfor TAG in `${cd} ${TMPDIR};${ls} *.tag|${sed} -e 's|.tag$$||g'`; do \
		${cat} ${header} >> ${TMPDIR}/$${TAG}.tag.xhtml &&            \
		${cat} ${TMPDIR}/$${TAG}.tag >> ${TMPDIR}/$${TAG}.tag.xhtml &&    \
		${cat} ${footer} >> ${TMPDIR}/$${TAG}.tag.xhtml &&            \
		${cat} ${TMPDIR}/$${TAG}.tag.xhtml | ${parser} ${parser_opts} \
			"TITLE=$${TAG}"                                  \
			>> ${TAGDIR}/$${TAG}.xhtml &&                   \
			${rm} ${TMPDIR}/$${TAG}.tag.xhtml && ${rm} -f ${TMPDIR}/$${TAG}.tag; \
		done

# Do Comments pages
.for DIR in ${COMMENTS_LIST}

TARGET_${DIR} = ${COMMENTDIR}/${DIR}.xhtml
COMMENTS_${DIR} != ${cd} ${SRCCOMMENTS}/${DIR}; ${ls}|${grep} '.md' |${sort}
META_${DIR} != ${cd} ${SRCCOMMENTS}/${DIR}; ${ls}|${grep} '.mk' |${sort}

${TARGET_${DIR}}: ${COMMENTDIR}
	$Q{ \
		${cat} ${header} > ${TMPDIR}/${DIR}.comment &&                       \
		${cat} ${COMMENTS_${DIR}:S/^/${SRCCOMMENTS}\/${DIR}\//} |${markdown} \
			>> ${TMPDIR}/${DIR}.comment &&                                     \
		${cat} ${footer} >> ${TMPDIR}/${DIR}.comment &&                      \
		${cat} ${TMPDIR}/${DIR}.comment | ${parser} ${parser_opts}           \
			"TITLE=${DIR}"                                                     \
		>> ${TARGET_${DIR}} &&                                               \
		${rm} ${TMPDIR}/${DIR}.comment;                                      \
	} && ${echo} "-- Comment page built: $@"

.endfor

# Clean all directories
# EXAMPLE: pub/* AND tmp/*
clean:
	$Q${rm} -rf ${DESTDIR}/*
	$Q${rm} -f ${TMPDIR}/*
	$Q${rm} -f README.html

doc: README.md
	$Q${markdown} README.md > ${htmldoc}

# END
.MAIN: all

# vim:tabstop=2:softtabstop=2:shiftwidth=2:noexpandtab
