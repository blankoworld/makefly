local blog = { }

local utils = require 'utils'

-------------------------------------------------------------------------------
-- Read '@filepath' and do substitutions using 'replacements' global table.
-- @param filepath absolute/relative path to the file to read (will use 'r' mode)
-- @param content if '@option' is set to 'markdown' and '@variable' given, this will set '@content' into '@variable' for next replacements
-- @param variable name of variable to use in order to replace it by '@content' string
-- @param option if set to 'markdown', use markdown format for '@content' variable. If no one, do nothing.
-- @param double_replacement if set to true, then do replacement twice. First on file, then on result.
-- @return a string that contains process result
-------------------------------------------------------------------------------
function blog.stuffTemplate(filepath, content, variable, option, double_replacement)
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
function blog.getKeywords(postconfig)
  local result = rope()
  if postconfig['KEYWORDS'] ~= nil then
    result:push (postconfig['KEYWORDS'])
  end
  if postconfig['TAGS'] then
    if result:flatten() ~= '' then
      result:push(',')
    end
    result:push(postconfig['TAGS'])
  end
  if config.BLOG_KEYWORDS then
    if result:flatten() ~= '' then
      result:push(',')
    end
    result:push (config.BLOG_KEYWORDS)
  end
  return result
end

-------------------------------------------------------------------------------
-- Add specific comments substitutions (ISSO_CONTENT variable)
-- @param sub Substitutions table
-- @param config Post configuration table
-- @param title Post title
-- @return Substitutions table with ISSO_CONTENT if needed
-------------------------------------------------------------------------------
function blog.commentSubstitutions(sub, cfg, title)
  local template_comment = utils.readFile(config.page_isso, 'r')
  if config.ISSO and config.ISSO == '1' then
    local isso_prefix = cfg['ISSO_PREFIX'] and cfg['ISSO_PREFIX'] ~= '' and cfg['ISSO_PREFIX'] or replacements['BLOG_URL']
    local isso_id = isso_prefix .. '/' .. title
    local isso_content = utils.replace(template_comment, {ISSO_ID=isso_id})
    sub['ISSO_CONTENT'] = isso_content
    -- process short and extended isso templates. Use previous ISSO_CONTENT value.
    local template_isso_short = utils.readFile(config.page_isso_short, 'r')
    local template_isso_extended = utils.readFile(config.page_isso_extended, 'r')
    local isso_short_content = utils.replace(template_isso_short, sub)
    local isso_extended_content = utils.replace(template_isso_extended, sub)
    sub['ISSO_SHORT'] = isso_short_content
    sub['ISSO_EXTENDED'] = isso_extended_content
  end
  return sub
end

-------------------------------------------------------------------------------
-- List tags from '@taglist' table and create a link list of tags to add them into TAG_LINKS_LIST variable in '@metadata'. If remember is true, add tags into tags global variable.
-- @param taglist list of tags' name
-- @param title name of post
-- @param metadata A table containing some replacement elements for posts
-- @param remember If true, set tag name into all tags list.
-- @return metadata (completed or not regarding taglist content)
-------------------------------------------------------------------------------
function blog.parseTags(taglist, metadata, title, template, remember)
  if taglist then
    local post_tags = {}
    for i, tag in pairs(taglist:split(',')) do
      local tagname = utils.deleteEndSpace(utils.deleteBeginSpace(tag))
      -- remember the tagname to create tag links
      table.insert(post_tags, tagname)
      -- add tag to list of all tags if remember is true.
      if remember and remember == true then
        if tags[tagname] == nil then
          tags[tagname] = {title}
        else
          table.insert(tags[tagname], title)
        end
      end
    end
    -- create tag links
    local tag_links = blog.createTagLinks(post_tags, template)
    if tag_links then
      metadata['TAG_LINKS_LIST'] = tag_links and utils.replace(tag_links, replacements) or ''
    end
  end
  return metadata
end

