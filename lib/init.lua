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
-- Initialization:
-- Import luafilesystem to work.
-- Get user's environment language
-- @author Olivier DOSSMANN
-------------------------------------------------------------------------------

local lfs = require 'lfs'
local gettext = require 'lib.gettext'

--- Minimum requirement to have translation
currentpath = os.getenv('CURDIR') or '.'
langpath = os.getenv('LANGDIR') or currentpath .. '/lang'
language_default = 'en' -- language name for default blog result
oslanguage = os.getenv('LANG') or language_default
-- Translations
local mofile = langpath .. '/' .. string.sub(oslanguage, 0, 2) .. '.mo'
if lfs.attributes(mofile) == nil then
  mofile = langpath .. '/' .. language_default .. '.mo'
end
_=assert(gettext.load_mo_file(mofile), string.format('Translation problem. A file is missing: %s', mofile))
