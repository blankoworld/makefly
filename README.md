# Makefly

## About

Makefly is a static weblog engine that used a BSD Makefile to work.

### Website

Stay tuned to [Makefly weblog](http://makefly.e-mergence.org/ "Visit Makefly official website").

### Contact

You can contact me [to this address](mailto:olivier+makefly@dossmann.net "Contact me").

### License

This software is published under GNU Affero General Public License 3.0.

### Stats

Some stats about projet could be found [on Ohloh.net](http://www.ohloh.net/p/makefly "See ohloh's analysis for Makefly project").

## Description

Makefly is a subproject of [BlogBox](http://blogbox.e-mergence.org/ "Read more about BlogBox project") that aims to give user a better way to host a blog at home.

## Dependencies

Some programs on which makefly depends: 

  * pmake or bmake
  * markdown command
  * lua 5.1 and earlier

So use your distribution package manager. For an example on Debian and derivated, it would be:

    apt-get install pmake markdown lua5.1

For other distribution, please have a look on your distribution's forum/IRC/community. They will enjoy helping you.

## Installation

There is 2 ways to install Makefly on your computer:

  * Using last stable version by fetching a tarball (recommanded)
  * Using current developement version by using a repository (for advanced user only)

### Using last stable version

Just download last version on official website: [http://makefly.e-mergence.org/](http://makefly.e-mergence.org/ "Go to official makefly website").

For an example [0.1 version](http://makefly.e-mergence.org/makefly_0.1.zip "Download Makefly 0.1").

Then extract tarball's content into a directory.

### Using current developement version

You have to use **git** command. If you don't know what it is, have a look to [Git SCM website](http://git-scm.com/ "Learn more about Git").

After git installation, go to a working directory and do this:

    git clone git://gitorious.org/makefly/master.git makefly_dev

This will fetch makefly repository and add files into **makefly_dev** directory.

**Note**: Using git is useful to easily update makefly. In fact:

    git pull git://gitorious.org/makefly/master.git

will update your makefly.

**WARNING**: You have to always backup your files! This method could delete some changes you made previously.

## Configuration

The first time you use Makefly you don't have any configuration file. An example is available in *makefly.rc.example*. Copy it to **makefly.rc** to permit Makefly to work.

For more information please read **The makefly.rc configuration file** section.

## Create content

A bash shell script is available: **create_post.sh**. To use it:

    bash create_post.sh

Give script all information it needs. It will generate some files needed by Makefly.

Note that Makefly use the [markdown format](http://daringfireball.net/projects/markdown/ "Learn more about Markdown format") for its posts.

### Static files

If you want to add some static files, just add them to the *static* directory. They will be copied in destination directory.

## Use it!

After having created *makefly.rc* (from makefly.rc.example) and having created some posts, just do this:

    pmake

It will generate a Makefly weblog to the **pub** directory.

Note: *pmake* is for Debian like distribution. For other distributions, I suggest you to use **bmake**.

## The makefly.rc configuration file

Here is some options you can change:

  * BLOG_TITLE: Title of your weblog
  * BLOG_SHORT_DESC: A short description of your weblog
  * BLOG_DESCRIPTION: A long description of your weblog
  * BLOG_LANG: your language. Note that file lang/translate.YOUR_LANGUAGE should exists. For an example if I set this parameter to *en*, a *lang/translate.en* file should exists!
  * BLOG_CHARSET: your encoding configuration. Should be something like **UTF-8** or **ISO-8859-1**
  * BASE_URL: absolute URL of your blog
  * RSS_FEED_NAME: Title for the RSS Feed
  * MAX_POST: Max post that would be showed on home page
  * DATE_FORMAT: Date format. Please see man date's page for more information.
  * SHORT_DATE_FORMAT: Short date format that would be used on the post list page. Please see man date's page for more information.
  * INDEX_FILENAME: Name given to all index'pages. For an example with **INDEX_FILENAME = mainpage**, post list page will be named *mainpage.html*.
  * PAGE_EXT: suffix that all page will have. **DO NOT FORGET TO ADD A POINT BEFORE SUFFIX**. For an example, with **PAGE_EXT = .html**, all pages will be index.html.
  * ABOUT_FILENAME: As described, this is the about's filename. If you set it to "about" for an example, you have to create a "about.md" file into **special** directory in order to have an about's page. If you change it to "toto", so you have to create a *toto.md* file into **special** directory.
  * POSTDIR_NAME: The name you want to be displayed in URL when a user go to post list. For an example, if you set it to "myposts": http://makefly.e-mergence.org/myposts/ will display all you posts. This is useful for others languages.
  * TAGDIR_NAME: Same behaviour as POSTDIR_NAME, but for tags. Change it to "mytags" for an example, and you will have URLs like this: http://makefly.e-mergence.org/mytags/ to display tag list.

## Publish result to the web

The result is compatible with all HTML servers. In fact you could probably use result with your website provider. You just have to upload all files from **pub** directory to your provider's web directory.

If you launch Makefly on you own server or probably on provider ' server, you should so use **install.sh** which is a bash shell script. Just launch it:

    bash install.sh

...and it will copy all files to **~/public_html** directory.

**WARNING**: This will erase all files from *public_html* directory!

**Note**: You can customize the script to copy files in another directory. To do that, just edit *install.sh** script and change this variable:

    DESTDIR=${HOME}/public_html

to

    DESTDIR=/my/personal/website

Relaunch *install.sh* script to see result.

## Translation

A simple way to translate Makefly to your language is to copy the **lang/translate.en** file to another translation file. For an example, for french (with fr code), you can copy **lang/translate.en** to **lang/translate.fr** and change values. Then just change *BLOG_LANG* option in **makefly.rc** file.

## Sources

Source are available: 

  * [On github](https://github.com/blankoworld/makefly)
  * [On personal git](http://git.dossmann.net/blogbox/makefly.git/)

## Documentation

This file is the documentation. You can [read it on github](https://github.com/blankoworld/makefly "Read documentation on Github") or simply generate an HTML file with this command:

    pmake doc

Note: pmake command is for Debian like. For other distribution, use **bmake** instead of pmake.
