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

--[[ Methods ]]--

-------------------------------------------------------------------------------
-- Read '@filepath' and do substitutions using 'replacements' global table.
-- @param filepath absolute/relative path to the file to read (will use 'r' mode)
-- @param content if '@option' is set to 'markdown' and '@variable' given, this will set '@content' into '@variable' for next replacements
-- @param variable name of variable to use in order to replace it by '@content' string
-- @param option if set to 'markdown', use markdown format for '@content' variable. If no one, do nothing.
-- @param double_replacement if set to true, then do replacement twice. First on file, then on result.
-- @return a string that contains process result
-------------------------------------------------------------------------------
function stuffTemplate(filepath, content, variable, option, double_replacement)
  -- default initialization
  local double = nil
  local result = ''
  local markdown_content = ''
  -- get markdown result of content if option is 'markdown'
  if option and option == 'markdown' and content then
    markdown_content = markdown(content)
  end
  -- activate double replacement function if double_replacement not nil
  if double_replacement then
    double = true
  end
  -- get file content
  file = utils.readFile(filepath, 'r')
  if file then
    local template_table = {}
    -- if no content or no variable, it's useless to complete template_table
    if content and variable then
      template_table[variable] = markdown_content
    end
    -- do replacements
    local substitutions = utils.getSubstitutions(replacements, template_table)
    if double then
      local tmp_result = utils.replace(file, substitutions)
      result = utils.replace(tmp_result, replacements)
    else
      result = utils.replace(file, substitutions)
    end
  end
  return result
end

-------------------------------------------------------------------------------
-- Check config to generate keywords
-- @param config post configuration (table)
-- @return A keywords rope()
-------------------------------------------------------------------------------
function getKeywords(config)
  local result = rope()
  if config['KEYWORDS'] ~= nil then
    result:push (config['KEYWORDS'])
  end
  if config['TAGS'] then
    if result:flatten() ~= '' then
      result:push(',')
    end
    result:push(config['TAGS'])
  end
  if makeflyrc['BLOG_KEYWORDS'] then
    if result:flatten() ~= '' then
      result:push(',')
    end
    result:push (makeflyrc['BLOG_KEYWORDS'])
  end
  return result
end

-------------------------------------------------------------------------------
-- Add specific comments substitutions (JSKOMMENT_CONTENT variable)
-- @param sub Substitutions table
-- @param config Post configuration table
-- @param title Post title
-- @return Substitutions table with JSKOMMENT_CONTENT if needed
-------------------------------------------------------------------------------
function commentSubstitutions(sub, config, title)
  if template_comment then
    local jskomment_prefix = config['JSKOMMENT_PREFIX'] and config['JSKOMMENT_PREFIX'] ~= '' and config['JSKOMMENT_PREFIX'] or replacements['BLOG_URL']
    local jskomment_id = jskomment_prefix .. '/' .. title
    local jskomment_content = utils.replace(template_comment, {JSKOMMENT_ID=jskomment_id})
    sub['JSKOMMENT_CONTENT'] = jskomment_content
  end
  return sub
end

