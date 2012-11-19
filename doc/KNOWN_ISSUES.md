<link href="./readme.css" rel="stylesheet"></link>

# Known issues

## Issue 1

Error:

    /bin/sh: 1: lua: not found
    -- Error while building ./pub/posts/makefly_project.html.
    *** Error code 1
    
    Stop.

Solution: Lua is missing. Install it by using a command like:

    apt-get install lua5.1

## Issue 2

Error:

    /bin/sh: 1: markdown: not found
    -- Could not build doc file: ./doc/README.html
    -- Doc file built: ./doc/README.html
    `doc' is up to date.

Solution: Markdown is missing. Install it by using a command like:

    apt-get install markdown