-------------------------------------------------------------------------------
-- Create post page for given '@file'
-- @param file filename of post in db directory
-- @param config configuration elements as TITLE, TAGS, TYPE, etc.
-- @param data.template_file file to use as template for a post
-- @param data.template_tag_file file to use as template for tag in a post page
-- @return Nothing (process function)
-------------------------------------------------------------------------------
function blog.createPost(file, cfg, header, footer, data)
  local timestamp, title = string.match(file, "(%d+),(.+)%.mk")
  -- only create post if date is older than today
  if today > tonumber(timestamp) then
    local template = utils.readFile(data.template_file, 'r')
    local out = assert(io.open(config.postpath .. "/" .. utils.keepUnreservedCharsAndDeleteDuplicate(title) .. config.PAGE_EXT, 'wb'))
    local post = rope()
    local content = utils.readFile(config.srcpath .. "/" .. title .. config.SRC_EXT, 'r')
    local markdown_content = markdown(content)
    -- concatenate all final post subelements
    post:push (header)
    post:push (template)
    post:push (footer)
    -- keywords
    local keywords = blog.getKeywords(cfg)
    -- local replacements
    local post_replacements = {
      TITLE = cfg['TITLE'],
      POST_TITLE = cfg['TITLE'],
      ARTICLE_CLASS_TYPE = cfg['TYPE'] or '',
      CONTENT = markdown_content,
      POST_FILE = utils.keepUnreservedCharsAndDeleteDuplicate(title) .. config.PAGE_EXT,
      DATE = os.date(config.DATE_FORMAT, timestamp) or '',
      DATETIME = os.date(config.datetime_format, timestamp) or '',
      POST_AUTHOR = cfg['AUTHOR'],
      POST_ESCAPED_TITLE = title,
      KEYWORDS = keywords:flatten(),
    }
    -- process tags
    post_replacements = blog.parseTags(cfg['TAGS'], post_replacements, title, data.template_tag_file, nil)
    -- create substitutions list
    local substitutions = utils.getSubstitutions(replacements, post_replacements)
    -- add comment block if comment system is activated
    substitutions = blog.commentSubstitutions(substitutions, cfg, title)
    -- ${VARIABLES} substitution on markdown content
    local flatten_final_content = post:flatten()
    local final_content = utils.replace(flatten_final_content, substitutions)
    -- First time we replace element, CONTENT will get markdown_content. But markdown_content was not replaced itself with replacements elements. The next line is here to do that
    final_content = utils.replace(final_content, substitutions)
    out:write(final_content)
    assert(out:close())
    -- Print post title
    print (string.format(_("[%s] New post: %s"), display_success, cfg['TITLE']))
  end
end

-------------------------------------------------------------------------------
-- For each tag in '@post_tags' table, use '@file' template and replace information by those given for each tag. Then return a string containing a concatenation of each completed template.
-- @param post_tags list of tags' name
-- @param file template to use for each tag link
-- @return a string if some tags
-- @return an empty string if no tags
-------------------------------------------------------------------------------
function blog.createTagLinks(post_tags, file)
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
    local tag_page = string.gsub(v, '%s', '_') .. config.PAGE_EXT
    result = result .. utils.replace(template, {TAG_PAGE=tag_page, TAG_NAME=v})
  end
  return result
end

-------------------------------------------------------------------------------
-- For given index, close it with a footer.
-- @param file File in which we write result
-- @param result Content of index
-- @param title Title of the page
-- @param body_class Name of the class that will be add into BODY tag
-- @param pagin Pagination object in which you have next/first/last/previous page
-- @param page_number Number of current page in the code (start at 0)
-- @return Nothing (process method)
-------------------------------------------------------------------------------
function blog.closeIndex(file, result, title, body_class, pagin, page_number, footer)
  result:push (footer)
  -- do substitutions on page
  local page_sub_first = config.indexfile
  local page_sub_last = config.INDEX_FILENAME .. (pagin.total - 1) .. config.PAGE_EXT
  local page_sub_previous = config.INDEX_FILENAME .. pagin:previous_page(page_number) .. config.PAGE_EXT
  local page_sub_next = config.INDEX_FILENAME .. pagin:next_page(page_number) .. config.PAGE_EXT
  local index_sub_table = {
    TITLE=title,
    BODY_CLASS=body_class,
    PAGE_FIRST_LINK=page_sub_first,
    PAGE_PREV_LINK=page_sub_previous,
    PAGE_NEXT_LINK=page_sub_next,
    PAGE_LAST_LINK=page_sub_last,
    PAGE_CURRENT=page_number + 1,
    PAGE_TOTAL=pagin.total,
  }
  local index_substitutions = utils.getSubstitutions(replacements, index_sub_table)
  local index_content = utils.replace(result:flatten(), index_substitutions)
  file:write(index_content)
  -- Close index
  file:close()
