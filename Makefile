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
TMPLDIR          = ./template
BINDIR           = ./bin
LANGDIR          = ./lang
SRCDIR           = ./src
DESTDIR          = ./pub
DBDIR            = ./db
TMPDIR           = ./tmp
DOCDIR           = ./doc
TAGDIR_NAME      = tags
POSTDIR_NAME     = posts
STATICDIR        = ./static
SPECIALDIR       = ./special
ABOUT_FILENAME   = about
THEME            = default
BACKUPDIR        = ./mbackup
SIDEBAR_FILENAME = sidebar
TOOLSDIR         = ./tools
MAKEFLYDIR       != pwd

# programs
markdown ?= markdown
lua      ?= lua
parser   ?= ${lua} ${BINDIR}/parser.lua
mv       ?= mv
rm       ?= rm
sort     ?= sort
date     ?= date
tar      ?= tar
PUBLISH_SCRIPT_NAME = publish.sh

# include some VARIABLES
BODY_CLASS = single
# first main variables
.include "makefly.rc"
# then translation variables
.include "${LANGDIR}/translate.${BLOG_LANG}"
# finally theme VARIABLES
THEMEDIR = ${TMPLDIR}/${THEME}
.include "${THEMEDIR}/config.mk"

# template's files
header      ?= ${THEMEDIR}/header.xhtml
footer      ?= ${THEMEDIR}/footer.xhtml
element     ?= ${THEMEDIR}/element.xhtml
article     ?= ${THEMEDIR}/article.xhtml
article_idx ?= ${THEMEDIR}/article.index.xhtml
taglink     ?= ${THEMEDIR}/taglink.xhtml
tagelement  ?= ${THEMEDIR}/tagelement.xhtml
tags        ?= ${THEMEDIR}/tags.xhtml
aboutlink   ?= ${THEMEDIR}/menu.about.xhtml
sidebar_tpl ?= ${THEMEDIR}/sidebar.xhtml
read_more   ?= ${THEMEDIR}/read_more_link.xhtml
searchbar   ?= ${THEMEDIR}/menu.search_bar.xhtml

# Create postdir and tagdir index's filenames
POSTDIR_INDEX = ${INDEX_FILENAME}${PAGE_EXT}
TAGDIR_INDEX  = ${INDEX_FILENAME}${PAGE_EXT}
# Create about index filename
ABOUT_INDEX   = ${ABOUT_FILENAME}${PAGE_EXT}
STYLEDIR      = ${THEMEDIR}/style

# Prepare parser options
parser_opts = "BLOG_TITLE=${BLOG_TITLE}"     \
		"BLOG_DESCRIPTION=${BLOG_DESCRIPTION}"   \
		"BLOG_SHORT_DESC=${BLOG_SHORT_DESC}"     \
		"BASE_URL=${BASE_URL}"                   \
		"HOME_TITLE=${HOME_TITLE}"               \
		"POST_LIST_TITLE=${POST_LIST_TITLE}"     \
		"POSTDIR_NAME=${POSTDIR_NAME}"           \
		"TAG_TITLE=${TAG_TITLE}"                 \
		"TAG_LIST_TITLE=${TAG_LIST_TITLE}"       \
		"TAGDIR_NAME=${TAGDIR_NAME}"             \
		"LANG=${BLOG_LANG}"                      \
		"BLOG_CHARSET=${BLOG_CHARSET}"           \
		"POWERED_BY=${POWERED_BY}"               \
		"LOGO_AVAILABLE=${LOGO_AVAILABLE}"       \
		"POSTED=${POSTED}"                       \
		"AUTHOR_LABEL=${AUTHOR_LABEL}"           \
		"PERMALINK_TITLE=${PERMALINK_TITLE}"     \
		"RSS_FEED_NAME=${RSS_FEED_NAME}"         \
		"POSTDIR_INDEX=${POSTDIR_INDEX}"         \
		"TAGDIR_INDEX=${TAGDIR_INDEX}"           \
		"SOURCE_LINK_NAME=${SOURCE_LINK_NAME}"   \
		"SOURCE_LINK_TITLE=${SOURCE_LINK_TITLE}" \
		"CSS_NAME=${CSS_NAME}"                   \
		"CSS_FILE=${CSS_FILE}"                   \
		"THEME_IS=${THEME_IS}"                   \
		"BODY_CLASS=${BODY_CLASS}"               \
		"LINKS_TITLE=${LINKS_TITLE}"             \
		"SIDEBAR="                               \
		"ARTICLE_CLASS_TYPE=normal"              \
		"SEARCHBAR="                             \
		"ABOUT_LINK=" # set to nothing because of next process

