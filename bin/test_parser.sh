#!/usr/bin/env bash

cat element.xhtml |lua parser.lua "DATE=2012-05-04 15:33:25" "BASEURL=http://localhost/" "FILE=art1.xhtml" "TITLE=Le \"super\" titre de mon billet"
