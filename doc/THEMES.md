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

This copy the default **base** theme.

The command show you where is the new theme. It remains commonly in the **template** directory (except if you change the template's directory location).

So you just have to customize the theme. Pay attention to values that are replacement ones. You can find a non-exhaustive list in **Replacement values** section of this documentation.

----

## Adapt an existing template (Example)

Sometimes, you're a lazy person (I too). So you prefer taking other people's templates! So you sometimes go to [a website template](http://templated.co/ "Choose a template on templated.co website").

Let's have a look to this template : http://templated.co/monochromed . We will use it for our tutorial.

I download the template, extract it in **template/monochromed** (in ${PROJECTNAMELOWER} directory).

Then we have 2 tasks:

  * Insert some specific word that would be replaced by our blog content
  * Make the structure of a template

The first task is explained in **Replacement values** section of the current document.

The second one is explained in **Template ' structure**.

Then I suggest you to read the following example to understand how to proceed.

TODO

TODO: explain the user how to adapt the theme so that it could be used into ${PROJECTNAME}.

TODO

----

## Template ' structure

In ${PROJECTNAME} the structure of templates are not complex. But you need to know how it works to understand the possibilities it offers.

### Quick list of needed files

Here is a short description of each element of the structure. Note that no header/footer is required for these templates:

  * **article.index.tmpl**: the template of **one** post on the homepage
  * **article.tmpl**: content of a given post from the weblog
  * **config.mk**: contains the configuration of your template. The name, the CSS filename, the second CSS filename, if you the sidebar is mandatory, etc.
  * **element.tmpl**: short info about a post to be integrated in the list of posts.
  * **footer.tmpl**: footer of **all** weblog pages. Should contains the first ```<html>``` tag, the ```<head>``` and the ```<body>``` one.
  * **header.tmpl**: header of **all** weblog pages. Should contains the last ```</body>``` and ```</html>``` one.
  * **[deprecated] jskomment.css**: CSS for JSKOMMENT comment system
  * **menu.about.tmpl**: supplementary main menu link to the about's page
  * **menu.search\_bar.tmpl**: supplementary main menu link to display a search bar
  * **pagination.tmpl**: HTML code used to make a pagination under 
  * **post.footer.tmpl**: last HTML code that will be displayed after the list of all posts
  * **post.index.tmpl**: first HTML code to be displayed before the list of all posts
  * **read\_more\_link.tmpl**: link "Read more" that will be displayed under each post on the homepage
  * **sidebar.tmpl**: HTML code that will be used in place of ${SIDEBAR} specific word in header/footer templates. Should contains the **${SIDEBAR\_CONTENT}** specific word.
  * **static**: directory that contains files that needs to be present in the result. For an example some pictures, javascript files, etc. But NOT CSS files.
  * **style**: list of possible CSS files. As ${PROJECTNAME} is designed, you can make a stylesheet for main appearance, then add a CSS file for each version of your template. For an example a CSS that makes your template red. Another one that makes your template blue, etc.
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
  * **[deprecated] jskomment.article.tmpl**: HTML code for each article for JSKOMMENT functionnality
  * **[deprecated] jskomment.css**: CSS used for JSKOMMENT functionnality
  * **[deprecated] jskomment\_css\_declaration.tmpl**: CSS HTML declaration used for header
  * **[deprecated] jskomment\_declaration.tmpl**: HTML code that declares the JSKOMMENT javascript in our weblog. Commonly placed in the footer.
  * **[deprecated] jskomment.js**: Javascript code used by JSKOMMENT functionnality

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
All posts are listed in a posts page list. The template for this list is **post.index.tmpl** (beginning) and **post.footer.tmpl** (end).
Each post short description on this list is described in **element.tmpl**.
If you activate the numbering of posts on this page, you will have a pagination. The template of this one is available here: **pagination.tmpl**.

Each post under the homepage can have a *Read More* link that is described here: **read\_more\_link.tmpl**.

For **tags** you have **taglink.tmpl** that contains each link to a tag used in a post. The tag list page is available here: **tags.tmpl**. Each tag displayed on this page is available here: **tagelement.tmpl**.

You can create a kind of main menu displayed on all pages that is called *sidebar*. The corresponding template is: **sidebar.tmpl** and contains a specific word named **${SIDEBAR\_CONTENT}** which integrate the content of *special/sidebar.md* file.

TODO: make a picture to display the structure

### The config.mk file

TODO: Explain this file: mandatories fields, other fields. How do we need to write this file (var = content)

----

## Replacement values

In ${PROJECTNAME} you have some specific words in templates that are replaced by some values. For an example the word **${HOME\_TITLE}** will be displayed as **Home**. So when you see it in template, or add it in template, you know that this specific word will be replaced.

Note that you can easily find these specific words in a template because the begin with "**${**" and finish by "**}**". This is the first rule.

The second one is: specific words should be in UPPERCASE.

In this section, you will know more about these replacement values, how to find them, which one you have, etc.

### Translated values

Some specific word can be found here: *lang/translate.en*.

In this file, each first word in uppercase of each line is a specific word that will be replaced in the result.

Tip: You can add your own specific word and its value. And it will be used for templates (if you add them in templates).

### Configuration values

There is some specific words that comes from the configuration file (${PROJECTNAMELOWER}.rc). You can so read the official documentation, especially the ${PROJECTNAMELOWER}.rc file section to know what they are used for.

  * **BLOG\_CHARSET**
  * **BLOG\_TITLE**
  * **LANG** (comes from BLOG\_LANG in ${PROJECTNAMELOWER}.rc)
  * **BLOG\_DESCRIPTION**
  * **BLOG\_SHORT\_DESCRIPTION**
  * **BLOG\_URL** (very used all over the blog)
  * **BLOG\_AUTHOR**
  * **BLOG\_COPYRIGHT**
  * **RSS\_FEED\_NAME**

Tip: Dislike the previous section about translation file, you cannot add any personal specific word in the ${PROJECTNAMELOWER}.rc file as they are used in a special way.

### Given by the ${PROJECTNAME} engine

To make template you need to know and understand these specific words. They are delivered by the ${PROJECTNAME} engine and permit you to design new template for your weblog.

Here is a non-exhaustive list. If you find a new one not listed here, please contact us or create a new ticket on [our bug tracking system](${GITPROJECT}issues).

  * **ABOUT\_INDEX**: Real html name of *About*'s page. For an example: about.html. If you want a link to the about's page, you just have to make this: "*${BLOG\_URL}/${ABOUT\_INDEX}*".
  * **ABOUT\_LINK**: Add a menu link regarding *menu.about.tmpl* template. This only works if About's page was activated by the default configuration with "*ABOUT = 1*".
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
  * **POSTDIR\_NAME**: Posts ' directory name. For an example *posts*. That permit to have a better web indexation for your language.
  * **POST\_AUTHOR**: Author of the post
  * **POST\_ESCAPED\_TITLE**: Title of the post without whitespaces. Commonly used for comment systems. Example of result: **my\_first\_post**.
  * **POST\_FILE**: Post filename. Example: **my\_first\_post.html**.
  * **POST\_TITLE**: Title of the post. For an example: **My first post**.
  * **SEARCHBAR**: Add a search bar here regarding **menu.search_bar.tmpl** template file. Only works if searchbar is activate in configuration file.
  * **SHORT\_DATE**: Date using short date format (SHORT\_DATE\_FORMAT in ${PROJECTNAMELOWER}.rc configuration file) for post list's page.
  * **SIDEBAR**: Add a sidebar here regarding *sidebar.tmpl* template. Only works if sidebar is activate from the configuration file (${PROJECTNAMELOWER}.rc) or the template's configuration file (config.mk).
  * **SIDEBAR\_CONTENT**: Add the content of **special/sidebar.md** file.
  * **TAGDIR\_NAME**: Tags directory name. For an example *tags*. This permits a better web indexation for your language.
  * **TAGDIR\_INDEX**: Tag index filename. Example: **index.html**.
  * **TAGLIST\_CONTENT**: List of all tags from the blog.
  * **TAG\_LINKS\_LIST**: List of tags from a given post.
  * **TAG\_NAME**: Tag name. For an example **My first tag**.
  * **TAG\_PAGE**: Tag filename. For an example: *my\_first\_tag.html*.
  * **TITLE**: Current page title. For an example *Homepage*, *Tags List*, *My first post*, etc.
