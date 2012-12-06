<link href="./readme.css" rel="stylesheet"></link>

# Makefly Technical Documentation

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

First thing you have to know is: Makefly is not made to be KISS/simple. It's made to do a thing and do it well. To have an interface to publish posts and to write posts, another project will born (*HYMBY* or *ANSWER* project) to make this interface. But this is another subject.

### Main engine

Makefly is a program that use a BSD Makefile to work. The BSD Makefile is a system that watch all needed files, all target files and will compile/make only what useful from needed files to target files. In fact, if you relaunch command, it will only recompile what needed.

For an example, if you change only one file, and this file is only used in ONE target file, then BSD Makefile will only compile/make the target file with the source file.

This mechanism permits to save up time and resources. To my mind, this is the power of Makefly.

Have a look to **Main engine: The Makefile file** section to understand how it works.

### Posts

In Makefly, a post is split in 2 files:

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

You can pull them with **git** command in a terminal, for an example with gitorious repository:

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

For other info, I suggest you to read comments in the *Makefile* file. If you have any question, ask me (`olivier+makeflydoc[AT]dossmann[DOT]net`).

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

### Tip: redefine some others VARS

Because of makefly.rc included into Makefile at process time, you can redefine some other variables into the **makefly.rc**:

  * TMPLDIR: template directory (in which their is all themes). By default **template**.
  * BINDIR: directory in which their is the LUA parser. By default **bin**.
  * LANGDIR: language directory. By default **lang**.
  * SRCDIR: source directory in which there is all posts ' content. By default **src**.
  * DESTDIR: destination directory in which the result would be placed. By default **pub**.
  * DBDIR: meta info directory in which there is all meta info for each post. By default **db**.
  * TMPDIR: temporary directory in which some temp files would be created/deleted. By default **tmp**.
  * DOCDIR: documentation directory. Useful for the documentation you're reading. By default **doc**.
  * TAGDIR\_NAME: name of the *result* directory in which all tag's page should be written. By default **tags**. This is useful for a better web indexation.
  * POSTDIR\_NAME: name of the *result* directory in which all posts should be written. By default **posts**. This is useful for a better web indexation.
  * STATICDIR: static directory in which user give files that would be copied into the result directory (DESTDIR). By default **static**.
  * SPECIALDIR: special directory in which you could find the **sidebar.md** file and the **about.md** file. By default **special**.
  * ABOUT\_FILENAME: name of the about's page. This is used to find the about's page in the SPECIALDIR **and** to rename the final about's page. By default **about**.
  * THEME: theme by default. Already explained in USER documentation.
  * BACKUPDIR: backup directory in which you can backup all files from Makefly. By default **mbackup**.
  * SIDEBAR\_FILENAME: name of the sidebar's page. Not only used to find the file, but also to write it into result directory. By default **sidebar**.
  * TOOLSDIR: tools directory in which some useful tools could be found. It's used for *publish* command. Do not redefine it without knowing what you're doing! By default: **tools**.
  * MAKEFLYDIR: current directory. DO NOT redefine it.
  * markdown: markdown command. By default **markdown**. But could be changed by python markdown, lua markdown, etc.
  * lua: lua command. By default **lua**.
  * parser: parser used to parse all files. Should not be redefined!
  * mv: command to move files.
  * rm: command to remove files.
  * sort: command to sort files or lists.
  * date: command to give timestamps, dates, etc.
  * tar: command to archivate files.
  * PUBLISH\_SCRIPT\_NAME: name of the publish script. Could be renamed by another one. The script should be located into the **TOOLSDIR** directory. By default: **publish.sh**.
  * BODY\_CLASS: Class used by the body html tag in all pages. Useful for theme and stylesheets. By default **single**.

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
  * ${BLOG\_CHARSET}: Blog charset as *UTF-8* or *ISO-8859-15*. This is for HTML pages **and** RSS feeds
  * ${BLOG\_TITLE}: Title of the blog. For an example *My first weblog*.
  * ${BODY\_CLASS}: Name of class defined for current body's page tag. For an example, on home page, the body class is *home*. This is useful for CascadingStyleSheets.
  * ${CONTENT}: Content of page/post. It often looks like a post content. But it could be another kind of content as a tag list, a post list, etc. This depends on the page you're editing.
  * ${CSS\_FILE}: Name of CSS file. For an example *simple.css*.
  * ${CSS\_NAME}: Name that will appears to user when it selects your CSS theme. For an example *default theme*.
  * ${HOME\_TITLE}: Title that will appears on the link that redirect to homepage. For an example *Home*.
  * ${LANG}: Country code used in HTML's page to define a language. For an example *en* for english, *fr* for *french*, etc.
  * ${POSTDIR\_INDEX}: Exact name of postdir's index page. For an example *index.html*.
  * ${POSTDIR\_NAME}: Name of posts directory. For an example *post*. That permit to have a better indexation on the Internet.
  * ${POST\_LIST\_TITLE}: Name that will appears on the link to go to Post's list. For an example *Post List*.
  * ${POST\_FILE}: Exact name of the post file. For an example with a post which title is *My first post*, the POST\_FILE would be *my_first_post*. This also permits a better web indexation.
  * ${POST\_TITLE}: Title of the post. For an example: *My fist post*.
  * ${POWERED\_BY}: Name displayed for the *Powered by* mention on all pages.
  * ${READ\_MORE}: Name displayed for the *Read more* link on each post (if activated in the configuration file)
  * ${RSS\_FEED\_NAME}: Name of your RSS feed. This will be shown for users that subscribe to your RSS. For an example *My first blog RSS feed*.
  * ${SEARCHBAR}: Will display a search bar here. This works if searchbar is activated in configuration file.
  * ${SEARCH\_BAR\_BUTTON\_NAME}: Name displayed for the search button. For an example *Search button*.
  * ${SEARCH\_BAR\_CONTENT}: Text displayed in the search bar. For an example *A search...*.
  * ${SHORT\_DATE}: Date using short date format (SHORT\_DATE\_FORMAT in makefly.rc configuration file) for post list's page. For an example *2012/11*.
  * ${SIDEBAR}: Add a sidebar here if activated in configuration file and if you give some links to the **special/sidebar.md** file.
  * ${SIDEBAR\_CONTENT}: Content of the sidebar will be displayed here.
  * ${TAGDIR\_NAME}: Name of tags directory. For an example *tags*. This permits a better web indexation.
  * ${TAGDIR\_INDEX}: Name of index file for tags. Example: *index.html*.
  * ${TAGLINK}: Absolute link to a tag. For an example: *http://my.domain.tld/tags/my_tag.html*.
  * ${TAGLIST\_CONTENT}: Content of tag list. A list of tags.
  * ${TAGNAME}: Name of a given tag. For an example *my_first_tag*.
  * ${TAG\_LIST\_TITLE}: Title of the list of tags. This is the name displayed on the link that redirect to tag's list. For an example *Tag list*.
  * ${TAG\_NAME}: Name of a tag. Same as TAGNAME (FIXME: WTF?)
  * ${TAG\_PAGE}: Real name of the page. For an example with a tag named *My tag*, it would be *my_tag.html*.
  * ${TAG\_TITLE}: Title of the tag. For an example *my_tag*.
  * ${TITLE}: Title of the current page. For an example *Homepage*, *Tag List*, *My first post*, etc.
  * ${THEME\_IS}: Sentence that is used to explain which theme have been choosed. For an example *The theme of this page is: *.

These variables are given by the **Makefile** file in some sections. So you probably have to update the Makefile in order to add some other ones.

## Language files

In Makefly you can adapt some content to your native language. For this you have to fill in some files in the **lang** directory.

### Existing files

Available files:

  * translate.en
  * translate.fr

You can see that 2 files exists, one for **en**glish translation, another one for **fr**ench translation.

If you want to add your, create another file named translate.**YOUR\_COUNTRY\_CODE**. For an example, for italian translation, create a file named **translate.it**.

You can also use the **translate.en** as first support to known how many word you have to translate.

### Language File Format

The language file format is similar to DB files format:

    A_VARIABLE = the translation about this variable

For an example:

    HOME_TITLE = Home

### Existing words to translate

At the time I write this documentation, here is the available words to translate (and their variable):

  * HOME\_TITLE (Home)
  * POST\_LIST\_TITLE (Post list)
  * TAG\_LIST\_TITLE (Tag list)
  * TAG\_TITLE (Tag(s))
  * PERMALINK\_TITLE (permalink)
  * POWERED\_BY (Powered by)
  * POSTED (Posted)
  * ABOUT\_TITLE (About)
  * SOURCE\_LINK\_NAME (Sources on)
  * SOURCE\_LINK\_TITLE (Go to the gitorious makefly homepage)
  * THEME\_IS (Theme is:)
  * LINKS\_TITLE (Links)
  * READ\_MORE (Read more)
  * SEARCH\_BAR\_CONTENT (Search)
  * SEARCH\_BAR\_BUTTON\_NAME (Search)

By using templates, you can easily add some texts and their translations in some themes.

## Tools

Makefly is delivered with some tools to be more usable. These tools are placed in **tools** directory.

### create_post.sh

Script that permit to help you to create new posts. Kind of lightweight console user interface.

This is useful if no interface exists to create posts in Makefly, which, I remember you, is not the goal of Makefly. This one just compile some files to create a blog. To create these files, you need a user interface.

### install.sh

Script that permit to copy **pub** directory content to those of your choice. By default the **public_html** directory located in you home directory.

This *install* method is not integrated in Makefly because it's could be dangerous to overwrite existing files. But you can have same effect with the *publish* method by using `pmake publish` and using **publish.sh**.

### populate_makefly.sh

Dev script that permits to populate Makefly by creating some posts. It uses **create_post.sh** script to work.

### publish.sh

This script give command to execute after having produced your blog. This permits to publish it on a remote server via SSH protocol or to synchronize your directory to another one. This is explained in USER documentation, so for more information please read **Publish result to the web** in the USER documentation.

## Best practices

### Add functionnality

If you add a functionnality:

  * complete **Changelog** file with a brief text to explain what have been changed/improved/fixed
  * fix **doc**umentation to update Makefly's state
  * don't forget to complete language files in **lang** directory if you add some TEXT into templates!
  * if you add some needed VAR that could be changed by user, add it to the **makefly.rc.example**

### Customizing template

If you add a text in a template, you have to add some variables for words to be translated. You also have to add theses variables into translation lang directory. Also complete this documentation.

### Errors

#### You have encounted a problem and resolved it?

Add your error message and its solution into **doc/KNOWN\_ISSUES.md** file!

#### You have encounted a problem and didn't have resolved it?

Go to [Makefly's github page](https://github.com/blankoworld/makefly/issues "Go to Issue's page for Makefly's project on github") and add a new issue with a detailed error:

  * where you encount the problem
  * your configuration file
  * how to reproduce the bug
  * which error message you encount

## Ideas

You have any idea to improve Makefly? Add it to the **IDEAS** file.

## A bug?

Go to the [Makefly's github page](https://github.com/blankoworld/makefly/issues "Issue for Makefly on Github") and create a new issue, or add your issue into the **TODO** file.

