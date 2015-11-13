#!/usr/bin/env lua
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
-- 
-------------------------------------------------------------------------------
-- load an mo file and return a lua table
-- @param mo_file name of the file to load
-- @return table on success
-- @return nil,string on failure
-- @copyright J.Jorgen von Bargen
-- @licence I provide this as public domain
-- @see http://www.gnu.org/software/hello/manual/gettext/MO-Files.html
-- @see http://lua.2524044.n2.nabble.com/State-of-Lua-and-GNU-gettext-tt4797364.html#a4835939
-------------------------------------------------------------------------------
local gettext = { }

function gettext.load_mo_file(mo_file)
    --------------------------------
    -- open file and read data
    --------------------------------
    local fd,err=io.open(mo_file,"rb")
    if not fd then return nil,err end
    local mo_data=fd:read("*all")
    fd:close()

    --------------------------------
    -- precache some functions
    --------------------------------
    local byte=string.byte
    local sub=string.sub

    --------------------------------
    -- check format
    --------------------------------
    local peek_long --localize
    local magic=sub(mo_data,1,4)
    -- intel magic 0xde120495
    if magic=="\222\018\004\149" then
        peek_long=function(offs)
            local a,b,c,d=byte(mo_data,offs+1,offs+4)
            return ((d*256+c)*256+b)*256+a
        end
    -- motorola magic = 0x950412de
    elseif magic=="\149\004\018\222" then
        peek_long=function(offs)
            local a,b,c,d=byte(mo_data,offs+1,offs+4)
            return ((a*256+b)*256+c)*256+d
        end
    else
        return nil,"no valid mo-file"
    end

    --------------------------------
    -- version
    --------------------------------
    local V=peek_long(4)
    if V~=0 then
        return nil,"unsupported version"
    end

    ------------------------------
    -- get number of offsets of table
    ------------------------------
    local N,O,T=peek_long(8),peek_long(12),peek_long(16)
    ------------------------------
    -- traverse and get strings
    ------------------------------
    local hash={}
    for nstr=1,N do
        local ol,oo=peek_long(O),peek_long(O+4) O=O+8
        local tl,to=peek_long(T),peek_long(T+4) T=T+8
        hash[sub(mo_data,oo+1,oo+ol)]=sub(mo_data,to+1,to+tl)
    end
    return function(text)
        return hash[text] or text
    end
end

return gettext