# Prepare some directory name
TAGDIR       = ${DESTDIR}/${TAGDIR_NAME}
POSTDIR      = ${DESTDIR}/${POSTDIR_NAME}

# some files'list
FILES != cd ${SRCDIR}; ls
DBFILES != cd ${DBDIR}; ls|${sort} -r
MAINDBFILES != cd ${DBDIR}; ls|${sort} -r|head -n ${MAX_POST}
RSSDBFILES != cd ${DBDIR}; ls|${sort} -r|head -n ${MAX_RSS} 
STATICFILES := ${STATICDIR}/*
MEDIAFILES != echo ${STATICFILES}
ABOUTFILE := ${SPECIALDIR}/${ABOUT_FILENAME}*
ABOUTRESULT != echo ${ABOUTFILE}
SIDEBARFILE := ${SPECIALDIR}/${SIDEBAR_FILENAME}*
SIDEBARRESULT != echo ${SIDEBARFILE}
THEMESTATICFILES := ${THEMEDIR}/static/*
THEMEMEDIAFILES != echo ${THEMESTATICFILES}
DOCFILES := ${DOCDIR}/*.md
DOCFILESRESULT != echo ${DOCFILES}

# DIRECTORIES
.for DIR in DESTDIR TMPDIR TAGDIR POSTDIR STATICDIR SPECIALDIR BACKUPDIR DOCDIR
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
	$Qcp -r ${FILE:S/^${DESTDIR}\//${STATICDIR}/} ${MEDIA_TARGET_${FILE}} && \
		echo "-- New static file: ${FILE:S/\/\//\//}"

.endif

.endfor

# ABOUT PAGE
.if defined(ABOUTRESULT) && ${ABOUTRESULT} != ${SPECIALDIR}/${ABOUT_FILENAME}*

ABOUT_LINK != cat ${aboutlink} |${parser} "ABOUT_TITLE=${ABOUT_TITLE}"
parser_opts += "ABOUT_LINK=${ABOUT_LINK}"

${DESTDIR}/${ABOUT_FILENAME}${PAGE_EXT}: ${DESTDIR} ${SPECIALDIR}
	$Q{ \
		{ \
			cat ${header} | ${parser} ${parser_opts} "TITLE=${ABOUT_TITLE}" && \
			${markdown} ${ABOUTFILE} && \
			cat ${footer} | ${parser} ${parser_opts}; \
		} > ${DESTDIR}/${ABOUT_FILENAME}${PAGE_EXT} || { \
			${rm} -f ${DESTDIR}/${ABOUT_FILENAME}${PAGE_EXT} ; \
			echo "-- Error while building ${ABOUT_FILENAME}${PAGE_EXT} page." ; \
			false                                             ; \
		} ; \
	} && echo "-- Page built: ${DESTDIR}/${ABOUT_FILENAME}${PAGE_EXT}."

.endif

# SEARCH BAR
.if defined(SEARCH_BAR) && $(SEARCH_BAR)

SEARCHBAR != cat ${searchbar} |${parser} \
	"SEARCH_BAR_BUTTON_NAME=${SEARCH_BAR_BUTTON_NAME}" \
	"SEARCH_BAR_CONTENT=${SEARCH_BAR_CONTENT}" \
	|sed -e 's|\"|\\"|g'
parser_opts += "SEARCHBAR=${SEARCHBAR}"

.endif

# THEME STATIC FILES
.for FILE in ${THEMEMEDIAFILES:S/^${THEMEDIR}\/static\//${DESTDIR}\//}

THEME_MEDIA_TARGET_${FILE} = ${FILE}

.if defined(THEMEMEDIAFILES) && ${THEMEMEDIAFILES} != ${THEMEDIR}/static/*

${THEME_MEDIA_TARGET_${FILE}}: ${DESTDIR}
	$Qcp ${FILE:S/^${DESTDIR}\//${THEMEDIR}\/static\//} ${THEME_MEDIA_TARGET_${FILE}} && \
		echo "-- New theme static file: ${FILE:S/\/\//\//}"

.endif

.endfor

# SIDEBAR
.if defined(SIDEBAR) && $(SIDEBAR) && defined(SIDEBARRESULT) && $(SIDEBARRESULT) != ${SPECIALDIR}/${SIDEBARFILE}*
SIDEBAR_CONTENT != ${markdown} ${SIDEBARRESULT} |sed -e 's|\"|\\"|g'
.else
SIDEBAR_CONTENT = ""
sidebar_tpl = 'empty.file'
.endif

sidebar: ${TMPDIR}
	$Qcat ${sidebar_tpl} |${parser} "SIDEBAR_CONTENT=${SIDEBAR_CONTENT}" > ${TMPDIR}/${SIDEBAR_FILENAME}${PAGE_EXT}

sidebar_tmp_file = ${TMPDIR}/${SIDEBAR_FILENAME}${PAGE_EXT}
parser_opts += "SIDEBAR=`cat ${sidebar_tmp_file}`"
# end of SIDEBAR

# BEGIN
all: sidebar ${FILES:S/.md/${PAGE_EXT}/g:S/^/${POSTDIR}\//} ${DESTDIR}/${CSS_FILE} ${DESTDIR}/${INDEX_FILENAME}${PAGE_EXT} ${DESTDIR}/rss.xml ${POSTDIR}/${POSTDIR_INDEX} ${TAGDIR}/${TAGDIR_INDEX} ${MEDIAFILES:S/^${STATICDIR}/${DESTDIR}\//} ${ABOUTRESULT:S/^${SPECIALDIR}/${DESTDIR}/:S/.md$/${PAGE_EXT}/} ${THEMEMEDIAFILES:S/^${THEMEDIR}\/static\//${DESTDIR}\//}
	@# Clean up tmp directory (because of persistent sidebar.md file)
	$Q${rm} ${TMPDIR}/* -f

# Create target post file LIST
# EXAMPLE: pub/article1.xhtml
.for FILE in ${FILES}
TARGET_${FILE} = ${FILE:S/.md$/${PAGE_EXT}/:S/^/${POSTDIR}\//}
.endfor

# Create temporary files LIST (this temporary files will fetch some infos for Post List and Homepage)
# EXAMPLE: tmp/130435,article1.mk
.for FILE in ${DBFILES}
TMP_${FILE} = ${FILE:S/^/${TMPDIR}\//}
.endfor

# Do each FINAL post file
# EXAMPLE: pub/article1.xhtml
.for FILE in ${FILES}
CONTENT_TARGET_${FILE} != ${markdown} ${SRCDIR}/${FILE} |sed -e 's|\"|\\"|g' -e 's|`|``\\`|g'
# Linked DB file (that contains metadata)
DB_${FILE} != find ${DBDIR} -name "*,${FILE:S/.md$/.mk/}"
# Include it
.include "${DB_${FILE}}"
# Fetch some data for this post
TITLE_${FILE}      != echo "${TITLE}" |sed -e 's|</a> <a|</a>, <a|g' -e 's/\"/\\"/g'
TMSTMP_${FILE}     != echo ${DB_${FILE}:S/^${DBDIR}\///}| cut -d ',' -f 1
ESCAPED_TITLE_${FILE} != echo ${DB_${FILE}:S/^${DBDIR}\///}| cut -d ',' -f 2|sed -e 's|.mk$$||g'
POSTDATE_${FILE}   != ${date} -d "@${TMSTMP_${FILE}}" +'${DATE_FORMAT}'
SHORTDATE_${FILE}  != ${date} -d "@${TMSTMP_${FILE}}" +'${SHORT_DATE_FORMAT}'
DATETIME_${FILE}   != ${date} -d "@${TMSTMP_${FILE}}" +'%Y-%m-%dT%H:%M'
DESC_${FILE}       != echo "${DESCRIPTION:S/'/\'/}" |sed -e 's|</a> <a|</a>, <a|g' -e 's/\"/\\"/g'
TAGS_${FILE}       != echo ${TAGS} |sed -e 's/\([0-9a-zA-Z]*\) \([0-9a-zA-Z]*\)/\1_\2/g' -e 's/^_//g' -e 's/_$$//g' -e 's/,_/, /g' -e 's/_,/ ,/g' -e 's/,/ /g'
CLASS_TYPE_${FILE} != echo ${TYPE}
AUTHOR_${FILE}     != echo ${AUTHOR}

.for TAG in ${TAGS_${FILE}}
TAGLINK_${FILE}_${TAG} != cat "${taglink}" |${parser} \
	TAG_PAGE=${TAG}${PAGE_EXT} \
	TAG_NAME=${TAG}
TAGLIST_TMP_${FILE} += ${TAGLINK_${FILE}_${TAG}}
.endfor

TAGLIST_${FILE} != echo "${TAGLIST_TMP_${FILE}}" |sed -e 's|</a> <a|</a>, <a|g' -e 's/\"/\\"/g'

${TARGET_${FILE}}: ${DESTDIR} ${POSTDIR} ${SRCDIR}/${FILE}
	$Q{ \
		{ \
			cat ${header} | ${parser} ${parser_opts} &&    \
			cat ${article} |${parser}                      \
				"CONTENT=${CONTENT_TARGET_${FILE}}"          \
				"POST_TITLE=${TITLE_${FILE}}"                \
				"POST_ESCAPED_TITLE=${ESCAPED_TITLE_${FILE}}" \
				"ARTICLE_CLASS_TYPE=${CLASS_TYPE_${FILE}}"   \
				"POST_AUTHOR=${AUTHOR_${FILE}}"              \
				| sed -e "s|^|        |g" &&                 \
			cat ${footer} | ${parser} ${parser_opts};      \
		} > ${TARGET_${FILE}} || {                       \
			${rm} -f ${TARGET_${FILE}};                    \
			echo "-- Error while building ${TARGET_${FILE}}." ; \
			false                                             ; \
		} ; \
	} && echo "-- Page built: ${TARGET_${FILE}}."
.endfor

# Do each TMP post files
# EXAMPLE: tmp/130435,article1.mk AND tmp/130435,article1.mk.list AND tmp/130435,article1.mk.rss
.for FILE in ${DBFILES}
# Include post information (example title, date, description, etc.)
.include "${DBDIR}/${FILE}"
# Fetch some data for this post
TITLE_${FILE}      != echo "${TITLE}" |sed -e 's|</a> <a|</a>, <a|g' -e 's/\"/\\"/g'
TMSTMP_${FILE}     != echo ${FILE}| cut -d ',' -f 1
POSTDATE_${FILE}   != ${date} -d "@${TMSTMP_${FILE}}" +'${DATE_FORMAT}'
SHORTDATE_${FILE}  != ${date} -d "@${TMSTMP_${FILE}}" +'${SHORT_DATE_FORMAT}'
DATETIME_${FILE}   != ${date} -d "@${TMSTMP_${FILE}}" +'%Y-%m-%dT%H:%M'
ESCAPED_NAME_${FILE} != echo ${FILE}| sed -e 's|.mk$$||' -e 's|^.*,||'
NAME_${FILE}       != echo ${FILE}| sed -e 's|.mk$$|${PAGE_EXT}|' -e 's|^.*,||'
DESC_${FILE}       != echo "${DESCRIPTION:S/'/\'/}" |sed -e 's|</a> <a|</a>, <a|g' -e 's/\"/\\"/g'
CONTENT_${FILE}    != ${markdown} ${SRCDIR}/${NAME_${FILE}:S/${PAGE_EXT}$/.md/} |sed -e 's/\"/\\"/g' -e 's|`|``\\`|g'
# Change content if MAX_POST_LINES is defined
.if defined(MAX_POST_LINES) && $(MAX_POST_LINES)
READ_MORE_LINK_${FILE} != cat ${read_more}| ${parser} ${parser_opts} "POST_FILE=${NAME_${FILE}}" |sed -e 's/\"/\\"/g'
SIZE_${FILE} != cat ${SRCDIR}/${NAME_${FILE}:S/${PAGE_EXT}$/.md/} |wc -l
# Add a "Read more" link but only if post is more tall than MAX_POST_LINES
.if ${SIZE_${FILE}} > ${MAX_POST_LINES}
CONTENT_${FILE}  != head -n ${MAX_POST_LINES} ${SRCDIR}/${NAME_${FILE}:S/${PAGE_EXT}$/.md/} |${markdown} |sed -e 's/\"/\\"/g' && echo "${READ_MORE_LINK_${FILE}}"
.endif
.endif
TAGS_${FILE}       != echo ${TAGS} |sed -e 's/\([0-9a-zA-Z]*\) \([0-9a-zA-Z]*\)/\1_\2/g' -e 's/^_//g' -e 's/_$$//g' -e 's/,_/, /g' -e 's/_,/ ,/g' -e 's/,/ /g'
CLASS_TYPE_${FILE} != echo ${TYPE}
AUTHOR_${FILE}     != echo ${AUTHOR}

.for TAG in ${TAGS_${FILE}}
TAGLINK_${FILE}_${TAG} != cat "${taglink}" |${parser} \
	TAG_PAGE=${TAG}${PAGE_EXT} \
	TAG_NAME=${TAG}
TAGLIST_TMP_${FILE} += ${TAGLINK_${FILE}_${TAG}}
.endfor

TAGLIST_${FILE} != echo "${TAGLIST_TMP_${FILE}}" |sed -e 's|</a> <a|</a>, <a|g' -e 's/\"/\\"/g'

${TMP_${FILE}}: ${TMPDIR} ${POSTDIR} ${TARGET_${NAME_${FILE}}}
	@# Template for Post List page
	$Qcat ${element} | ${parser}                 \
		"POST_TITLE=${TITLE_${FILE}}"              \
		"DATE=${POSTDATE_${FILE}}"                 \
		"POST_ESCAPED_TITLE=${ESCAPED_NAME_${FILE}}" \
		"POST_FILE=${NAME_${FILE}}"                \
		"SHORT_DATE=${SHORTDATE_${FILE}}"          \
		"DATETIME=${DATETIME_${FILE}}"             \
		"TAG_LINKS_LIST=${TAGLIST_${FILE}}"        \
		"POST_AUTHOR=${AUTHOR_${FILE}}"            \
		"ARTICLE_CLASS_TYPE=${CLASS_TYPE_${FILE}}" \
		> ${TMPDIR}/${FILE}.list
	@# Template for Home page
	$Qcat ${article_idx} | ${parser} ${parser_opts} \
		"CONTENT=${CONTENT_${FILE}}"                  \
		"TITLE=${TITLE_${FILE}}"                      \
		"POST_ESCAPED_TITLE=${ESCAPED_NAME_${FILE}}"  \
		"POST_FILE=${NAME_${FILE}}"                   \
		"DATE=${POSTDATE_${FILE}}"                    \
		"DATETIME=${DATETIME_${FILE}}"                \
		"TAG_LINKS_LIST=${TAGLIST_${FILE}}"           \
		"POST_TITLE=${TITLE_${FILE}}"                 \
		"POST_AUTHOR=${AUTHOR_${FILE}}"               \
		"ARTICLE_CLASS_TYPE=${CLASS_TYPE_${FILE}}"    \
		> ${TMPDIR}/${FILE}
	@# Add article's title to page's header
	$Qcat ${POSTDIR}/${NAME_${FILE}} | ${parser} ${parser_opts} \
		"TITLE=${TITLE_${FILE}}"                   \
		"DATE=${POSTDATE_${FILE}}"                 \
		"DATETIME=${DATETIME_${FILE}}"             \
		"POST_ESCAPED_TITLE=${ESCAPED_NAME_${FILE}}" \
		"POST_FILE=${NAME_${FILE}}"                \
		"TAG_LINKS_LIST=${TAGLIST_${FILE}}"        \
		> ${TMPDIR}/${NAME_${FILE}}
	@# Move temporary file to pub
	$Q${mv} ${TMPDIR}/${NAME_${FILE}} ${POSTDIR}/${NAME_${FILE}}
	@# Template for RSS Feed
	$Qcat ${TMPLDIR}/feed.element.rss | ${parser}        \
		"TITLE=${TITLE_${FILE}}"                           \
		"DESCRIPTION=${CONTENT_${FILE}}"                   \
		"LINK=${BASE_URL}/${POSTDIR_NAME}/${NAME_${FILE}}" \
		"POST_AUTHOR=${AUTHOR_${FILE}}"                    \
	> ${TMPDIR}/${FILE}.rss
	@# Prepare TAGS
	$Qfor TAG in ${TAGS_${FILE}}; do                             \
		cat ${tagelement} | ${parser}                              \
			"TAGLINK=${BASE_URL}/${TAGDIR_NAME}/$${TAG}${PAGE_EXT}"  \
			"TAGNAME=$${TAG}"                                        \
		>> ${TMPDIR}/tags.list;                                    \
	done
	$Qfor TAG in ${TAGS_${FILE}}; do               \
		cat ${element} | ${parser} ${parser_opts}    \
			"POST_TITLE=${TITLE_${FILE}}"              \
			"DATE=${POSTDATE_${FILE}}"                 \
			"POST_ESCAPED_TITLE=${ESCAPED_NAME_${FILE}}" \
			"POST_FILE=${NAME_${FILE}}"                \
			"SHORT_DATE=${SHORTDATE_${FILE}}"          \
			"DATETIME=${DATETIME_${FILE}}"             \
			"TAG_LINKS_LIST=${TAGLIST_${FILE}}"        \
			"POST_AUTHOR=${AUTHOR_${FILE}}"            \
		>> ${TMPDIR}/$${TAG}.tag; \
	done
.endfor

# Do CSS file
${DESTDIR}/${CSS_FILE}: ${DESTDIR} ${STYLEDIR}/${CSS_FILE}
	$Qcat ${STYLEDIR}/${CSS_FILE} |${parser} ${parser_opts} \
		> ${DESTDIR}/${CSS_FILE} && \
		echo "-- CSS copied from ${THEME} theme: ${DESTDIR}/${CSS_FILE}"

# Do Homepage
# EXAMPLE: pub/index.xhtml
${DESTDIR}/${INDEX_FILENAME}${PAGE_EXT}: ${DESTDIR} ${TMPDIR} ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		cat ${header} >> ${TMPDIR}/index${PAGE_EXT} &&                               \
		cat ${MAINDBFILES:S/^/${TMPDIR}\//} >> ${TMPDIR}/index${PAGE_EXT} &&         \
		${rm} -f ${DBFILES:S/^/${TMPDIR}\//} &&                                         \
		cat ${footer} >> ${TMPDIR}/index${PAGE_EXT} &&                               \
		cat ${TMPDIR}/index${PAGE_EXT} |${parser} ${parser_opts}                     \
			"TITLE=${HOME_TITLE}"                                                         \
			"BODY_CLASS=home"                                                             \
			> ${TMPDIR}/index${PAGE_EXT}.tmp &&                                           \
		${mv} ${TMPDIR}/index${PAGE_EXT}.tmp ${DESTDIR}/${INDEX_FILENAME}${PAGE_EXT} && \
		${rm} ${TMPDIR}/index${PAGE_EXT} || {                                           \
			echo "-- Could not build index page: $@" ;                    \
			false ;                                                          \
		} ;                                                                \
	} && echo "-- Index page built: $@"

# Do RSS Feed
# EXAMPLE: pub/rss.xml
${DESTDIR}/rss.xml: ${DESTDIR} ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		cat ${TMPLDIR}/feed.header.rss | ${parser} ${parser_opts} \
			> ${DESTDIR}/rss.xml &&                \
		cat ${RSSDBFILES:S/^/${TMPDIR}\//:S/$/.rss/} >> ${DESTDIR}/rss.xml && \
		${rm} -f ${RSSDBFILES:S/^/${TMPDIR}\//:S/$/.rss/} && \
		cat ${TMPLDIR}/feed.footer.rss >> ${DESTDIR}/rss.xml || { \
			echo "-- Could not build RSS page: $@" ; \
			false ; \
		} ; \
	} && echo "-- RSS page built: $@"

# Do Post List page
# EXAMPLE: pub/list.xhtml
${POSTDIR}/${INDEX_FILENAME}${PAGE_EXT}: ${POSTDIR} ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		cat ${header} >> ${TMPDIR}/list${PAGE_EXT} &&                              \
		cat ${DBFILES:S/^/${TMPDIR}\//:S/$/.list/} >> ${TMPDIR}/list${PAGE_EXT} && \
		${rm} -f ${DBFILES:S/^/${TMPDIR}\//:S/$/.list/} &&                            \
		cat ${footer} >> ${TMPDIR}/list${PAGE_EXT} &&                              \
		cat ${TMPDIR}/list${PAGE_EXT} | ${parser} ${parser_opts}                   \
			"TITLE=${POST_LIST_TITLE}"                                                  \
			> ${POSTDIR}/${INDEX_FILENAME}${PAGE_EXT} &&                                \
    ${rm} ${TMPDIR}/list${PAGE_EXT} || {                                          \
			echo "-- Could not build list page: $@" ;                           \
			false ;                                                                \
		} ;                                                                      \
	} && echo "-- List page built: $@"

# Do Tag List page
# EXAMPLE: pub/tags/index.xhtml
${TAGDIR}/${INDEX_FILENAME}${PAGE_EXT}: ${TAGDIR} ${DBFILES:S/^/${TMPDIR}\//}
	$Q{ \
		cat ${header} > ${TMPDIR}/taglist${PAGE_EXT} &&             \
		cat ${tags} | ${parser} ${parser_opts}                      \
			"TAG_LIST_TITLE=${TAG_LIST_TITLE}"                           \
			"TAGLIST_CONTENT=`cat ${TMPDIR}/tags.list |${sort} -u`"   \
			>> ${TMPDIR}/taglist${PAGE_EXT} &&                           \
		cat ${footer} >> ${TMPDIR}/taglist${PAGE_EXT} &&            \
		cat ${TMPDIR}/taglist${PAGE_EXT} | ${parser} ${parser_opts} \
		  "BODY_CLASS=tags"                                            \
			"TITLE=${TAG_LIST_TITLE}"                                    \
		> ${TAGDIR}/${INDEX_FILENAME}${PAGE_EXT} &&                    \
		${rm} ${TMPDIR}/tags.list &&                                   \
		${rm} ${TMPDIR}/taglist${PAGE_EXT} ||                          \
		{                                                              \
			echo "-- Could not build tag list page: $@" ;             \
			false ;                                                      \
		} ;                                                            \
	} && echo "-- Tag list built: $@"
	$Qfor TAG in `cd ${TMPDIR};ls *.tag|sed -e 's|.tag$$||g'`; do        \
		cat ${header} > ${TMPDIR}/$${TAG}.tag${PAGE_EXT} &&                    \
		cat ${TMPDIR}/$${TAG}.tag >> ${TMPDIR}/$${TAG}.tag${PAGE_EXT} &&        \
		cat ${footer} >> ${TMPDIR}/$${TAG}.tag${PAGE_EXT} &&                     \
		cat ${TMPDIR}/$${TAG}.tag${PAGE_EXT} | ${parser} ${parser_opts}         \
			"TITLE=$${TAG}"                                                           \
			> ${TAGDIR}/$${TAG}${PAGE_EXT} &&                                       \
			${rm} ${TMPDIR}/$${TAG}.tag${PAGE_EXT} && ${rm} -f ${TMPDIR}/$${TAG}.tag; \
		done

# Clean all directories
# EXAMPLE: pub/* AND tmp/*
clean:
	$Q${rm} -rf ${DESTDIR}/*
	$Q${rm} -f ${TMPDIR}/*
	$Q${rm} -f ${DOCDIR}/*${PAGE_EXT}

# Create documentation
.for FILE in ${DOCFILESRESULT}

${FILE:S/.md$/${PAGE_EXT}/}: ${DOCDIR}
	$Q{                                                    \
		${markdown} ${FILE} > ${FILE:S/.md$/${PAGE_EXT}/} || \
		{                                                    \
			echo "-- Could not build doc file: $@" ;        \
		} ;                                                  \
	} && echo "-- Doc file built: $@"

.endfor

doc: ${DOCFILESRESULT:S/.md$/${PAGE_EXT}/}

# Backup: save important files
TODAY != date '+%Y%m%d'
backup: makefly.rc ${BACKUPDIR}
	$Q{ \
		${tar} cfz ${BACKUPDIR}/${TODAY}_makefly.tar.gz makefly.rc ${STATICDIR} ${DBDIR} ${SRCDIR} ${SPECIALDIR} || \
		{ \
			echo "-- Backup failed!" ; \
			false ; \
		} ; \
	} && echo "-- Files successfully saved in ${BACKUPDIR}: makefly.rc, ${STATICDIR}, ${DBDIR}, ${SRCDIR} and ${SPECIALDIR}."

# Publish: send files out
publish_script = ${TOOLSDIR}/${PUBLISH_SCRIPT_NAME}
PUBDIR != echo ${DESTDIR:S/^.\//${MAKEFLYDIR}\//}
publish: ${DESTDIR}
	$Q{ \
		cat ${publish_script} |${parser} \
			"DESTDIR=${PUBDIR}" \
			"PUBLISH_DESTINATION=${PUBLISH_DESTINATION}" \
			> ${TMPDIR}/${PUBLISH_SCRIPT_NAME} && \
			chmod +x ${TMPDIR}/${PUBLISH_SCRIPT_NAME} && \
			${TMPDIR}/${PUBLISH_SCRIPT_NAME} && \
			${rm} -f ${TMPDIR}/${PUBLISH_SCRIPT_NAME} || \
		{ \
			${rm} -f ${TMPDIR}/${PUBLISH_SCRIPT_NAME} ; \
			echo "-- Publication failed!" ; \
			false ; \
		} ; \
	} && echo "-- Publish ${DESTDIR} content with ${publish_script}: OK."

# END
.MAIN: all

# vim:tabstop=2:softtabstop=2:shiftwidth=2:noexpandtab
