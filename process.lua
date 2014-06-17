#!/usr/bin/env lua
-------------------------------------------------------------------------------
-- Core: Process db and src directory to create a result in a 'public' directory
-- - get libraries
-- - initialize configuration
-- - prepare the location
-- - copy CSS files
-- - prepare some translations for templates
-- - create eli's badge
-- - create sidebar
-- - create searchbar
-- - create introduction/conclusion paragraphs
-- - create about's page
-- - copy static directory
-- - parse db files
-- - create each post file
-- - create post index file
-- - create each tag file
-- - create tag index file
-- - create homepage
-- - delete temporary files
-- @author Olivier DOSSMANN
-- @copyright Olivier DOSSMANN
-------------------------------------------------------------------------------

--[[Depends

LuaFileSystem is required: 
luarocks install luafilesystem

Markdown is required:
luarocks install markdown

]]--

require 'lib.init'
local utils = require 'lib.utils'
require 'lib.rope'

require 'markdown'

--[[ Variables ]]--
-- default's directories
local dbpath = os.getenv('DBDIR') or currentpath .. '/db'
local srcpath = os.getenv('SRCDIR') or currentpath .. '/src'
local tmppath = os.getenv('TMPDIR') or currentpath .. '/tmp'
local templatepath = os.getenv('TMPLDIR') or currentpath .. '/template'
local staticpath = os.getenv('STATICDIR') or currentpath .. '/static'
local specialpath = os.getenv('SPECIALDIR') or currentpath .. '/special'
local publicpath = os.getenv('DESTDIR') or currentpath .. '/pub'
local pagepath = os.getenv('PAGEDIR') or currentpath .. '/pages'
-- default's files
local makeflyrcfile = os.getenv('conf') or 'makefly.rc'
local themercfile = 'config.mk'
local jskomment_js_filename = 'jskomment.js'
local introduction_filename = 'introduction'
local footer_filename = 'footer'
-- theme filenames
local template_extension_default = os.getenv('TMPL_EXT') or '.tmpl'
local page_header_name = 'header' .. template_extension_default
local page_footer_name = 'footer' .. template_extension_default
local page_posts_name = 'post.index' .. template_extension_default
local page_article_name = 'article' .. template_extension_default
local page_homepage_article_name = 'article.index' .. template_extension_default
local page_post_element_name = 'element' .. template_extension_default
local page_tag_element_name = 'tagelement' .. template_extension_default
local page_tag_link_name = 'taglink' .. template_extension_default
local page_tag_index_name = 'tags' .. template_extension_default
local page_sidebar_name = 'sidebar' .. template_extension_default
local page_searchbar_name = 'menu.search_bar' .. template_extension_default
local page_about_name = 'menu.about' .. template_extension_default
local page_read_more_name = 'read_more_link' .. template_extension_default
local page_pagination_name = 'pagination' .. template_extension_default
local page_jskomment = templatepath .. '/' .. 'jskomment.article' .. template_extension_default
local page_jskomment_declaration = templatepath .. '/' .. 'jskomment_declaration' .. template_extension_default
local page_jskomment_css_declaration = templatepath .. '/' .. 'jskomment_css_declaration' .. template_extension_default
local page_jskomment_script = templatepath .. '/' .. jskomment_js_filename
local page_jskomment_css_name = 'jskomment.css'
local page_rss_header = templatepath .. '/' .. 'feed.header.rss'
local page_rss_element = templatepath .. '/' .. 'feed.element.rss'
local page_rss_footer = templatepath .. '/' .. 'feed.footer.rss'
local page_eli_content = templatepath .. '/' .. 'eli_content' .. template_extension_default
local page_eli_css = templatepath .. '/' .. 'eli.css'
local page_eli_declaration = templatepath .. '/' .. 'eli_declaration' .. template_extension_default
local page_eli_css_declaration = templatepath .. '/' .. 'eli_css_declaration' .. template_extension_default
local page_eli_script = templatepath .. '/' .. 'eli.js'
-- others
local blog_url = os.getenv('BLOG_URL') or ''
local version = os.getenv('VERSION') or 'unknown-trunk'
replacements = {} -- substitution table
local today = os.time() -- today's timestamp
local tags = {}
local lang = os.getenv('LANG') or en_US.utf-8 -- default user language (could be overwritten by using LANG= before script)
-- set language for Lua
os.setlocale(lang)
-- default values
local datetime_format_default = '%Y-%m-%dT%H:%M'
local date_format_default = '%Y-%m-%d at %H:%M'
local short_date_format_default = '%Y/%m'
local theme_default = "minisch" -- theme
local postdir_name_default = 'posts' -- name for posts directory
local tagdir_name_default = 'tags' -- name for tags directory
local about_default = 'about' -- about's page name in special directory
local intro_default = 'introduction' -- name introduction page in special directory
local footer_default = 'footer' -- footer's name in special directory
local sidebar_default = 'sidebar' -- sidebar's name in special directory
local bodyclass_default = 'single' -- body class for pages
local index_name_default = 'index' -- index name
local rss_name_default = 'rss' -- rss default name
local extension_default = '.html' -- file extension for HTML pages
local rss_extension_default = '.xml' -- rss file extension
local source_extension_default = '.md' -- source file default extension (markdown here)
local max_post_default = 3 -- number of posts displayed on homepage
local max_post_lines_default = nil -- no post limitations
local max_rss_default = 5 -- number of posts displayed in RSS Feed
local sort_default = 'desc' -- sort order (asc or desc)
local max_page_default = 0 -- number of posts displayed by page on post's list (0 = no limit)
local jskomment_max_default = 3 -- number of comments displayed by default for each post
local jskomment_url_default = 'http://jskomment.appspot.com' -- default URL of JSKOMMENT comment system
local jskomment_captcha_theme_default = 'white'
local eli_css_name = 'eli.css'
local eli_js_filename = 'eli.js'
local eli_max_default = 5
local eli_type_default = 'user'
local eli_tmp_file = tmppath .. '/' .. 'content.eli'
-- default display values
display_info =    _('  INFO   ')
display_success = _(' SUCCESS ')
display_enable =  _(' ENABLE  ')
display_disable = _(' DISABLE ')
display_warning = _(' WARNING ')
display_error =   _('  ERROR  ')
-- default mandatories variables
local mandatories_makeflyrc_vars = { 'BLOG_TITLE', 'BLOG_DESCRIPTION', 'BLOG_URL' }
local mandatories_post_vars = { 'TITLE', 'TAGS', 'AUTHOR' }

--[[ MAIN ]]--
-- create thread table
threads = {}

-- Get makefly's configuration
makeflyrc = utils.getConfig(makeflyrcfile)
language = makeflyrc['BLOG_LANG'] or language_default
-- FIXME: permit user to choose its own extension
source_extension = source_extension_default
-- FIXME: regarding user default extension choice do a script that will use the right parser (markdown, etc.)
-- FIXME: place here the code

-- Check some variables presence
print (string.format(_("-- [%s] Check mandatories information"), display_info))
local missing_makeflyrc_info = utils.processMissingInfo(makeflyrc, mandatories_makeflyrc_vars)
-- Check that all is OK, otherwise display an error message and quit the program
if missing_makeflyrc_info ~= '' then
  print(string.format(_("-- [%s] Missing information in %s file: %s"), display_error, makeflyrcfile, missing_makeflyrc_info))
  os.exit(1)
end

-- Set variables regarding user configuration
index_tmp_name = makeflyrc['INDEX_FILENAME'] or index_name_default
index_name = utils.keepUnreservedCharsAndDeleteDuplicate(index_tmp_name)
resultextension = makeflyrc['PAGE_EXT'] or extension_default
theme = makeflyrc['THEME'] or theme_default
themepath = templatepath .. '/' .. theme
postdir_name = makeflyrc['POSTDIR_NAME'] or postdir_name_default
tagdir_name = makeflyrc['TAGDIR_NAME'] or tagdir_name_default
bodyclass = makeflyrc['BODY_CLASS'] or bodyclass_default
postpath = publicpath .. '/' .. postdir_name
tagpath = publicpath .. '/' .. tagdir_name
index_filename = index_name .. resultextension
date_format = makeflyrc['DATE_FORMAT'] or date_format_default
short_date_format = makeflyrc['SHORT_DATE_FORMAT'] or short_date_format_default
max_post = makeflyrc['MAX_POST'] and tonumber(makeflyrc['MAX_POST']) or max_post_default
max_post_lines = makeflyrc['MAX_POST_LINES'] and tonumber(makeflyrc['MAX_POST_LINES']) or max_post_lines_default
max_rss = makeflyrc['MAX_RSS'] and tonumber(makeflyrc['MAX_RSS']) or max_rss_default
max_page = makeflyrc['MAX_PAGE'] and tonumber(makeflyrc['MAX_PAGE'] or max_page_default)
jskomment_max = makeflyrc['JSKOMMENT_MAX'] and tonumber(makeflyrc['JSKOMMENT_MAX']) or jskomment_max_default
jskomment_url = makeflyrc['JSKOMMENT_URL'] or jskomment_url_default
-- Check if an order have been set for sorting posts
user_sort_choice = sort_default
if makeflyrc['SORT'] ~= nil and makeflyrc['SORT'] ~= '' then
  for id_nb, sort_value in pairs({'ASC', 'asc', 'desc', 'DESC'}) do
    if sort_value == makeflyrc['SORT'] then
      user_sort_choice = string.lower(makeflyrc['SORT'])
    end
  end
end
-- Display which theme the user have choosed
print (string.format(_("-- [%s] Theme: %s"), display_info, theme))

-- Check that given them exists
if lfs.attributes(templatepath .. '/' .. theme) == nil then
  print(string.format(_("-- [%s] Given theme (%s) seems to not exist."), display_error, theme))
  os.exit(1)
end

-- Check that user choice doesn't conflict with default templates extension
if resultextension == template_extension_default then
  print(string.format(_("-- [%s] You cannot choose an extension (%s) similar to template's one (%s)."), display_error, resultextension, template_extension_default))
  os.exit(1)
end

-- Get language configuration
languagefile = langpath .. '/translate.' .. language
if lfs.attributes(languagefile) == nil then
  languagefile = langpath .. '/translate.' .. language_default
  print(string.format(_("-- [%s] No '%s' translation. Use default one: %s."), display_warning, language, language_default))
end
languagerc = utils.getConfig(languagefile)

-- Check if needed directories exists. Otherwise create them
for k,v in pairs({tmppath, publicpath, postpath, tagpath}) do
  utils.checkDirectory(v)
end

-- Create path for template's files
local page_header = themepath .. '/' .. page_header_name
local page_footer = themepath .. '/' .. page_footer_name
local page_article_single = themepath .. '/' .. page_article_name
local page_post_element = themepath .. '/' .. page_post_element_name
local page_tag_element = themepath .. '/' .. page_tag_element_name
local page_tag_link = themepath .. '/' .. page_tag_link_name
local page_sidebar = themepath .. '/' .. page_sidebar_name
local page_searchbar = themepath .. '/' .. page_searchbar_name
local page_article_index = themepath .. '/' .. page_homepage_article_name

-- Read template configuration file
local themerc = utils.getConfig(themepath .. '/' .. themercfile)

-- Some values that comes from template configuration file
local jskomment_captcha_theme = makeflyrc['JSKOMMENT_CAPTCHA_THEME'] or themerc['JSKOMMENT_CAPTCHA_THEME'] or jskomment_captcha_theme_default

-- Read template's mandatory files
header = utils.readFile(page_header, 'r')
footer = utils.readFile(page_footer, 'r')

-- Create CSS files
css_file = themepath .. '/style/' .. themerc['CSS_FILE']
local css_color_file_name = themerc['CSS_COLOR_FILE']
if makeflyrc['FLAVOR'] and makeflyrc['FLAVOR'] ~= '' then
  local css_color_file_test = 'color_' .. theme .. '_' .. makeflyrc['FLAVOR'] .. '.css'
  local css_color_file_attr = lfs.attributes(themepath .. '/style/' .. css_color_file_test)
  if css_color_file_attr and css_color_file_attr.mode == 'file' then
    css_color_file_name = css_color_file_test
  else
    print (string.format(_("-- [%s] Wrong flavor: %s"), display_warning, makeflyrc['FLAVOR']))
  end
  print (string.format(_("-- [%s] Specific flavor: %s"), display_info, makeflyrc['FLAVOR']))
end
css_color_file = themepath .. '/style/' .. css_color_file_name
if themerc['JSKOMMENT_CSS'] then
  jskomment_css_file = themepath .. '/' .. themerc['JSKOMMENT_CSS']
  jskomment_css_filename = themerc['JSKOMMENT_CSS']
else
  jskomment_css_file = templatepath .. '/' .. page_jskomment_css_name
  jskomment_css_filename = page_jskomment_css_name
end
table.insert(threads, coroutine.create(function () utils.copyFile(css_file, publicpath .. '/' .. themerc['CSS_FILE'], { BLOG_URL = blog_url }) end))
table.insert(threads, coroutine.create(function () utils.copyFile(css_color_file, publicpath .. '/' .. themerc['CSS_COLOR_FILE']) end))
-- Copy static theme directory
theme_static_directory = themepath .. '/static'
table.insert(threads, coroutine.create(function () utils.copy(theme_static_directory, publicpath, { BLOG_URL = blog_url }) end))

-- Add result to replacements table (to substitute ${VARIABLES} in files)
replacements = {
  VERSION = version,
  BLOG_TITLE = makeflyrc['BLOG_TITLE'],
  BLOG_DESCRIPTION = makeflyrc['BLOG_DESCRIPTION'],
  BLOG_SHORT_DESC = makeflyrc['BLOG_SHORT_DESC'],
  BLOG_URL = blog_url,
  BLOG_AUTHOR = makeflyrc['BLOG_AUTHOR'] or '',
  BLOG_COPYRIGHT = makeflyrc['BLOG_COPYRIGHT'] or '&copy; ' .. os.date('%Y', today),
  KEYWORDS = makeflyrc['BLOG_KEYWORDS'] or '',
  LANG = makeflyrc['BLOG_LANG'],
  BLOG_CHARSET = makeflyrc['BLOG_CHARSET'],
  RSS_FEED_NAME = makeflyrc['RSS_FEED_NAME'],
  SIDEBAR = '',
  ARTICLE_CLASS_TYPE = 'normal',
  SEARCHBAR = '',
  JSKOMMENT_SCRIPT = '',
  JSKOMMENT_CSS_DECLARATION = '',
  JSKOMMENT_CONTENT = '',
  ELI_SCRIPT = '',
  ELI_CONTENT = '',
  ELI_CSS = '',
  ELI_CSS_DECLARATION = '',
  ELI_STATUS = '',
  INTRO_CONTENT = '',
  FOOTER_CONTENT = '',
  ABOUT_LINK = '',
  ABOUT_FILENAME = '',
  CSS_NAME = themerc['CSS_NAME'],
  CSS_FILE = themerc['CSS_FILE'],
  CSS_COLOR_FILE = themerc['CSS_COLOR_FILE'],
  JSKOMMENT_CSS = themerc['JSKOMMENT_CSS'],
  TAGDIR_NAME = tagdir_name,
  POSTDIR_NAME = postdir_name,
  BODY_CLASS = bodyclass,
  POSTDIR_INDEX = index_filename,
  TAGDIR_INDEX = index_filename, -- FIXME: delete these two var to add a new one: INDEX_FILENAME which is better for indexes.
}

-- Add language translation to replacements table
for k, v in pairs(languagerc) do 
  replacements[k] = v
end

-- Check about's page presence
about_filename = makeflyrc['ABOUT_FILENAME'] or about_default
about_file_path = specialpath .. '/' .. about_filename .. source_extension
about_file = utils.readFile(about_file_path, 'r')
if about_file ~= '' then
  print (string.format(_("-- [%s] About's page available"), display_enable))
  replacements['ABOUT_INDEX'] = about_filename .. resultextension
  replacements['ABOUT_LINK'] = blog.stuffTemplate(themepath .. '/' .. page_about_name, '', '', '', false)
else
  print (string.format(_("-- [%s] About's page not found"), display_disable))
end

-- ELI badge
if makeflyrc['ELI_USER'] and makeflyrc['ELI_API'] then
  print (string.format(_("-- [%s] ELI badge"), display_enable))
  -- Set default ELI mandatory variables
  eli_max = makeflyrc['ELI_MAX'] and tonumber(makeflyrc['ELI_MAX']) or eli_max_default
  eli_type = makeflyrc['ELI_TYPE'] or eli_type_default
  -- copy ELI css file
  table.insert(threads, coroutine.create(function () utils.copyFile(page_eli_css, publicpath .. '/' .. eli_css_name) end))
  replacements['ELI_CSS'] = eli_css_name
  -- copy ELI script to public directory
  local template_eli_script = utils.readFile(page_eli_script, 'r')
  local eli_script = assert(io.open(publicpath .. '/' .. eli_js_filename, 'wb'))
  eli_script_substitutions = utils.getSubstitutions(replacements, {ELI_MAX=eli_max,ELI_TYPE=eli_type,ELI_API=makeflyrc['ELI_API'],ELI_USER=makeflyrc['ELI_USER']})
  local eli_script_replace = utils.replace(template_eli_script, eli_script_substitutions)
  eli_script:write(eli_script_replace)
  assert(eli_script:close())
  -- ELI script declaration in all pages
  local template_eli_declaration = utils.readFile(page_eli_declaration, 'r')
  replacements['ELI_SCRIPT'] = utils.replace(template_eli_declaration, {eli_name=eli_js_filename, BLOG_URL=blog_url})
  -- ELI CSS declaration in all pages
  local template_eli_css_declaration = utils.readFile(page_eli_css_declaration, 'r')
  replacements['ELI_CSS_DECLARATION'] = utils.replace(template_eli_css_declaration, replacements)
  -- FIXME: get ELI status (with lua socket or anything else)
--  local eli_cmd = 'curl -s ${ELI_API}users/show/${ELI_USER}.xml |grep -E "<text>(.+)</text>"|sed "s/<[/]*text>//g" > ${eli_tmp_file}'
--  eli_cmd = utils.replace(eli_cmd, {ELI_MAX=eli_max,ELI_TYPE=eli_type,ELI_API=makeflyrc['ELI_API'],ELI_USER=makeflyrc['ELI_USER'], eli_tmp_file=eli_tmp_file})
--  status_return = assert(os.execute(eli_cmd))
--  if status_return == 0 then
--    local eli_status = utils.readFile(eli_tmp_file, 'r')
--    replacements['ELI_STATUS'] = eli_status
--  end
  replacements['ELI_STATUS'] = languagerc['ELI_DEFAULT_STATUS'] or ''
  -- read ELI content to add it in all pages
  replacements['ELI_CONTENT'] = blog.stuffTemplate(page_eli_content, '', '')
else
  print (string.format(_("-- [%s] ELI badge"), display_disable))
end

-- Sidebar (display that's active/inactive)
local sidebar_filename = (makeflyrc['SIDEBAR_FILENAME'] or sidebar_default) .. source_extension
if (makeflyrc['SIDEBAR'] and makeflyrc['SIDEBAR'] == '1') or (themerc['SIDEBAR'] and themerc['SIDEBAR'] == '1') then
  print (string.format(_("-- [%s] Sidebar"), display_enable))
  local sidebar_content = utils.readFile(specialpath .. '/' .. sidebar_filename, 'r')
  replacements['SIDEBAR'] = blog.stuffTemplate(page_sidebar, sidebar_content, 'SIDEBAR_CONTENT', 'markdown', true)
else
  print (string.format(_("-- [%s] Sidebar"), display_disable))
end

-- Search bar
if makeflyrc['SEARCH_BAR'] and makeflyrc['SEARCH_BAR'] == '1' then
  print (string.format(_("-- [%s] Search bar"), display_enable))
  replacements['SEARCHBAR'] = blog.stuffTemplate(page_searchbar)
else
  print (string.format(_("-- [%s] Search bar"), display_disable))
end

-- JSKOMMENT system
-- FIXME: Delete "link" tag in header file for JSKOMMENT css file (it's useless)
if makeflyrc['JSKOMMENT'] and makeflyrc['JSKOMMENT'] == '1' then
  print (string.format(_("-- [%s] Comment system"), display_enable))
  -- copy jskomment css file
  table.insert(threads, coroutine.create(function () utils.copyFile(jskomment_css_file, publicpath .. '/' .. jskomment_css_filename) end))
  replacements['JSKOMMENT_CSS'] = jskomment_css_filename
  -- copy jskomment javascript
  local template_jskomment_script = utils.readFile(page_jskomment_script, 'r')
  local jskomment_script = assert(io.open(publicpath .. '/' .. jskomment_js_filename, 'wb'))
  jskomment_script_substitutions = utils.getSubstitutions(replacements, {JSKOMMENT_URL=jskomment_url,JSKOMMENT_MAX=jskomment_max,JSKOMMENT_CAPTCHA_THEME=jskomment_captcha_theme})
  jskomment_script_content = utils.replace(template_jskomment_script, jskomment_script_substitutions)
  jskomment_script:write(jskomment_script_content)
  assert(jskomment_script:close())
  -- jskomment javascript declaration in all pages
  local template_jskomment_declaration = utils.readFile(page_jskomment_declaration, 'r')
  replacements['JSKOMMENT_SCRIPT'] = utils.replace(template_jskomment_declaration, {jskom_name=jskomment_js_filename, BLOG_URL=blog_url})
  -- jskomment css declaration in all pages
  local template_jskomment_css_declaration = utils.readFile(page_jskomment_css_declaration, 'r')
  replacements['JSKOMMENT_CSS_DECLARATION'] = utils.replace(template_jskomment_css_declaration, replacements)
  -- read different templates for next processes
  template_comment = utils.readFile(page_jskomment, 'r')
else
  print (string.format(_("-- [%s] Comment system"), display_disable))
end

-- Introduction / footer file
-- prepare a list of special files
special_files = {
  INTRO = introduction_filename .. source_extension,
  FOOTER = footer_filename .. source_extension,
}
-- browse them
for i, j in pairs(special_files) do
  -- read special file if exists
  local special_file_path = specialpath .. '/' .. j
  local special_file = utils.readFile(special_file_path, 'r')
  if special_file and special_file ~= '' then
    print (string.format(_("-- [%s] %s"), display_enable, i))
    local special_file_final_content = utils.replace(markdown(special_file), replacements)
    replacements[i .. '_CONTENT'] = special_file_final_content
  else
    print (string.format(_("-- [%s] %s"), display_disable, i))
  end
end

-- Create about's page if exists
if about_file then
  -- create content
  about_markdown = markdown(about_file)
  about_replaced = utils.replace(about_markdown, replacements)
  -- construct about's page
  about = rope()
  about:push(header)
  about:push(about_replaced)
  about:push(footer)
  -- do replacements
  about_substitutions = utils.getSubstitutions(replacements, {TITLE=languagerc['ABOUT_TITLE'], BODY_CLASS='about'})
  about_content = utils.replace(about:flatten(), about_substitutions)
  -- write changes
  about_file_result = assert(io.open(publicpath .. '/' .. utils.keepUnreservedCharsAndDeleteDuplicate(makeflyrc['ABOUT_FILENAME'] or about_default) .. extension_default, 'wb'))
  about_file_result:write(about_content)
  about_file_result:close()
end

-- Copy static directory content to public path
static_directory = staticpath
utils.copy(static_directory, publicpath, { BLOG_URL = blog_url })
print (string.format(_("-- [%s] Folder content copied: %s"), display_success, staticpath))

-- Browse DB files
local post_files = {}
dbresult = utils.listing (dbpath, "mk")
if dbresult then
  for k,v in pairs(dbresult) do
    -- parse DB files to get metadata and posts'title
    local postConf = utils.getConfig(v)
    -- Check some variables presence
    local missing_post_info = utils.processMissingInfo(postConf, mandatories_post_vars)
    -- Check that all is OK, otherwise display an error message and quit the program
    local timestamp, postTitle = string.match(v, "(%d+),(.+)%.mk")
    if missing_post_info ~= '' then
      print(string.format(_("-- [%s] Missing information in '%s' post: %s"), display_error, postTitle, missing_post_info))
      os.exit(1)
    end
    if today > tonumber(timestamp) then
      table.insert(post_files, {file=v, conf=postConf})
      local co = coroutine.create(function () blog.createPost(v, postConf, {template_file=page_article_single, template_tag_file=page_tag_link}) end)
      table.insert(threads, co)
    end
  end
else
  print (string.format(_("-- [%s] No DB file(s) found!"), display_warning))
end

-- Add static pages to the dispatcher
pages_result = utils.listing(pagepath, 'md')
if pages_result then
  for k,v in pairs(pages_result) do
    local pagetitle = string.match(v, ".+/(.+)%.md")
    local pagefile = publicpath .. '/' .. utils.keepUnreservedCharsAndDeleteDuplicate(pagetitle) .. resultextension
    local co = coroutine.create(function () blog.createPage(v, pagefile, pagetitle) end)
    table.insert(threads, co)
  end
else
  print (string.format(_("-- [%s] No static page(s) found."), display_info))
end

-- launch dispatcher to create each post and more (copy needed directories/files, etc.)
utils.dispatcher()

-- Create post's index
blog.createPostIndex(post_files, {
  index_file = themepath .. '/' .. page_posts_name,
  element_file = page_post_element,
  taglink_file = page_tag_link,
  article_index_file = page_article_index
})

-- Create tag's files: index and each tag's page
-- {template_index_filename, template_element_filename})
blog.createTagIndex(index_filename, {
  template_index_filename = themepath .. '/' .. page_tag_index_name,
  template_element_filename = page_tag_element
})

-- Create index
blog.createHomepage(publicpath .. '/' .. index_filename, languagerc['HOME_TITLE'])

-- Delete temporary files
for tag, posts in pairs(tags) do
  for i, post in pairs(posts) do
    os.remove(tmppath .. '/' .. post)
  end
end
-- delete posts that appear on homepage
local index_nb = 0
while index_nb <= max_post do
  local displayednumber = index_nb + 1
  local indexpath = tmppath .. '/' .. 'index.' .. displayednumber .. '.tmp'
  os.remove(indexpath)
  index_nb = index_nb + 1
end

--[[ END ]]--
return 0

-- vim:expandtab:smartindent:tabstop=2:softtabstop=2:shiftwidth=2:
