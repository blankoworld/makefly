# Themes for ${PROJECTNAME}

[Version française](${PROJECTURL}themes.html.fr) (French original version)

[Official website](${PROJECTURL} "Go to the website")

## Requirements

Making a theme is not difficult. But you need some skills as:

  * making HTML
  * making CSS
  * [optional] making JS

All these skills can be learned on [openclassrooms](http://openclassrooms.com/ "Go to the official openclassrooms website").

Remember that this is not difficult, you just need a little bit time to make it.

----

## Design a new theme

Create a new theme is easy as explained in the officiel documentation. Just do this:

    ./${PROJECTNAMELOWER} theme myTheme

where **myTheme** is the name of your theme.

This will copy the default **base** theme.

The command show you where is the new theme. It remains commonly in the **template** directory (except if you change the template's directory location).

So you just have to customize the theme. Pay attention to values that are replacement ones. You can find a non-exhaustive list in **Replacement values** section of this documentation.

----

## Adapt an existing template (Example)

For lazy people, you can choose a template on the Web and adapt it to ${PROJECTNAME} so that it makes less work to create a new template.

I suggest you either to see a video showing how to adapt Monochromed template to ${PROJECTNAME} or to read explanation about it.

### Learn with a video

As a video is more verbose than a lot of explanation I make [a video that show you how to search/download/adapt an existing template to ${PROJECTNAME}](${PROJECTURL}monochromed.mkv "How to adapt a template to ${PROJECTNAME}") (30 MB and 30 minutes approximatively).

NB: This video can be seen with [VLC media player](https://www.videolan.org/vlc/ "Download VLC").

### Learn with explanations (you can compare with the video)

Sometimes, you're a lazy person. And I too. So you prefer taking other people's templates! I so use [a website template](http://templated.co/ "Choose a template on templated.co website").

#### Template download

Let's have a look to this template: [http://templated.co/monochromed](http://templated.co/monochromed "Discover the template called 'monochromed'"). We will use it for our tutorial.

Download the template, extract it in **template/monochromed** (in ${PROJECTNAMELOWER} directory).

#### To do

Then we have 2 tasks so that the template works on ${PROJECTNAME}:

  1. Insert some keys (specific words) that insert our blog content into
  2. Create the template's structure

A list of keys is available in **Replacement values** section of the current document. This is for the **first task**.

The **second one** is explained in **Template ' structure** section.

But have a look to the following steps to understand a template migration procedure.

**Note:** Have a look to **template/monochromed** directory for an example of this tutorial.

#### What needs each page

First open the **template/monochromed/index.html** file with your web browser. You can see the original monochromed template.

Open then the same file with your favorite editor. Mine is *vim*. But you can open the file with *gedit* or *geany* for an example. You see the file composed of:

  * doctype
  * head content
  * body content (homepage class)

The last one (body content) have some elements:

  * Header DIV
  * Main DIV
  * Sidebar DIV
  * Footer DIV
  * Copyright DIV

As explained in **Template 's structure** we need to create a **header.tmpl** and a **footer.tmpl** file. They will be used in all pages in our weblog.

The idea is to get the begining of the page from doctype to this:

    <!-- Main -->
      <div id="main">
        <div class="container">

and to put it into **template/monochromed/header.tmpl** file.

Then get the last 2 DIV from the container DIV to the end of the file and put it into **template/monochromed/footer.tmpl**.

#### Static directory

Each template need a static directory in which you will put some pictures/images, javascript files, etc.

In our example, do this:

  * create static directory in **template/monochromed/static**
  * copy **css**, **images** and **js** directory into **static** one

It's time to configure our template.

#### config.mk file

As explained in next chapters, **config.mk** file gives some information about your new template/theme.

So create **template/monochromed/config.mk** file with this content:

    CSS_NAME = Monochromed
    CSS_FILE = main_monochromed.css
    CSS_COLOR_FILE = color_monochromed_light.css

which implies to create two files:

  * template/monochromed/style/main_monochromed.css: all common CSS rules for your template/theme
  * template/monochromed/style/color_monochromed_light.css: only recommanded for a color version of your template so that you can create multiple versions

For now, just create the files. You will move all CSS rules later.

#### Test the result

What's about testing the result?

Just modify your **makefly.rc** and add this:

    THEME = monochromed

Then refresh your blog:

    ./makefly refresh

And you will see the result in your web browser by opening **pub/index.html**.

#### Hey, I want to display the title!

Let's display our blog title.

Open **template/monochromed/header.tmpl** file and replace this:

    <title>Monochromed by TEMPLATED</title>

by this:

    <title>${BLOG_TITLE} - ${TITLE}</title>

And:

    <h1><a href="#">Monochromed</a></h1>
    <span>Design by TEMPLATED</span>

by:

    <h1><a href="${BLOG_URL}">${BLOG_TITLE}</a></h1>
    <span>${BLOG_SHORT_DESC}</span>

In fact we just place some variables so that ${PROJECTNAME} makes replacements in all pages.

As previously, test the result:

    ./makefly refresh

And open **pub/index.html** in your web browser.

#### Where are posts?

See **template/monochromed/onecolumn.html** with your editor. The template give us a row containing a "No sidebar" post that takes all the width.

So take the content of **row** DIV (```<div class="row">```) and put it into **template/monochromed/article.index.tmpl** file.

Then add some variables to display your posts (you can see the result in **template/monochromed/article.index.tmpl**):

  * POST\_TITLE
  * POST\_DESCRIPTION
  * POST\_FILE
  * POSTDIR\_NAME
  * POST\_TYPE
  * POST\_CONTENT

This will only make posts available on homepage. To have each post create the **template/monochromed/article.tmpl**. You can copy the **template/monochromed/article.index.tmpl** file instead. As explained in **Template ' structure** section, *article.index.tmpl* is used by homepage and *article.tmpl* by each single post. So just adapt them as your needs.

#### Main menu

What we are used to see in ${PROJECTNAME} looks like:

    <li><a href="${BLOG_URL}">${HOME_TITLE}</a></li>
    <li><a href="${BLOG_URL}/${POSTDIR_NAME}/${POSTDIR_INDEX}">${POST_LIST_TITLE}</a></li>
    <li><a href="${BLOG_URL}/${TAGDIR_NAME}/${TAGDIR_INDEX}">${TAG_LIST_TITLE}</a></li>${ABOUT_LINK}

You can adapt the **template/monochromed/header.tmpl** file to integrate the menu in place of **nav** tag.

Note that the ABOUT\_LINK variable needs the **template/monochromed/menu.about.tmpl** file. Copy those from *template/base/menu.about.tmpl*.

#### Some problems appears with the CSS

Now you have a menu and use it you see that CSS is not available for all pages. This is because of the fact that all CSS and JS links are relative. They refers to *css/style.css* for an example. And each page don't have the same depth into our blog tree.

To avoid this kind of problem we recommand in ${PROJECTNAME} to use absolute path. But how to add our blog URL in each CSS and JS files? We use variables. That way, you can add BLOG\_URL variable in your CSS/JS files (located in **template/monochromed/static** directory) to complete all links. For an example in **template/monochromed/static/js/init.js** file replace:

    prefix: 'css/style',

by:

    prefix: '${BLOG_URL}/css/style',

Then adapt **template/monochromed/header.tmpl** to have this:

      <link href='http://fonts.googleapis.com/css?family=Oxygen:400,300,700' rel='stylesheet' type='text/css'>
      <!--[if lte IE 8]><script src="${BLOG_URL}/js/html5shiv.js"></script><![endif]-->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
      <script src="${BLOG_URL}/js/skel.min.js"></script>
      <script src="${BLOG_URL}/js/skel-panels.min.js"></script>
      <script src="${BLOG_URL}/js/init.js"></script>
      <noscript>
        <link rel="stylesheet" href="${BLOG_URL}/css/skel-noscript.css" />
        <link rel="stylesheet" href="${BLOG_URL}/css/style.css" />
      </noscript>
      <!--[if lte IE 8]><link rel="stylesheet" href="${BLOG_URL}/css/ie/v8.css" /><![endif]-->
      <!--[if lte IE 9]><link rel="stylesheet" href="${BLOG_URL}/css/ie/v9.css" /><![endif]-->
    </head>

Refresh the blog and enjoy!

#### Common files

As explained in **Template ' structure** section, there is a lot of files needed for our template to work. Some needs to be adapted, and some other one can be just used as it is.

So you can copy these files (from **template/base** directory) in your monochromed directory:

  * element.tmpl
  * menu.about.tmpl
  * post.footer.tmpl
  * post.index.tmpl
  * tagelement.tmpl
  * taglink.tmpl
  * tags.tmpl

After a *refresh* your blog will have posts list and tags list available.

What do you think about your blog now?

----

## Template ' structure

In ${PROJECTNAME} the structure of templates is not complex. But you need to know how it works to understand the possibilities it offers.

### Quick list of needed files

Here is a short description of each element of the structure. Note that no header/footer is required for these templates. Which means that the begining of all pages is **header.tmpl** and the end of all pages is **footer.tmpl**, except for RSS feeds that use **feed.header.rss** and **feed.footer.rss**.

Elements:

  * **article.index.tmpl**: the template of **one** post on the homepage
  * **article.tmpl**: content of a given post from the weblog
  * **config.mk**: contains the configuration of your template. The name, the CSS filename, the second CSS filename, if the sidebar is mandatory, etc.
  * **element.tmpl**: short info about a post to be integrated in the list of posts.
  * **header.tmpl**: header of **all** weblog pages. Should contains the first ```<html>``` tag, the ```<head>``` and the ```<body>``` one.
  * **footer.tmpl**: footer of **all** weblog pages. Should contains the last ```</body>``` and ```</html>``` one.
  * **menu.about.tmpl**: supplementary main menu link to the about's page
  * **menu.search\_bar.tmpl**: supplementary main menu link to display a search bar
  * **pagination.tmpl**: HTML code used to make a pagination under posts list
  * **post.footer.tmpl**: last HTML code that will be displayed after the list of all posts
  * **post.index.tmpl**: first HTML code to be displayed before the list of all posts
  * **read\_more\_link.tmpl**: link "Read more" that will be displayed under each post on the homepage. Only available if MAX\_POST\_LINES is used.
  * **sidebar.tmpl**: HTML code that will be used in place of ${SIDEBAR} specific word in header/footer templates. Should contains the **${SIDEBAR\_CONTENT}** specific word.
  * **static** [directory]: directory that contains files that needs to be present in the result. For an example some pictures, javascript files, etc. Do not place CSS files here (but not forbidden) as we have *style* directory for this. You should know that files contained in static directory will be completed during a compilation process. But this is only ready for the **BLOG\_URL** variable.
  * **style** [directory]: list of possible CSS files. As ${PROJECTNAME} is designed, you can make a stylesheet for main appearance, then add a CSS file for each version of your template. For an example a CSS that makes your template red. Another one that makes your template blue, etc. Is configurable with the help of CSS\_COLOR\_FILE in **config.mk** file.
  * **tagelement.tmpl**: a single tag element to be displayed on the tag list page
  * **taglink.tmpl**: a single tag info that would be displayed on each post
  * **tags.tmpl**: the tag list page. Should content the **${TAG\_LIST\_TITLE}** specific word.

Pay attention that some other ones are located in the template main directory for specific treatments. You should not create them into your template but you need to know them:

  * **eli\_content.tmpl**: HTML code of status timeline from ELI application.
  * **eli.css**: CSS for ELI functionnality
  * **eli\_css\_declaration.tmpl**: HTML code used to declare ELI CSS in our weblog
  * **eli\_declaration.tmpl**: HTML code that declares the ELI javascript in our weblog. Commonly placed in the footer.
  * **eli.js**: Javascript code used by ELI functionnality
  * **empty.file**: an empty file (some applications are very curious, this one don't escape to this rule)
  * **feed.footer.rss**: XML footer code for RSS feed
  * **feed.header.rss**: XML header code for RSS feed
  * **isso.tmpl**: HTML code for each post for ISSO comment functionnality. Replace ISSO\_CONTENT variable in templates.
  * **isso.css**: CSS used for ISSO functionnality
  * **isso\_css\_declaration.tmpl**: CSS HTML declaration used in header for ISSO comment system. Replace ISSO\_CSS\_DECLARATION variable in templates.
  * **isso\_declaration.tmpl**: HTML code that declares the ISSO javascript in our weblog. Commonly placed in the footer. Replace ISSO\_SCRIPT variable in templates.
  * **isso.short.tmpl**: usually used on homepage to only display number of comment using ISSO comment system. Replace ISSO\_SHORT variable in templates.
  * **isso.extended.tmpl**: usually used on each post to display comments using ISSO comment system. Replace ISSO\_EXTENDED variable in templates.

### More explanation

First, ${PROJECTNAME} delivers the blog as:

  * an homepage
  * a list of posts
  * a list of tags
  * an about's page (optional)
  * some static pages (user adds itself the static pages it wants)
  * a page for each post
  * a page for each tag

So a page is composed of:

  * a header (**header.tmpl** file)
  * a content (various contents: list of posts, list of tags, a tag, a post, an homepage, an about's one, etc.)
  * a footer (**footer.tmpl** file)

If you understand it well, you need so 2 files:

  * header.tmpl (the begining of ALL pages)
  * footer.tmpl (the end of ALL pages)

Then, how works the content?

The content is so build regarding which page we want.

So for **posts** you have **article.tmpl** that describe each single post page, but **article.index.tmpl** describe the code used for one post that is displayed on homepage.
All posts are listed in a posts page. The template for this list is **post.index.tmpl** (beginning) and **post.footer.tmpl** (end).
Each post short description on this list is described in **element.tmpl**.
If you activate the numbering of posts on this page, you will have a pagination. The template of this one is available here: **pagination.tmpl**.

Each post under the homepage can have a *Read More* link that is described here: **read\_more\_link.tmpl**.

For **tags** you have **taglink.tmpl** that contains each link to a tag used in a post. The tag list page is available here: **tags.tmpl**. Each tag displayed on this page is available here: **tagelement.tmpl**.

You can create a kind of main menu displayed on all pages that is called *sidebar*. The corresponding template is: **sidebar.tmpl** and contains a specific word named **${SIDEBAR\_CONTENT}** which integrate the content of *special/sidebar.md* file.

TODO: make a picture to display the structure

### The config.mk file

Each template delivers a **config.mk** file. This is the business card of your template.

The file contains some mandatories info as:

  * **CSS\_NAME**: template's name. For an example: *Minisch 2.4*
  * **CSS\_FILE**: template's main CSS file. This should be located into '*template/yourTemplate/style/*' directory. Example: *main\_minisch.css*
  * **CSS\_COLOR\_FILE**: template's particular colors. This means you can have more than one color for your template just by giving a lot of CSS files. All CSS files should be located into '*template/yourTemplate/style/*'. For an example: *color\_minisch\_light.css*

and optional ones:

  * **ISSO\_CSS**: additionnal CSS used for ISSO comment system. Should be located into **template/yourTemplate** directory. Example: *myissocomment.css*
  * **SIDEBAR**: If value is 1 then the sidebar is mandatory for your template. Which means your template have been designed to be only used with a sidebar.
  * **ISSO\_SHORT**: template used for ISSO\_SHORT variable. In fact, it replaces ISSO\_SHORT variable by the content of this template.

**NB:** These info should be placed like this:

    VAR = value

You can find some example of *config.mk* file into the **template** directory. Don't hesitate to have a look into this directory. You will learn a lot!

----

## Replacement values

In ${PROJECTNAME} you have some specific words in templates that are replaced by some values. For an example the word **${HOME\_TITLE}** will be displayed as **Home**. So when you see it in template, or add it in template, you know that this specific word will be replaced.

Note that you can easily find these specific words in a template because the begin with "**${**" and finish by "**}**". This is the first rule.

The second one is: specific words should be in UPPERCASE.

In this section, you will know more about these replacement values, how to find them, which one you have, etc.

### Translated values

Some specific words can be found here: *lang/translate.en*.

In this file, each first word in uppercase of each line is a specific word that will be replaced in the result.

Tip: You can add your own specific word and its value. And it will be used for templates (if you add them in templates).

### Configuration values

There is some specific words that comes from the configuration file (${PROJECTNAMELOWER}.rc). You can so read the official documentation, especially the ${PROJECTNAMELOWER}.rc file section to know what they are used for.

  * **BLOG\_CHARSET**
  * **BLOG\_TITLE**
  * **LANG** (comes from BLOG\_LANG in ${PROJECTNAMELOWER}.rc file)
  * **BLOG\_DESCRIPTION**
  * **BLOG\_SHORT\_DESCRIPTION**
  * **BLOG\_URL** (very used all over the blog)
  * **BLOG\_AUTHOR**
  * **BLOG\_COPYRIGHT**
  * **RSS\_FEED\_NAME**

Tip: Dislike the previous section about translation file, you cannot add any personal specific word in the ${PROJECTNAMELOWER}.rc file as they are used in a special way.

### Given by the ${PROJECTNAME} engine

To make template you need to know and understand these specific words. They are delivered by the ${PROJECTNAME} engine and permit you to design new templates for your weblog.

Here is a non-exhaustive list. If you find a new one not listed here, please contact us or create a new ticket on [our bug tracking system](${GITPROJECT}issues).

  * **ABOUT\_INDEX**: Real html name of *About*'s page. For an example: about.html. If you want a link to the about's page, you just have to make this: "*${BLOG\_URL}/${ABOUT\_INDEX}*".
  * **ABOUT\_LINK**: Add a menu link regarding *menu.about.tmpl* template. This only works if About's page was activated by its presence.
  * **BODY\_CLASS**: The engine is configured to change this value regarding the generated page. By default the value is "single" for all pages. Then you have: 
    * single (default value)
    * about: to say the entire page is an about's one
    * tags: to say the entire page is the list of tags
    * home: homepage
    * page: you're in a static page (static page functionnality)
  * **CONTENT**: Content of a post (when you edit posts ' templates)
  * **CSS\_COLOR\_FILE**: CSS second filename (in template directory) used as supplementary CSS. Ofently used for CSS that gaves the color (to permit user to choose among few CSS color files). Defined in **config.mk** of your template.
  * **CSS\_FILE**: Main CSS filename.
  * **CSS\_NAME**: Name displayed when the user choose your template. Defined in **config.mk** of your template.
  * **DATE**: Date using DATE\_FORMAT format. Displayed date changes regarding the post you are into.
  * **DATETIME**: Date using ISO8601 format to be compatible with HTML5 *time* tag. Displayed datetime changes regarding the post you are into.
  * **POST\_TYPE**: Type the user filled in when it creates the post. This permit to use it in CSS and class so that each article have another color for an example.
  * **POSTDIR\_INDEX**: Name of postdir's index page. For an example *index.html*.
  * **POSTDIR\_NAME**: Posts ' directory name. For an example *post*. That permit to have a better web indexation for your language.
  * **POST\_AUTHOR**: Author of the post
  * **POST\_ESCAPED\_TITLE**: Title of the post without whitespaces. Commonly used for comment systems. Example of result: **my\_first\_post**.
  * **POST\_FILE**: Post filename. Example: **my\_first\_post.html**.
  * **POST\_TITLE**: Title of the post. For an example: **My first post**.
  * **SEARCHBAR**: Add a search bar here regarding **menu.search_bar.tmpl** template file. Only works if searchbar is activate in configuration file.
  * **SHORT\_DATE**: Date using short date format (SHORT\_DATE\_FORMAT in ${PROJECTNAMELOWER}.rc configuration file) for post list's page.
  * **SIDEBAR**: Add a sidebar here regarding *sidebar.tmpl* template. Only works if sidebar is activate from the configuration file (${PROJECTNAMELOWER}.rc) or the template's configuration file (config.mk).
  * **SIDEBAR\_CONTENT**: Add the content of **special/sidebar.md** file.
  * **TAGDIR\_NAME**: Tags directory name. For an example *tag*. This permits a better web indexation for your language.
  * **TAGDIR\_INDEX**: Tag index filename. Example: **index.html**.
  * **TAGLIST\_CONTENT**: List of all tags from the blog.
  * **TAG\_LINKS\_LIST**: List of tags from a given post.
  * **TAG\_NAME**: Tag name. For an example **My first tag**.
  * **TAG\_PAGE**: Tag filename. For an example: *my\_first\_tag.html*.
  * **TITLE**: Current page title. For an example *Homepage*, *Tags List*, *My first post*, etc.

