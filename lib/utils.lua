-------------------------------------------------------------------------------
-- General utilities.
-- @author Olivier DOSSMANN
-- @copyright Olivier DOSSMANN
-------------------------------------------------------------------------------

--- Split a string using '@sep' separator
-- @param sep char to split string
-- @usage 'a string, with some words':split(',')
-- @usage 'some:data:to:split':split()
-- @return table with all split elements using the separator char
-------------------------------------------------------------------------------
function string:split(sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

-------------------------------------------------------------------------------
--- Cut off trailing spaces from string's beginning
-- @param string string to be replaced
-- @usage deleteBeginSpace('a string') => 'a string'
-- @usage deleteBeginSpace('   a string') => 'a string'
-- @usage deleteBeginSpace('   a string    ') => 'a string    '
-- @return a string without any space at the beginning
-------------------------------------------------------------------------------
function deleteBeginSpace(string)
  local res = string.gsub(string, "^ *", '')
  return res
end

-------------------------------------------------------------------------------
--- Cut off trailing spaces from string's end
-- @param string string to be replaced
-- @usage deleteEndSpace('a string') => 'a string'
-- @usage deleteEndSpace('a string   ') => 'a string'
-- @usage deleteEndSpace('   a string    ') => '   a string'
-- @return a string without any space at the end
-------------------------------------------------------------------------------
function deleteEndSpace(string)
  local res = string.gsub(string, " *$", '')
  return res
end

-------------------------------------------------------------------------------
-- List only files that have '@extension' as extension from the given '@path'
-- @param path the absolute path to list
-- @param extension the extension from file to be listed
-- @usage listing('/home/olivier/dbfiles', '.mk') => will list all .mk files from /home/olivier/dbfiles
-- @return a table with key/value where values are file's name
-- @return nil if path does not exist
-------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
-- Read given file as a configuration file (each line as VARIABLE_NAME = value)
-- @param file the absolute/relative path to the configuration file to read
-- @usage getConfig('/home/olivier/config.rc')
-- @return a table with key/value where key = VARIABLE_NAME and value = value
-------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
-- Get '@string' and replace all '${KEY}' by its value given in '@table'
-- @param string the string in which you will replace some elements
-- @param table a table composed of KEY/VALUE where KEY is the ${KEY} to replace and VALUE its replacement
-- @usage replace('Hello, my name is ${NAME}. Who are you?', {NAME='Olivier'})
-- @usage replace('Hello, my name is ${NAME}. I am ${AGE}.', {NAME='Olivier', AGE='18', TALL='1m80'})
-- @return the replaced string
-------------------------------------------------------------------------------
function replace(string, table)
  return string:gsub("$(%b{})", function(string)
    return table[string:sub(2,-2)]
   end)
end

-------------------------------------------------------------------------------
-- Check if path exists, otherwise create the path as a directory
-- @param path the absolute/relative path to check and to create if no one
-- @usage checkDirectory('/home/olivier/new_directory')
-- @return Nothing. The result is just a directory.
-------------------------------------------------------------------------------
function checkDirectory(path)
  if lfs.attributes(path) == nil then
    assert(lfs.mkdir(path))
    -- Display created directory
    print (string.format(_("-- [%s] New folder: %s"), display_success, path))
  end
end

-------------------------------------------------------------------------------
-- Read the file and return its content
-- @param path the absolute/relative path to the file to read
-- @param mode read mode among 'r', 'rb', etc.
-- @see http://www.lua.org/manual/5.2/manual.html#pdf-io.open
-- @usage readFile('/home/olivier/document.txt', 'r')
-- @return file's content if exists
-- @return an empty string if file does not exist (or is not a file)
-------------------------------------------------------------------------------
function readFile(path, mode)
  local result = ''
  if mode == nil then
    local mode = 'r'
  end
  if mode ~= 'r' and mode ~= 'rb' then
    print(string.format(_("-- [%s] Unknown read mode while reading this path: %s."), display_error, path))
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

-------------------------------------------------------------------------------
-- Read first lines ('@number') from given '@path'
-- @param path the absolute/relative path to the file to read
-- @param number number of line to read from the file's header
-- @usage headFile('/home/olivier/document.txt', '15') => read the 15 first lines from document.txt file
-- @return the first lines from given file
-------------------------------------------------------------------------------
function headFile(path, number)
  local result = ''
  if not number then
    return readFile(path, 'r')
  else
    local attr = lfs.attributes(path)
    if attr and attr.mode == 'file' then
      local f = assert(io.open(path, mode))
      i = 0
      for line in f:lines() do
        result = result .. line .. '\n'
        i = i + 1
        if i == number then break end
      end
    end
  end
  return result
end

-------------------------------------------------------------------------------
-- Copy a file from its '@origin' to given '@destination'. Optionally replace some elements
-- @see replace method
-- @param origin the absolute/relative path to the file to copy
-- @param destination the absolute/relative path of the result file
-- @param freplace a table containing all VARIABLE/VALUE to replace in the given '@origin' file
-- @usage copyFile('/home/olivier/document.txt', '/home/olivier/document2.txt', nil) => will copy document.txt to document2.txt
-- @usage copyFile('/home/olivier/document.txt', '/home/olivier/document3.txt', {TITLE='My title'}) => will copy document.txt to document3.txt and will replace all ${TITLE} by 'My title' string.
-- @return Nothing. The result is the '@destination' file.
-------------------------------------------------------------------------------
function copyFile(origin, destination, freplace)
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
    if freplace then
      result:write(replace(content, freplace))
    else
      result:write(content)
    end
  end
  result:close()
end

-------------------------------------------------------------------------------
-- Recursive copy from a directory to another one
-- @param origin original directory to copy
-- @param destination destination where to copy the given directory ('@origin')
-- @usage copy('/home/olivier/Pictures', '/home/olivier/Pictures2') => will copy all Pictures' content to Pictures2
-- @return Nothing. The '@destination' directory should be created.
-------------------------------------------------------------------------------
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
    print (string.format(_("-- [%s] %s not found in copy method!"), display_error, origin))
    os.exit(1)
  end
end

-------------------------------------------------------------------------------
-- Merge '@local_replaces' table into '@replaces' one. Overwrite variables from '@replaces' if exist.
-- @param replaces first table in which add new values
-- @param local_replaces new values
-- @usage getSubstitutions({TITLE='My title', NAME='Olivier'}, {AGE='18', NAME='MiniMe'}) => {TITLE='My title', NAME='MiniMe', AGE='18'}
-- @return a table containing replaces + local_replaces, otherwise return an empty table
-------------------------------------------------------------------------------
function getSubstitutions(replaces, local_replaces)
  -- create substitutions list
  local result = {}
  for k, v in pairs(replaces) do 
    result[k] = v
  end
  for k, v in pairs(local_replaces) do 
    result[k] = v
  end
  return result
end

-------------------------------------------------------------------------------
-- Launch threads from 'threads' table
-- @use dispatcher()
-- @return Nothing
-------------------------------------------------------------------------------
function dispatcher ()
  while true do
    local n = table.getn(threads)
    if n == 0 then break end   -- no more threads to run
    for i=1,n do
      if coroutine.status(threads[i]) == 'dead' then
        table.remove(threads, i)
        break
      end
      local status, res = coroutine.resume(threads[i])
      if not res then    -- thread finished its task?
        table.remove(threads, i)
        break
      end
    end
  end
end

-------------------------------------------------------------------------------
-- Compare 2 posts regarding their filename. This method is used in a table.sort() method, for an example.
-- @param a first post
-- @param b second post to compare regarding the first one
-- @param order asc OR desc to do a ascending/descending comparison
-- @usage compare_post({file='the_filename'}, {file='my_filename'}, 'asc') => return False because my_filename is before the_filename in ascending sort
-- @usage compare_post({file='the_filename'}, {file='my_filename'}, 'desc') => return True because my_filename is after the_filename in descending sort
-- @return true if a before b with asc
-- @return true if a after b with desc
-- @return false if a after b with asc
-- @return false if a before b with desc
-------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
-- Iterator that traverses a table following the order of its keys
-- @see http://www.lua.org/pil/19.3.html
-- @param t table to browse
-- @param f alternative order (function)
-- @usage for name, line in pairsByKeys(lines) do print(name, line) end => print name, line in alphabetical order
-------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
-- Check if given '@mandatories' values are present in '@origin'
-- @param origin table to check
-- @param mandatories table with mandatories elements
-- @usage missingMandatories({TITLE='my title', DATE='2013/08/01'}, {'TITLE', 'TAGS'}) => will return a table with a value to "TAGS" because DATE is present, but not TAGS one.
-- @return an empty table if all mandatories elements are present in origin
-- @return a table with missing elements if some elements are missing in '@origin' table
-------------------------------------------------------------------------------
function missingMandatories(origin, mandatories)
  local res = {}
  for i, j in ipairs(mandatories) do
    if origin[j] == nil or origin[j] == '' then
      table.insert(res, j)
    end
  end
  return res
end

-------------------------------------------------------------------------------
-- Concatenate all elements from given '@missingTable' to display them in a string
-- @param missingTable table that lists some elements
-- @usage displayMissing({'TITLE', 'DATE'}) => return 'TITLE, DATE'
-- @return a string containing all elements with a coma separator and a space (could be changed regarding language)
-------------------------------------------------------------------------------
function displayMissing(missingTable)
  local res = ''
  for i, j in ipairs(missingTable) do
    separator = _(', ')
    if i == 1 then separator = '' end
    res = res .. separator .. j
  end
  return res
end

-------------------------------------------------------------------------------
-- Process '@origin' table to see if all given '@mandatories' elements are present. If not display a string containing all missing ones.
-- @see missingMandatories function
-- @see displayMissing function
-- @param origin table to check
-- @param mandatories table with elements that should not be missed!
-- @usage processMissingInfo({TITLE='my title'}, {'DATE', 'TAGS'})
-- @return 'DATE, TAGS' because they are missing in {TITLE='my title'}
-- @return a string containing missing elements if case appears
-- @return an empty string if no element missed
-------------------------------------------------------------------------------
function processMissingInfo(origin, mandatories)
  local missing = missingMandatories(origin, mandatories)
  local res = displayMissing(missing) or ''
  return res
end
-- vim:expandtab:smartindent:tabstop=2:softtabstop=2:shiftwidth=2:
