<link href="./readme.css" rel="stylesheet"></link>

# Documentation Technique de Makefly

## Introduction

Ce document a pour but d'expliquer comment Makefly fonctionne. Le dévelopeur recherchera probablement des informations sur comment ajouter du code et comment contribuer à Makefly.

Vous devriez trouver ce que vous cherchez ici. Le cas contraire veuillez me contacter pour que je puisse répondre dans cette documentation pour les prochains développeurs.

Mon adresse de contact : olivier+makefly [CHEZ] dossmann [POINT] net.

## Pré-requis

Vous ne devez pas être un dévelopeur ou un "hacker" pour comprendre cette documentation et contribuer à Makefly. Soyez simplement curieux, lisez la doc et contacter l'auteur :-).

Cependant je vous recommande vivement de savoir :

  * Utiliser un shell (comme bash, zsh ou sh)
  * Lire la documentation des Makefile BSD (ou bien utilisez là comme référence)
  * Comment créer une page web - HTML et CSS

## Repères rapides

La première chose que vous devez savoir est : Makefly n'a pas été construit pour être KISS/simple. Il a été fait pour faire une chose et la faire bien. Pour avoir une interface pour publier des articles et écrire des articles, un autre projet naîtra (le projet *HYMBY* ou *ANSWER*) pour faire cette interface. Mais ceci est un autre sujet.

### Moteur principal

Makefly est un programme qui utilise un Makefile BSD pour fonctionner. Le Makefile BSD est un système qui regarde tout les fichiers nécessaires, tout les fichiers cibles et va compiler/faire seulement ce qui est utile pour les fichiers cibles nécessaires. En effet, si vous relancer la commande, il ne compilera que ce qui est nécessaire.

Par exemple si vous changez seulement un fichier, et que ce fichier est simplement utilisé dans UN fichier cible, alors le Makefile BSD compilera/fera seulement le fichier cible avec le fichier source.

Ce mécanisme permet d'économiser du temps et des ressources. Selon moi c'est ce qui fait la puissance de Makefly.

Jetez un œil à la section **Moteur principal : Le fichier Makefile** pour comprendre comment cela fonctionne.

### Articles

Dans Makefly les articles sont séparés en 2 fichiers : 

  * un fichier méta-données
  * un fichier source

Le fichier méta-données contient toutes les méta-données de l'article.

Le fichier source contient le contenu de l'article.

Vous pensez probablement que cela ne fait pas de sens, mais regardez du côté du Makefile pour voir que c'est utile. Pour plus d'information, lisez la section **En savoir plus à propos des fichiers articles**.

### Fichier de configuration

Comme d'autres programmes, Makefly vise à permettre la configuration dans UN fichier unique : **makefly.rc**. Mais comme d'autres, vous pouvez faire plus en personnalisant les fichiers de Makefly comme : 

  * Makefile : quelques variables peuvent être utiles pour montrer les erreurs dans d'autres langues, donner d'autres fichiers template, ajouter plus de variables, etc.
  * Les fichiers lang/translate.* : Vous pouvez ajouter de nouvelles traductions ou d'autres valeurs
  * Les fichiers template : Vous pouvez personnaliser les templates comme vous voulez. Il n'est pas certain que cela fonctionne après changements :-)

Avec le fichier de configuration principal (**makefly.rc**) vous pouvez faire des choses comme : 

  * activer/désactiver une barre latérale, une barre de recherche
  * changer les templates du thème
  * changer le format de date
  * nom, description de votre joueb (JOUrnal wEB)
  * nom des fichiers index
  * extension de votre blog
  * etc.

Pour plus d'information regardez la section **Le fichier makefly.rc**.

## Où est le code ?

Le code est distribué sur Internet sur quelques dépôts. Chaque dépôts a quelques branches. Chaque branche est utilisée pour un but précis. Par exemple le site officiel Makefly est contenu dans une branche appelée *weblog*.
### Dépôts

Le code est mis dans 3 dépôts git : 

  * [Gitorious](http://gitorious.org/makefly/ "Makefly sur Gitorious")
  * [Github](http://github.com/blankoworld/makefly/ "Makefly sur Github")
  * Dépôt personnel : http://git.dossmann.net/

Vous pouvez les récupérer avec la commande **git** dans un terminal, par exemple avec le dépôt gitorious : 

    git clone git://gitorious.org/makefly/master.git master

Pour github : 

    git clone git://github.com/blankoworld/makefly.git

**Note**: Nous n'avons pas le temps de débattre sur mon choix de git. Si vous n'aimez pas git, peut-être pourriez-vous utiliser un autre système de gestion de version comme HQ (mercurial) et son [hg-git plugin](http://hg-git.github.com/ "En apprendre plus sur hg-git").

### Les branches

Je travaille avec des branches. Chaque branche a un but spécifique. Voici 3 branches principales dont je dispose : 

  * master: derniers développement de Makefly
  * disqus\_comments: avec Disqus comme système de commentaire
  * comments: pour la version 0.2 avec un système de commentaire intégré

Si vous voulez développer une fonctionnalité, je vous suggère de commencer de la **branche master** sur gitorious et/ou github. Puis de faire une *demande de merge* sur cette dernière.

### Comment créer une nouvelle branche et pousser les changements adéquats dedans ?

Je vous suggère de lire cet article : [A successful git branching model](http://nvie.com/posts/a-successful-git-branching-model/ "En apprendre plus au sujet d'un modèle de branches git réussi") (anglais). Ce dernier explique comment faire une branche et ajouter des fonctionnalités dedans.

## En apprendre plus sur les fichiers articles

Comme expliqué précédemment, les articles sont composés de 2 fichiers : 

  * un fichier DB contenant les méta-données
  * un fichier source qui contient le contenu de l'article

Ceci permet à Makefly de simplement extraite le contenu ou juste les méta-données.

Les méta-données sont stockées dans le dossier **db** (variable DBDIR). De plus les fichiers sources sont stockées dans le dossier **src**.

Pour que Makefly fonctionne, chaque article doit non seulement avoir UN fichier db et UN fichier source, mais il a aussi besoin que ces fichiers aient le même nom. Par exemple j'écris un article nommé "Mon premier article". J'aurai deux fichiers : 

  * **db/1234567890,mon_premier_article.mk**
  * **src/mon_premier_article.md**

À la compilation du joueb (blog), Makefly va parcourir chaque fichier et publier l'article.

### Les fichiers DB

Les fichiers méta-données permettent de générer la page qui contient la liste des articles. Leur nom est composé ainsi : 

  * un **timestamp** qui définit la date où l'article devrait être**publié**
  * une virgule: **,**
  * le **titre** de l'article en minuscule, sans espaces et sans caractères spéciaux comme `?!:;,<>(){}`
  * l'extension de fichier db : **.mk**

À noter que l'extension de fichier db est **.mk** ce qui autorise l'inclusion dans le Makefile BSD et récupère directement les variables.

Si vous éditez un fichier de méta-données, vous pouvez y trouver quelque chose comme : 

    VAR = contenu de votre variable

Par exemple : 

    TITRE = Le titre de mon article
    TYPE = nouvelle
    TAG = une_etiquette, une_autre_etiquette

Ce qui annonce que l'article aura pour titre "**Le titre de mon article**", un type "**nouvelle**" et aura quelques étiquettes : une\_etiquette et une\_autre\_etiquette.

Les fichiers DB sont inclut dans le Makefile quand vous voyez du code comme : 

    .include "${DBFILES}"

ou : 

    .include "${DBDIR}/${FILES}"

Si vous ajoutez quelques VARIABLES, vous devez modifier le Makefile et le compléter.

### Les fichiers sources

Les fichiers sources permettent la génération de chaque article.

L'extension des fichiers source est **.md** ce qui implique qu'ils sont des **fichiers markdown**. Vous pouvez en lire plus sur le format de fichier sur le [site officiel de Markdown](http://daringfireball.net/projects/markdown/syntax/ "Documentation Markdown").

## Moteur principal : Le fichier Makefile

Le cœur de Makefly : the fichier **Makefile**. Ce dernier génère tout les fichiers nécessaires pour votre future joueb (JOUrnal wEB, blog).

Je vous suggère d'utiliser le [manuel de pmake](http://www.freebsd.org/doc/en/books/pmake/ "En savoir plus sur pmake") (anglais) comme support principal.

Ce que vous devriez savoir à propos du Makefile : 

  * si vous voulez ajouter quelques cibles, ajoutez les à la fichier du fichier
  * une fois que vous avez développé votre cible, vous pouvez probablement l'ajouter dans la cible nommée **all**
  * pour ajouter une variable globale, ajoutez la en début de fichier
    * les variables qui ciblent un répertoire sont en majuscule
    * les variables qui ciblent a fichier template ou un programme sont en minuscule
  * si vous voulez ajouter quelques VARIABLES pour être interprétées lors du parcours des templates, ajoutez VARIABLES dans la variable *parser_opts*
  * ajoutez un commentaire simple avant votre cible dans le but d'être compréhensible pour les quelques dévelopeurs suivants afin de comprendre pourquoi cette cible existe
  * si vous rencontrez des problèmes et trouvez une solution, n'oubliez pas d'ajouter le problème et la solution dans le fichier *doc/KNOWN_ISSUES.md*

Pour d'autres information, je vous suggère de lire les commentaires dans le fichier *Makefile*. Si vous avez une question, demandez-moi (`olivier+makeflydoc[AT]dossmann[DOT]net`).

## Le fichier makefly.rc

Le fichier est nécessaire pour l'utilisateur afin de configurer Makefly. L'utilisateur doit le créer pour que Makefly fonctionne.

Quelques variables importantes : 

  * BLOG\_TITLE : titre du blog
  * BLOG\_SHORT\_DESC : description courte du blog (non utilisé actuellement)
  * BLOG\_DESCRIPTION : description du blog pour le flux RSS
  * BLOG\_LANG : est un code utilisé pour chercher le fichier correspondant dans le répertoire **lang**. Par exemple **fr** pour Français, ou **en** pour anglais.
  * BLOG\_CHARSET : utilisé pour le flux RSS et tout les fichiers HTML. Similaire à **UTF-8** ou **ISO-8859-15** par exemple.
  * BASE\_URL: pour compléter toutes les adresses URL. Par example : **http://mon.joueb.tld/**
  * RSS\_FEED\_NAME: The name that appears as title in your RSS feed.
  * MAX\_POST: to limit the number of post on mainpage. If 0, do not add any limit.
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

