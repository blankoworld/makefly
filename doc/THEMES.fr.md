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

## Structure du template

Dans ${PROJECTNAME} la structure des templates n'est pas complexe. Mais vous devez savoir comment cela fonctionne pour comprendre les possibilités qu'elle offre.

### Liste rapide des fichiers nécessaires

Voici une description courte de chaque élément de la structure. Notez qu'aucune entête/enqueue n'est requise pour ces templates. Ce qui veut dire que le début de chaque page est **header.tmpl** et la fin de chaque page est **footer.tmpl**, à l'exception des flux RSS qui utilisent **feed.header.rss** et **feed.footer.rss**.

Éléments : 

  * **article.index.tmpl** : la structure d'**un** billet sur la page d'accueil
  * **article.tmpl** : contenu d'un billet donné du blog
  * **config.mk** : contient la configuration de votre template. Le nom, le nom du fichier CSS, le nom du fichier CSS secondaire, si la barre latérale est obligatoire, etc.
  * **element.tmpl** : courtes informations à propos d'un billet qui sera intégré dans une liste de billets.
  * **header.tmpl** : entête de **toutes** les pages du blog. Devrait contenir les premières balises ```<html>```, ```<head>``` et ```<body>```.
  * **footer.tmpl** : enqueue de **toutes** les pages du blog. Devrait contenir les dernières balises ```</body>``` et ```</html>```.
  * **menu.about.tmpl** : lien supplémentaire du menu principal vers la page d'à propos
  * **menu.search\_bar.tmpl** : lien supplémentaire du menu principal pour afficher une barre de recherche
  * **pagination.tmpl** : code HTML utilisé pour faire une pagination sous la liste des billets
  * **post.footer.tmpl** : dernier code HTML qui sera affiché après la liste de tous les billets
  * **post.index.tmpl** : premier code HTML à être affiché avant la liste de tous les billets
  * **read\_more\_link.tmpl** : lien "Lire la suite" qui sera affiché sous chaque billet de la page d'accueil. Seulement disponible si MAX\_POST\_LINES est utilisé.
  * **sidebar.tmpl** : code HTML qui sera utilisé à la place du mot spécifique ${SIDEBAR} dans les templates header/footer. Devrait contenir le mot spécifique **${SIDEBAR\_CONTENT}**.
  * **static** [dossier] : dossier qui contient les fichiers qui doivent être présent dans le résultat. Par exemple quelques images, fichiers javascript, etc. Ne pas mettre les fichiers CSS ici (mais pas interdit de le faire) puisque nous avons un dossier *style* pour cela. Vous devez savoir que les fichiers contenus dans le dossier *static* seront complétés pendant le processus de compilation. Mais ceci n'est seulement fonctionnel que pour la variable **BLOG\_URL**.
  * **style** [dossier] : liste des fichiers CSS possibles du template. De la manière dont ${PROJECTNAME} est conçu, vous pouvez faire une feuille de style pour l'apparence principale, puis ajouter un fichier CSS pour chaque version de votre template. Par exemple un CSS qui rend votre template rouge. Un autre qui rend le template bleu, etc. Se configure à l'aide de CSS\_COLOR\_FILE dans le fichier **config.mk**.
  * **tagelement.tmpl** : le détail d'un mot-clé à afficher sur la liste des mots-clés
  * **taglink.tmpl** : les informations d'un mot clé seul qui sera affiché sur chaque billet
  * **tags.tmpl** : la page de la liste des mots-clés. Devrait contenir le mot spécifique **${TAG\_LIST\_TITLE}**.

Faites attention car d'autres fichiers sont situés dans le répertoire principale des templates pour des traitements spécifiques. Vous ne devriez pas les créer dans votre template mais vous devez les connaître : 

  * **eli\_content.tmpl** : code HTML de l'historique des statuts de l'application ELI
  * **eli.css** : CSS pour la fonctionnalité ELI
  * **eli\_css\_declaration.tmpl** : code HTML utilisé pour déclarer le CSS d'ELI sur votre blog
  * **eli\_declaration.tmpl** : code HTML qui déclare le javascript d'ELI dans notre blog. Principalement localisé dans l'enqueue.
  * **eli.js** : Code javascript utilisé par la fonctionnalité ELI
  * **empty.file** : un fichier vide (certaines applications sont très curieuses, celle-ci n'échappe pas à la règle)
  * **feed.footer.rss** : code XML de l'enqueue du flux RSS
  * **feed.header.rss** : code XML de l'entête du flux RSS
  * **isso.tmpl** : code HTML pour chaque billet pour la fonctionnalité de commentaire nommée ISSO. Remplace la variable ISSO\_CONTENT dans les templates.
  * **isso.css** : CSS utilisé pour la fonctionnalité ISSO
  * **isso\_css\_declaration.tmpl** : déclaration HTML du CSS utilisée dans l'entête pour le système de commentaire ISSO. Remplace la variable ISSO\_CSS\_DECLARATION dans les templates.
  * **isso\_declaration.tmpl** : code HTML qui déclare le javascript d'ISSO dans votre blog. Principalement localisé dans le pied de page. Remplace la variable ISSO\_SCRIPT dans les templates.
  * **isso.short.tmpl** : habituellement utilisé sur la page d'accueil pour seulement afficher le nombre de commentaire en utilisant le système de commentaire ISSO. Remplace la variable ISSO\_SHORT dans les templates.
  * **isso.extended.tmpl** : habituellement utilisé sur chaque billet pour afficher les commentaires utilisant le système de commentaire ISSO. Remplace la variable ISSO\_EXTENDED dans les templates.

### Plus d'explications

Premièrement ${PROJECTNAME} délivre le blog de la manière suivante : 

  * une page d'accueil
  * une liste de billets
  * une liste de mots-clés
  * une page d'à propos (optionnel)
  * quelques pages statiques (l'utilisateur ajoute lui-même les pages statiques qu'il veut)
  * une page pour chaque billet
  * une page pour chaque mot-clé

Donc une page est composée de : 

  * une entête (fichier **header.tmpl**)
  * un contenu (contenus variés : liste de billets, liste de mots-clés, un mot-clé, un billet, une page d'accueil, une d'à propos, etc.)
  * une enqueue (fichier **footer.tmpl**)

Si vous le comprenez correctement, vous avez donc besoin de 2 fichiers : 

  * header.tmpl (le début de TOUTES les pages)
  * footer.tmpl (la fin de TOUTES les pages)

Ainsi, comment fonctionne le contenu ?

Le contenu est ainsi fabriqué au regard de la page que nous voulons.

Donc pour les **billets** vous avez **article.tmpl** qui décrit chaque page simple d'un billet, mais **article.index.tmpl** décrit le code utilisé pour un billet qui sera affiché sur la page d'accueil.
Tout les billets sont listés sur une page des billets. Le template pour cette liste est **post.index.tmpl** (début) et **post.footer.tmpl** (fin).
Chaque courte description d'un billet de cette liste est décrit dans **element.tmpl**.
Si vous activez la numérotation des billets sur cette page, vous aurez de la pagination. Le template pour cela est disponible ici : **pagination.tmpl**.

Chaque billet dans la page d'accueil peut avoir un lien *Lire la suite* qui est décrit ici : **read\_more\_link.tmpl**.

Pour les **mots-clés** vous avez **taglink.tmpl** qui contient chaque lien vers un mot-clé utilisé par un billet. La page de la liste des mots-clés est disponible ici : **tags.tmpl**. Chaque mot-clé affiché sur cette page est disponible ici : **tagelement.tmpl**.

Vous pouvez créer une sorte de menu principal affiché sur chaque page, appelé *panneau latéral*. Le template correspondant est **sidebar.tmpl** et contient un mot spécifique nommé **${SIDEBAR\_CONTENT}** qui intègre le contenu du fichier *special/sidebar.md*.

À FAIRE : créer une image pour afficher la structure

### Le fichier config.mk

Chaque template donne un fichier **config.mk**. C'est la carte de visite de votre template.

Le fichier contient quelques informations obligatoires comme : 

  * **CSS\_NAME**: nom du template. Par exemple *Minisch 2.4*
  * **CSS\_FILE**: fichier CSS principal du template. Il devrait être contenu dans le dossier '*template/votreTemplate/style/*'. Exemple : *main\_minisch.css*
  * **CSS\_COLOR\_FILE**: Couleurs particulières du template. Ceci veut dire que vous pouvez avoir plus qu'une couleur pour votre template en donnant simplement plusieurs fichiers CSS. All les fichiers CSS doivent être placés dans le dossier '*template/votreTemplate/style/*'. Par exemple : *color\_minisch\_light.css*

et quelques autres optionnelles : 

  * **ISSO\_CSS**: CSS additionnel utilisé pour le sytème de commentaire d'ISSO. Devrait être placé dans le dossier **template/yourTemplate**. Exemple : *commentairesIsso.css*
  * **SIDEBAR**: Si la valeur est 1 alors le panneau latéral est obligatoire pour votre template. Ce qui implique que votre template a été conçu pour être seulement utilisé avec le panneau latéral.
  * **ISSO\_SHORT**: template utilisé pour la variable ISSO\_SHORT. En fait, cela remplace la variable ISSO\_SHORT par le contenu de ce template.

**NB** : Ces informations doivent être ajoutées comme ça : 

    VAR = valeur

Vous pouvez trouver quelques exemples de fichier *config.mk* dans le dossier **template**. N'hésitez pas à jeter un œil dans ce dossier. Vous apprendrez énormément !

----

## Valeurs de remplacement

Dans ${PROJECTNAME} vous avez quelques mots spécifiques dans les templates qui sont remplacés par quelques valeurs. Par exemple le mot **${HOME\_TITLE}** sera affiché comme **Accueil**. Donc quand vous les voyez dans les templates, ou que vous les ajoutez dans les templates, vous savez que ce mot spécifique sera remplacé.

À noter que vous pouvez facilement trouver ces mots spécifiques dans un template car ils comment avec "**${**" et finissent avec "**}**". Ceci est la première règle.

La seconde est celle-ci : les mots spécifiques doivent être en MAJUSCULES.

Dans cette section vous en saurez plus à propos de ces valeurs de remplacement, comment les trouver, desquelles vous disposez, etc.

### Valeurs de traduction

Certains mots spécifiques peuvent se trouver ici : *lang/translate.fr*.

Dans ce fichier, chaque premier mot en majuscule sur chaque ligne est un mot spécique qui sera remplacé dans le résultat final.

Astuce : Vous pouvez ajouter vos propres mot spécifiques et leurs valeurs. Et ils seront utilisés pour les templates (si vous les ajoutez aux templates).

### Valeurs de configuration

Il y a certains mots spécifiques qui viennent du fichier de configuration (${PROJECTNAMELOWER}.rc). Vous pouvez donc lire la documentation officielle, spécifiquement la section sur le fichier ${PROJECTNAMELOWER}.rc pour savoir pour quoi ils sont utilisés.

  * **BLOG\_CHARSET**
  * **BLOG\_TITLE**
  * **LANG** (provient de BLOG\_LANG dans le fichier ${PROJECTNAMELOWER}.rc)
  * **BLOG\_DESCRIPTION**
  * **BLOG\_SHORT\_DESCRIPTION**
  * **BLOG\_URL** (très utilisé dans tout le blog)
  * **BLOG\_AUTHOR**
  * **BLOG\_COPYRIGHT**
  * **RSS\_FEED\_NAME**

Astuce : Contrairement à la section précédente à propos du fichier de traduction, vous ne pouvez pas ajouter de mot spécifique personnel dans le fichier ${PROJECTNAMELOWER}.rc puisqu'ils sont utilisés d'une manière spéciale.

### Fournis par le moteur de ${PROJECTNAME}

Pour faire votre template vous avez besoin de savoir et comprendre certains mots spécifiques. Ils sont fournis par le moteur de ${PROJECTNAME} et permettent de concevoir de nouveaux templates pour votre blog.

Voici une liste non-exhaustive. Si vous en trouvez une nouvelle non listée ici, merci de nous contacter ou de créer un nouveau ticket sur [notre système de gestion de tickets](${GITPROJECT}issues).

  * **ABOUT\_INDEX**: Nom réel du fichier HTML de la page d'*À propos*. Par exemple : apropos.html. Si vous voulez un lien vers la page d'à propos, vous avez juste à faire ceci : "*${BLOG\_URL}/${ABOUT\_INDEX}*".
  * **ABOUT\_LINK**: Ajout un lien pour un menu au regard du template *menu.about.tmpl*. Ceci fonctionne seulement si la page d'à propos a été activé par sa présence.
  * **BODY\_CLASS**: Le moteur est configuré pour changer cette valeur au regard de la page générée. Par défaut la valeur est "single" pour toutes les pages. Puis vous avez : 
    * single (valeur par défaut)
    * about: pour signifier que la page entière est une page d'à propos
    * tags: pour dire que la page entière est une liste de mots-clés
    * home: page d'accueil
    * page: vous êtes dans une page statique (fonctionnalité des pages statiques)
  * **CONTENT**: Contenu d'un billet (quand vous éditez les templatees des billets)
  * **CSS\_COLOR\_FILE**: nom du fichier CSS secondaire (dans le dossier du template) utilisé comme d'une feuille de style supplémentaire. Souvent utilisé pour un CSS qui donne des couleurs (pour permettre à l'utilisateur de choisir parmi quelques fichiers de couleurs CSS). Défini dans **config.mk** de votre template.
  * **CSS\_FILE**: nom du fichier CSS principal.
  * **CSS\_NAME**: Nom affiché quand l'utilisateur choisi un template. Défini dans **config.mk** de votre template.
  * **DATE**: Date utilisant le format de DATE\_FORMAT. La date affiché change en fonction du billet dans lequel vous êtes.
  * **DATETIME**: Date utilisant le format ISO8601 pour être compatible avec la balise *time* d'HTML5. Le datetime affiché change en fonction du billet dans lequel vous êtes.
  * **POST\_TYPE**: Type que l'utilisateur a rempli quand il crée le billet. Ceci permet de l'utiliser dans le CSS et les class afin que chaque article ait une autre couleur par exemple.
  * **POSTDIR\_INDEX**: Nom de la page d'index du dossier contenant les billets. Par exemple *index.html*.
  * **POSTDIR\_NAME**: Nom du dossier des billets. Par exemple *article*. Ceci permet d'avoir un meilleur référencement web pour votre langage.
  * **POST\_AUTHOR**: Auteur du billet
  * **POST\_ESCAPED\_TITLE**: Titre du billet sans espaces. Principalement u tilisé pour les systèmes de commentaires. Exemple de résultat : **mon\_premier\_billet**.
  * **POST\_FILE**: Nom du fichier du billet. Exemple : **mon\_premier\_billet.html**.
  * **POST\_TITLE**: Titre du billet. Par exemple : **Mon premier billet**.
  * **SEARCHBAR**: Ajoute une barre de recherche au regard du fichier de template **menu.search_bar.tmpl**. Ne fonctionne seulement si la barre de recherche est activé dans le fichier de configuration.
  * **SHORT\_DATE**: Date utilisant le format de date court (SHORT\_DATE\_FORMAT du fichier de configuration ${PROJECTNAMELOWER}.rc) pour la page de la liste des billets.
  * **SIDEBAR**: Ajoute un panneau latéral à cette endroit en fonction du template *sidebar.tmpl*. Ne fonctionne seulement si le panneau latéral est activé dans le fichier de configuration (${PROJECTNAMELOWER}.rc) ou dans le fichier de configuration du template (config.mk).
  * **SIDEBAR\_CONTENT**: Ajoute le contenu du fichier **special/sidebar.md**.
  * **TAGDIR\_NAME**: Nom du répertoire des mots-clés. Par exemple *motcle*. Ceci permet un meilleur référencement web pour votre langage.
  * **TAGDIR\_INDEX**: Nom du fichier d'index du répertoire des mots-clés. Exemple : **index.html**.
  * **TAGLIST\_CONTENT**: Liste de tous les mots-clés de votre blog.
  * **TAG\_LINKS\_LIST**: Liste des mots-clés pour un billet donné.
  * **TAG\_NAME**: Nom du mot-clé. Par exemple : **Mon premier mot-clé**.
  * **TAG\_PAGE**: Nom du fichier du mot-clé. Par exemple : *mon\_premier\_mot\_cle.html*.
  * **TITLE**: Titre de la page courante. Par exemple : *Accueil*, *Liste des mots-clés*, *Mon premier billet*, etc.

