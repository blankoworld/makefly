-------------------------------------------------------------------------------
-- Initialization:
-- Import luafilesystem to work.
-- Get user's environment language
-- @author Olivier DOSSMANN
-------------------------------------------------------------------------------

local lfs = require 'lfs'
local gettext = require 'gettext'

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