-------------------------------------------------------------------------------
-- Create post page for given '@file'
-- @param file filename of post in db directory
-- @param config configuration elements as TITLE, TAGS, TYPE, etc.
-- @param data.template_file file to use as template for a post
-- @param data.template_tag_file file to use as template for tag in a post page
-- @return Nothing (process function)
-------------------------------------------------------------------------------
function createPost(file, config, data)
  local timestamp, title = string.match(file, "(%d+),(.+)%.mk")
  -- only create post if date is older than today
  if today > tonumber(timestamp) then
    local template = utils.readFile(data.template_file, 'r')
    local out = assert(io.open(postpath .. "/" .. utils.keepUnreservedCharsAndDeleteDuplicate(title) .. resultextension, 'wb'))
    local post = rope()
    local content = utils.readFile(srcpath .. "/" .. title .. source_extension, 'r')
    local markdown_content = markdown(content)
    -- process tags
    local post_tags = {}
    for i, tag in pairs(config['TAGS']:split(',')) do
      local post_tagname = utils.deleteEndSpace(utils.deleteBeginSpace(tag))
      table.insert(post_tags, post_tagname)
    end
    -- create tag links
    local post_tag_links = createTagLinks(post_tags, data.template_tag_file)
    -- concatenate all final post subelements
    post:push (header)
    post:push (template)
    post:push (footer)
    -- keywords
    local keywords = getKeywords(config)
    -- local replacements
    local post_replacements = {
      TITLE = config['TITLE'],
      POST_TITLE = config['TITLE'],
      ARTICLE_CLASS_TYPE = config['TYPE'] or '',
      CONTENT = markdown_content,
      POST_FILE = utils.keepUnreservedCharsAndDeleteDuplicate(title) .. resultextension,
      TAG_LINKS_LIST = post_tag_links and utils.replace(post_tag_links, replacements) or '',
      DATE = os.date(date_format, timestamp) or '',
      DATETIME = os.date(datetime_format_default, timestamp) or '',
      POST_AUTHOR = config['AUTHOR'],
      POST_ESCAPED_TITLE = title,
      KEYWORDS = keywords:flatten(),
    }
    -- create substitutions list
    local substitutions = utils.getSubstitutions(replacements, post_replacements)
    -- add comment block if comment system is activated
    substitutions = commentSubstitutions(substitutions, config, title)
    -- ${VARIABLES} substitution on markdown content
    local flatten_final_content = post:flatten()
    local final_content = utils.replace(flatten_final_content, substitutions)
    -- First time we replace element, CONTENT will get markdown_content. But markdown_content was not replaced itself with replacements elements. The next line is here to do that
    final_content = utils.replace(final_content, substitutions)
    out:write(final_content)
    assert(out:close())
    -- Print post title
    print (string.format(_("-- [%s] New post: %s"), display_success, config['TITLE']))
  end
end

-------------------------------------------------------------------------------
-- For each tag in '@post_tags' table, use '@file' template and replace information by those given for each tag. Then return a string containing a concatenation of each completed template.
-- @param post_tags list of tags' name
-- @param file template to use for each tag link
-- @return a string if some tags
-- @return an empty string if no tags
-------------------------------------------------------------------------------
function createTagLinks(post_tags, file)
  -- prepare some values
  local result = ''
  -- get single tag element template
  local template = utils.readFile(file, 'r')
  template = string.gsub(template, '\n$', '')
  -- add each tag
  for k, v in pairs(post_tags) do
    if k > 1 then
      result = result .. ', '
    end
    local tag_page = string.gsub(v, '%s', '_') .. resultextension
    result = result .. utils.replace(template, {TAG_PAGE=tag_page, TAG_NAME=v})
  end
  return result
end

-------------------------------------------------------------------------------
-- Create post index page
-- @param posts list of posts {{file='123456,the_title_of_post.mk', conf={TITLE='The title of post', TAGS='something, other'}}, {file='234567,anything_else.mk', conf={TITLE='Anythin else', TAGS='anything'}}}
-- @param data.template_index_file path to the template to use for the index's page
-- @param data.template_element_file path to the template to use for each post that appears on tag's page
-- @param data.template_taglink_file path to the template to use for list of links to the tags
-- @param data.template_article_index_file path to the template to use for each post that appears on index's page
-- @return Nothing (process function)
-------------------------------------------------------------------------------
function createPostIndex(posts, data)
  -- check directory
  utils.checkDirectory(postpath)
  -- open result file
  local post_index = io.open(postpath .. '/' .. utils.keepUnreservedCharsAndDeleteDuplicate(index_name) .. resultextension, 'wb')
  -- prepare rss elements
  local rss_index = io.open(publicpath .. '/' .. utils.keepUnreservedCharsAndDeleteDuplicate(rss_name_default) .. rss_extension_default, 'wb')
  local rss_header = utils.readFile(page_rss_header, 'r')
  local rss_footer = utils.readFile(page_rss_footer, 'r')
  local rss_element = utils.readFile(page_rss_element, 'r')
  -- create a rope to merge all text
  local index = rope()
  local rss = rope()
  -- get header for results
  index:push (header)
  rss:push (rss_header)
  -- get post index general content
  local post_content = utils.readFile(data.template_index_file, 'r')
  index:push (post_content)
  -- get info for each post
  local post_element = utils.readFile(data.template_element_file, 'r')
  -- open template for posts that appears on index
  local template_article_index = utils.readFile(data.template_article_index_file, 'r')
  -- sort posts in a given order
  table.sort(posts, function(a, b) return utils.compare_post(a,b, user_sort_choice) end)
  -- prepare some values
  local index_nb = 0 -- number of post in all posts
  local home_min = 0 -- minimal index_nb in all posts to appear on homepage
  local home_max = home_min + max_post + 1 -- max index_nb in all posts to appear on homepage
  local home_index = 0 -- index process for posts that will appear on homepage
  local rss_min = 0
  local rss_max = rss_min + max_rss + 1
  local rss_index_nb = 0
  local post_nb = #posts
  local increment = true
  local page_number = 0
  local page_post_nb = 1
  local pages = 1
  if max_page and max_page > 0 then
    pages = (post_nb - (post_nb%max_page))/max_page + 1
  elseif max_page == 0 then
    max_page = nil
  end
  -- Some common pagination numbers/files
  local page_sub_first = index_name .. resultextension
  local page_sub_last = index_name .. (pages - 1) .. resultextension
  local page_sub_total = pages
  local page_pagination = utils.readFile(themepath .. '/' .. page_pagination_name, 'r')
  if user_sort_choice == 'asc' then
    increment = false
    home_min = post_nb - max_post - 1
    home_max = post_nb + 1
    home_index = max_post + 1
    rss_min = post_nb - max_rss - 1
    rss_max = post_nb + 1
    rss_index_nb = max_post + 1
  end
  -- process posts
  for k, v in pairs(posts) do
    -- get post's title
    local timestamp, title = string.match(v['file'], "(%d+),(.+)%.mk")
    -- only add a link for post older than today
    if today > tonumber(timestamp) then
      -- local substitutions
      local metadata = {
        POST_TITLE = v['conf']['TITLE'],
        POST_FILE = utils.keepUnreservedCharsAndDeleteDuplicate(title) .. resultextension,
        POST_AUTHOR = v['conf']['AUTHOR'],
        POST_DESCRIPTION = v['conf']['DESCRIPTION'] or '',
        SHORT_DATE = os.date(short_date_format, timestamp) or '',
        DATE = os.date(date_format, timestamp) or '',
        DATETIME = os.date(datetime_format_default, timestamp) or '',
      }
      -- registering tags
      local post_conf_tags = v['conf']['TAGS'] or nil
      if post_conf_tags then
        local post_tags = {}
        for i, tag in pairs(post_conf_tags:split(',')) do
          local tagname = utils.deleteEndSpace(utils.deleteBeginSpace(tag))
          -- remember the tagname to create tag links
          table.insert(post_tags, tagname)
          -- add tag to list of all tags
          if tags[tagname] == nil then
            tags[tagname] = {title}
          else
            table.insert(tags[tagname], title)
          end
        end
        -- create tag links
        local tag_links = createTagLinks(post_tags, data.template_taglink_file)
        if tag_links then
          metadata['TAG_LINKS_LIST'] = tag_links
        end
      end
      -- prepare substitutions for the post
      local post_substitutions = utils.getSubstitutions(v, metadata)
      -- remember this post's element for each tag page
      local post_element_content = utils.replace(post_element, post_substitutions)
      local remember_file = assert(io.open(tmppath .. '/' .. utils.keepUnreservedCharsAndDeleteDuplicate(title), 'wb'))
      assert(remember_file:write(post_element_content))
      assert(remember_file:close())
      -- push result into index
      index:push(post_element_content)
      -- read post real content
      local post_content_file = srcpath .. '/' .. title .. source_extension
      local real_post_content = utils.readFile(post_content_file, 'r')
      -- process post to be displayed on HOMEPAGE
      local final_post_content = utils.readFile(post_content_file, 'r')
      if index_nb >= home_min and index_nb <= home_max then
        if max_post_lines then
          local n = 0
          for i in real_post_content:gmatch("\n") do n=n+1 end
          final_post_content = utils.headFile(post_content_file, max_post_lines)
          if max_post_lines < n then
            local page_read_more = utils.readFile(themepath .. '/' .. page_read_more_name, 'r')
            final_post_content = final_post_content .. page_read_more
          end
        end
        local post_content = utils.replace(template_article_index, {CONTENT=markdown(final_post_content)})
        -- complete missing info
        post_substitutions['ARTICLE_CLASS_TYPE'] = v['conf']['TYPE'] or ''
        post_substitutions['POST_ESCAPED_TITLE'] = title
        -- add comment block if comment system is activated
        if template_comment then
          local jskomment_prefix = v['conf']['JSKOMMENT_PREFIX'] and v['conf']['JSKOMMENT_PREFIX'] ~= '' and v['conf']['JSKOMMENT_PREFIX'] or replacements['BLOG_URL']
          local jskomment_id = jskomment_prefix .. '/' .. title
          local jskomment_content = utils.replace(template_comment, {JSKOMMENT_ID=jskomment_id})
          post_substitutions['JSKOMMENT_CONTENT'] = jskomment_content
        end
        local content4index = utils.replace(post_content, post_substitutions)
        -- create temporary file for Homepage
        if increment then
          home_index = home_index + 1
        else
          home_index = home_index - 1
        end
        local homepage_file = io.open(tmppath .. '/index.' .. home_index .. '.tmp', 'wb')
        assert(homepage_file:write(content4index))
        -- close first_posts file
        assert(homepage_file:close())
      end
      -- process post to be used in RSS file
      if index_nb >= rss_min and index_nb <= rss_max then
        -- create temporary file for RSS
        if increment then
          rss_index_nb = rss_index_nb + 1
        else
          rss_index_nb = rss_index_nb - 1
        end
        local rss_file = io.open(tmppath .. '/rss.' .. rss_index_nb .. '.tmp', 'wb')
        local rss_post_html_link = blog_url .. '/' .. postdir_name .. '/' .. title .. resultextension
        -- Change temporarly locale
        assert(os.setlocale('C'))
        local rss_date = os.date('!%a, %d %b %Y %T GMT', timestamp) or ''
        assert(os.setlocale(lang))
        local rss_post = utils.replace(rss_element, {DESCRIPTION=markdown(real_post_content), TITLE=v['conf']['TITLE'], LINK=rss_post_html_link, DATE=rss_date})
        assert(rss_file:write(rss_post))
        -- close first_posts file
        assert(rss_file:close())
      end
      -- incrementation
      index_nb = index_nb + 1
      -- Page process
      page_post_nb = page_post_nb + 1
      if max_page and page_post_nb > max_page then
        page_post_nb = 1
        -- Prepare page substitution elements
        page_current = page_number + 1
        page_previous = (page_number - 1) > 0 and (page_number - 1) or 0
        page_next = (page_number + 1) < pages and (page_number + 1) or pages - 1
        if page_previous == 0 then
          page_previous = ''
        end
        page_sub_previous = index_name .. page_previous .. resultextension
        page_sub_next = index_name .. page_next .. resultextension
        -- Add pagination template
        index:push (page_pagination)
        -- CLOSE CURRENT INDEX
        index:push (footer)
        -- do substitutions on page
        index_sub_table = {
          TITLE=replacements['POST_LIST_TITLE'],
          BODY_CLASS="posts",
          PAGE_FIRST_LINK=page_sub_first,
          PAGE_PREV_LINK=page_sub_previous,
          PAGE_NEXT_LINK=page_sub_next,
          PAGE_LAST_LINK=page_sub_last,
          PAGE_CURRENT=page_current,
          PAGE_TOTAL=page_sub_total,
        }
        index_substitutions = utils.getSubstitutions(replacements, index_sub_table)
        index_content = utils.replace(index:flatten(), index_substitutions)
        post_index:write(index_content)
        -- Close post's index
        post_index:close()
        post_index = nil
        index = nil
        print (string.format(_('-- [%s] Post list %s/%s: BUILT.'), display_success, page_current, page_sub_total))
        -- increment page number
        page_number = page_number + 1
        -- CREATE NEW INDEX
        post_index = io.open(postpath .. '/' .. index_name .. page_number .. resultextension, 'wb')
        index = rope()
        index:push (header)
        index:push (post_content)
      end
    end
  end
  -- If last post, finish index writing (to close file)
  if page_post_nb >= post_nb or (max_page and page_post_nb <= max_page) then
    -- Prepare page substitution elements
    if max_page and max_page > 0 and page_sub_total > 1 then
      page_current = page_number + 1
      page_previous = (page_number - 1) > 0 and (page_number - 1) or 0
      page_next = (page_number + 1) < pages and (page_number + 1) or pages - 1
      if page_previous == 0 then
        page_previous = ''
      end
      page_sub_previous = index_name .. page_previous .. resultextension
      page_sub_next = index_name .. page_next .. resultextension
      -- Add pagination template
      index:push (page_pagination)
    end
    -- CLOSE FINAL INDEX
    index:push (footer)
    -- do substitutions on page
    index_sub_table = {
      TITLE=replacements['POST_LIST_TITLE'],
      BODY_CLASS="posts",
      PAGE_FIRST_LINK=page_sub_first,
      PAGE_PREV_LINK=page_sub_previous,
      PAGE_NEXT_LINK=page_sub_next,
      PAGE_LAST_LINK=page_sub_last,
      PAGE_CURRENT=page_current,
      PAGE_TOTAL=page_sub_total,
    }
    local index_substitutions = utils.getSubstitutions(replacements, index_sub_table)
    local index_content = utils.replace(index:flatten(), index_substitutions)
    post_index:write(index_content)
    -- Close post's index
    post_index:close()
    if max_page and max_page > 0 and page_sub_total > 1 then
      print (string.format(_('-- [%s] Post list %s/%s: BUILT.'), display_success, page_current, page_sub_total))
    end
  end
  -- rss process
  local index_rss_nb = 1
  while index_rss_nb <= max_rss do
    local rss_content = utils.readFile(tmppath .. '/' .. 'rss.' .. index_rss_nb .. '.tmp', 'r')
    rss:push (rss_content)
    index_rss_nb = index_rss_nb + 1
  end
  rss:push (rss_footer)
  rss_replace = utils.replace(rss:flatten(), replacements)
  rss_index:write(rss_replace)
  rss_index:close()
  -- Display that RSS file was created
  print (string.format(_("-- [%s] RSS feed: BUILT."), display_success))
  -- Display that post index was created
  print (string.format(_('-- [%s] Post list: BUILT.'), display_success))
