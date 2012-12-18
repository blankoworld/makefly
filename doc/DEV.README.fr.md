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
    TAG = un_mot_cle, un_autre_mot_cle

Ce qui annonce que l'article aura pour titre "**Le titre de mon article**", un type "**nouvelle**" et aura quelques mots-clés : un\_mot\_cle et un\_autre\_mot\_cle.

Les fichiers DB sont inclut dans le Makefile quand vous voyez du code comme : 

    .include "${DBFILES}"

ou : 

    .include "${DBDIR}/${FILES}"

Si vous ajoutez quelques VARIABLES, vous devez modifier le Makefile et le compléter.

#### VARIABLES disponibles dans les fichiers DB

Ce que vous pouvez y trouver : 

  * TITLE : Titre de l'article (affiché dans toutes les pages liées à un article)
  * DESCRIPTION : Description de l'article (actuellement non utilisé)
  * DATE : Pas encore utilisé (inutile ?)
  * TAGS : Liste des mots-clés dans lesquels les articles sont inclus.
  * TYPE : nom utilisé pour différencier un type d'article d'un autre. Utile pour les feuilles de style.
  * AUTHOR : Rédacteur de l'article.

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
  * BLOG\_SHORT\_DESC : description courte du blog
  * BLOG\_DESCRIPTION : description du blog pour le flux RSS
  * BLOG\_LANG : est un code utilisé pour chercher le fichier correspondant dans le répertoire **lang**. Par exemple **fr** pour Français, ou **en** pour anglais.
  * BLOG\_CHARSET : utilisé pour le flux RSS et tout les fichiers HTML. Similaire à **UTF-8** ou **ISO-8859-15** par exemple.
  * BASE\_URL: pour compléter toutes les adresses URL. Par example : **http://mon.joueb.tld/**
  * RSS\_FEED\_NAME: Le nom qui apparaît comme titre dans votre flux RSS.
  * MAX\_POST: Pour limiter le nombre d'article sur la page principale.
  * DATE\_FORMAT: pour transformer le timestamp des articles en un autre format de votre choix.
  * SHORT\_DATE\_FORMAT: même chose que pour DATE\_FORMAT
  * INDEX\_FILENAME: si vous voulez nommer la page **principal** au lieu de **index**.
  * PAGE\_EXT: si vous voulez une autre extension. Par exemple **xhtml** au lieu de **html**.
  * MAX_RSS: Pour limiter le nombre d'article sur le flux RSS.

### Astuce : redéfinir d'autres VARIABLES

Du fait que le fichier makefly.rc est inclus dans le Makefile au moment du traitement, vous pouvez redéfinir quelques autres variables dans le fichier **makefly.rc** : 

  * TMPLDIR : répertoire des templates (dans lequel il y a tout les thèmes). Par défaut **template**.
  * BINDIR : répertoire dans lequel il y a l'analyseur LUA. Par défaut **bin**.
  * LANGDIR : répertoire pour les traductions. Par défaut **lang**.
  * SRCDIR : répertoire source dans lequel il y a tout les contenu d'articles. Par défaut **src**.
  * DESTDIR : répertoire de destination dans lequel le résultat sera mis. Par défaut **pub**.
  * DBDIR : répertoire des méta-données dans lequel il y aura les méta-infos de chaque article. Par défaut **db**.
  * TMPDIR : répertoire temporaire dans lequel quelques fichiers temporaires seront crées/supprimés. Par défaut **tmp**.
  * DOCDIR : répertoire de documentation. Utile pour la documentation que vous être en train de lire. Par défaut **doc**.
  * TAGDIR\_NAME : nom du répertoire résultant dans lequel seront écrits les pages de tag. Par défaut **tags**. C'est utile pour un meilleur référencement web.
  * POSTDIR\_NAME : nom du répertoire résultant dans lequel seront écrits les articles. Par défaut **posts**. C'est utile pour un meilleur référencement web.
  * STATICDIR : répertoire statique dans lequel l'utilisateur donne les fichiers qui seront copiés dans le dossier résultat (DESTDIR). Par défaut **static**.
  * SPECIALDIR : répertoire spécial dans lequel vous pouvez trouver le fichier **sidebar.md** et le fichier **about.md**. Par défaut **special**.
  * ABOUT\_FILENAME : nom de la page d'à propos. Ceci est utilisé pour trouver le fichier d'à propos dans le répertoire SPECIALDIR **et** pour renommer la page d'à propos finale. Par défaut **about**.
  * THEME : thème par défaut. Déjà expliqué dans la documentation UTILISATEUR.
  * BACKUPDIR : répertoire de sauvegarde dans lequel vous pouvez sauver tout les fichiers importants de Makefly. Par défaut **mbackup**.
  * SIDEBAR\_FILENAME : nom de la page de panneau latéral. Non seulement utilisé pour trouver le fichier, mais aussi pour l'écrire dans le dossier résultant. Par défaut **sidebar**.
  * TOOLSDIR : répertoire d'outils dans lequel vous pouvez trouver quelques outils utiles. C'est utilisé pour la commande *publish*. Ne pas la redéfinir sans savoir ce que vous faites ! Par défaut **tools**.
  * MAKEFLYDIR : répertoire actuel. NE PAS le redéfinir.
  * markdown : commande markdown. Par défaut **markdown**. Mais peut être changé par *python markdown*, *lua markdown.lua*, etc.
  * lua : commande lua. Par défaut **lua**.
  * parser : analyseur utilisé pour parcourir tout les fichiers. Ne devrait pas être redéfini !
  * mv : commande pour déplacer des fichiers.
  * rm : commande pour supprimer des fichiers.
  * sort : commande pour ordonner des fichiers ou des listes.
  * date : commande pour donner des dates, des timestamps, etc.
  * tar : commande pour archiver des fichiers.
  * PUBLISH\_SCRIPT\_NAME : nom du script de publication. Pourrait être renommé par un autre script. Ce script devrait être situé dans le répertoire **TOOLSDIR**. Par défaut **publish.sh**.
  * BODY\_CLASS : Classe utilisée par la baliste html *body* dans toutes les pages. Utile pour le thème et les feuilles de style. Par défaut **single**.

## Les fichiers template

Les templates sont situés dans le dossier **template** (variable TMPLDIR).

### Composition

Chaque thème a son propre répertoire. Ainsi pour le thème *défaut*, un dossier **défaut** est crée dans lequel vous pouvez voir quelques fichiers comme :

  * les fichiers .xhtml pour décrire le contenu du joueb (JOUrnal wEB, blog)
  * un dossier **style** dans lequel vous pouvez voir tout les fichiers CSS pour un thème défini
  * un **config.mk** dans lequel vous avez des détails à propos du thème : 
    * CSS\_NAME : Nom qui apparaîtra dans le joueb avec `${CSS_NAME}`
    * CSS\_FILE : le nom de fichier du CSS choisi pour un thème spécifique

### Fichiers obligatoires

Voici quelques explications à propos des fichiers **.xhtml** que vous pouvez trouver dans un thème : 

  * article.index.xhtml: Template pour chaque article qui est montré sur la page principale
  * article.xhtml: Template pour un article sur sa page seule
  * element.xhtml: Template pour une liste dans la page **Post List** (liste des articles)
  * footer.xhtml: Fin de chaque page HTML
  * header.xhtml: Début de chaque page HTML
  * menu.about.xhtml: Élément qui est utilisé pour montrer le lien de la page *À propos*.
  * menu.search_bar.xhtml: Template pour la barre de recherche
  * read_more_link.xhtml: Template pour le lien **Lire la suite** pour chaque article.
  * sidebar.xhtml: Template pour le panneau latéral
  * tagelement.xhtml: Template pour une ligne sur la page **Tag List** (liste des mots-clés)
  * taglink.xhtml: Template pour un lien seul vers une page de mot-clé
  * tags.xhtml: Template pour la page **Tag List** (liste des mots-clés)

### Complètement

Pour afficher le contenu des articles ou quelques éléments de chaque page, vous pouvez utiliser ce que nous appelons des **variables**. Dans les templates de Makefly, les variables sont montrées ainsi : 

    ${UNE\_VARIABLE}

Variables disponibles : 

  * ${ABOUT\_INDEX} : Nom de la page *À propos*. Par exemple : apropos.html
  * ${ABOUT\_LINK} : Ajoute un lien vers la page *À propos* (si activé dans le fichier de configuration par défaut)
  * ${ABOUT\_TITLE} : Titre de la page d'à propos (juste le titre). Par exemple : À propos.
  * ${ARTICLE\_CLASS\_TYPE} : Classe de l'article que l'utilisateur a rempli. Par exemple : news. Ceci permit d'adapter la feuille de style pour chaque type d'article.
  * ${BASE\_URL} : L'adresse de votre site web. Par exemple : http://mon.blog L'utilisateur le renseigne dans le fichier de configuration.
  * ${BLOG\_CHARSET} : Encodage du blog, comme *UTF-8* ou *ISO-8859-15*. Ceci est pour les pages HTML **et** les flux RSS.
  * ${BLOG\_TITLE} : Titre du blog. Par exemple *Mon premier joueb*.
  * ${BODY\_CLASS} : Nom de la classe définie pour la balise *body* de la page courante. Par exemple, sur la page d'accueil, la classe *body* est *home*. Ceci est utile pour les feuilles de style en cascade.
  * ${CONTENT} : Contenu de la page / de l'article. Cela ressemble souvent au contenu d'un article. Mais cela peut être un autre type de contenu comme une liste de mots-clés, une liste d'articles, etc. Ceci dépend de la page que vous éditez.
  * ${CSS\_FILE} : Nom du fichier CSS. Par exemple *simple.css*.
  * ${CSS\_NAME} : Nom qui apparaîtra à l'utilisateur quand il choisira votre thème CSS. Par exemple le thème *défaut*.
  * ${DATE}: Date utilisant le format de ${DATE\_FORMAT}.
  * ${DATETIME}: Date utilisant le format ISO8601 pour être compatible avec la balise HTML5 *time*.
  * ${HOME\_TITLE} : Titre qui apparaîtra sur le lien qui redirige vers la page d'accueil. Par exemple *Accueil*.
  * ${LANG} : Code pays utilisé dans les pages HTML pour définir une langue. Par exemple *fr* pour français, *en* pour anglais, etc.
  * ${POSTDIR\_INDEX} : Nom exact de la page d'index des articles. Par exemple *index.html*.
  * ${POSTDIR\_NAME} : Nom du répertoire des articles. Par exemple *articles*. Ceci permet d'avoir un meilleur référencement sur Internet.
  * ${POST\_AUTHOR}: Rédacteur de l'article
  * ${POST\_LIST\_TITLE} : Nom qui apparaîtra sur le lien pour aller sur la liste des articles. Par exemple *Liste des articles*.
  * ${POST\_FILE} : Nom exact du fichier article. Par exemple pour un article dont le nom est *Mon premier article*, la variable POST\_FILE devrait être *mon_premier_article*. Ceci permet également un meilleur référencement.
  * ${POST\_TITLE} : Titre de l'article. Par exemple : *Mon premier article*.
  * ${POWERED\_BY} : Nom affiché pour la mention *Propulsé par* sur toutes les pages.
  * ${READ\_MORE} : Nom affiché pour le lien *Lire la suite* sur chaque article (si activé dans le fichier de configuration)
  * ${RSS\_FEED\_NAME} : Nom pour votre flux RSS. Ceci sera montré aux utilisateurs qui souscrivent à votre RSS. Par exemple *Flux RSS de mon premier blog*.
  * ${SEARCHBAR} : Affichera une barre de recherche ici. Ceci fonctionne si la barre de recherche est activée dans le fichier de configuration.
  * ${SEARCH\_BAR\_BUTTON\_NAME} : Nom affiché pour le bouton de recherche. Par exemple *Rechercher*.
  * ${SEARCH\_BAR\_CONTENT} : Texte affiché dans la barre de recherche. Par exemple *Recherche...*.
  * ${SHORT\_DATE} : Date utilisant le format court de date. (variable SHORT\_DATE\_FORMAT dans le fichier de configuration makefly.rc) sur la page de la liste des articles. Par exemple *11/2012*.
  * ${SIDEBAR} : Ajoute un panneau latéral ici si activé dans le fichier de configuration et si vous donnez quelques liens dans le fichier **special/sidebar.md**.
  * ${SIDEBAR\_CONTENT} : Le contenu du panneau latéral sera affiché ici.
  * ${TAGDIR\_NAME} : Nom du répertoire de mots-clés. Par exemple *motscles*. Ceci permet un meilleur référencement.
  * ${TAGDIR\_INDEX} : Nom du fichier index pour les mots-clés. Exemple : *index.html*.
  * ${TAGLINK} : Lien absolu vers un mot-clé. Par exemple : *http://mon.domaine.tld/motscles/mon_mot_cle.html*.
  * ${TAGLIST\_CONTENT} : Contenu de la liste des mots-clés. Une liste de mots-clés.
  * ${TAGNAME} : Nom d'un mot-clé donné. Par exemple *mon_mot_cle*.
  * ${TAG\_LIST\_TITLE} : Titre de la liste des mots-clés. Ceci est le nom affiché sur le lien qui redirige vers la liste des mots-clés. Par exemple *Liste de mots-clés*.
  * ${TAG\_NAME} : Nom d'un mot-clé. Identique à la variable TAGNAME (FIXME: WTF?)
  * ${TAG\_PAGE} : Nom réel d'une page. Par exemple avec un mot-clé nommé *Mon mot clé*, cela sera *mon_mot_cle.html*.
  * ${TAG\_TITLE} : Titre du mot-clé. Par exemple *mon_mot_cle*.
  * ${TITLE} : Titre de la page courante. Par exemple *Accueil*, *Liste des mots-clés*, *Mon premier article*, etc.
  * ${THEME\_IS} : Phrase qui est utilisée pour expliquer le thème choisi. Par exemple *Le thème de cette page est : *.

Ces variables sont données dans le fichier **Makefile** dans plusieurs sections. Donc vous avez probablement à mettre à jour le Makefile pour en ajouter plusieurs autres.

## Les fichiers de langue

Dans Makefly vous pouvez adapter du contenu dans votre langue natale. Pour cela vous avez à remplir quelques fichiers dans le répertoire **lang** (variable LANGDIR).

### Fichiers existants

Fichiers disponibles : 

  * translate.en
  * translate.fr

Vous pouvez voir que 2 fichiers existent, l'un pour la traduction anglaise (**en**), l'autre pour la traduction **fr**ançaise.

Si vous voulez ajouter le votre, crééez un autre fichier nommé translate.**VOTRE\_CODE\_PAYS**. Par exemple, pour la traduction italienne, crééez le fichier nommé **translate.it**.

Vous pouvez aussi utiliser le fichier **translate.en** comme premier support pour savoir combien de mots vous avez à traduire.

### Format de fichier langue

Le format de fichier de langue est similaire à celui des fichiers DB :

    UNE_VARIABLE = la traduction de cette variable

Par exemple : 

    HOME_TITLE = Accueil

### Mot existants à traduire

Au moment où j'écrivais cette documentation, voici les mots disponible à la traduction (et leur variable) : 

  * HOME\_TITLE (Accueil)
  * POST\_LIST\_TITLE (Liste des articles)
  * TAG\_LIST\_TITLE (Liste des mots-clés)
  * TAG\_TITLE (Mot(s)-clé(s))
  * PERMALINK\_TITLE (lien permanent)
  * POWERED\_BY (Propulsé par)
  * POSTED (Publié)
  * ABOUT\_TITLE (À propos)
  * SOURCE\_LINK\_NAME (Sources disponibles sur)
  * SOURCE\_LINK\_TITLE (Aller sur la page d'accueil Makefly sur gitorious)
  * THEME\_IS (Le thème est : )
  * LINKS\_TITLE (Liens)
  * READ\_MORE (Lire la suite)
  * SEARCH\_BAR\_CONTENT (Recherche)
  * SEARCH\_BAR\_BUTTON\_NAME (Rechercher)
  * AUTHOR\_LABEL (Rédacteur)

En utilisant les templates, vous pouvez facilement ajouter du texte et leur traduction dans plusieurs thèmes.

## Outils

Makefly est livré avec quelques outils pour être plus utilisable. Ces outils sont mis dans le répertoire **tools**.

### create_post.sh

Script qui permet de vous aider à créer de nouveaux articles. Un genre d'interface utilisateur légère en mode console.

Ceci est utile si aucune interface n'existe pour créer des articles dans Makefly, ce qui, je vous le rappelle, n'est pas le but de Makefly. Ce dernier compile simplement quelque fichiers pour créer un joueb (JOUrnal wEB, blog). Pour créer ces fichiers, vous avez besoin d'une interface utilisateur.

### install.sh

Script qui permet de copier le contenu du répertoire **pub** dans celui de votre choix. Par défaut le dossier **public_html** situé dans votre dossier *home*.

Cette méthode d'*install*ation n'est pas intégrée dans Makefly directement parce qu'il peut être dangeureux d'écrire par dessus des fichiers existants. Mais vous pouvez avoir le même effet avec la méthode *publish* en utilisant `pmake publish` et en utilisant le script **publish.sh**.

### populate_makefly.sh

Script de développement qui permet de peupler Makefly en créant quelques articles. Ça utilise le script **create\_post.sh** pour fonctionner.

### publish.sh

Ce script donne des commandes à exécuter après avoir produit votre joueb (JOUrnal wEB, blog). Ceci permet de le publier sur un serveur distant via le protocole SSH ou de synchroniser votre dossier vers un autre. Ceci est expliqué dans la documentation UTILISATEUR, donc pour plus d'information, lisez **Publier le résultat sur le web** dans la documentation UTILISATEUR.

### flush.sh

Ce script **supprime** tout les fichiers SRC et DB. Donc pour l'utiliser : 

    cd tools && ./flush.sh && cd ..

écrasera tout les fichiers SRC et DB.

### Ce qui peut être fait avec tout ça

#### Regénérer le blog et l'installer dans le dossier cible

Quand je dévelope certaines fonctionnalités, j'ai pour habitude de regénérer tout le blog. Pour cela j'utilise :

    cd makefly
    pmake clean && pmake && cd tools && ./install.sh && cd ..

Cela va aller dans le dossier *makefly* puis nettoyer les fichiers, regénérer le blog, aller dans le dossier *tools*, lancer le script *install.sh* puis revenir dans le dossier *makefly*.

#### Regénérer les articles

Il peut être utile de regénérer tout les articles. Ce que j'utilise : 

    cd tools/ && ./flush.sh && ./populate_makefly.sh && cd ..

On va dans le répertoire *tools*, on supprime tout les articles, puis on les recrée.

Faites attention, cela détruira tout les articles !

## Meilleures pratiques

### Ajouter une fonctionnalité

Si vous ajoutez une fonctionnalité : 

  * complétez le fichier **Changelog** avec un texte bref pour expliquer ce qui a été changé/amélioré/corrigé
  * complétez la **doc**umentation pour mettre à jour l'état de Makefly
  * n'oubliez pas de parfaire les fichiers de langue dans le dossier **lang** si vous ajoutez du texte dans les templates !
  * si vous ajoutez quelques VARIABLES nécessaires qui peuvent être changées par l'utilisateur, ajoutez les dans le fichier **makefly.rc.example**

### Personnalisez les templates

Si vous ajoutez du texte dans un template, vous devez ajouter quelques variables pour les mots à traduire. Vous devez également ajouter ces variables dans le dossier de traduction *lang*. Complétez aussi cette documentation.

### Erreurs

#### Vous avez rencontré une erreur et l'avez résolue ?

Ajoutez vos messages d'erreurs et leurs solutions dans le fichier **doc/KNOWN\_ISSUES.md** !

#### Vous avez rencontré un problème et ne l'avez pas résolu ?

Allez sur la [page github de Makefly](https://github.com/blankoworld/makefly/issues "Aller sur la page d'erreur du projet Makefly sur Github") et ajoutez une nouvelle issue avec une erreur détaillée :

  * où vous avez rencontré le problème
  * votre fichier de configuration
  * comment reproduire le bug
  * quelle message d'erreur vous rencontrez

## Idées

Vous avez une idée pour améliorer Makefly ? Ajoutez là dans le fichier **IDEAS**.

## Un bug ?

Aller sur la [page github de Makefly](https://github.com/blankoworld/makefly/issues "Issue pour Makefly sur Github") et créez une nouvelle issue ou bien ajoutez votre issue dans le fichier **TODO**.

