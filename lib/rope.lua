#!/usr/bin/env lua
-------------------------------------------------------------------------------
-- Permit to do rope with string method
-- @see http://lua-users.org/wiki/LuaRopes
-------------------------------------------------------------------------------

--[[ QUICK HOWTO ]]--
--t,x = rope(),rope()
--t:push (string.upper) "m" "r" (string.char) (32) "Smith" ;
--x:push [[ Good ]] [[morning]];
--t:push (x)
--t:walk(io.write) --> Mr Smith Good morning
--print(t:flatten()) --> Mr Smith Good morning

do
  local function walk(x,f)
    local typ, ok, bad = type(x),true
    local errmsg = "bad type (%s), %s"
    if typ == "string" then return pcall(f,x)
    elseif typ == "table" then
      local i,n = 1,#x
      while ok and i <= n do
        ok,bad = walk(x[i],f)
        i = i+1
      end -- while
      return ok,bad
    else
      bad = errmsg:format(typ,typ and "" or "something undefined?")
      return nil,bad
    end -- if
  end -- function

  local mt = {
    push = function (self,x)
      local function f(y)
        if y and type(y) ~= "function" then
          self[#self + 1] =y
          return f
        elseif y then
          return function (z)
            return f(y(z))
          end -- function
        end -- if
      end -- function y
      return f(x)
    end; -- function push
    walk = walk;
    flatten = function(self)
      local o = {}
      local f = function (x) o[#o + 1] = x end -- function
      self:walk(f)
      return table.concat(o)
    end; -- function
  }

  function rope()
    return setmetatable({}, {__index = mt})
  end -- function
end -- do
