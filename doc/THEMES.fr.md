# Thèmes pour ${PROJECTNAME}

[English version](${PROJECTURL}themes.html.en) (version originale française)

[Site officiel](${PROJECTURL} "Aller sur le site web")

## Dépendances

Concevoir un thème n'est pas difficile. Mais cela demande quelques compétences comme : 

  * faire du HTML
  * faire du CSS
  * [optionnel] faire du JS

Toutes ces compétences peuvent être apprises sur [openclassrooms](http://openclassrooms.com/ "Aller sur le site web officiel d'openclassrooms").

Rappelez-vous que ce n'est pas difficile, vous avez simplement besoin d'un peu de temps pour le faire.

----

## Concevoir un nouveau thème

Créér un nouveau thème est facile, comme expliqué dans la documentation officielle. Faites simplement : 

    ./${PROJECTNAMELOWER} theme monTheme

où **monTheme** est le nom de votre thème.

Ceci va copier le thème par défaut **base**.

La commande vous montre où est le nouveau thème. Cela reste généralement dans le répertoire **template** (sauf si vous changez l'emplacement du répertoire des templates).

Donc vous avez simplement à personnaliser le thème. Faites attention aux valeurs qui sont des valeurs de remplacement. Vous pouvez trouver une liste non-exhaustive dans la section **Valeurs de remplacement** de cette documentation.

----

## Adapter un template existant (Exemple)

Pour les personnes fainéantes, vous pouvez choisir un template sur le Web et l'adapter à ${PROJECTNAME} afin que cela fasse moins de travail pour créer un nouveau template.

Je vous suggère soit de voir une vidéo montrant comment adapter le template Monochromed à ${PROJECTNAME} soit de lire les explications à ce propos.

### Apprendre avec une vidéo

Comme une vidéo est plus parlante qu'un ensemble d'explication, j'ai fait [une vidéo qui vous montre comment chercher/charger/adapter un template existant à ${PROJECTNAME}](${PROJECTURL}monochromed.mkv "Comment adapter un template à ${PROJECTNAME}") (30 MB et 30 minutes approximativement).

NB: Cette vidéo est visionnable avec [VLC media player](https://www.videolan.org/vlc/ "Charger VLC").

### Apprendre avec des explications (vous pouvez comparer avec la vidéo)

Parfois, vous êtes feignants. Et moi aussi. Alors vous préférez prendre les templates des autres ! Ainsi j'utilise [un site web de templates](http://templated.co/ "Choisir un template sur le site web templated.co").

#### Chargement du template

Jetez un œil à ce template : [http://templated.co/monochromed](http://templated.co/monochromed "Découvrir le template nommé 'monochromed'"). Nous l'utiliserons pour notre tutoriel.

Charger le template, l'extraire dans **template/monochromed** (dans le dossier ${PROJECTNAMELOWER}).

#### Tâches à faire

Donc nous avons 2 choses à faire pour que le template fonctionne sur ${PROJECTNAME} : 

  1. Ajouter quelques clés (des mots spécifiques) qui vont insérer le contenu de notre blog à l'intérieur
  2. Créer la structure du template

La liste des clés est disponible dans la section **Valeurs de remplacement** du présent document. Ceci est pour la **première tâche** à faire.

**La seconde** est expliquée dans la section **Structure du template**.

Mais jetez un œil aux étapes suivantes pour comprendre la procédure de migration d'un template.

**Note** : Regardez le dossier **template/monochromed** en exemple de ce tutoriel.

#### Ce que demande chaque page

Premièrement ouvrez le fichier **template/monochromed/index.html** avec votre navigateur web. Vous pouvez voir le template monochromed original.

Ouvrez ensuite le même fichier avec votre éditeur favoris. Le mien est *vim*. Mais vous pouvez ouvrir le fichier avec *gedit* ou *geany* par exemple. Vous voyez le fichier composé de : 

  * un doctype
  * le contenu de head
  * le contenu de body (classe homepage)

Le dernier (le contenu de body) a plusieurs éléments : 

  * un DIV header
  * un DIV main
  * un DIV sidebar
  * un DIV footer
  * un DIV copyright

Comme expliqué dans **Structure du template** nous avons besoin de créer un fichier **header.tmpl** et **footer.tmpl**. Ils seront utilisés dans toutes les pages de notre blog.

L'idée est de prendre le début de la page depuis doctype à : 

    <!-- Main -->
      <div id="main">
        <div class="container">

et le déposer dans le fichier **template/monochromed/header.tmpl**.

Puis nous prenons les 2 derniers DIV de celui nommé *container* à la fin du fichier et on le dépose dans **template/monochromed/footer.tmpl**.

#### Dossier static

Chaque template a besoin d'un dossier statique dans lequel vous placerez quelques images/photos, fichiers javascript, etc.

Dans notre exemple, faites ceci : 

  * créez un dossier *static* : **template/monochromed/static**
  * copiez les dossiers **css**, **images** et **js** dans celui nommé **static**

Il est temps de configurer notre template.

#### Fichier config.mk

Comme expliqué dans les chapitres suivants, le fichier **config.mk** donne des informations à propos de notre nouveau template/thème.

Donc créez le fichier **template/monochromed/config.mk** avec ce contenu : 

    CSS_NAME = Monochromed
    CSS_FILE = main_monochromed.css
    CSS_COLOR_FILE = color_monochromed_light.css

ce qui implique de créer deux fichiers : 

  * template/monochromed/style/main_monochromed.css : toutes les règles CSS communes pour notre template/thème
  * template/monochromed/style/color_monochromed_light.css : seulement conseillé pour une version colorée de votre template afin que vous puissiez créer plusieurs versions

Pour l'instant créez simplement les fichiers. Vous migrerez les règles CSS plus tard.

#### Tester le résultat

Que diriez-vous de tester le résultat ?

Modifiez simplement votre **makefly.rc** et ajoutez ceci : 

    THEME = monochromed

Puis réactualisez votre blog : 

    ./makefly refresh

Et vous observerez le résultat dans votre navigateur web en ouvrant **pub/index.html**.

#### Hé, je voudrais afficher le titre !

Affichons le titre de notre blog.

Ouvrez le fichier **template/monochromed/header.tmpl** et remplacez ceci : 

    <title>Monochromed by TEMPLATED</title>

par ceci : 

    <title>${BLOG_TITLE} - ${TITLE}</title>

Et : 

    <h1><a href="#">Monochromed</a></h1>
    <span>Design by TEMPLATED</span>

par : 

    <h1><a href="${BLOG_URL}">${BLOG_TITLE}</a></h1>
    <span>${BLOG_SHORT_DESC}</span>

En fait nous mettons simplement quelques variables pour que ${PROJECTNAME} fasse des remplacements dans toutes les pages.

Comme précédemment, testez le résultat : 

    ./makefly refresh

Et ouvrez **pub/index.html** dans votre navigateur web.

#### Où sont les billets ?

Regardez **template/monochromed/onecolumn.html** avec votre éditeur. Le template nous donne une ligne contenant un billet "No sidebar" qui prend toute la largeur.

Donc prenez le contenu de la DIV **row** (```<div class="row">```) et mettez le dans le fichier **template/monochromed/article.index.tmpl**.

Puis ajoutez quelques variables pour afficher vos billets (vous pouvez voir le résultat dans **template/monochromed/article.index.tmpl**) : 

  * POST\_TITLE
  * POST\_DESCRIPTION
  * POST\_FILE
  * POSTDIR\_NAME
  * POST\_TYPE
  * POST\_CONTENT

Cela rendra seulement disponible les billets sur la page d'accueil. Pour avoir chaque billet créez le fichier **template/monochromed/article.tmpl**. Vous pouvez copier **template/monochromed/article.index.tmpl** à la place. Comme expliqué dans la section **Structure du template**, *article.index.tmpl* est utilisé par la page d'accueil et *article.tmpl* par chaque billet seul. Donc adaptez les suivant vos besoins.

#### Menu principal

Ce dont nous sommes habitués à voir dans ${PROJECTNAME} ressemble à : 

    <li><a href="${BLOG_URL}">${HOME_TITLE}</a></li>
    <li><a href="${BLOG_URL}/${POSTDIR_NAME}/${POSTDIR_INDEX}">${POST_LIST_TITLE}</a></li>
    <li><a href="${BLOG_URL}/${TAGDIR_NAME}/${TAGDIR_INDEX}">${TAG_LIST_TITLE}</a></li>${ABOUT_LINK}

Vous pouvez adapter le fichier **template/monochromed/header.tmpl** pour intégrer le menu à la place de la balise **nav**.

Notez que la variable ABOUT\_LINK a besoin du fichier **template/monochromed/menu.about.tmpl**. Copiez celui de *template/base/menu.about.tmpl*.

#### Quelques problèmes apparaissent avec le CSS

Maintenant que vous avez un menu et que vous l'utiliser, vous voyez que le CSS n'est pas disponible pour toutes les pages. C'est du fait que tout les liens CSS et JS sont relatifs. Ils se réfèrent par exemple à *css/style.css*. Et chaque page n'a pas l'a même profondeur au sein l'arbre de notre blog.

Pour éviter ce genre de problème nous recommandons dans ${PROJECTNAME} d'utiliser des liens absolus. Mais comment ajouter l'URL de notre blog dans chaque fichier CSS et JS ? Nous utilisons les variables. De cette façon vous pouvez ajouter la variable BLOG\_URL dans vos fichiers CSS/JS (situés dans le dossier **template/monochromed/static**) pour compléter tous les liens. Par exemple dans le fichier **template/monochromed/static/js/init.js** remplacez : 

    prefix: 'css/style',

par : 

    prefix: '${BLOG_URL}/css/style',

Puis adaptez **template/monochromed/header.tmpl** pour avoir ceci : 

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

Réactualisez le blog et profitez !

#### Fichiers communs

Comme expliqué dans la section **Structure du template**, il y a beaucoup de fichiers nécessaires pour que notre template fonctionne. Certains demandent à être adaptés, d'autres peuvent être utilisés comme tels.

Donc vous pouvez copiez ces fichiers (depuis le dossier **template/base**) dans votre dossier monochromed : 

  * element.tmpl
  * menu.about.tmpl
  * post.footer.tmpl
  * post.index.tmpl
  * tagelement.tmpl
  * taglink.tmpl
  * tags.tmpl

Après un *refresh*, votre blog aura une liste de billets et une liste de mots-clés disponible.

Que pensez-vous de votre blog désormais ?

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
  * **footer.tmpl**: footer of **all** weblog pages. Should contains the first ```<html>``` tag, the ```<head>``` and the ```<body>``` one.
  * **header.tmpl**: header of **all** weblog pages. Should contains the last ```</body>``` and ```</html>``` one.
  * **menu.about.tmpl**: supplementary main menu link to the about's page
  * **menu.search\_bar.tmpl**: supplementary main menu link to display a search bar
  * **pagination.tmpl**: HTML code used to make a pagination under homepage
  * **post.footer.tmpl**: last HTML code that will be displayed after the list of all posts
  * **post.index.tmpl**: first HTML code to be displayed before the list of all posts
  * **read\_more\_link.tmpl**: link "Read more" that will be displayed under each post on the homepage
  * **sidebar.tmpl**: HTML code that will be used in place of ${SIDEBAR} specific word in header/footer templates. Should contains the **${SIDEBAR\_CONTENT}** specific word.
  * **static**: directory that contains files that needs to be present in the result. For an example some pictures, javascript files, etc. Do not place CSS files here (but not forbidden) as we have *style* directory for this. You should know that files contained in static directory will be completed during a compilation process. But this is only ready for the **BLOG\_URL** variable.
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
  * **isso.tmpl**: HTML code for each article for ISSO comment functionnality. Replace ISSO\_CONTENT variable in templates.
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
All posts are listed in a posts page list. The template for this list is **post.index.tmpl** (beginning) and **post.footer.tmpl** (end).
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

  * **ISSO\_CSS**: additionnal CSS used for ISSO comment system. Should be located into **template/yourTemplate* directory. Example: *myissocomment.css*
  * **SIDEBAR**: If value is 1 then the sidebar is mandatory for your template. Which means your template have been designed to be only used with a sidebar.
  * **ISSO\_SHORT**: template used for ISSO\_SHORT variable. In fact, it replaces ISSO\_SHORT variable by the content of this template.

**NB:** These info should be placed like this:

    VAR = value

You can find some example of *config.mk* file into the **template** directory. Don't hesitate to have a look into this directory. You will learn a lot!

----

## Valeurs de remplacement

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

