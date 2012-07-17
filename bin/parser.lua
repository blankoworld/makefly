#!/usr/bin/env lua

--[[ LICENSE

Makefly, a static weblog engine using a BSD Makefile
Copyright (C) 2012 DOSSMANN Olivier

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

--]]

--[[ USE

lua parser.lua var1=value1 var2=value2 <in >out
This permits to replace ${var1} by "value1" in a string.

Could be used as this: % lua test.lua "un cochon=un chat" <<<'Oh ! ${un cochon} !' 
Result: Oh ! un chat !
--]]

function replace(file, table)
  local s = file:read("*a")
  return s:gsub("$(%b{})", function(s)
    return table[s:sub(2,-2)]
  end)
end

function parseargs(...)
  local out = {}
  for _, v in ipairs({...}) do
    local key = v:match("(.-)=")
    local val = v:match("=(.*)")
    out[key] = val
  end
  return out
end

io.write((replace(io.stdin, parseargs(...))))
