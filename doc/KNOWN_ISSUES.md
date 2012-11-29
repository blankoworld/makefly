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

## Issue 3

Error:

    pmake: "./makefly/Makefile" line XXX: warning: Couldn't read shell's output for "cd ./src; ls"
    pmake: "./makefly/Makefile" line XXY: warning: Couldn't read shell's output for "cd ./db; ls|sort -r"
    pmake: "./makefly/Makefile" line XXZ: warning: Couldn't read shell's output for "cd ./db; ls|sort -r|head -n 3"

Solution: No post to process. Add new post for your blog :)

## Issue 4

Error:

    pmake: "./makefly/Makefile" line 70: Could not find makefly.rc
    pmake: "./makefly/Makefile" line 72: Could not find ./lang/translate.
    head : l'option requiert un argument -- n
    Saisissez « head --help » pour plus d'informations.
    pmake: "./makefly/Makefile" line 135: warning: "cd ./db; ls|sort -r|head -n " returned non-zero status
    pmake: Fatal errors encountered -- cannot continue

Solution: Copy the makefly.rc.example to makefly.rc file.
