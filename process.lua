#!/usr/bin/env lua
-------------------------------------------------------------------------------
-- Core: Process db and src directory to create a result in a 'public' directory
-- - get libraries
-- - initialize configuration
-- - prepare the location
-- - copy CSS files
-- - prepare some translations for templates
-- - create eli's badge
-- - create sidebar
-- - create searchbar
-- - create introduction/conclusion paragraphs
-- - create about's page
-- - copy static directory
-- - parse db files
-- - create each post file
-- - create post index file
-- - create each tag file
-- - create tag index file
-- - create homepage
-- - delete temporary files
-- @author Olivier DOSSMANN
-- @copyright Olivier DOSSMANN
-------------------------------------------------------------------------------

--[[ Variables ]]--
local jskomment_max_default = 3 -- number of comments displayed by default for each post
local jskomment_url_default = 'http://jskomment.appspot.com' -- default URL of JSKOMMENT comment system
local jskomment_captcha_theme_default = 'white'
local eli_css_name = 'eli.css'
local eli_js_filename = 'eli.js'
local eli_max_default = 5
local eli_type_default = 'user'
local eli_tmp_file = tmppath .. '/' .. 'content.eli'
-- vim:expandtab:smartindent:tabstop=2:softtabstop=2:shiftwidth=2:
