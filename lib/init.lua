-------------------------------------------------------------------------------
-- Initialization:
-- Import luafilesystem to work.
-- Use a getConfig function to get default configuration.
-- Fetch default configuration
-- Get user's language
-- @author Olivier DOSSMANN
-------------------------------------------------------------------------------

lfs = require 'lfs'
require 'lib.gettext'

--- Minimum requirement to have translation
langpath = os.getenv('LANGDIR') or currentpath .. '/lang'
language_default = 'en' -- language name
oslanguage = os.getenv('LANG') or language_default
-- Translations
mofile = langpath .. '/' .. string.sub(oslanguage, 0, 2) .. '.mo'
if lfs.attributes(mofile) == nil then
  mofile = langpath .. '/' .. language_default .. '.mo'
end
_=assert(load_mo_file(mofile), string.format('Translation problem. A file is missing: %s', mofile))
