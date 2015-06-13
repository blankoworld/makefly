# ${PROJECTNAME}

[Version française](${PROJECTURL}documentation.html.fr) (French original version)

[Official website](${PROJECTURL} "Go to the website")

## Description

${PROJECTNAME} is a fast and lightweight command line static weblog engine which uses the [Markdown format](http://daringfireball.net/projects/markdown/syntax "Discover the Markdown format") for post writting and rendering.

It consists in a homepage, a post list, a tag list and an about's page.

It gives these functionnalities:

  * themes
  * RSS feed
  * keywords on each page (for web ranking)
  * tags
  * static webpages
  * predate posts
  * translations
  * comment system
  * backup
  * publishing scripts to remote servers
  * quick theme creation
  * Nanoblogger posts migration (Cf. **Migrate from Nanoblogger** section)

**Note** : ${PROJECTNAME} was not designed to create, edit and delete posts. Even if it offers a script that make new post we suggest you to turn to other projects like [Hymby](https://github.com/blankoworld/hymby) (in development).

# Installation

## Briefly

In some short steps, here is how to install the last version (current development):

    sudo apt-get install lua5.1 lua-filesystem
    curl ${GITPROJECT}archive/master.zip
    unzip master.zip
    cd makefly-master
    cp ${PROJECTNAMELOWER}.rc.example ${PROJECTNAMELOWER}.rc
    ./${PROJECTNAMELOWER} clean && ./${PROJECTNAMELOWER} compile

You should have an action list done on your computer. And result is available in **pub directory**.

## Detailed

If you achieve the **Briefly** step, go to **Use it!** section.

### Dependencies

Some programs on which ${PROJECTNAME} depends: 

  * lua 5.1 and earlier
  * lua-filesystem

So use your distribution package manager to install them. For an example on Debian and derivated, it would be:

    apt-get install lua5.1 lua-filesystem

For other distribution, please have a look on your distribution's forum/IRC/community. They will enjoy helping you.

### Others methods to install dependancies

If your distribution doesn't have *lua-filesystem*, you can attempt to install **luarocks** then install dependancies as:

    sudo apt-get install luarocks
    luarocks install lua-filesystem

That's all!

### Installation

There is 2 ways to install ${PROJECTNAME} on your computer:

  * [current development version](${GITPROJECT}archive/master.zip "Download current development version")
  * [0.3 stable version (recommanded)](${PROJECTURL}${PROJECTNAMELOWER}_0.3.zip "Download 0.3 stable version")

So you just have to:

  * fetch the choosen version
  * extract the content in a directory on your computer

And ${PROJECTNAME} is installed.

### Configuration

#### Stable version

No special configuration required. Check that **${PROJECTNAMELOWER}.rc** file is present. Otherwise copy **${PROJECTNAMELOWER}.rc.example** file or rename it to **${PROJECTNAMELOWER}.rc**.

#### Trunk version

The first time you use ${PROJECTNAME} you don't have any configuration file. An example is available in *${PROJECTNAMELOWER}.rc.example*. Copy it to **${PROJECTNAMELOWER}.rc** to permit ${PROJECTNAME} to work.

#### More info

For more information please read **The ${PROJECTNAMELOWER}.rc configuration file** section.

# Use it!

**By default the content of the blog is located in the pub directory**.

## In brief

Some useful commands:

  * **./${PROJECTNAMELOWER} compile**: Produce the blog. Available in the **pub** directory
  * **./${PROJECTNAMELOWER} help**: Display available commands
  * **./${PROJECTNAMELOWER} add**: Create a post and add its main metadata
  * **./${PROJECTNAMELOWER} clean**: Trash the entire final directory content and empty the ${PROJECTNAME}'s *cache*.

## Create content

### Create a new post

Use this command:

    ./${PROJECTNAMELOWER} add

and answer to all given questions. It will generate some files needed by ${PROJECTNAME}.

Note that ${PROJECTNAME} use the [markdown format](http://daringfireball.net/projects/markdown/ "Learn more about Markdown format") for its posts.

**Don't forget to edit the file that the './${PROJECTNAMELOWER} add' command return.**

### Static content (pictures, videos, PDF files, etc.)

Sometimes you want to share some files as photos, demonstration, shows, etc. *static* directory exists for this kind of use. Each file that is in this directory will be copied in the result directory.

Example:

  * We created *static/makefly.svg* file
  * After blog's compilation: *pub/makefly.svg* file exists

It works for each kind of file in this *static* directory.

### Static pages

Sometimes you'd prefer to add **static** pages,  for an example legal notices.

For this, create **pages** directory in the ${PROJECTNAME}'s root. Then add some files that contains Markdown content with **.md** file extension.

Example:

  * We created *pages/notices.md* file
  * After blog's compilation: *pub/mentions.html* file exists

This allow you to create a full website only with static pages.

### The 'special' directory

This one is named **special** because it can contain some file you have to create in order to activate a functionality:

  * *about.md* : Is the content of an about's page about your website. It will add an item in the website main menu (If your theme support it.)
  * *sidebar.md* : Add a sidebar on your website. The theme have to support this function.
  * *introduction.md* : Display this file's content as an introduction on all your website's pages. This could change regarding the choosen theme.
  * *footer.md* : Display this file's content as a footer on all your website's pages. This could change regarding the choosen theme.

## Produce the blog

After having created *${PROJECTNAMELOWER}.rc* (from ${PROJECTNAMELOWER}.rc.example) and having created some posts, just do this:

    ./${PROJECTNAMELOWER} compile

It will generate a ${PROJECTNAME} weblog to the **pub** directory (default directory).

# Publish result to the web

The result is compatible with all HTML servers. In fact you could probably use result with your website provider. You just have to upload all files from **pub** directory to your provider's web directory.

## From a webserver

If you launch ${PROJECTNAME} on you own server or probably on provider ' server, you should be capable to use **install** script automation. Just launch it as:

    ./${PROJECTNAMELOWER} install

...and it will copy all files to **~/public\_html** directory.

**WARNING**: This will erase all files from *public\_html* directory!

**Note**: You can customize the destination by changing **${PROJECTNAMELOWER}.rc** file espacially the given line : 

    INSTALLDIR=${HOME}/public_html

Then relaunch `./${PROJECTNAMELOWER} refresh && ./${PROJECTNAMELOWER} install` to recompile and reinstall the weblog.

## To a remote computer: *publish* command

To publish your blog to a remote computer you have to:

  * have an SSH access to the remote machine
  * have rsync program
  * configure **PUBLISH\_DESTINATION** in **${PROJECTNAMELOWER}.rc** file
  * launch **publish** command

That's all!

Note that **PUBLISH\_DESTINATION** looks like:

    myRemoteUser@remoteDomain.tld:/myhomedirectory/public_dir

Once having complete this variable in **${PROJECTNAMELOWER}.rc** file, just launch:

    ./${PROJECTNAMELOWER} publish

For developers: You can also edit **tools/publish.sh** file and change script content to you own code.

# Create a new theme

To make easier the theme creation you can use this command:

    ./${PROJECTNAMELOWER} theme myTheme

where **myTheme** is to replace by your own theme name.

Note: This exploit a theme called *Base* as example.

# Translation

A simple way to translate ${PROJECTNAME} to your language is to copy the **lang/translate.en** file to another translation file. For an example, for french (with fr code), you can copy **lang/translate.en** to **lang/translate.fr** and change values. Then just change *BLOG\_LANG* option in **${PROJECTNAMELOWER}.rc** file.

# Backup

Perhaps would you backup some important files in ${PROJECTNAME}? It's possible via **backup command**. Just launch it like this:

    ./${PROJECTNAMELOWER} backup

Requirements:

  * tar
  * gzip

Files saved:

  * ${PROJECTNAMELOWER}.rc
  * static directory
  * special directory
  * db directory
  * src directory
  * the directory that contains the choosen theme (for an example *templates/default/*)

Result: This will create a *tarball* named *YYYYmmdd-HM\_${PROJECTNAMELOWER}.tar.gz* in **mbackup** directory (for an example 20120823-1732\_${PROJECTNAMELOWER}.tar.gz). You can so backup your ${PROJECTNAME} each day for an example.

## Tip

You can customize (in your **${PROJECTNAMELOWER}.rc** file):

  * the backup directory by using **BACKUPDIR** option
  * the prefix of the name by using **BACKUP\_PREFIX** option
  * the suffix of the name by using **BACKUP\_SUFFIX** option
  * the date format using **BACKUP\_FORMAT** option

# Sources

Sources are available: 

  * [On gitorious](http://gitorious.org/makefly/master.git/)
  * [On github](${GITPROJECT})

# Documentation

This file is the documentation. You can [read it on github](${GITPROJECT} "Read documentation on Github") or simply generate an HTML file with this command:

    ./${PROJECTNAMELOWER} doc

# Tips

## Write post ahead of current's datetime

In ${PROJECTNAME} you can publish early posts. To do that metadata file should have a timestamp superior to current's one when you generate the weblog. 

For an example we are 2013, the 6th march. 12:30:00. The timestamp is : 1362569400. Your post (situated in the **db** directory) have to have a timestamp inferior to current's one (1362569400).

## Write directly the post's content during its creation

Just use the 'content' variable at the beginning of the command:

    content="my little content" ./${PROJECTNAMELOWER} add

This will add "my little content" into your new post.

## Do not lost comments when migrating from an old domain to a new one

When you migrate from **old.domain.tld** to **new.domain.tld**, comments will not appear.

To avoid this problem, just use **migratefrom command** as:

    ./${PROJECTNAMELOWER} migratefrom http://old.domain.tld

This will update all your old posts with the old comments' identifier (your old domain) and comments will afressh appear.

# The ${PROJECTNAMELOWER}.rc configuration file

Here is some options you can change:

  * BLOG\_TITLE: Title of your weblog
  * BLOG\_SHORT\_DESC: A short description of your weblog
  * BLOG\_DESCRIPTION: A long description of your weblog
  * BLOG\_LANG: your language code. Note that file lang/translate.YOUR\_LANGUAGE\_CODE should exists. For an example if I set this parameter to *en*, a *lang/translate.en* file should exists!
  * BLOG\_CHARSET: your encoding configuration. Should be something like **UTF-8** or **ISO-8859-1**. If you don't know what's this option, just let it to *UTF-8*.
  * BLOG\_URL: absolute URL of your blog. For an example ${PROJECTURL}.
  * BLOG\_AUTHOR: Main blog writer. Allow a better indexation in websearch engine.
  * BLOG\_COPYRIGHT: Blog copyright. Allow a better indexation in websearch engine.
  * BLOG\_KEYWORDS: Keywords that will appears on all webblog pages. Allow a better indexation in websearch engine.
  * RSS\_FEED\_NAME: Title for the RSS Feed
  * MAX\_POST: Max post that would be showed on home page
  * MAX\_POST\_LINES: Number of lines that should be shown on Homepage. If set to 0 or not referenced in *${PROJECTNAMELOWER}.rc* file, then posts are fully shown.
  * MAX\_PAGE: Maximum number of post that should be displayed on Post's list. If set to 0 or not used in *${PROJECTNAMELOWER}.rc* file, then only one page is done with all posts!
  * DATE\_FORMAT: Date format displayed for each post. Please see man date's page for more information.
  * SHORT\_DATE\_FORMAT: Short date format that would be used on the post list page. Please see man date's page for more information.
  * INDEX\_FILENAME: Name given to all index'pages. For an example with **INDEX\_FILENAME = mainpage**, post list page will be named *mainpage.html*.
  * PAGE\_EXT: suffix that all page will have. **DO NOT FORGET TO ADD A POINT BEFORE SUFFIX**. For an example, with **PAGE\_EXT = .html**, all pages will be under the form: index.html.
  * ABOUT\_FILENAME: As described, this is the about's filename. If you set it to "about" for an example, you have to create a "about.md" file into **special** directory in order to have an about's page. If you change it to "toto", so you have to create a *toto.md* file into **special** directory.
  * POSTDIR\_NAME: The name you want to be displayed in URL when a user go to post list. For an example, if you set it to "myposts": ${PROJECTURL}myposts/ will display all you posts. This is useful for others languages.
  * TAGDIR\_NAME: Same behaviour as POSTDIR\_NAME, but for tags. Change it to "mytags" for an example, and you will have URLs like this: ${PROJECTURL}mytags/ to display tag list.
  * THEME: Name of the theme you want to be used. All themes are available in **template** directory. Each theme have its own directory. For an example, "default" theme have its **template/default** directory.
  * FLAVOR: This name will be used to select a color from your theme (if exists)
  * BACKUPDIR: Name of directory where *backup* command will save all files.
  * BACKUP\_FORMAT: Date format that would be used for the backup file.
  * BACKUP\_PREFIX: prefix used for the backup file between the date and the filename.
  * BACKUP\_SUFFIX: suffix used for the backup file between the filename and the extension.
  * SIDEBAR\_FILENAME: As described, name of sidebar file that would be used to create a sidebar. If you set it to "sidebar" for an example, you have to create a "sidebar.md" file into **special** directory in order to have this sidebar. Note that your theme should support sidebars!
  * SIDEBAR: If set to 1, so activate a sidebar on ${PROJECTNAME}. Note that your theme should support sidebars!
  * PUBLISH\_DESTINATION: Full address from where to send files in order to publish them.
  * PUBLISH\_SCRIPT\_NAME: script filename used to send files from **pub** directory to a destination filled in *PUBLISH\_DESTINATION* variable.
  * SEARCH\_BAR: If set to 1, activate a search bar on ${PROJECTNAME}. Note that your theme should support search bar!
  * MAX\_RSS: Max RSS posts that would be fetch from your users.
  * ISSO : If set to 1, this activate a comment system on ${PROJECTNAME}. Note that your theme should support comment system. Warning: default server is isso.appspot.com which doesn't guarantee a long backup of your comments. More info are available [on isso project installation page](http://posativ.org/isso/docs/install/ "Go to isso webpage for more information") (fr).
  * ISSO\_URL (optional): Define a ISSO server on which send comments. By default **http://posativ.org/isso/**.
  * ISSO\_MAX (optional): Define a limit for displayed comments for ISSO comment system. By default **2**.
  * ELI\_USER: If set, this activate a badge for identica. Note that your theme should support ELI widget. By default this functionality use IDENTICA's API.
  * ELI\_TYPE (optional): Change this to "group" to follow a group instead of a user on IDENTICA. By default "user".
  * ELI\_MAX (optional): Permit to choose how many statuses to display. On identica, this couldn't bypass the default 20 items. Default value: 5.
  * ELI\_API (optional) : Access to your StatusNet API system.
  * INSTALLDIR : Permit to choose a target directory when using **./${PROJECTNAMELOWER} install** command (Read more in *Publish result to the web* chapter)
  * SORT (optional) : Sort posts' list. Use ASC for posts to be from the oldiest to the latest. DESC (default value) sort posts from the latest to the oldiest.
  * AUTO\_EDIT (optionnel) : Allow to edit automatically posts after their creation. Use the EDITOR variable content to know which editor to use.

# Migrate from Nanoblogger

A script that permits to migrate from Nanoblogger exists: [nb2makefly](http://github.com/blankoworld/nb2makefly "Discover nb2makefly").

I guest you to read the [nb2makefly documentation](https://github.com/blankoworld/nb2makefly/blob/master/README.en.md "Read the nb2makefly documentation") to know more about it.

# The project

## Description

${PROJECTNAME} is a subproject of [BlogBox](http://blogbox.depotoi.re/ "Read more about BlogBox project") that aims to give user a better way to host a blog at home.

## Website

Stay tuned to [${PROJECTNAME} weblog](${PROJECTURL}blog/ "Visit ${PROJECTNAME} official website") to know more about the project.

## Red alert, bug detected!

You find a bug? Or something goes wrong? Let's go [opening a ticket on Github](${GITPROJECT}issues). It's simple:

  * Go to [this link](${GITPROJECT}issues)
  * If you're not registered, use **Sign up** link. Then reclick on the previous link and continue to do steps
  * Click on **New Issue**
  * Give a title that could be a short description of your problem
  * Then under title, explain in details:
    * What you do
    * What you have after that
    * What you expect
    * \[optional\] give the copy/paste of what you see on your computer or [give some screenshots](https://lut.im/)
  * Validate by using **Submit new issue**

This take few minutes and permit to improve ${PROJECTNAME}. Thanks -in advance - a lot for your help!

## Development

${PROJECTNAME} is developed in Lua, CSS and HTML.

The code of the software is available in the given repositories:

  * [Gitorious](https://gitorious.org/makefly/ "Go to ${PROJECTNAME}'s project page on Gitorious")
  * [Github](${GITPROJECT} "Go to ${PROJECTNAME}'s project page on Github")

### Tip to fork the project

The project can be duplicated and renamed easily. For that just use the given variable in ${PROJECTNAMELOWER} file:

  * PROJECTNAME
  * PROJECTNAMEURL
  * GITPROJECT

Then rename the ${PROJECTNAMELOWER} file to the name given in PROJECTNAME variable, in lower case.

I suggest you to rename the ${PROJECTNAMELOWER}.svg file to those given in PROJECTNAME..

Good fork and good luck!

## Docker file

A Docker file is available to test ${PROJECTNAME}: https://registry.hub.docker.com/u/bl4n/docker-makefly/

## Contact

You can contact me [to this address](mailto:olivier+makefly@dossmann.net "Contact me").

## License

This software is published under GNU Affero General Public License 3.0.

## Stats

Some stats about project could be found [on Ohloh.net](http://www.ohloh.net/p/makefly "See ohloh's analysis for ${PROJECTNAME} project").