end

-------------------------------------------------------------------------------
-- Create a page for a given tag
-- @param filename path to the file we want to create
-- @param title title of page (using a replacement)
-- @param posts list of posts that are linked to this tag
-------------------------------------------------------------------------------
function createTag(filename, title, posts)
  local page = rope()
  page:push(header)
  -- insert content (all posts linked to this tag)
  for k, post in pairs(posts) do
    local content = ''
    content = utils.readFile(tmppath .. '/' .. post, 'r')
    if content then
      page:push(content)
    end
  end
  page:push(footer)
  local page_file = assert(io.open(filename, 'wb'))
  -- keywords
  local keywords = rope()
  keywords:push (title)
  if makeflyrc['BLOG_KEYWORDS'] then
    keywords:push (',' .. makeflyrc['BLOG_KEYWORDS'])
  end
  -- do substitutions on page
  local substitutions = utils.getSubstitutions(replacements, {TITLE=title, KEYWORDS=keywords:flatten()})
  local final_content = utils.replace(page:flatten(), substitutions)
  page_file:write(final_content)
  page_file:close()
  -- Print tag title
  print (string.format(_("-- [%s] New tag: %s"), display_success, title))
end

-------------------------------------------------------------------------------
-- Create the tag index's page
-- @param index_filename path of file to use to write result into
-- @param template_index_filename path to the template to use for tag index's page
-- @param template_element_filename path to the template to use for each tag on tag index's page
-- @return Nothing (process function)
-------------------------------------------------------------------------------
function createTagIndex(index_filename, template_index_filename, template_element_filename)
  local index = rope()
  index:push(header)
  -- check tagpath directory
  utils.checkDirectory(tagpath)
  local index_file = assert(io.open(tagpath .. '/' .. index_filename, 'wb'))
  -- read general tag index template file
  local template_index = utils.readFile(template_index_filename, 'r')
  -- read tage element template file
  local template_element = utils.readFile(template_element_filename, 'r')
  -- browse all tags
  local taglist_content = ''
  for tag, posts in utils.pairsByKeys(tags) do
    local tag_page = string.gsub(tag, '%s', '_') .. resultextension
    taglist_content = taglist_content .. utils.replace(template_element, {TAG_PAGE=tag_page, TAG_NAME=tag})
    createTag(tagpath .. '/' .. utils.keepUnreservedCharsAndDeleteDuplicate(tag_page), tag, posts)
  end
  index:push(utils.replace(template_index, {TAGLIST_CONTENT=taglist_content}))
  index:push(footer)
  -- do substitutions on page
  local substitutions = utils.getSubstitutions(replacements, {TITLE=replacements['TAG_LIST_TITLE'], BODY_CLASS='tags'})
  local index_content = utils.replace(index:flatten(), substitutions)
  index_file:write(index_content)
  -- Close post's index
  assert(index_file:close())
  -- Display that tag index was created
  print (string.format(_("-- [%s] Tag list: BUILT."), display_success))
