# ${PROJECTNAME}

[English version](${PROJECTURL}documentation.html.en) (version originale en anglais)

[Site web officiel](${PROJECTURL} "Se rendre sur la page principale du site web")

## Description

${PROJECTNAME} est un moteur de blog statique rapide et l&eacute;ger en ligne de commande qui s'appuie sur le [format Markdown](http://daringfireball.net/projects/markdown/syntax "D&eacute;couvrir le format Markdown") pour la r&eacute;daction et le rendu de ses articles.

Il s'articule autour d'une page d'accueil, d'une liste d'articles, d'une liste de mots-cl&eacute;s et d'une page d'&agrave; propos.

Il propose les fonctionnalités suivantes : 

  * th&egrave;mes
  * flux RSS
  * r&eacute;f&eacute;rencement pour chaque page
  * tags
  * page permanentes/statiques
  * antidatage (poster un article à une date diff&eacute;rente)
  * traductions
  * syst&egrave;me de commentaire
  * copie de sauvegarde
  * script de publication &agrave; distance
  * cr&eacute;ation rapide de nouveaux th&egrave;mes
  * migration depuis Nanoblogger (Cf. section **Migration depuis Nanoblogger**)

**Note** : ${PROJECTNAME} n'est pas destiné à créer, éditer ou supprimer des billets, même s'il propose un script pour faire un nouveau billet, il est conseillé de se tourner vers des projets tierces tels qu'[Hymby](https://github.com/blankoworld/hymby) (en développement).

## Installation

### En rapide

En quelques &eacute;tapes voici comment installer la derni&egrave;re version (en d&eacute;veloppement) : 

    sudo apt-get install lua5.1 lua-filesystem
    curl ${GITPROJECT}archive/master.zip
    unzip master.zip
    cd makefly-master
    cp ${PROJECTNAMELOWER}.rc.fr.example ${PROJECTNAMELOWER}.rc
    ./${PROJECTNAMELOWER} clean && ./${PROJECTNAMELOWER} compile

Vous devriez avoir une liste d'actions effectu&eacute;es sur votre machine. Et le r&eacute;sultat se trouve dans le dossier **pub**.

### En d&eacute;taill&eacute;

Si vous avez r&eacute;ussi l'&eacute;tape **En rapide** avec succ&egrave;s, passez directement &agrave; la section **Utilisation**.

#### D&eacute;pendences

${PROJECTNAME} d&eacute;pend des &eacute;l&eacute;ment suivants : 

  * lua 5.1 ou plus r&eacute;cent
  * lua-filesystem

Ainsi utilisez le gestionnaire de paquet de votre distribution pour les installer. Par exemple sur Debian et d&eacute;riv&eacute;es, ce serait : 

    apt-get install lua5.1 lua-filesystem

Pour d'autres distributions, regardez du c&ocirc;t&eacute; des forums, d'IRC et/ou de la communaut&eacute; de votre distribution. Ils seront heureux de vous aider.

#### Autre m&eacute;thode pour les dépendances

Si votre distribution ne propose pas le paquet *lua-filesystem*, vous pouvez tenter d'installer **luarocks** puis installer les d&eacute;pendances de la mani&egrave;re suivante : 

    sudo apt-get install luarocks
    luarocks install lua-filesystem

Et le tour est jou&eacute; !

#### Installation

Vous avez le choix entre : 

  * [la version en cours de d&eacute;veloppement](${GITPROJECT}archive/master.zip "T&eacute;l&eacute;charger la derni&egrave;re version en cours de d&eacute;veloppement")
  * [la version stable 0.3 FR (recommand&eacute;e)](${PROJECTURL}${PROJECTNAMELOWER}_0.3_fr.zip "T&eacute;l&eacute;charger la version stable 0.3 FR")

Il suffit donc de :

  * r&eacute;cup&eacute;rer la version choisie
  * extraire le contenu dans un dossier de votre ordinateur

Et ${PROJECTNAME} est install&eacute;.

#### Configuration

##### Pour la version stable

Aucune configuration particuli&egrave;re n'est requise. V&eacute;rifiez que le fichier **${PROJECTNAMELOWER}.rc** existe bien. Le cas &eacute;ch&eacute;ant copiez le fichier **${PROJECTNAMELOWER}.rc.fr.example** ou renommez le en **${PROJECTNAMELOWER}.rc**.

##### Pour la version en cours de d&eacute;veloppement

La premi&egrave;re fois que vous utilisez ${PROJECTNAME} vous n'avez aucun fichier de configuration. Un exemple de fichier de configuration est disponible dans **${PROJECTNAMELOWER}.rc.fr.example**. Copiez le vers **${PROJECTNAMELOWER}.rc** pour permettre &agrave; ${PROJECTNAME} de fonctionner.

##### Plus d'infos

Pour plus d'informations, lisez la section **Le fichier de configuration ${PROJECTNAMELOWER}.rc**.

## Utilisation

**Par défaut le contenu du blog se trouve dans le r&eacute;pertoire pub**.

### En rapide

Quelques commandes utiles :

  * **./${PROJECTNAMELOWER} compile** : G&eacute;n&eacute;re le blog. Disponible dans le r&eacute;pertoire **pub**
  * **./${PROJECTNAMELOWER} help** : Affiche les commandes possibles
  * **./${PROJECTNAMELOWER} add** : Créer un article et compl&eacute;ter ses infos principales
  * **./${PROJECTNAMELOWER} clean** : Vide compl&egrave;tement le contenu du r&eacute;pertoire final et vide le *cache* de ${PROJECTNAME}

### Cr&eacute;er du contenu

#### Cr&eacute;er un nouvel article

Utilisez la commande suivante :

    ./${PROJECTNAMELOWER} add

et r&eacute;pondez &agrave; toutes les questions pos&eacute;es. Cela g&eacute;n&egrave;rera les fichiers n&eacute;cessaires pour ${PROJECTNAME}.

Il est &agrave; noter que ${PROJECTNAME} utilise [le format markdown](http://daringfireball.net/projects/markdown/ "En savoir plus sur le format Markdown") pour ses articles.

**N'oubliez pas d'&eacute;diter le fichier renseign&eacute; par la commande './${PROJECTNAMELOWER} add'.**

#### Contenu statique (photos, vidéos, fichiers PDF, etc.)

Parfois on souhaite partager des fichiers tels quels, que ce soit des images, des démonstrations, des présentations, etc. Il existe pour cela le dossier *static*. Tout fichier déposé dans ce dossier sera copié dans le dossier de destination.

Exemple : 

  * Nous possédons le fichier *static/makefly.svg*
  * Après compilation du blog, nous avons un fichier *pub/makefly.svg*

Cela fonctionne donc pour tout type de fichier contenu dans ce dossier.

#### Pages statiques

Parfois on aimerait ajouter à son blog quelques pages dites **statiques**. Par exemple les mentions légales.

Pour cela, créez le dossier *pages* à la racine de votre projet ${PROJECTNAME}. Puis ajoutez des fichiers contenant du texte au format Markdown dont l'extension est **.md**.

Exemple : 

  * Nous créeons le fichier *pages/mentions.md*
  * Après compilation du blog, nous avons un fichier *pub/mentions.html*

Ceci vous permet de créer un site web avec des pages statiques.

Note 1 : Le nom de la page résultante sera en minuscule et remplacera les espaces par des espaces soulignés (le caractère *_*).

Note 2 : Aucun lien dynamique ne sera fait vers la page statique. Vous devrez modifier vous-même le template pour ajouter un lien vers la page statique. Cf. la section *Structure du template*.

Pour en savoir plus je vous invite à [lire la documentation sur la création des pages statiques](${PROJECTURL}/static.html.fr "En lire d'avantage sur la création d'un site entièrement statique sans la fonction blog.")

#### Le dossier 'special'

Ce dossier nomm&eacute; **special** peut contenir certains fichiers que vous devrez cr&eacute;er pour activer une fonctionnalit&eacute; : 

  * *about.md* : Contient le contenu d'une page d'&agrave; propos au sujet de votre site. Cela va ajouter une entr&eacute;e dans le menu principal du site (si votre th&egrave;me le supporte).
  * *sidebar.md* : Ajoute une barre lat&eacute;rale sur votre site. Le th&egrave;me doit supporter cette fonction.
  * *introduction.md* : Affiche le contenu de ce fichier comme introduction sur l'ensemble de vos pages. Varie selon le th&egrave;me choisi.
  * *footer.md* : Affiche le contenu de ce fichier comme d'un pied de page sur l'ensemble de vos pages. Varie selon le th&egrave;me choisi.

### G&eacute;n&eacute;rer le blog

Apr&egrave;s avoir cr&eacute;e quelques articles, faites simplement : 

    ./${PROJECTNAMELOWER} compile

Ceci g&eacute;n&egrave;rera un blog ${PROJECTNAME} dans le dossier **pub** (r&eacute;pertoire par d&eacute;faut).

## Publier le r&eacute;sultat sur le web

Le r&eacute;sultat de ${PROJECTNAME} est compatible avec tous le serveurs HTML. En effet vous pouvez probablement utiliser le r&eacute;sultat sur le site web de votre h&eacute;bergeur. Il suffit d'envoyer le contenu du r&eacute;pertoire **pub** dans celui de votre h&eacute;bergeur.

### Sur un serveur web

Si vous lancez ${PROJECTNAME} sur votre propre serveur ou tr&egrave;s certainement sur le serveur de votre h&eacute;bergeur, vous pourrez utiliser l'installation automatis&eacute;e. Lancez simplement la commande suivante : 

    ./${PROJECTNAMELOWER} install

...et cela copiera tous les fichiers dans le r&eacute;pertoire **~/public\_html**.

**ATTENTION**: Cela supprimera tous les fichiers contenus dans le dossier *public\_html* !

**Note**: Vous pouvez personnaliser la destination en changeant le fichier **${PROJECTNAMELOWER}.rc** et plus particuli&egrave;rement la ligne suivante : 

    INSTALLDIR=${HOME}/public_html

Relancez ensuite la commande `./${PROJECTNAMELOWER} refresh && ./${PROJECTNAMELOWER} install` pour recompiler le blog.

### Vers un ordinateur distant : la commande *publish*

Pour publier votre blog vers une machine distante, vous devez : 

  * avoir un acc&egrave;s SSH &agrave; la machine distante
  * avoir le programme rsync
  * configurer la variable **PUBLISH\_DESTINATION** dans le fichier **${PROJECTNAMELOWER}.rc**
  * lancer la commande **publish**

C'est tout!

&Agrave; noter que la variable **PUBLISH\_DESTINATION** ressemble &agrave; : 

    monUtilisateurDistant@domaineDistant.tld:/mondossierhome/dossier_public

Une fois cette variable renseign&eacute;e dans le fichier **${PROJECTNAMELOWER}.rc**, lancez simplement : 

    ./${PROJECTNAMELOWER} publish

Pour les d&eacute;velopeurs : Vous pouvez aussi modifier le fichier **tools/publish.sh** et changer le contenu du script par votre propre code.

## Cr&eacute;er un nouveau th&egrave;me

Afin de vous faciliter la tâche de cr&eacute;ation d'un nouveau th&egrave;me, vous pouvez utiliser la commande suivante :

    ./${PROJECTNAMELOWER} theme myTheme

o&ugrave; **myTheme** est &agrave; remplacer par le nom de votre th&egrave;me.

Note : Ceci utilise le th&egrave;me nomm&eacute; *Base* comme exemple.

Pour les concepteur de thèmes jetez un œil ici: [Documentation sur les thèmes](${PROJECTURL}/themes.html.fr "En savoir plus sur la manière de faire un template pour ${PROJECTNAME}").

## Traduction

Une fa&ccedil;on simple de traduire ${PROJECTNAME} dans votre langage est de copier le fichier **lang/translate.en** dans un autre fichier. Par exemple, pour le Fran&ccedil;ais (avec le code fr), vous pouvez copier **lang/translate.en** en **lang/translate.fr** et changez les valeurs. Puis changez simplement l'option *BLOG\_LANG* dans le fichier **${PROJECTNAMELOWER}.rc**.

## Sauvegardes

Peut-&ecirc;tre voudriez-vous sauvegarder les fichiers importants de ${PROJECTNAME} ? C'est possible via la **commande backup**. Lancez la simplement de cette mani&egrave;re : 

    ./${PROJECTNAMELOWER} backup

Requis : 

  * tar
  * gzip

Fichiers sauv&eacute;s : 

  * ${PROJECTNAMELOWER}.rc
  * le r&eacute;pertoire static
  * le r&eacute;pertoire special
  * le r&eacute;pertoire db
  * le r&eacute;pertoire src
  * le r&eacute;pertoire contenant le th&egrave;me choisi (par exemple *templates/default/*)

R&eacute;sultat : Ceci cr&eacute;era une *archive* nomm&eacute;e *YYYYmmdd-HM\_${PROJECTNAMELOWER}.tar.gz* (20120823-1735\_${PROJECTNAMELOWER}.tar.gz par exemple) dans le dossier **mbackup**. Vous pouvez ainsi sauvegarder votre ${PROJECTNAME} chaque jour.

### Astuce

Vous pouvez personnaliser (dans votre fichier **${PROJECTNAMELOWER}.rc**) :

  * le dossier de sauvegarde en utilisant l'option **BACKUPDIR**
  * le pr&eacute;fixe du fichier de sauvegarde en utilisant l'option **BACKUP\_PREFIX**
  * le suffixe du fichier de sauvegarde en utilisant l'option **BACKUP\_SUFFIX**
  * le format de date en utilisant l'option **BACKUP\_FORMAT**

## Jouer avec la ligne de commande

Sachant que ${PROJECTNAME} fonctionne de la manière suivante : 

    ./${PROJECTNAMELOWER} help

et utilise quelques fichiers de configuration comme **config** et **${PROJECTNAMELOWER}**.rc, on peut s'amuser avec quelques variables.

Par exemple : 

    LANG=en_US.UTF-8 ./${PROJECTNAMELOWER} help

Ceci permet de changer la langue de sortie en Anglais.

Ainsi vous disposez des variables suivantes : 

  * CURDIR : chemin du répertoire de ${PROJECTNAME}. Permet de lancer la compilation depuis un autre répertoire. Par défaut le répertoire courant.
  * LANGDIR : chemin du répertoire contenant les traductions. Par défaut le dossier **lang** du répertoire courant.
  * LANG : langue utillisée par la ligne de commande. Par exemple **en_US.UTF-8** ou **fr_FR.UTF-8**.
  * CONFIG : chemin du fichier de configuration par défaut de ${PROJECTNAME}. Par défaut le fichier **config** du répertoire courant.
  * RC_CONFIG : chemin du fichier de configuration de l'utilisateur. Par défaut le fichier **${PROJECTNAMELOWER}**.rc du répertoire courant.

L'ensemble de ces paramètres vous permettront de créer des scripts utilisant ${PROJECTNAME}.

## Sources

Les sources sont disponibles : 

  * [Sur github](${GITPROJECT})

## Documentation

Ce fichier est la documentation. Vous pouvez [le lire sur github](${GITPROJECT} "Lire la documentation sur Github") ou simplement g&eacute;n&eacute;rer un fichier HTML &agrave; l'aide de cette commande : 

    ./${PROJECTNAMELOWER} doc

## Astuces

### &Eacute;crire des billets en avance

Dans ${PROJECTNAME} vous pouvez &eacute;crire des billets en avance. Il suffit pour cela que le fichier de m&eacute;ta-donn&eacute;es de votre billet poss&egrave;de un timestamp sup&eacute;rieur &agrave; celui du moment o&ugrave; est g&eacute;n&eacute;r&eacute; le blog.

Par exemple nous sommes le 6 mars 2013, &agrave; 12:30, le timestamp est : 1362569400. Il faut que dans le dossier **db**, votre article ait un timestamp inf&eacute;rieur &agrave; celui d'aujourd'hui.

### &Eacute;crire directement le contenu de l'article &agrave; sa cr&eacute;ation

Utilisez juste la variable 'content' au d&eacute;but de la commande : 

    content="mon petit contenu" ./${PROJECTNAMELOWER} add

Ceci ajoutera "mon petit contenu" dans votre nouvel article.

### Disposer d'un service de commentaires

${PROJECTNAME} dispose d'un service gratuit en bêta test nommé [Rave Comment](http://rave.depotoi.re/) mis à disposition de ses utilisateurs.

Une fois enregistré, vous recevrez une adresse URL telle que : **rave.depotoi.re/monpseudo**.

Il suffit ensuite d'éditer le fichier ${PROJECTNAMELOWER}.rc et d'y modifier les variables suivantes : 

    ISSO = 1
    ISSO_URL = rave.depotoi.re/monpseudo

Vous aurez ainsi un système de commentaire sur votre site.

Note : les commentaires ne seront pas visibles sur votre machine. Seulement sur le site distant.

### [périmé] Ne pas perdre les commentaires quand on migre d'un vieux domaine &agrave; un nouveau

**Note** : cette astuce n'est **plus valable** pour la version 0.4 et suivante de ${PROJECTNAME}. Elle ne fonctionne que si vous utilisez JSKOMMENT.

Quand vous migrez de **vieux.domaine.tld** &agrave; **nouveau.domaine.tld**, les commentaires n'appara&icirc;tront plus.

Pour r&eacute;gler le probl&egrave;me, utilisez simplement la **commande migratefrom** : 

    ./${PROJECTNAMELOWER} migratefrom http://vieux.domaine.tld

Ceci va mettre &agrave; jour tout les anciens articles avec l'identifiant des vieux commentaires (votre vieux domaine) et les commentaires r&eacute;appara&icirc;tront.

## Le fichier de configuration ${PROJECTNAMELOWER}.rc

Voici quelques options que vous pouvez changer : 

  * BLOG\_TITLE : Titre de votre blog
  * BLOG\_SHORT\_DESC : Une courte description de votre blog
  * BLOG\_DESCRIPTION : Une description plus compl&egrave;te de votre blog
  * BLOG\_LANG : votre code langue. &Agrave; noter qu'un fichier lang/translate.VOTRE\_CODE\_LANGAGE doit exister. Par exemple si je configure ce param&egrave;tre &agrave; *fr*, un fichier *lang/translate.fr* doit exister !
  * BLOG\_CHARSET : votre configuration d'encodage. Doit ressembler &agrave; quelque chose comme **UTF-8** ou **ISO-8859-1**. Si vous ne savez pas ce que c'est, laissez la param&eacute;tr&eacute;e &agrave; *UTF-8*.
  * BLOG\_URL : adresse URL absolue de votre blog. Par exemple ${PROJECTURL}.
  * BLOG\_AUTHOR : Auteur principal du blog. Permet un r&eacute;f&eacute;rencement dans les moteurs de recherche.
  * BLOG\_COPYRIGHT : Copyright du blog. Permet un r&eacute;f&eacute;rencement dans les moteurs de recherche.

  * BLOG\_KEYWORDS : Mots-cl&eacute;s qui doivent appara&icirc;trent pour l'ensemble des pages du blog. Permet un r&eacute;f&eacute;rencement dans les moteurs de recherche.
  * RSS\_FEED\_NAME : Titre affich&eacute; dans le flux RSS.
  * MAX\_POST : Nombre maximum d'articles qui seront affich&eacute;s sur la page d'accueil.
  * MAX\_POST\_LINES : Nombre de lignes qui seront montr&eacute;es sur la page d'accueil. Si param&eacute;tr&eacute; &agrave; 0 ou inexistant dans le fichier *${PROJECTNAMELOWER}.rc*, alors les articles sont enti&egrave;rement montr&eacute;s.
  * DATE\_FORMAT : Format de la date affich&eacute;e pour chaque article. Lisez les pages du manuel *date* pour plus d'informations.
  * MAX\_PAGE : Nombre maximal d'articles qui devrait s'afficher sur la liste des articles. Si param&eacute;tr&eacute; &agrave; 0 ou inexistant du fichier *${PROJECTNAMELOWER}.rc*, alors une seule page sera faite avec tout les articles !
  * SHORT\_DATE\_FORMAT : Format court de la date. Sera utilis&eacute; sur la page de la liste des articles. Pour plus d'informations, lire les pages du manuel *date*.
  * INDEX\_FILENAME : Nom donn&eacute; &agrave; toutes les pages index. Par exemple avec **INDEX\_FILENAME = mainpage**, la liste des articles se nommera *mainpage.html*.
  * PAGE\_EXT : suffixe que toutes les pages auront. **NE PAS OUBLIER D'AJOUTER UN POINT AVANT LE SUFFIXE**. Par exemple avec **PAGE\_EXT = .html**, toutes les pages seront de la forme : *index.html*.
  * ABOUT\_FILENAME : Comme son nom l'indique, c'est le titre du fichier utilis&eacute; pour la page "&Agrave; propos". Si vous le param&eacute;trez &agrave; "apropos" par exemple, vous devez cr&eacute;er un fichier "apropos.md" dans le r&eacute;pertoire nomm&eacute; **special** afin de permettre  l'obtention d'une page d'&agrave; propos. Si vous le changez &agrave; *toto*, vous devez cr&eacute;er un fichier *toto.md* dans le dossier **special**.
  * POSTDIR\_NAME : Le nom que vous voudriez afficher dans l'URL quand un utilisateur se rend sur la page de la liste des articles. Par exemple, param&eacute;tr&eacute; &agrave; "mesarticles" : ${PROJECTURL}mesarticles/ affichera la liste de vos articles. Ceci est utile pour divers langages.
  * TAGDIR\_NAME : M&ecirc;me chose que pour le param&egrave;tre *POSTDIR\_NAME*, mais pour les mots-cl&eacute;s (tags) cette fois. Modifiez le en "motcle" par exemple et l'adresse suivante affichera la liste des mots-cl&eacute;s : ${PROJECTURL}motcle/.
  * THEME : Nom du th&egrave;me choisi. Les th&egrave;mes sont disponibles dans le dossier nomm&eacute; **template**. Chaque th&egrave;me poss&egrave;de son propre r&eacute;pertoire. Par exemple, le th&egrave;me *default* poss&egrave;de son propre r&eacute;pertoire **template/default**.
  * FLAVOR: Ce nom sera utilis&eacute; pour choisir la couleur de votre th&egrave;me (si elle existe)
  * BACKUPDIR : Nom du dossier o&ugrave; seront sauv&eacute;s les fichiers r&eacute;sultant de la commande *backup*.
  * BACKUP\_FORMAT : Format de date utilis&eacute; pour le fichier de sauvegarde.
  * BACKUP\_PREFIX : pr&eacute;fixe utilis&eacute; pour le fichier de sauvegarde (entre la date et le nom de fichier).
  * BACKUP\_SUFFIX : suffixe utilis&eacute; pour le fichier de sauvegarde (entre le nom de fichier et l'extension).
  * SIDEBAR\_FILENAME : Comme d&eacute;crit, nom du fichier utilis&eacute; pour la barre lat&eacute;rale. Elle contient des liens et tout un tas d'autres choses. Si vous la param&eacute;trez &agrave; "sidebar.md", par exemple, vous devez cr&eacute;er le fichier dans le r&eacute;pertoire **special** pour obtenir cette barre. &Agrave; noter que votre th&egrave;me doit inclure les barres lat&eacute;rales !
  * SIDEBAR : Mis &agrave; 1 permet d'activer la barre lat&eacute;rale sur ${PROJECTNAME}. &Agrave; noter que votre th&egrave;me doit inclure les barres lat&eacute;rales !
  * PUBLISH\_DESTINATION : Adresse compl&egrave;te du lieu o&ugrave; envoyer les fichiers afin de les publier.
  * PUBLISH\_SCRIPT\_NAME : Nom du fichier script utilis&eacute; pour envoyer les fichiers du dossier **pub** vers une destination renseign&eacute;e dans la variable *PUBLISH\_DESTINATION*.
  * SEARCH\_BAR : Mis &agrave; 1 permet d'activer une barre de recherche sur ${PROJECTNAME}. &Agrave; noter que votre th&egrave;me doit supporter la barre de recherche.
  * MAX\_RSS : Nombre d'articles RSS maximum qui sera r&eacute;cup&eacute;r&eacute; par vos utilisateurs.
  * ISSO : Mis &agrave; 1 permet d'activer un syst&egrave;me de commentaires pour ${PROJECTNAME}. &Agrave; noter que votre th&egrave;me doit supporter le syst&egrave;me de commentaires. Attention, par d&eacute;faut cela utilise rave.depotoi.re en tant que serveur, il ne garantit pas un archivage &agrave; long terme des commentaires. Plus d'informations sont disponibles [sur la page d'installation du projet isso](http://posativ.org/isso/docs/install/ "Se rendre sur la page du projet pour en savoir plus").
  * ISSO\_URL (optionnel) : D&eacute;finit un serveur ISSO sur lequel envoyer les commentaires. Par exemple **rave.depotoi.re/pseudo**. Attention : n'utilisez pas de **http://** devant l'adresse. Cela permet d'avoir du http ou du https quand nécessaire.
  * ISSO\_MAX (optionnel) : D&eacute;finit une limite de commentaires &agrave; afficher pour le syst&egrave;me de commentaire ISSO. Par d&eacute;faut **3**.
  * ELI\_USER: Si utilis&eacute;, ceci active un cadre pour identica. &Agrave; noter que votre th&egrave;me doit supporter le widget ELI. Par d&eacute;faut cette fonctionnalit&eacute; utiliser l'API d'IDENTICA.
  * ELI\_TYPE (optionel) : Changer cet &eacute;l&eacute;ment par "group" pour suivre un groupe plut&ocirc;t qu'un utilisateur d'IDENTICA. Par d&eacute;faut "user".
  * ELI\_MAX (optionnel) : Permet de choisir le nombre de statuts affich&eacute;s. Sur IDENTICA ceci ne peut d&eacute;passer 20 &eacute;l&eacute;ments. Valeur par d&eacute;faut : 5.
  * ELI\_API (optionnel) : Acc&egrave;s &agrave; l'API de votre syst&egrave;me StatusNet.
  * INSTALLDIR : Permet de choisir le dossier de destination lors de l'utilisation de la commande **./${PROJECTNAMELOWER} install** (Cf. Chapitre Publier le r&eacute;sultat sur le web).
  * SORT (optionnel) : Tri la liste des billets. Utilisez ASC pour que les billets soient triés du plus anciens au plus récent. DESC (valeur par défaut) tri les billets du plus récent au plus ancien.
  * AUTO\_EDIT (optionnel) : Permet d'&eacute;diter automatiquement les billets apr&egrave;s leur cr&eacute;ation. Utilise le contenu de la variable EDITOR pour savoir quel &eacute;diteur utiliser.

## Migration depuis Nanoblogger

Un script de migration depuis Nanoblogger existe: [nb2makefly](http://github.com/blankoworld/nb2makefly "D&eacute;couvrir nb2makefly").

Je vous invite &agrave; lire la [documentation de nb2makefly](https://github.com/blankoworld/nb2makefly/blob/master/README.md "Lire la documentation de nb2makefly") pour cela.

## Le projet

### Description

${PROJECTNAME} est un sous-projet de [BlogBox](http://blogbox.depotoi.re/ "En savoir plus sur le projet BlogBox") qui vise &agrave; fournir de meilleurs moyens pour h&eacute;berger un blog &agrave; la maison.

### Site web

Visitez fr&eacute;quemment le [blog de ${PROJECTNAME}](${PROJECTURL}blog/ "Visiter le blog officiel de ${PROJECTNAME}") (en) pour avoir des nouvelles du projet.

### Alerte rouge, bug détecté !

Vous avez trouvé un bug ? Ou quelque chose ne va pas (hormis vos problèmes de couple) ? C'est parti pour [ouvrir un rapport de bug sur Github](${GITPROJECT}issues). C'est simple : 

  * Allez sur [ce lien](${GITPROJECT}issues)
  * Si vous n'êtes pas enregistré, utilisez le lien **Sign up**. Puis recliquez sur le lien précédent pour accomplir les étapes
  * Cliquez sur **New Issue**
  * Donnez un titre qui serait une courte description de votre problème
  * Puis, sous le titre, expliquez en détail : 
    * Ce que vous avez fait
    * Le résultat que vous obtenez
    * Ce à quoi vous vous attendriez plutôt
    * \[optionnel\] donnez un copier/coller de ce que vous avez à l'écran ou [donnez une capture d'écran](https://lut.im/)
  * Validez en utilisant **Submit new issue**

This take few minutes and permit to improve ${PROJECTNAME}. Thanks -in advance - a lot for your help!

### Développement

${PROJECTNAME} est développ&eacute; en Lua, CSS et HTML.

Le code du logiciel se trouve sur le d&eacute;p&ocirc;t suivant : 

  * [Github](${GITPROJECT} "Se rendre sur la page d'accueil du projet ${PROJECTNAME} sur Github")

#### Astuce pour forker/bifurquer le projet

Le projet peut se dupliquer et se renommer facilement en utilisant les variables suivantes dans le fichier ${PROJECTNAMELOWER} : 

  * PROJECTNAME
  * PROJECTURL
  * GITPROJECT

Et en renommant le fichier ${PROJECTNAMELOWER} par le nom donné dans PROJECTNAME en minuscule.

Pensez également à renommer le fichier ${PROJECTNAMELOWER}.svg en celui du nom de votre projet.

Bon fork, et bonne chance !

### Fichier Docker

Un fichier Docker est disponible pour tester ${PROJECTNAME} : https://registry.hub.docker.com/u/bl4n/docker-makefly/

### Contact

Vous pouvez me contacter [&agrave; cette adresse](mailto:olivier+makefly@dossmann.net "Me contacter").

### Licence

Ce logiciel est publi&eacute; sous la licence suivante : GNU Affero General Public License 3.0.

### Stats

Quelques stats du projet se trouvent [sur Ohloh.net](http://www.ohloh.net/p/makefly "Voir les analyses d'ohloh &agrave; propos du projet ${PROJECTNAME}").
