<link href="./readme.css" rel="stylesheet"></link>

# Makefly

Une version fran&ccedil;aise de cette documentation est disponible dans le fichier **README.fr.md**.

## About

Makefly is a static weblog engine that used a BSD Makefile to work.

### Website

Stay tuned to [Makefly weblog](http://makefly.e-mergence.org/ "Visit Makefly official website").

### Contact

You can contact me [to this address](mailto:olivier+makefly@dossmann.net "Contact me").

### License

This software is published under GNU Affero General Public License 3.0.

### Stats

Some stats about project could be found [on Ohloh.net](http://www.ohloh.net/p/makefly "See ohloh's analysis for Makefly project").

## Description

Makefly is a subproject of [BlogBox](http://blogbox.e-mergence.org/ "Read more about BlogBox project") that aims to give user a better way to host a blog at home.

## Dependencies

Some programs on which makefly depends: 

  * pmake or bmake
  * markdown command
  * lua 5.1 and earlier

So use your distribution package manager to install them. For an example on Debian and derivated, it would be:

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

This will fetch makefly repository and add files into **makefly\_dev** directory.

**Note**: Using git is useful to easily update makefly. In fact:

    git pull git://gitorious.org/makefly/master.git

will update your makefly.

**WARNING**: You have to always backup your files! This method could delete some changes you made previously.

## Configuration

The first time you use Makefly you don't have any configuration file. An example is available in *makefly.rc.example*. Copy it to **makefly.rc** to permit Makefly to work.

For more information please read **The makefly.rc configuration file** section.

## Create content

A bash shell script is available in **tools** directory: **create\_post.sh**. To use it:

    cd tools
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

  * BLOG\_TITLE: Title of your weblog
  * BLOG\_SHORT\_DESC: A short description of your weblog
  * BLOG\_DESCRIPTION: A long description of your weblog
  * BLOG\_LANG: your language code. Note that file lang/translate.YOUR\_LANGUAGE\_CODE should exists. For an example if I set this parameter to *en*, a *lang/translate.en* file should exists!
  * BLOG\_CHARSET: your encoding configuration. Should be something like **UTF-8** or **ISO-8859-1**. If you don't know what's this option, just let it to *UTF-8*.
  * BASE\_URL: absolute URL of your blog. For an example http://makefly.e-mergence.org/.
  * RSS\_FEED\_NAME: Title for the RSS Feed
  * MAX\_POST: Max post that would be showed on home page
  * MAX\_POST\_LINES: Number of lines that should be shown on Homepage. If set to 0 or not referenced in *makefly.rc* file, then posts are fully shown.
  * DATE\_FORMAT: Date format displayed for each post. Please see man date's page for more information.
  * SHORT\_DATE\_FORMAT: Short date format that would be used on the post list page. Please see man date's page for more information.
  * INDEX\_FILENAME: Name given to all index'pages. For an example with **INDEX\_FILENAME = mainpage**, post list page will be named *mainpage.html*.
  * PAGE\_EXT: suffix that all page will have. **DO NOT FORGET TO ADD A POINT BEFORE SUFFIX**. For an example, with **PAGE\_EXT = .html**, all pages will be under the form: index.html.
  * ABOUT\_FILENAME: As described, this is the about's filename. If you set it to "about" for an example, you have to create a "about.md" file into **special** directory in order to have an about's page. If you change it to "toto", so you have to create a *toto.md* file into **special** directory.
  * POSTDIR\_NAME: The name you want to be displayed in URL when a user go to post list. For an example, if you set it to "myposts": http://makefly.e-mergence.org/myposts/ will display all you posts. This is useful for others languages.
  * TAGDIR\_NAME: Same behaviour as POSTDIR\_NAME, but for tags. Change it to "mytags" for an example, and you will have URLs like this: http://makefly.e-mergence.org/mytags/ to display tag list.
  * THEME: Name of the theme you want to be used. All themes are available in **template** directory. Each theme have its own directory. For an example, "default" theme have its **template/default** directory.
  * BACKUPDIR: Name of directory where *backup* command will save all files.
  * SIDEBAR\_FILENAME: As described, name of sidebar file that would be used to create a sidebar. If you set it to "sidebar" for an example, you have to create a "sidebar.md" file into **special** directory in order to have this sidebar. Note that your theme should support sidebars!
  * SIDEBAR: If set to 1, so activate a sidebar on Makefly. Note that your theme should support sidebars!
  * PUBLISH\_DESTINATION: Full address from where to send files in order to publish them.
  * PUBLISH\_SCRIPT\_NAME: script filename used to send files from **pub** directory to a destination filled in *PUBLISH\_DESTINATION* variable.
  * SEARCH\_BAR: If set to 1, activate a search bar on Makefly. Note that your theme should support search bar!
  * MAX\_RSS: Max RSS posts that would be fetch from your users.
  * JSKOMMENT : If set to 1, this activate a comment system on Makefly. Note that your theme should support comment system. Warning: default server is jskomment.appspot.com which doesn't guarantee a long backup of your comments. More info are available [on jskomment project installation page](http://code.google.com/p/jskomment/wiki/Installation "Go to jskomment webpage for more information") (fr).
  * JSKOMMENT\_CAPTCHA\_THEME (optional): Define a theme regarding [reCaptcha page](https://developers.google.com/recaptcha/docs/customization "More info about reCaptcha themes") for Catpcha in JSKOMMENT comment system
  * JSKOMMENT\_URL (optional): Define a JSKOMMENT server on which send comments. By default **http://jskomment.appspot.com/**.
  * JSKOMMENT\_MAX (optional): Define a limit for displayed comments for JSKOMMENT comment system. By default **2**.
  * ELI\_USER: If set, this activate a badge for identica. Note that your theme should support ELI widget. By default this functionality use IDENTICA's API.
  * ELI\_TYPE (optional): Change this to "group" to follow a group instead of a user on IDENTICA. By default "user".
  * ELI\_MAX (optional): Permit to choose how many statuses to display. On identica, this couldn't bypass the default 20 items. Default value: 5.

## Publish result to the web

The result is compatible with all HTML servers. In fact you could probably use result with your website provider. You just have to upload all files from **pub** directory to your provider's web directory.

### From a webserver

If you launch Makefly on you own server or probably on provider ' server, you should so use **install.sh** which is a bash shell script. Just launch it:

    cd tools
    bash tinstall.sh

...and it will copy all files to **~/public\_html** directory.

**WARNING**: This will erase all files from *public\_html* directory!

**Note**: You can customize the script to copy files in another directory. To do that, just edit **install.sh** script and change this variable:

    DESTDIR=${HOME}/public_html

to:

    DESTDIR=/my/personal/website

Relaunch *install.sh* script to see result.

### To a remote computer: *publish* command

To publish your blog to a remote computer you have to:

  * have an SSH access to the remote machine
  * have rsync program
  * configure **PUBLISH\_DESTINATION** in **makefly.rc** file
  * launch **publish** command

That's all!

Note that **PUBLISH\_DESTINATION** looks like:

    myRemoteUser@remoteDomain.tld:/myhomedirectory/public_dir

Once having complete this variable in **makefly.rc** file, just launch:

    pmake publish

For developers: You can also edit **tools/publish.sh** file and change script content to you own code.

## Translation

A simple way to translate Makefly to your language is to copy the **lang/translate.en** file to another translation file. For an example, for french (with fr code), you can copy **lang/translate.en** to **lang/translate.fr** and change values. Then just change *BLOG\_LANG* option in **makefly.rc** file.

## Backup

Perhaps would you backup some important files in Makefly? It's possible via **backup command**. Just launch it like this:

    pmake backup

Requirements:

  * tar
  * gzip

Files saved:

  * makefly.rc
  * static directory
  * special directory
  * db directory
  * src directory

Result: This will create a *tarball* named *YYYYMMDD\_makefly.tar.gz* in **mbackup** directory (for an example 20120823\_makefly.tar.gz). You can so backup your Makefly each day for an example.

Tip: You can customize backup directory by using **BACKUPDIR** option in your **makfley.rc** file.

## Sources

Sources are available: 

  * [On gitorious](http://gitorious.org/makefly/master.git/)
  * [On github](https://github.com/blankoworld/makefly)
  * [On my own git repository](http://git.dossmann.net/blogbox/makefly.git/)

## Documentation

This file is the documentation. You can [read it on github](https://github.com/blankoworld/makefly "Read documentation on Github") or simply generate an HTML file with this command:

    pmake doc

Note: pmake command is for Debian like. For other distribution, use **bmake** instead of pmake.