end

-------------------------------------------------------------------------------
-- Create homepage
-- @param file path to the file to write into
-- @param title title of the page
-- @return Nothing (process function)
-------------------------------------------------------------------------------
function createHomepage(file, title)
  local index = rope()
  local index_file = io.open(file, 'wb')
  index:push(header)
  -- push content from all temporary files
  local index_nb = 1
  while index_nb <= max_post do
    local content = utils.readFile(tmppath .. '/' .. 'index.' .. index_nb .. '.tmp', 'r')
    index:push(content)
    index_nb = index_nb + 1
  end
  index:push(footer)
  local substitutions = utils.getSubstitutions(replacements, {BODY_CLASS='home', TITLE=title})
  local final_content = utils.replace(index:flatten(), substitutions)
  index_file:write(final_content)
  assert(index_file:close())
  -- Display that homepage was created
  print (string.format(_("-- [%s] Homepage: BUILT."), display_success))
end

-------------------------------------------------------------------------------
-- Create single static page named PAGE
-- @return Nothing (process function)
-------------------------------------------------------------------------------
function createPage(origin, destination, title)
  local page = rope()
  local page_file = io.open(destination, 'wb')
  page:push(header)
  -- add page content
  local content = utils.readFile(origin, 'r')
  local markdown_content = markdown(content)
  page:push(markdown_content)
  -- add footer and close file
  page:push(footer)
  local substitutions = utils.getSubstitutions(replacements, {BODY_CLASS='page', TITLE=title})
  local final_content = utils.replace(page:flatten(), substitutions)
  page_file:write(final_content)
  assert(page_file:close())
  -- Display that this page have been created
  print (string.format(_("-- [%s] Page '%s': BUILT."), display_success, title))
