#!/usr/bin/env lua
-- utils.lua
-- Useful methods for process.lua script
-- Olivier DOSSMANN

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

function checkDirectory(path)
  if lfs.attributes(path) == nil then
    assert(lfs.mkdir(path))
    -- Display created directory
    print (string.format("-- [%s] New folder: %s", display_success, path))
  end
end

function readFile(path, mode)
  local result = ''
  if mode == nil then
    local mode = 'r'
  end
  if mode ~= 'r' and mode ~= 'rb' then
    print(string.format("-- [%s] Unknown read mode while reading this path: %s.", display_error, path))
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
    print (string.format("-- [%s] %s not found in copy method!", display_error, origin))
    os.exit(1)
  end
end

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
