-------------------------------------------------------------------------------
-- LICENSE
--
-- Makefly, a static weblog engine using Lua
-- Copyright (C) 2012-2015 DOSSMANN Olivier, <olivier+makefly@dossmann.net>
--
-- This file is part of Makefly.
-- 
-- Makefly is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- Makefly is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
-- 
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
-------------------------------------------------------------------------------

pagination = { }

function pagination.new(item_number, max)
  -- default values
  local o = {
    items = item_number,
    first_page = 1,
    last_page = 1,
    total = 1,
  }
  if max == 0 then
    max = nil
  end
  o.max = max or nil
  -- If item_number is inferior to max, then page number (total) is 1. And all is 1.
  -- Otherwise, do some processes
  if max and item_number > max then
    local remain = item_number%max
    if remain > 0 then
      o.total = (item_number - remain)/max + 1
    else
      o.total = item_number/max
    end
    o.last_page = o.total - 1
  end
  return setmetatable(o, { __index = pagination })
end

function pagination:show()
  for i, j in pairs(self) do
    print(i .. ' ' .. j)
  end
end

function pagination:previous_page(number)
  res = (number - 1) > 0 and (number - 1) or 0
  if res == 0 then
    res = ''
  end
  return res
end

function pagination:next_page(number)
  res = (number + 1) < self.total and (number + 1) or self.total - 1
  if res == 0 then
    res = ''
  end
  return res
end

return pagination