end

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
index_name = makeflyrc['INDEX_FILENAME'] or index_name_default
resultextension = makeflyrc['PAGE_EXT'] or extension_default
theme = makeflyrc['THEME'] or theme_default
themepath = templatepath .. '/' .. theme
postdir_name = makeflyrc['POSTDIR_NAME'] or postdir_name_default
tagdir_name = makeflyrc['TAGDIR_NAME'] or tagdir_name_default
bodyclass = makeflyrc['BODY_CLASS'] or bodyclass_default
postpath = publicpath .. '/' .. postdir_name
tagpath = publicpath .. '/' .. tagdir_name
index_filename = utils.keepUnreservedCharsAndDeleteDuplicate(index_name) .. resultextension
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
  replacements['ABOUT_LINK'] = stuffTemplate(themepath .. '/' .. page_about_name, '', '', '', false)
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
  replacements['ELI_CONTENT'] = stuffTemplate(page_eli_content, '', '')
else
  print (string.format(_("-- [%s] ELI badge"), display_disable))
end

-- Sidebar (display that's active/inactive)
local sidebar_filename = (makeflyrc['SIDEBAR_FILENAME'] or sidebar_default) .. source_extension
if (makeflyrc['SIDEBAR'] and makeflyrc['SIDEBAR'] == '1') or (themerc['SIDEBAR'] and themerc['SIDEBAR'] == '1') then
  print (string.format(_("-- [%s] Sidebar"), display_enable))
  local sidebar_content = utils.readFile(specialpath .. '/' .. sidebar_filename, 'r')
  replacements['SIDEBAR'] = stuffTemplate(page_sidebar, sidebar_content, 'SIDEBAR_CONTENT', 'markdown', true)
else
  print (string.format(_("-- [%s] Sidebar"), display_disable))
end

-- Search bar
if makeflyrc['SEARCH_BAR'] and makeflyrc['SEARCH_BAR'] == '1' then
  print (string.format(_("-- [%s] Search bar"), display_enable))
  replacements['SEARCHBAR'] = stuffTemplate(page_searchbar)
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
    if missing_post_info ~= '' then
      local timestamp, postTitle = string.match(v, "(%d+),(.+)%.mk")
      print(string.format(_("-- [%s] Missing information in '%s' post: %s"), display_error, postTitle, missing_post_info))
      os.exit(1)
    end
    table.insert(post_files, {file=v, conf=postConf})
    local co = coroutine.create(function () createPost(v, postConf, {template_file=page_article_single, template_tag_file=page_tag_link}) end)
    table.insert(threads, co)
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
    local co = coroutine.create(function () createPage(v, pagefile, pagetitle) end)
    table.insert(threads, co)
  end
else
  print (string.format(_("-- [%s] No static page(s) found."), display_info))
end

-- launch dispatcher to create each post and more (copy needed directories/files, etc.)
utils.dispatcher()

-- Create post's index
createPostIndex(post_files, {
  template_index_file = themepath .. '/' .. page_posts_name,
  template_element_file = page_post_element,
  template_taglink_file = page_tag_link,
  template_article_index_file = page_article_index
})

-- Create tag's files: index and each tag's page
createTagIndex(index_filename, themepath .. '/' .. page_tag_index_name, page_tag_element)

-- Create index
createHomepage(publicpath .. '/' .. index_filename, languagerc['HOME_TITLE'])

-- Delete temporary files
for tag, posts in pairs(tags) do
  for i, post in pairs(posts) do
    os.remove(tmppath .. '/' .. post)
  end
end
-- delete posts that appear on homepage
local index_nb = 0
while index_nb < max_post do
  os.remove(tmppath .. '/' .. 'index.' .. index_nb .. '.tmp')
  index_nb = index_nb + 1
end

--[[ END ]]--
return 0

-- vim:expandtab:smartindent:tabstop=2:softtabstop=2:shiftwidth=2:
