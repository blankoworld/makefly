#!/usr/bin/env lua
-- process.lua
-- Process db and src directory to create a result
-- Olivier DOSSMANN

--[[Depends

LuaFileSystem is required: 
luarocks install luafilesystem

Markdown is required:
luarocks install markdown

]]--

require 'rope'
require 'lfs'
require 'markdown'

--[[ Variables ]]--

-- requirements
local lfs = require "lfs"

-- default's directories
local currentpath = os.getenv('CURDIR') or '.'
local dbpath = os.getenv('DBDIR') or currentpath .. '/db'
local srcpath = os.getenv('SRCDIR') or currentpath .. '/src'
local tmppath = os.getenv('TMPDIR') or currentpath .. '/tmp'
local templatepath = os.getenv('TMPLDIR') or currentpath .. '/template'
local staticpath = os.getenv('STATICDIR') or currentpath .. '/static'
local specialpath = os.getenv('SPECIALDIR') or currentpath .. '/special'
local langpath = os.getenv('LANGDIR') or currentpath .. '/lang'
local publicpath = os.getenv('DESTDIR') or currentpath .. '/pub'
-- default's files
local makeflyrcfile = os.getenv('conf') or 'makefly.rc'
local themercfile = 'config.mk'
-- theme filenames
local page_header_name = 'header.xhtml'
local page_footer_name = 'footer.xhtml'
local page_posts_name = 'post.index.xhtml'
local page_article_name = 'article.xhtml'
local page_homepage_article_name = 'article.index.xhtml'
local page_post_element_name = 'element.xhtml'
local page_tag_element_name = 'tagelement.xhtml'
local page_tag_link_name = 'taglink.xhtml'
local page_tag_index_name = 'tags.xhtml'
local page_sidebar_name = 'sidebar.xhtml'
-- others
local version = os.getenv('VERSION') or 'L 0.2.1-trunk'
local replacements = {} -- substitution table
local today = os.time() -- today's timestamp
local tags = {}
-- default values
local theme_default = "responsive" -- theme
local postdir_name_default = 'posts' -- name for posts directory
local tagdir_name_default = 'tags' -- name for tags directory
local about_default = 'about' -- about's page name in special directory
local intro_default = 'introduction' -- name introduction page in special directory
local footer_default = 'footer' -- footer's name in special directory
local sidebar_default = 'sidebar' -- sidebar's name in special directory
local bodyclass_default = 'single' -- body class for pages
local index_name_default = 'index' -- index name
local extension_default = '.html' -- file extension for HTML pages
local language_default = 'en' -- language name
local max_post_default = 3 -- number of posts displayed on homepage

--[[ Methods ]]--

function string:split(sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

function deleteBeginSpace(string)
  local res = string.gsub(string, "^ *", '')
  return res
end

function deleteEndSpace(string)
  local res = string.gsub(string, " *$", '')
  return res
end

function listing (path, extension)
  local files = {}
  if lfs.attributes(path) then
    for file in lfs.dir(path) do
      if file ~= "." and file ~= ".." then
        local f = path..'/'..file
        local attr = lfs.attributes (f)
        local filext = (string.match(file, "[^\\/]-%.?([^%.\\/]*)$"))
        if attr.mode == 'file' and filext == extension then
          table.insert(files, f)
        end
      end
    end
  else
    files = nil
  end
  return files
end

function checkDirectory(path)
  if lfs.attributes(path) == nil then
    assert(lfs.mkdir(path))
    -- Display created directory
    print ('-- Created folder: ' .. path .. ' ...')
  end
end

function getConfig(file)
  local result = {}
  local f = assert(io.open(file, 'r'))
  while true do
    local line = f.read(f)
    if not line then break end
    local key = line:match('(.-)[ ]+=')
    local val = line:match('=[ ]+(.*)')
    local comment = string.find(line, '^#+.*')
    if comment then
      -- do nothing with commented lines
    elseif key then
      result[key] = val
    end
  end
  assert(f:close())
  return result
end

function replace(string, table)
  return string:gsub("$(%b{})", function(string)
    return table[string:sub(2,-2)]
   end)
end

function readFile(path, mode)
  local result = ''
  if not mode then
    local mode = 'r'
  end
  if mode ~= 'r' and mode ~= 'rb' then
    print('Unknown read mode!')
    os.exit(1)
  end
  local attr = lfs.attributes(path)
  if attr and attr.mode == 'file' then
    local f = assert(io.open(path, mode))
    result = assert(f:read('*a'))
    assert(f:close())
  end
  return result
end

function copyFile(origin, destination, replacements)
  local content = ''
  if lfs.attributes(origin) and lfs.attributes(origin).mode == 'file' then
    -- open the file
    content = readFile(origin, 'r')
  end
  -- write in destination
  local result = assert(io.open(destination, 'wb'))
  if content == nil then
    result:close()
  else
    if replacements then
      result:write(replace(content, replacements))
    else
      result:write(content)
    end
  end
  result:close()
end

function copy(origin, destination)
  local attr = lfs.attributes(origin)
  if attr and attr.mode == 'directory' then
    -- create destination if no one exists
    if lfs.attributes(destination) == nil then
      lfs.mkdir(destination)
    end
    -- browse origin directory
    for element in lfs.dir(origin) do
      if element ~= '.' and element ~= '..' then
        local path = origin .. '/' .. element
  -- launch copy directory if element is a directory, otherwise copy file
  if lfs.attributes(path) and lfs.attributes(path).mode == 'directory' then
    copy(path, destination .. '/' .. element)
  else
    copyFile(path, destination .. '/' .. element)
  end
      end
    end
  -- if origin is a file, just launch copyFile function
  elseif attr and attr.mode == 'file' then
    copyFile(origin, destination)
  else
    print (origin .. ' not found!')
  end
end

function getSubstitutions(replacements, local_replacements)
  -- create substitutions list
  local result = {}
  for k, v in pairs(replacements) do 
    result[k] = v
  end
  for k, v in pairs(local_replacements) do 
    result[k] = v
  end
  return result
end

function createPost(file, config, header, footer, tagpath, template_file, template_tag_file, date_format)
  -- get post's title and timestamp
  local timestamp, title = string.match(file, "(%d+),(.+)%.mk")
  -- only create post if date is older than today
  if os.date('%s', today) > os.date('%s', timestamp) then
    -- open template file
    local template = readFile(template_file, 'r')
    -- open post output file
    local out = assert(io.open(postpath .. "/" .. title .. resultextension, 'wb'))
    -- create a rope for post's result
    local post = rope()
    -- open content of post (SRC file)
    local content = readFile(srcpath .. "/" .. title .. ".md", 'r')
    -- markdown process on content
    local markdown_content = markdown(content)
    -- process tags
    local post_tags = {}
    for i, tag in pairs(config['TAGS']:split(',')) do
      local post_tagname = deleteEndSpace(deleteBeginSpace(tag))
      table.insert(post_tags, post_tagname)
    end
    -- create tag links
    local post_tag_links = createTagLinks(post_tags, tagpath, template_tag_file, resultextension)
    -- concatenate all final post subelements
    post:push (header)
    post:push (template)
    post:push (footer)
    -- local replacements
    local post_replacements = {
      TITLE = config['TITLE'],
      POST_TITLE = config['TITLE'],
      ARTICLE_CLASS_TYPE = config['TYPE'],
      CONTENT = markdown_content,
      POST_FILE = title .. resultextension,
      TAG_LINKS_LIST = post_tag_links and replace(post_tag_links, replacements) or '',
      DATE = os.date(date_format, timestamp) or '',
      POST_AUTHOR = config['AUTHOR'],
    }
    -- create substitutions list
    local substitutions = {}
    for k, v in pairs(replacements) do 
      substitutions[k] = v
    end
    for k, v in pairs(post_replacements) do 
      substitutions[k] = v
    end
    -- ${VARIABLES} substitution on markdown content
    local final_content = replace(post:flatten(), substitutions)
    -- write result to output file
    out:write(final_content)
    -- close output file
    assert(out:close())
    -- Print post title
    print ("-- Post successfully created: " .. config['TITLE'])
  end
end

function dispatcher ()
  while true do
    local n = table.getn(threads)
    if n == 0 then break end   -- no more threads to run
    for i=1,n do
      local status, res = coroutine.resume(threads[i])
      if not res then    -- thread finished its task?
        table.remove(threads, i)
        break
      end
    end
  end
end

function compare_post(a, b, order)
  local r = a['file'] > b['file']
  if order == nil then
    r = a['file'] > b['file']
  elseif order == 'asc' then
    r = a['file'] < b['file']
  elseif order == 'desc' then
    r = a['file'] > b['file']
  else
    r = a['file'] > b['file']
  end
  return r
end

function pairsByKeys (t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0      -- iterator variable
  local iter = function ()   -- iterator function
    i = i + 1
    if a[i] == nil then return nil
    else return a[i], t[a[i]]
    end
  end
  return iter
end

function createTagLinks(post_tags, tagpath, file, extension)
  -- prepare some values
  local result = ''
  -- get single tag element template
  local template = readFile(file, 'r')
  template = string.gsub(template, '\n$', '')
  -- add each tag
  for k, v in pairs(post_tags) do
    if k > 1 then
      result = result .. ', '
    end
    local tag_page = string.gsub(v, '%s', '_') .. extension
    result = result .. replace(template, {TAG_PAGE=tag_page, TAG_NAME=v})
  end
  return result
end

function createPostIndex(posts, index_file, header, footer, replacements, extension, template_index_file, template_element_file, short_date_format, tagpath, template_taglink_file, template_article_index_file, max_post)
  -- open result file
  local post_index = io.open(index_file, 'wb')
  -- create a rope to merge all text
  local index = rope()
  index:push (header)
  -- get post index general content
  local post_content = readFile(template_index_file, 'r')
  index:push (post_content)
  -- get info for each post
  local post_element = readFile(template_element_file, 'r')
  -- create temporary file with first posts
  local first_posts_file = io.open(tmppath .. '/index.tmp', 'wb')
  -- open template for posts that appears on index
  local template_article_index = readFile(template_article_index_file, 'r')
  -- sort posts in a given order
  table.sort(posts, compare_post)
  -- prepare some values
  index_nb = 0
  -- process posts
  for k, v in pairs(posts) do
    -- get post's title
    local timestamp, title = string.match(v['file'], "(%d+),(.+)%.mk")
    -- only add a link for post older than today
    if os.date('%s', today) > os.date('%s', timestamp) then
      -- local substitutions
      local metadata = {
        POST_TITLE = v['conf']['TITLE'],
        POST_FILE = title .. resultextension,
        POST_AUTHOR = v['conf']['AUTHOR'],
        POST_DESCRIPTION = v['conf']['DESCRIPTION'],
        SHORT_DATE = os.date(short_date_format_default, timestamp),
	DATE = os.date(date_format_default, timestamp)
      }
      -- registering tags
      local post_conf_tags = v['conf']['TAGS'] or nil
      if post_conf_tags then
        local post_tags = {}
        for i, tag in pairs(post_conf_tags:split(',')) do
          local tagname = deleteEndSpace(deleteBeginSpace(tag))
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
        local tag_links = createTagLinks(post_tags, tagpath, template_taglink_file, extension)
        if tag_links then
          metadata['TAG_LINKS_LIST'] = tag_links
        end
      end
      -- prepare substitutions for the post
      local post_substitutions = getSubstitutions(v, metadata)
      -- remember this post's element for each tag page
      local post_element_content = replace(post_element, post_substitutions)
      local remember_file = assert(io.open(tmppath .. '/' .. title, 'wb'))
      assert(remember_file:write(post_element_content))
      assert(remember_file:close())
      -- push result into index
      index:push(post_element_content)
      -- process post to be displayed on HOMEPAGE
      if index_nb < max_post then
        -- read post real content
        local real_post_content = readFile(srcpath .. '/' .. title .. '.md', 'r')
        local post_content = replace(template_article_index, {CONTENT=markdown(real_post_content)})
        -- complete missing info
        post_substitutions['ARTICLE_CLASS_TYPE'] = v['conf']['TYPE']
        -- FIXME: Add here missing info for JSKOMMENT with unique identifier
        local content4index = replace(post_content, post_substitutions)
        assert(first_posts_file:write(content4index))
      end
      -- incrementation
      index_nb = index_nb + 1
    end
  end
  -- close first_posts file
  assert(first_posts_file:close())
  index:push (footer)
  -- do substitutions on page
  local index_substitutions = getSubstitutions(replacements, {TITLE=replacements['POST_LIST_TITLE']})
  local index_content = replace(index:flatten(), index_substitutions)
  post_index:write(index_content)
  -- Close post's index
  post_index:close()
  -- Display that post index was created
  print ('-- Post list built.')
end

function createTag(filename, title, posts, header, footer, replacements)
  local page = rope()
  page:push(header)
  -- insert content (all posts linked to this tag)
  for k, post in pairs(posts) do
    local content = ''
    content = readFile(tmppath .. '/' .. post, 'r')
    if content then
      page:push(content)
    end
  end
  page:push(footer)
  local page_file = assert(io.open(filename, 'wb'))
  -- do substitutions on page
  local substitutions = getSubstitutions(replacements, {TITLE=title})
  page_file:write(replace(page:flatten(), substitutions))
  page_file:close()
  -- Print tag title
  print ("-- Tag successfully created: " .. title)
end

function createTagIndex(all_tags, tagpath, index_filename, header, footer, replacements, extension, template_index_filename, template_element_filename)
  local index = rope()
  index:push(header)
  local index_file = assert(io.open(tagpath .. '/' .. index_filename, 'wb'))
  -- read general tag index template file
  local template_index = readFile(template_index_filename, 'r')
  -- read tage element template file
  local template_element = readFile(template_element_filename, 'r')
  -- browse all tags
  local taglist_content = ''
  for tag, posts in pairsByKeys(tags) do
    local tag_page = string.gsub(tag, '%s', '_') .. extension
    taglist_content = taglist_content .. replace(template_element, {TAG_PAGE=tag_page, TAG_NAME=tag})
    createTag(tagpath .. '/' .. tag_page, tag, posts, header, footer, replacements)
  end
  index:push(replace(template_index, {TAGLIST_CONTENT=taglist_content}))
  index:push(footer)
  -- do substitutions on page
  local substitutions = getSubstitutions(replacements, {TITLE=replacements['TAG_LIST_TITLE'], BODY_CLASS='tags'})
  local index_content = replace(index:flatten(), substitutions)
  index_file:write(index_content)
  -- Close post's index
  assert(index_file:close())
  -- Display that tag index was created
  print ('-- Tag list built.')
end

function createHomepage(file, title, header, footer)
  local index = rope()
  local index_file = io.open(file, 'wb')
  local content = readFile(tmppath .. '/' .. 'index.tmp', 'r')
  index:push(header)
  index:push(content)
  index:push(footer)
  local substitutions = getSubstitutions(replacements, {BODY_CLASS='home', TITLE=title})
  local final_content = replace(index:flatten(), substitutions)
  index_file:write(final_content)
  assert(index_file:close())
end

--[[ MAIN ]]--
-- create thread table
threads = {}

-- Get makefly's configuration
makeflyrc = getConfig(makeflyrcfile)

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
index_filename = index_name .. resultextension
date_format_default = makeflyrc['DATE_FORMAT'] or '%Y-%m-%d at %H:%M'
short_date_format_default = makeflyrc['SHORT_DATE'] or '%Y/%m'
max_post = makeflyrc['MAX_POST'] and tonumber(makeflyrc['MAX_POST']) or max_post_default
-- Display which theme the user have choosed
print ('-- Choosen theme: ' .. theme)

-- Get language configuration
language = makeflyrc['BLOG_LANG'] or language_default
languagerc = getConfig(langpath .. '/translate.' .. language)

-- Check if needed directories exists. Otherwise create them
for k,v in pairs({tmppath, publicpath, postpath, tagpath}) do
  local co_directory = coroutine.create(function () checkDirectory(v) end)
  table.insert(threads, co_directory)
end

-- Create path for template's files
local page_header = themepath .. '/' .. page_header_name
local page_footer = themepath .. '/' .. page_footer_name
local page_article_single = themepath .. '/' .. page_article_name
local page_post_element = themepath .. '/' .. page_post_element_name
local page_tag_element = themepath .. '/' .. page_tag_element_name
local page_tag_link = themepath .. '/' .. page_tag_link_name
local page_sidebar = themepath .. '/' .. page_sidebar_name
local page_article_index = themepath .. '/' .. page_homepage_article_name

-- Read template configuration file
local themerc = getConfig(themepath .. '/' .. themercfile)

-- Read template's mandatory files
local header = readFile(page_header, 'r')
local footer = readFile(page_footer, 'r')

-- Create CSS files
css_file = themepath .. '/style/' .. themerc['CSS_FILE']
css_color_file = themepath .. '/style/' .. themerc['CSS_COLOR_FILE']
table.insert(threads, coroutine.create(function () copyFile(css_file, publicpath .. '/' .. themerc['CSS_FILE'], { BLOG_URL = makeflyrc['BLOG_URL'] }) end))
table.insert(threads, coroutine.create(function () copyFile(css_color_file, publicpath .. '/' .. themerc['CSS_COLOR_FILE']) end))
-- Copy static theme directory
theme_static_directory = themepath .. '/static'
table.insert(threads, coroutine.create(function () copy(theme_static_directory, publicpath) end))

-- Add result to replacements table (to substitute ${VARIABLES} in files)
replacements = {
  VERSION = version,
  BLOG_TITLE = makeflyrc['BLOG_TITLE'],
  BLOG_DESCRIPTION = makeflyrc['BLOG_DESCRIPTION'],
  BLOG_SHORT_DESC = makeflyrc['BLOG_SHORT_DESC'],
  BLOG_URL = makeflyrc['BLOG_URL'],
  LANG = makeflyrc['BLOG_LANG'],
  BLOG_CHARSET = makeflyrc['BLOG_CHARSET'],
  RSS_FEED_NAME = makeflyrc['RSS_FEED_NAME'],
  SIDEBAR = '',
  ARTICLE_CLASS_TYPE = 'normal',
  SEARCHBAR = '',
  JSKOMMENT_SCRIPT = '',
  JSKOMMENT_CONTENT = '',
  ELI_SCRIPT = '',
  ELI_CONTENT = '',
  ELI_CSS = '',
  INTRO_CONTENT = '',
  FOOTER_CONTENT = '',
  ABOUT_LINK = '',
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

-- FIXME: COMPLETE here replacements for all kind of variables as ELI, SEARCH, about's page, special files, etc.
-- Sidebar (display that's active/inactive)
if makeflyrc['SIDEBAR'] and makeflyrc['SIDEBAR'] == '1' then
  print ('-- Sidebar: activated.')
  local template_sidebar = readFile(page_sidebar, 'r')
  local sidebar_content = readFile(specialpath .. '/' .. sidebar_default .. '.md', 'r')
  if sidebar_content and template_sidebar then
    local markdown_content = markdown(sidebar_content)
    local sidebar_final_content = ''
    sidebar_final_content = replace(template_sidebar, {SIDEBAR_CONTENT=markdown_content})
    replacements['SIDEBAR'] = replace(sidebar_final_content, replacements)
  end
else
  print ('-- Sidebar: desactivated.')
end

-- Browse DB files
local post_files = {}
dbresult = listing (dbpath, "mk")
if dbresult then
  for k,v in pairs(dbresult) do
    -- parse DB files to get metadata and posts'title
    table.insert(post_files, {file=v, conf=getConfig(v)})
    local co = coroutine.create(function () createPost(v, getConfig(v), header, footer, tagpath, page_article_single, page_tag_link, date_format_default) end)
    table.insert(threads, co)
  end
else
  print ("-- No DB file found!")
end

-- launch dispatcher to create each post and more (copy needed directories/files, etc.)
dispatcher()

-- Create post's index
createPostIndex(post_files, postpath .. '/' .. index_filename, header, footer, replacements, resultextension, themepath .. '/' .. page_posts_name, page_post_element, short_date_format_default, tagpath, page_tag_link, page_article_index, max_post)

-- Create tag's files: index and each tag's page
createTagIndex(tags, tagpath, index_filename, header, footer, replacements, resultextension, themepath .. '/' .. page_tag_index_name, page_tag_element)

-- Create index
createHomepage(publicpath .. '/' .. index_filename, languagerc['HOME_TITLE'], header, footer)

-- Delete temporary files
for tag, posts in pairs(tags) do
  for i, post in pairs(posts) do
    os.remove(tmppath .. '/' .. post)
  end
end
os.remove(tmppath .. '/' .. 'index.tmp') -- posts that appears on homepage

--[[ END ]]--
return 0
