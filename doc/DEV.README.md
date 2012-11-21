<link href="./readme.css" rel="stylesheet"></link>

# Makefly Technical Documentation

## Plan - Working Intro

  * explain db dir and src dir
  * explain how works git repositories:
    * 3 hosts (gitorious, github and git.dossmann.net)
    * some branches (master, comments, weblog)
  * how is made Makefile
  * how templates work?
  * langage variables
  * makefly.rc: give some tips that permits to change some other variable, as programs, etc.
  * Dev's best practices:
    * if add a variable for TEMPLATE, add translation in lang directory, complete documentation
    * if encount a problem and solve it: give solution into doc/KNOWN_ISSUES.md file
    * if a problem is not solved: create an issue on github for other developers to know it and resolve it if possible
    * if a fix is down or a new functionalities is available, don't forget to add a line into Changelog file

## Introduction

This documentation aims to explain how Makefly work. Developer will probably search information on how add code and how contribute on Makefly.

You should found what you want here. If not, please tell me that I add answer in this file for next developers.

My contact: olivier+makefly [AT] dossmann [DOT] net.

## Requirements

You don't need to be a developer and/or a hacker to understand this documentation and contribute to Makefly. Just be curious, read the doc and contact the author :-).

Nevertheless, I recommand you to know:

  * Using a shell (as bash, zsh or sh)
  * Read the BSD Makefile documentation (or use it as a reference)
  * How to create a web page - HTML and CSS

## Quick Bases

First thing you have to know is : Makefly is not made to be KISS/simple. It's made to do a thing and do it well. To have an interface to publish posts and to write posts, another project will born (*HYMBY* or *ANSWER* project) to make this interface. But this is another subject.

### Main engine

Makefly is a program that use a BSD Makefile to work. The BSD Makefile is a system that watch all needed files, all target files and will compile/make only what useful from needed files to target files. In fact, if you relaunch command, it will only recompile what needed.

For an example, if you change only one file, and this file is only used in ONE target file, then BSD Makefile will only compile/make the target file with the source file.

This mechanism permits to save up time and resources. To my mind, this is the power of Makefly.

Have a look to **Main engine: The Makefile file** section to understand how it works.

### Posts

In makefly, a post is split in 2 files:

  * a metadata file
  * a source file

Metadata file contains all metadata for the post.

Source file contains the content of the post.

You probably think that this make no sense, but have a look to the Makefile to see that's useful. For further information, read **Leanr more about posts ' files** section.

### Configuration file

As some programs, Makefly aims to permit configuration in ONE unique file: **makefly.rc**. But as others, you can do more by customizing Makefly's files as:

  * Makefile: some variables could be useful to display errors in another langages, give some other template files, add more variables, etc.
  * lang/translate.* files: You can add a new translation or add more values
  * template files: You can customize template as you want. But not sure it works after changes :-)

With the main configuration file (**makefly.rc**) you can do some things as:

  * activate/desactivate a sidebar, a searchbar
  * change template
  * change date format
  * name, description of your blog
  * name of index files
  * extension of your blog
  * etc.

For more information, please have a look to **The makefly.rc file** section.

### Where is the code?

## Repos

The code is put on 3 git repositories:

  * [Gitorious](http://gitorious.org/makefly/ "Makefly on Gitorious")
  * [Github](http://github.com/blankoworld/makefly/ "Makefly on Github")
  * Personal repository: http://git.dossmann.net/

You can pull them with **git** command in a terminal, for an example with gitorious:

    git clone git://gitorious.org/makefly/master.git master

For gitub:

    git clone git://github.com/blankoworld/makefly.git

**Note**: We have no time to discuss about my git choice. If you dislike git, perhaps could you use another VCS like HG and its [hg-git plugin](http://hg-git.github.com/ "Learn more about hg-git").

## Branches

I work with branches. Each branch have a specific goal. Here is the 3 main branches I have:

  * master: last makefly development
  * disqus_comments: with disqus as comment system
  * comments: for 0.2 version with a integrated comment system

If you want to dev a functionnality, I suggest you to begin from **master branch** on gitorious and/or github. Then to do a merge request on it.

## Learn more about posts ' files

FIXME

## Main engine: The Makefile file

FIXME

## The makefly.rc file

FIXME

## Template's files

FIXME

## Language files

FIXME
