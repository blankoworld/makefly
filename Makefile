#!/usr/bin/env pmake -f

# use make Q= to enable the debug mode.
Q ?= @

# directories
TMPLDIR  = ./template
STYLEDIR = ./style
BINDIR   = ./bin
LANGDIR  = ./lang
SRCDIR   = ./src
DESTDIR  = ./pub
DBDIR    = ./db
TMPDIR   = ./tmp
TAGDIR   = ${DESTDIR}/tags

# template's files
header  ?= ${TMPLDIR}/header.xhtml
footer  ?= ${TMPLDIR}/footer.xhtml
element ?= ${TMPLDIR}/element.xhtml
article ?= ${TMPLDIR}/article.xhtml

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

# some files'list
FILES != ${cd} ${SRCDIR}; ${ls}
DBFILES != ${cd} ${DBDIR}; ${ls}|${grep} -v tags.list|${sort} -r
MAINDBFILES != ${cd} ${DBDIR}; ${ls}|${grep} -v tags.list|${sort} -r|${head} -n ${MAX_POST}
TAGLIST != ${cat} ${DBDIR}/tags.list|${sed} -e 's/\:/@/g'|${sort}
#def TAGLIST_CONTENT

# DIRECTORIES
.for DIR in DESTDIR TMPDIR TAGDIR
${${DIR}}:
	$Q[ -d "${${DIR}}" ] || { \
		echo "-- Creating ${${DIR}}..." ; \
		mkdir -p "${${DIR}}" || { \
			echo "-- Error while creating ${${DIR}}" >&2 ; \
			false ; \
		}; \
	}
.endfor

# BEGIN
all: ${FILES:S/.md/.xhtml/g:S/^/${DESTDIR}\//} ${DESTDIR}/simple.css ${DESTDIR}/index.xhtml ${DESTDIR}/rss.xml ${DESTDIR}/list.xhtml ${DESTDIR}/tags/index.xhtml

# Create target post file LIST
# EXAMPLE: pub/article1.xhtml
.for FILE in ${FILES}
TARGET_${FILE} = ${FILE:S/.md$/.xhtml/:S/^/${DESTDIR}\//}
.endfor

# Create temporary files LIST (this temporary files will fetch some infos for Post List and Homepage)
# EXAMPLE: tmp/130435,article1.mk
.for FILE in ${DBFILES}
TMP_${FILE} = ${FILE:S/^/${TMPDIR}\//}
.endfor

# Do each FINAL post file
# EXAMPLE: pub/article1.xhtml
.for FILE in ${FILES}
CONTENT_TARGET_${FILE} != ${markdown} ${SRCDIR}/${FILE}
${TARGET_${FILE}}: ${DESTDIR} ${SRCDIR}/${FILE}
	$Q{ \
		{ \
			${cat} ${header} | ${parser}           \
				"BLOG_TITLE=${BLOG_TITLE}"           \
				"BASE_URL=${BASE_URL}"               \
				"HOME_TITLE=${HOME_TITLE}"           \
				"POST_LIST_TITLE=${POST_LIST_TITLE}" \
				"TAG_LIST_TITLE=${TAG_LIST_TITLE}"   \
				"LANG=${BLOG_LANG}" && \
			${cat} ${article} | ${parser} "CONTENT=${CONTENT_TARGET_${FILE}}" | ${sed} "s|^|        |g" && \
			${cat} ${footer} | ${parser} "POWERED_BY=${POWERED_BY}" ; \
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
CONTENT_${FILE}   != ${markdown} ${SRCDIR}/${NAME_${FILE}:S/.xhtml$/.md/}
TAGS_${FILE}      != ${echo} ${TAGS}

${TMP_${FILE}}: ${TMPDIR} ${TARGET_${NAME_${FILE}}}
	@# Template for Post List page
	$Q${cat} ${element} | ${parser}              \
		"TITLE=${TITLE_${FILE}}"                   \
		"DATE=${POSTDATE_${FILE}}"                 \
		"FILE=${NAME_${FILE}}"                     \
		"SHORT_DATE=${SHORTDATE_${FILE}}"          \
		> ${TMPDIR}/${FILE}.list
	@# Template for Home page
	$Q${cat} ${article} | ${parser}              \
		"CONTENT=${CONTENT_${FILE}}"               \
		"TITLE=${TITLE_${FILE}}"                   \
		"FILE=${NAME_${FILE}}"                     \
		"DATE=${POSTDATE_${FILE}}"                 \
		"PERMALINK_TITLE=${PERMALINK_TITLE}"       \
		> ${TMPDIR}/${FILE}
	@# Add article's title to page's header
	$Q${cat} ${DESTDIR}/${NAME_${FILE}} | ${parser}    \
		"TITLE=${TITLE_${FILE}}"                   \
		"RSS_FEED_NAME=${RSS_FEED_NAME}"           \
		"PERMALINK_TITLE=${PERMALINK_TITLE}"       \
		"POSTED=${POSTED}"                         \
		"DATE=${POSTDATE_${FILE}}"                 \
		"BASE_URL=${BASE_URL}"                     \
		"FILE=${NAME_${FILE}}"                     \
		> ${TMPDIR}/${NAME_${FILE}}
	@# Move temporary file to pub
	$Q${mv} ${TMPDIR}/${NAME_${FILE}} ${DESTDIR}/${NAME_${FILE}}
	@# Template for RSS Feed
	$Q${cat} ${TMPLDIR}/feed.element.rss | ${parser}   \
		"TITLE=${TITLE_${FILE}}"                   \
		"DESCRIPTION=${DESC_${FILE}}"              \
		"LINK=${BASE_URL}/${NAME_${FILE}}"         \
		> ${TMPDIR}/${FILE}.rss
.endfor

# Do CSS file
${DESTDIR}/simple.css: ${DESTDIR} ${STYLEDIR}/simple.css
	$Q${cp} ${STYLEDIR}/simple.css ${DESTDIR}/simple.css && \
		${echo} "-- CSS copied: ${DESTDIR}/simple.css"

# Do Homepage
# EXAMPLE: pub/index.xhtml
${DESTDIR}/index.xhtml: ${DESTDIR} ${TMPDIR} ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		${cat} ${header} >> ${TMPDIR}/index.xhtml && \
		${cat} ${MAINDBFILES:S/^/${TMPDIR}\//} >> ${TMPDIR}/index.xhtml && \
		${rm} -f ${DBFILES:S/^/${TMPDIR}\//} && \
		${cat} ${footer} >> ${TMPDIR}/index.xhtml && \
		${cat} ${TMPDIR}/index.xhtml |${parser}      \
			"BASE_URL=${BASE_URL}"               \
			"BLOG_TITLE=${BLOG_TITLE}"           \
			"TITLE=${HOME_TITLE}"                \
			"RSS_FEED_NAME=${RSS_FEED_NAME}"     \
			"HOME_TITLE=${HOME_TITLE}"           \
			"POST_LIST_TITLE=${POST_LIST_TITLE}" \
			"TAG_LIST_TITLE=${TAG_LIST_TITLE}"   \
			"LANG=${BLOG_LANG}"                  \
			"POWERED_BY=${POWERED_BY}"           \
			"POSTED=${POSTED}"                   \
			> ${TMPDIR}/index.xhtml.tmp && \
		${mv} ${TMPDIR}/index.xhtml.tmp ${DESTDIR}/index.xhtml && \
		${rm} ${TMPDIR}/index.xhtml || { \
			${echo} "-- Could not build index page: $@" ; \
			false ; \
		} ; \
	} && ${echo} "-- Index page built: $@"

# Do RSS Feed
# EXAMPLE: pub/rss.xml
${DESTDIR}/rss.xml: ${DESTDIR} ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		${cat} ${TMPLDIR}/feed.header.rss | ${parser}  \
			"BLOG_TITLE=${BLOG_TITLE}"             \
			"BLOG_DESCRIPTION=${BLOG_DESCRIPTION}" \
			"BASE_URL=${BASE_URL}"                 \
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
${DESTDIR}/list.xhtml: ${DESTDIR} ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		${cat} ${header} >> ${TMPDIR}/list.xhtml && \
		${cat} ${DBFILES:S/^/${TMPDIR}\//:S/$/.list/} >> ${TMPDIR}/list.xhtml && \
		${rm} -f ${DBFILES:S/^/${TMPDIR}\//:S/$/.list/} && \
		${cat} ${footer} >> ${TMPDIR}/list.xhtml && \
		${cat} ${TMPDIR}/list.xhtml | ${parser}        \
			"BLOG_TITLE=${BLOG_TITLE}"             \
			"BLOG_DESCRIPTION=${BLOG_DESCRIPTION}" \
			"BASE_URL=${BASE_URL}"                 \
			"RSS_FEED_NAME=${RSS_FEED_NAME}"       \
			"HOME_TITLE=${HOME_TITLE}"             \
			"POST_LIST_TITLE=${POST_LIST_TITLE}"   \
			"TAG_LIST_TITLE=${TAG_LIST_TITLE}"     \
			"TITLE=${POST_LIST_TITLE}"             \
			"LANG=${BLOG_LANG}"                    \
			"POWERED_BY=${POWERED_BY}"             \
			> ${DESTDIR}/list.xhtml &&             \
    ${rm} ${TMPDIR}/list.xhtml || { \
			${echo} "-- Could not build list page: $@" ; \
			false ; \
		} ; \
	} && ${echo} "-- List page built: $@"

# Do Tag List page
# EXAMPLE: pub/taglist.xhtml
.for TAG in ${TAGLIST}
TAGNAME_${TAG} != ${echo} ${TAG} |${cut} -d '@' -f1
TAGFILE_${TAG} = ${TAGNAME_${TAG}}.xhtml
TAGLINK_${TAG} = \"${BASE_URL}/tags/${TAGFILE_${TAG}}\"
ARTICLES_${TAG} != ${echo} ${TAG} |${cut} -d '@' -f2|${sed} -e 's|,| |g'
# Sed is needed to avoid problem with missing double quote in template parsing
TAGCONTENT_${TAG} != ${cat} ${TMPLDIR}/tagelement.xhtml |${sed} -e 's|\"|\\"|g' |${parser} \
	"TAGNAME=${TAGNAME_${TAG}}" \
	"TAGLINK=${TAGLINK_${TAG}}"
TAGLIST_CONTENT += ${TAGCONTENT_${TAG}}

${TAG}: ${DBDIR}/tags.list ${TAGDIR}
	$Q${cat} ${header} >> ${TMPDIR}/${TAGFILE_${TAG}}.tag
	$Q${echo} "      <ul>" >> ${TMPDIR}/${TAGFILE_${TAG}}.tag
.	for ARTICLE in ${ARTICLES_${TAG}}
	$Q${echo} "        <li><a href=\"${BASE_URL}/${ARTICLE:S/.md$/.xhtml/}\">${ARTICLE:S/.md$//}</a></li>" >> ${TMPDIR}/${TAGFILE_${TAG}}.tag
.	endfor
	$Q${echo} "      </ul>" >> ${TMPDIR}/${TAGFILE_${TAG}}.tag
	$Q${cat} ${footer} >> ${TMPDIR}/${TAGFILE_${TAG}}.tag
	$Q${cat} ${TMPDIR}/${TAGFILE_${TAG}}.tag |${parser} \
		"TAGLIST_CONTENT=${TAGLIST_CONTENT}"         \
		"BLOG_TITLE=${BLOG_TITLE}"                   \
		"BLOG_DESCRIPTION=${BLOG_DESCRIPTION}"       \
		"BASE_URL=${BASE_URL}"                       \
		"RSS_FEED_NAME=${RSS_FEED_NAME}"             \
		"HOME_TITLE=${HOME_TITLE}"                   \
		"POST_LIST_TITLE=${POST_LIST_TITLE}"         \
		"TAG_LIST_TITLE=${TAG_LIST_TITLE}"           \
		"TITLE=${TAGNAME_${TAG}}"                    \
		"LANG=${BLOG_LANG}"                          \
		"POWERED_BY=${POWERED_BY}"                   \
		> ${DESTDIR}/tags/${TAGFILE_${TAG}}
.endfor

${DESTDIR}/tags/index.xhtml: ${DESTDIR} ${DBDIR}/tags.list ${TAGLIST}
	$Q{ \
		${cat} ${header} >> ${TMPDIR}/taglist.xhtml && \
		${cat} ${TMPLDIR}/tags.xhtml >> ${TMPDIR}/taglist.xhtml && \
		${cat} ${footer} >> ${TMPDIR}/taglist.xhtml && \
		${cat} ${TMPDIR}/taglist.xhtml | ${parser}     \
			"TAGLIST_CONTENT=${TAGLIST_CONTENT}"         \
			"BLOG_TITLE=${BLOG_TITLE}"                   \
			"BLOG_DESCRIPTION=${BLOG_DESCRIPTION}"       \
			"BASE_URL=${BASE_URL}"                       \
			"RSS_FEED_NAME=${RSS_FEED_NAME}"             \
			"HOME_TITLE=${HOME_TITLE}"                   \
			"POST_LIST_TITLE=${POST_LIST_TITLE}"         \
			"TAG_LIST_TITLE=${TAG_LIST_TITLE}"           \
			"TITLE=${TAG_LIST_TITLE}"                    \
			"LANG=${BLOG_LANG}"                          \
			"POWERED_BY=${POWERED_BY}"                   \
			> ${DESTDIR}/tags/index.xhtml && \
	  ${rm} ${TMPDIR}/taglist.xhtml || { \
			${echo} "-- Could not build tag list page: $@" ; \
			false ; \
		} ; \
	} && ${echo} "-- Tag list built: $@"

# Clean all directories
# EXAMPLE: pub/* AND tmp/*
clean:
	$Q${rm} -rf ${DESTDIR}/*
	$Q${rm} -f ${TMPDIR}/*

# END
.MAIN: all

# vim:tabstop=2:softtabstop=2:shiftwidth=2:noexpandtab
