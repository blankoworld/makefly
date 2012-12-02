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
    * if encount a problem and solve it: give solution into doc/KNOWN\_ISSUES.md file
    * if a problem is not solved: create an issue on github for other developers to know it and resolve it if possible
    * if a fix is down or a new functionalities is available, don't forget to add a line into Changelog file
  * Explain which tools exists: populate\_makefly, install, etc.

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

The metadata file contains all metadata for the post.

The source file contains the content of the post.

You probably think that this make no sense, but have a look to the Makefile to see that's useful. For further information, read **Learn more about posts ' files** section.

### Configuration file

As some programs, Makefly aims to permit configuration in ONE unique file: **makefly.rc**. But as others, you can do more by customizing Makefly's files as:

  * Makefile: some variables could be useful to display errors in another languages, give some other template files, add more variables, etc.
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

## Where is the code?

The code is distributed on the Internet on some repositories. Each repository have some branches. Each branch is used for a specific goal. For an example the official Makefly website is contained in a branch called *weblog*.

### Repos

The code is put on 3 git repositories:

  * [Gitorious](http://gitorious.org/makefly/ "Makefly on Gitorious")
  * [Github](http://github.com/blankoworld/makefly/ "Makefly on Github")
  * Personal repository: http://git.dossmann.net/

You can pull them with **git** command in a terminal, for an example with gitorious:

    git clone git://gitorious.org/makefly/master.git master

For gitub:

    git clone git://github.com/blankoworld/makefly.git

**Note**: We have no time to discuss about my git choice. If you dislike git, perhaps could you use another VCS like HG and its [hg-git plugin](http://hg-git.github.com/ "Learn more about hg-git").

### Branches

I work with branches. Each branch have a specific goal. Here is the 3 main branches I have:

  * master: last makefly development
  * disqus\_comments: with disqus as comment system
  * comments: for 0.2 version with a integrated comment system

If you want to dev a functionnality, I suggest you to begin from **master branch** on gitorious and/or github. Then to do a *merge request* on it.

### How to create new branch and push specific changes into?

I suggest you to read this article: [A successful git branching model](http://nvie.com/posts/a-successful-git-branching-model/ "Learn more about a successful git branching model"). This one explain how you can do branch and merge functionalities into.

## Learn more about posts ' files

As described previously, posts are composed of 2 files: 

  * a DB file that contains meta data
  * a source file that contains content of post

This permit Makefly to just extract content or just meta info.

Meta data are stored into the **db** directory (DBDIR variable). Furthermore source files are stored into **src** directory.

For Makefly to work each post not only need ONE db file and ONE source file but it also need that these files have the same name. For an example, I write a post named "My First Post". I will so have two files:

  * **db/1234567890,my_first_post.mk**
  * **src/my_first_post.md**

At blog compilation, Makefly will parse each file and publish one post.

### DB files

Meta data files permit to generate a post list page. Their named are composed as:

  * a **timestamp** that defined the date where the post should be **published**
  * a coma: **,**
  * the post's **title** in lower case, without spaces and no special chars as `?!:;,<>(){}`
  * the db file extension: **.mk**

Note that db file extension is **.mk** which permit to include it into BSD Makefile and fetch directly variables.

If you edit a meta data file, you can find something like:

    VAR = content of your var

For an example:

    TITLE = The title of my post
    TYPE = news
    TAG = one_tag, another_tag

Which informs that the post have a title "**The title of my post**", a type "**news**" and have some tags: one\_tag and another\_tag.

DB files are included in Makefile when you see some code like:

    .include "${DBFILES}"

or

    .include "${DBDIR}/${FILES}"

If you add some VAR, you have to edit Makefile and complete it.

### Source files

Source files permit to generate each post.

Source files extension is **.md** which means that they are **markdown files**. You can read more about this file format [markdown official website](http://daringfireball.net/projects/markdown/syntax/ "Markdown documentation").

## Main engine: The Makefile file

The core of Makefly: the **Makefile** file. This one generates all needed files for your future weblog.

I suggest you to use the [pmake handbook](http://www.freebsd.org/doc/en/books/pmake/ "Learn more about pmake") to be your main support.

Some things you have to know about the Makefile:

  * if you want to add some targets, add them at the end of the file
  * once you have developed your target, you can probably add it into the target called **all**
  * to add global variable, add them at file's beginning
    * variable that targets a directory are in upper case
    * variable that targets a template's file or a program are in lower case
  * if you want to add some VARS to be interpreted at template's parsing, add VARS into *parser_opts* variable
  * Add a simple comment before your target in order some developer to understand why this block exists
  * If you encount some problems and find a solution, don't forget to add problem/solution into *doc/KNOWN_ISSUES.md* file

## The makefly.rc file

This file is needed by user to configure Makefly. User have to create it for Makefly to work.

Most important variables:

  * BLOG\_TITLE
  * BLOG\_SHORT\_DESC
  * BLOG\_DESCRIPTION
  * BLOG\_LANG is a code used to search corresponding files in **lang** directory
  * BLOG\_CHARSET used for RSS feed and all HTML files
  * BASE\_URL to complete all URL
  * RSS\_FEED\_NAME
  * MAX\_POST to limit the number of post on mainpage
  * DATE\_FORMAT to transform timestamp of posts
  * SHORT\_DATE\_FORMAT same as DATE\_FORMAT
  * INDEX\_FILENAME if you want to name page as **main** instead of **index**
  * PAGE\_EXT if you want another extension. For an example **xhtml** instead of **html**.

## Template's files

Templates are located to **template** directory.

### Composition

Each theme have its own directory. So for default theme, a **default** directory is created in which you can see some files:

  * .xhtml files to describe the content of the weblog
  * a **style** directory in which you can see all CSS files for a defined theme
  * a **config.mk** in which you have some details about the theme:
    * CSS\_NAME: Name that will appear on the weblog with `${CSS_NAME}`
    * CSS\_FILE: the filename of choosen CSS for a defined theme

### Mandatory files

Here is some explanations about **.xhtml** file you can find into a theme:

  * article.index.xhtml: Template for each post that are shown on homepage
  * article.xhtml: Template for a post on its single page
  * element.xhtml: Template for a line in **Post List** page
  * footer.xhtml: End of each HTML page
  * header.xhtml: Head of each HTML page
  * menu.about.xhtml: Element that is used to show the link to the About's page
  * menu.search_bar.xhtml: Template for search bar
  * read_more_link.xhtml: Template for the link **Read more** for each post.
  * sidebar.xhtml: Template for the sidebar
  * tagelement.xhtml: Template for a line in **Tag List** page 
  * taglink.xhtml: Template for a single link to a tag's page
  * tags.xhtml: Template for the **Tag List** page

### Completion

To display content of posts or some elements in each page, you can use what we call **variables**. In Makefly's template, variable are showned as here:

    ${SOME\_VARIABLE}

Available variables:

  * ${ABOUT\_INDEX}: Name of *About*'s page. For an example: about.html 
  * ${ABOUT\_LINK}: Add a link to the about's page (if activated in default configuration's file
  * ${ABOUT\_TITLE}: Title of about's page (just title). For an example: About.
  * ${ARTICLE\_CLASS\_TYPE}: Class of article that user have filled in. For an example: news. This permit to adapt a stylesheet for each type of article.
  * ${BASE\_URL}: Your website address. For an example: htt://my.weblog.tld/. The user give it in the configuration file.
  * ${BLOG\_CHARSET}:
  * ${BLOG\_TITLE}:
  * ${BODY\_CLASS}:
  * ${CONTENT}:
  * ${CSS\_FILE}:
  * ${CSS\_NAME}:
  * ${HOME\_TITLE}:
  * ${LANG}:
  * ${POSTDIR\_INDEX}:
  * ${POSTDIR\_NAME}:
  * ${POST\_LIST\_TITLE}:
  * ${POST\_FILE}:
  * ${POST\_TITLE}:
  * ${POWERED\_BY} :
  * ${READ\_MORE}:
  * ${RSS\_FEED\_NAME}:
  * ${SEARCHBAR}:
  * ${SEARCH\_BAR\_BUTTON\_NAME}:
  * ${SEARCH\_BAR\_CONTENT}:
  * ${SHORT\_DATE}:
  * ${SIDEBAR}:
  * ${SIDEBAR\_CONTENT}:
  * ${TAGDIR\_NAME}:
  * ${TAGDIR\_INDEX}:
  * ${TAGLINK}:
  * ${TAGLIST\_CONTENT}:
  * ${TAGNAME}:
  * ${TAG\_LIST\_TITLE}:
  * ${TAG\_NAME}:
  * ${TAG\_PAGE}:
  * ${TAG\_TITLE}:
  * ${TITLE}:
  * ${THEME\_IS}:

FIXME : Note here which VAR could be used and what should be showned by using these variables

## Language files

FIXME

## Best practices

### Add functionnality

If you add a functionnality:

  * complete **Changelog** file with a brief text to explain what have been changed/improved/fixed
  * fix **doc**umentation to update Makefly's state
  * don't forget to complete language files in **lang** directory if you add some TEXT into templates!
  * if you add some needed VAR that could be changed by user, add it to the **makefly.rc.example**

## Ideas

You have any idea to improve Makefly? Add it to the **IDEAS** file.

## A bug?

Go to the [Makefly's github page](https://github.com/blankoworld/makefly/issues "Issue for Makefly on Github") and create a new issue, or add your issue into the **TODO** file.


