#!/usr/bin/env bash
#
# test_parser.sh

## LICENSE ##
#
# Copyright (c) 2012 DOSSMANN Olivier
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# THE SOURCE CODE OF THE SOFTWARE DESIGNATES THE FILES REQUIRED TO BUILD THE SOFTWARE AND TO MAKE IT WORK. THE SOURCE CODE OF ANY PART OF THE SOFTWARE INVOLVED IN THE PRODUCTION OF A SERVICE OR IN PROVIDING IT MUST BE ACCESSIBLE TO ANYONE. THE SOURCE CODE OF THE SOFTWARE MUST BE PUBLISHED WITH THE SERVICE OR BE SENT TO ANYONE REQUESTING IT, PREFERABLY BY SOME CUSTOMARY MEANS.

cat element.xhtml |lua parser.lua "DATE=2012-05-04 15:33:25" "BASEURL=http://localhost/" "FILE=art1.xhtml" "TITLE=Le \"super\" titre de mon billet"