end

-------------------------------------------------------------------------------
-- Create temporary elements (post content and post summary) to be included in Homepage and post list
-- @param data.index_nb Number of current index page (in the code)
-- @param data.increment If we do incrementation or decrementation of 'num'
-- @param data.min Homepage index minimum number
-- @param data.max Homepage index maximum number
-- @param data.num Real displayed number for index page
-- @return data.num, the number of new real displayed index number
-------------------------------------------------------------------------------
function blog.createPostForHomepage(file, title, cfg, content, sub, post_template, data)
  local final_content = utils.readFile(file, 'r')
  if data.index_nb >= data.min and data.index_nb <= data.max then
    if config.MAX_POST_LINES then
      local n = 0
      for i in content:gmatch("\n") do n=n+1 end
      final_content = utils.headFile(file, config.MAX_POST_LINES)
      if config.MAX_POST_LINES < n then
        local page_read_more = utils.readFile(config.themepath .. '/' .. config.page_read_more_name, 'r')
        final_content = final_content .. page_read_more
      end
    end
    local post_content = utils.replace(post_template, {CONTENT=markdown(final_content)})
    -- complete missing info
    sub['ARTICLE_CLASS_TYPE'] = cfg['TYPE'] or ''
    sub['POST_ESCAPED_TITLE'] = title
    -- add comment block if comment system is activated
    sub = blog.commentSubstitutions(sub, cfg, title)
    local content4index = utils.replace(post_content, sub)
    -- create temporary file for Homepage
    if data.increment then
      data.num = data.num + 1
    else
      data.num = data.num - 1
    end
    local homepage_file = io.open(config.tmppath .. '/index.' .. data.num .. '.tmp', 'wb')
    assert(homepage_file:write(content4index))
    -- close first_posts file
    assert(homepage_file:close())
  end
  return data.num
end

-------------------------------------------------------------------------------
-- Create RSS index page
-- @param content Content of the post to add in the RSS (if can be included)
-- @param config Metadata from the post
-- @param title Title of the post to be saved into temporary directory
-- @param template Template of RSS element
-- @param data.min Number minimum that the post number should have to be on RSS page
-- @param data.max Number maximum that the post number should have to be on RSS page
-- @param data.increment If true, increment, otherwise decrement number
-- @param data.index_nb Number (in the code) of the post for the result RSS. Cannot be superior to 'data.max'
-- @param data.num Number (in the code) of the post
-- @return data.num which is the number of the RSS
-------------------------------------------------------------------------------
function blog.createPostForRSS(content, cfg, title, template, data)
  if data.index_nb >= data.min and data.index_nb <= data.max then
    -- create temporary file for RSS
    if data.increment then
      data.num = data.num + 1
    else
      data.num = data.num - 1
    end
    local rss_file = io.open(config.tmppath .. '/' .. 'rss.' .. data.num .. '.tmp', 'wb')
    local rss_post_html_link = config.BLOG_URL .. '/' .. config.POSTDIR_NAME .. '/' .. title .. config.PAGE_EXT
    -- Change temporarly locale
    assert(os.setlocale('C'))
    local rss_date = os.date('!%a, %d %b %Y %T GMT', timestamp) or ''
    assert(os.setlocale(oslanguage or en_US.utf-8))
    local rss_post = utils.replace(template, {DESCRIPTION=markdown(content), TITLE=cfg['TITLE'], LINK=rss_post_html_link, DATE=rss_date})
    assert(rss_file:write(rss_post))
    -- close first_posts file
    assert(rss_file:close())
  end
  return data.num
end

-------------------------------------------------------------------------------
-- Parse all given posts to create the Index page and a RSS file
-- @param posts List of posts
-- @param result Rope of the post index file (result of the final page)
-- @param pagin Pagination object in which you have next/first/last/previous page
-- @param number.post_nb Current post number. Begin to 1
-- @param number.page_number Current page number in the code. Begin to 0.
-- @param template.element Template of an element that represents a short post description/info
-- @param template.article Template of post index
-- @param template.tag Template for tags
-- @param template.pagination Content of the template for pagination
-- @return indexfile after its modification
-- @return result after its modifications
-- @return number.post_nb after its modifications
-- @return number.page_number after its modifications
-- @return pagin after its modifications
-------------------------------------------------------------------------------
function blog.postsIndexing(posts, indexfile, result, pagin, number, template, post_list_title, header, footer)
  -- prepare some variables
  local index_nb = 0 -- number of post in all posts
  local increment = true
  local home_min = 0 -- minimal index_nb in all posts to appear on homepage
  local home_max = home_min + config.MAX_POST + 1 -- max index_nb in all posts to appear on homepage
  local home_index = 0 -- index process for posts that will appear on homepage
  local rss_min = 0
  local rss_max = rss_min + config.MAX_RSS + 1
  local rss_index_nb = 0
  if config.SORT == 'asc' then
    increment = false
    home_min = number.post_nb - config.MAX_POST - 1
    home_max = number.post_nb + 1
    home_index = config.MAX_POST + 1
    rss_min = number.post_nb - config.MAX_RSS - 1
    rss_max = number.post_nb + 1
    rss_index_nb = config.MAX_POST + 1
  end
  local post_element = utils.readFile(template.element, 'r')
  local rss_element = utils.readFile(config.page_rss_element, 'r')
  for k, v in pairs(posts) do
    -- get post's title
    local timestamp, title = string.match(v['file'], "(%d+),(.+)%.mk")
    -- only add a link for post older than today
    if today > tonumber(timestamp) then
      -- local substitutions
      local metadata = {
        POST_TITLE = v['conf']['TITLE'],
        POST_FILE = utils.keepUnreservedCharsAndDeleteDuplicate(title) .. config.PAGE_EXT,
        POST_AUTHOR = v['conf']['AUTHOR'],
        POST_DESCRIPTION = v['conf']['DESCRIPTION'] or '',
        SHORT_DATE = os.date(config.SHORT_DATE_FORMAT, timestamp) or '',
        DATE = os.date(config.DATE_FORMAT, timestamp) or '',
        DATETIME = os.date(config.datetime_format, timestamp) or '',
      }
      -- registering tags
      local post_conf_tags = v['conf']['TAGS'] or nil
      metadata = blog.parseTags(post_conf_tags, metadata, title, template.tag, true)
      -- prepare substitutions for the post
      local post_substitutions = utils.getSubstitutions(v, metadata)
      -- remember this post's element for each tag page
      local post_element_content = utils.replace(post_element, post_substitutions)
      local remember_file = assert(io.open(config.tmppath .. '/' .. utils.keepUnreservedCharsAndDeleteDuplicate(title), 'wb'))
      assert(remember_file:write(post_element_content))
      assert(remember_file:close())
      -- push result into index
      result:push(post_element_content)
      -- read post real content
      local postfile = config.srcpath .. '/' .. title .. config.SRC_EXT
      local content = utils.readFile(postfile, 'r')
      -- process post to be displayed on HOMEPAGE
      home_index = blog.createPostForHomepage(postfile, title, v['conf'], content, post_substitutions, template.article, { min = home_min, max = home_max, num = home_index, index_nb = index_nb, increment = increment })
      -- process post to be used in RSS file
      rss_index_nb = blog.createPostForRSS(content, v['conf'], title, rss_element, { min = rss_min, max = rss_max, num = rss_index_nb, index_nb = index_nb, increment = increment })
      -- incrementation
      index_nb = index_nb + 1
      -- Page process
      number.post_nb = number.post_nb + 1
      if pagin.max and number.post_nb > pagin.max and pagin.total > 1 then
        number.post_nb = 1
        -- Add pagination template
        result:push (template.pagination)
        -- CLOSE CURRENT INDEX
        blog.closeIndex(indexfile, result, replacements['POST_LIST_TITLE'], 'posts', pagin, number.page_number, footer)
        indexfile = nil
        result = nil
        print (string.format(_('[%s] Post list %s/%s: BUILT.'), display_success, number.page_number + 1, pagin.total))
        -- increment page number
        number.page_number = number.page_number + 1
        -- CREATE NEW INDEX
        indexfile = io.open(config.postpath .. '/' .. config.INDEX_FILENAME .. number.page_number .. config.PAGE_EXT, 'wb')
        result = rope()
        result:push (header)
        -- Add title of the post list on the result
        result:push (post_list_title)
      end
    end
  end
  return indexfile, result, number.post_nb, number.page_number, pagin
end

-------------------------------------------------------------------------------
-- Create post index page
-- @param posts list of posts {{file='123456,the_title_of_post.mk', conf={TITLE='The title of post', TAGS='something, other'}}, {file='234567,anything_else.mk', conf={TITLE='Anythin else', TAGS='anything'}}}
-- @param template.index_file path to the template to use for the index's page
-- @param template.element_file path to the template to use for each post that appears on tag's page
-- @param template.taglink_file path to the template to use for list of links to the tags
-- @param template.article_index_file path to the template to use for each post that appears on index's page
-- @return Nothing (process function)
-------------------------------------------------------------------------------
function blog.createPostIndex(posts, header, footer, template)
  -- check directory
  utils.checkDirectory(config.postpath)
  -- prepare some values
  local indexfile = io.open(config.postpath .. '/' .. config.indexfile, 'wb')
  local rssfile = io.open(config.publicpath .. '/' .. utils.keepUnreservedCharsAndDeleteDuplicate(config.RSS_NAME) .. config.rss_extension, 'wb')
  local rss_header = utils.readFile(config.page_rss_header, 'r')
  local rss_footer = utils.readFile(config.page_rss_footer, 'r')
  -- create a rope to merge all text
  local index = rope()
  local rss = rope()
  -- get header for results
  index:push (header)
  rss:push (rss_header)
  local post_list_title = utils.readFile(template.index_file, 'r')
  index:push (post_list_title)
  local template_article_index = utils.readFile(template.article_index_file, 'r')
  -- sort posts in a given order
  table.sort(posts, function(a, b) return utils.compare_post(a,b, config.SORT) end)
  -- prepare some values
  local pagination = require "pagination"
  local pagin = pagination.new(#posts, config.MAX_PAGE)
  local post_nb = #posts
  local page_number = 0
  local page_post_nb = 1
  -- Some common pagination numbers/files
  local page_pagination = utils.readFile(config.themepath .. '/' .. config.page_pagination_name, 'r')
  -- process posts
  indexfile, index, page_post_nb, page_number, pagin = blog.postsIndexing(posts, indexfile, index, pagin, { post_nb = page_post_nb, page_number = page_number }, { article = template_article_index, element = template.element_file, tag = template.taglink_file, pagination = page_pagination }, post_list_title, header, footer)
  -- If last post, finish index writing (to close file)
  if page_post_nb >= post_nb or (pagin.max and page_post_nb <= pagin.max) then
    -- Prepare page substitution elements
    if pagin.max and pagin.max > 0 and pagin.total > 1 then
      -- Add pagination template
      index:push (page_pagination)
    end
    -- CLOSE FINAL INDEX
    blog.closeIndex(indexfile, index, replacements['POST_LIST_TITLE'], 'posts', pagin, page_number, footer)
    if pagin.max and pagin.max > 0 and pagin.total > 1 then
      print (string.format(_('[%s] Post list %s/%s: BUILT.'), display_success, page_number + 1, pagin.total))
    end
  end
  -- rss process
  local index_rss_nb = 1
  while index_rss_nb <= config.MAX_RSS do
    local rsspath = config.tmppath .. '/' .. 'rss.' .. index_rss_nb .. '.tmp'
    local rss_content = utils.readFile(rsspath, 'r')
    rss:push (rss_content)
    index_rss_nb = index_rss_nb + 1
    os.remove(rsspath)
  end
  rss:push (rss_footer)
  rss_replace = utils.replace(rss:flatten(), replacements)
  rssfile:write(rss_replace)
  rssfile:close()
  -- Display that RSS file was created
  print (string.format(_("[%s] RSS feed: BUILT."), display_success))
  -- Display that post index was created
  print (string.format(_('[%s] Post list: BUILT.'), display_success))
end

-------------------------------------------------------------------------------
-- Create a page for a given tag
-- @param filename path to the file we want to create
-- @param title title of page (using a replacement)
-- @param posts list of posts that are linked to this tag
-------------------------------------------------------------------------------
function blog.createTag(filename, title, posts, header, footer)
  local page = rope()
  page:push(header)
  -- insert content (all posts linked to this tag)
  for k, post in pairs(posts) do
    local content = ''
    content = utils.readFile(config.tmppath .. '/' .. post, 'r')
    if content then
      page:push(content)
    end
  end
  page:push(footer)
  local page_file = assert(io.open(filename, 'wb'))
  -- keywords
  local keywords = rope()
  keywords:push (title)
  if config.BLOG_KEYWORDS then
    keywords:push (',' .. config.BLOG_KEYWORDS)
  end
  -- do substitutions on page
  local substitutions = utils.getSubstitutions(replacements, {TITLE=title, KEYWORDS=keywords:flatten()})
  local final_content = utils.replace(page:flatten(), substitutions)
  page_file:write(final_content)
  page_file:close()
  -- Print tag title
  print (string.format(_("[%s] New tag: %s"), display_success, title))
end

-------------------------------------------------------------------------------
-- Create the tag index's page
-- @param index_filename path of file to use to write result into
-- @param data.template_index_filename path to the template to use for tag index's page
-- @param data.template_element_filename path to the template to use for each tag on tag index's page
-- @return Nothing (process function)
-------------------------------------------------------------------------------
function blog.createTagIndex(path, header, footer, data)
  local index = rope()
  index:push(header)
  -- check tagpath directory
  utils.checkDirectory(config.tagpath)
  local index_file = assert(io.open(path, 'wb'))
  -- read general tag index template file
  local template_index = utils.readFile(data.template_index_filename, 'r')
  -- read tage element template file
  local template_element = utils.readFile(data.template_element_filename, 'r')
  -- browse all tags
  local taglist_content = ''
  for tag, posts in utils.pairsByKeys(tags) do
    local tag_page = string.gsub(tag, '%s', '_') .. config.PAGE_EXT
    taglist_content = taglist_content .. utils.replace(template_element, {TAG_PAGE=tag_page, TAG_NAME=tag})
    blog.createTag(config.tagpath .. '/' .. utils.keepUnreservedCharsAndDeleteDuplicate(tag_page), tag, posts, header, footer)
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
  print (string.format(_("[%s] Tag list: BUILT."), display_success))
end

-------------------------------------------------------------------------------
-- Create homepage
-- @param file path to the file to write into
-- @param title title of the page
-- @return Nothing (process function)
-------------------------------------------------------------------------------
function blog.createHomepage(file, title, header, footer)
  local index = rope()
  local index_file = io.open(file, 'wb')
  index:push(header)
  -- push content from all temporary files
  local index_nb = 1
  while index_nb <= config.MAX_POST do
    local content = utils.readFile(config.tmppath .. '/' .. 'index.' .. index_nb .. '.tmp', 'r')
    index:push(content)
    index_nb = index_nb + 1
  end
  -- fetch mini-footer for homepage
  local index_footer_file = utils.readFile(config.themepath .. '/' .. config.page_posts_footername, 'r')
  index:push(index_footer_file)
  index:push(footer)
  local substitutions = utils.getSubstitutions(replacements, {BODY_CLASS='home', TITLE=title})
  local final_content = utils.replace(index:flatten(), substitutions)
  index_file:write(final_content)
  assert(index_file:close())
  -- Display that homepage was created
  print (string.format(_("[%s] Homepage: BUILT."), display_success))
end

-------------------------------------------------------------------------------
-- Create single static page named PAGE
-- @return Nothing (process function)
-------------------------------------------------------------------------------
function blog.createPage(origin, destination, title, header, footer)
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
  print (string.format(_("[%s] Page '%s': BUILT."), display_success, title))
end

function blog.checkTheme(cfg)
  -- Display which theme the user have choosed
  print (string.format(_("[%s] Theme: %s"), display_info, cfg.THEME))

  -- Check that given them exists
  if lfs.attributes(config.themepath) == nil then
    print(string.format(_("[%s] Given theme (%s) seems to not exist."), display_error, cfg.THEME))
    os.exit(1)
  end

  -- Check that user choice doesn't conflict with default templates extension
  if cfg.PAGE_EXT == cfg.TMPL_EXT then
    print(string.format(_("[%s] You cannot choose an extension (%s) similar to template's one (%s)."), display_error, cfg.PAGE_EXT, cfg.TMPL_EXT))
    os.exit(1)
  end
end

function blog.getLanguageConfig(cfg, path)
  -- Get language configuration
  local language = string.sub(cfg.BLOG_LANG, 0, 2)
  local languagefile = path .. '/translate.' .. language
  if lfs.attributes(languagefile) == nil then
    languagefile = path .. '/translate.' .. language_default
    print(string.format(_("[%s] No '%s' translation. Use default one: %s."), display_warning, language, language_default))
  end
  return utils.getConfig(languagefile)
end

return blog
