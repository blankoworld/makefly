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

--[[ Variables ]]--
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
local page_jskomment_script = templatepath .. '/' .. config.jskomment_jsfilename
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
local rss_name_default = 'rss' -- rss default name
local rss_extension_default = '.xml' -- rss file extension
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
-- vim:expandtab:smartindent:tabstop=2:softtabstop=2:shiftwidth=2:
