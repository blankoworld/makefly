# Makefly

[Original english documentation version](http://makefly.depotoi.re/documentation.html.en) (version originale en anglais)

[Aller sur le site web](http://makefly.depotoi.re/)

## &Agrave; propos

Makefly est un moteur de blog statique qui utilise les fichiers Makefile BSD pour fonctionner.

### Site web

Visitez fr&eacute;quemment le [blog de Makefly](http://makefly.depotoi.re/blog/ "Visiter le blog officiel de Makefly") (en) pour avoir des nouvelles du projet.

### Contact

Vous pouvez me contacter [&agrave; cette adresse](mailto:olivier+makefly@dossmann.net "Me contacter").

### Licence

Ce logiciel est publi&eacute; sous la licence suivante : GNU Affero General Public License 3.0.

### Stats

Quelques stats du projet se trouvent [sur Ohloh.net](http://www.ohloh.net/p/makefly "Voir les analyses d'ohloh &agrave; propos du projet Makefly").

## Description

Makefly est un sous-projet de [BlogBox](http://blogbox.depotoi.re/ "En savoir plus sur le projet BlogBox") qui vise &agrave; fournir de meilleurs moyens pour h&eacute;berger un blog &agrave; la maison.

## D&eacute;pendences

Quelques programmes dont Makefly d&eacute;pend : 

  * pmake ou bmake
  * lua 5.1 ou plus r&eacute;cent

Ainsi utilisez le gestionnaire de paquet de votre distribution pour les installer. Par exemple sur Debian et d&eacute;riv&eacute;es, ce serait : 

    apt-get install pmake lua5.1

Pour d'autres distributions, regardez du c&ocirc;t&eacute; des forums, d'IRC et/ou de la communaut&eacute; de votre distribution. Ils seront heureux de vous aider.

### Biblioth&egrave;ques

Quelques biblioth&egrave;ques sont n&eacute;cessaires pour faire fonctionner les scripts Lua : 

  * lua-filesystem
  * lua-markdown

Pour les installer, vous avez deux possibilit&eacute;s : 

  * soit vous utilisez **luarocks**
  * soit vous utilisez **les paquets de votre distribution**

#### Luarocks

Il suffit d'installer *luarocks* et de lancer quelques commandes : 

    apt-get install luarocks
    luarocks install lua-filesystem lua-markdown

Et c'est tout !

#### Les paquets de votre distribution

Utilisez cette m&eacute;thode seulement si vous n'avez pas fait celle de *luarocks* pr&eacute;c&eacute;dente.

Sous Debian GNU/Linux, par exemple, installer les paquets suivant : 

  * liblua5.1-filesystem0
  * liblua5.1-markdown0

à l'aide de la commande suivante : 

    apt-get install liblua5.1-filesystem0 liblua5.1-markdown0

Et c'est tout !

## Installation

Il y a deux mani&egrave;res d'installer Makefly sur votre ordinateur : 

  * Utiliser la derni&egrave;re version stable en r&eacute;cup&eacute;rant une archive (recommand&eacute;)
  * Utiliser la version en cours de d&eacute;veloppement en utilisant un d&eacute;p&ocirc;t de version (por les utilisateurs avanc&eacute;s seulemennt)

### Utiliser la derni&egrave;re version stable

R&eacute;cup&eacute;rez simplement la derni&egrave;re version sur le site officiel : [http://makefly.depotoi.re/](http://makefly.depotoi.re/ "Aller sur le site officiel de Makefly").

Par exemple [la version 0.3 (fr)](http://makefly.depotoi.re/makefly_0.3_fr.zip "T&eacute;l&eacute;charger Makefly 0.3 (fr)").

Puis extraire le contenu de l'archive dans un dossier.

### Utiliser la version en cours de d&eacute;veloppement

Vous devez utiliser la commande **git**. Si vous ne savez pas ce que c'est, jetez un &oelig;il au [site web Git SCM](http://git-scm.com/ "En savoir plus sur Git").

Apr&egrave;s une installation git, allez dans un r&eacute;pertoire de travail et faites : 

    git clone git://gitorious.org/makefly/master.git makefly_dev

Ceci va r&eacute;cup&eacute;rer le d&eacute;p&ocirc;t Makefly et ajouter les fichiers dans le dossier **makefly\_dev**.

**Note**: Utiliser git est utile pour mettre &agrave; jour Makefly au fur et &agrave; mesure du d&eacute;veloppement de ce dernier. En effet : 

    git pull git://gitorious.org/makefly/master.git

mettra &agrave; jour Makefly.

**ATTENTION**: Vous devez toujours sauvegarder vos fichiers ! Cette m&eacute;thode peut supprimer des modificiations faites pr&eacute;c&eacute;demment.

## Configuration

### Pour la version stable

Aucune configuration particuli&egrave;re n'est requise. V&eacute;rifiez que le fichier **makefly.rc** existe bien. Le cas &eacute;ch&eacute;ant copiez le fichier **makefly.rc.example** ou renommez le en **makefly.rc**.

### Pour la version trunk

La premi&egrave;re fois que vous utilisez Makefly vous n'avez aucun fichier de configuration. Un exemple de fichier de configuration est disponible dans **makefly.rc.example*. Copiez le vers **makefly.rc** pour permettre &agrave; Makefly de fonctionner.

### Plus d'infos

Pour plus d'informations, lisez la section **Le fichier de configuration makefly.rc**.

## Cr&eacute;er du contenu

La mani&egrave;re de cr&eacute;er du contenu d&eacute;pend de votre version.

Pour connaitre votre version, faites :

    pmake version

Si une erreur apparait comme : ``pmake: don't know how to make version. Stop``, alors vous avez une version ant&eacute;rieure &agrave; 0.2.1.

### Version ant&eacute;rieure &agrave; 0.2.1

Rendez-vous dans le dossier **tools** puis lancez le script **create_post.sh** de la mani&egrave;re suivante : 

    cd tools
    ./create_post.sh

et r&eacute;pondez &agrave; toutes les questions pos&eacute;es. Cela g&eacute;n&egrave;rera les fichiers n&eacute;cessaires pour Makefly.

Il est &agrave; noter que Makefly utilise [le format markdown](http://daringfireball.net/projects/markdown/ "En savoir plus sur le format Markdown") pour ses articles.

### Version sup&eacute;rieure ou &eacute;gale &agrave; 0.2.1

Utilisez la commande suivante :

    pmake add

et r&eacute;pondez &agrave; toutes les questions pos&eacute;es. Cela g&eacute;n&egrave;rera les fichiers n&eacute;cessaires pour Makefly.

Il est &agrave; noter que Makefly utilise [le format markdown](http://daringfireball.net/projects/markdown/ "En savoir plus sur le format Markdown") pour ses articles.

**N'oubliez pas d'&eacute;diter le fichier renseign&eacute; par la commande 'pmake add'.**

### Fichiers statiques

Si vous voulez ajouter quelques fichiers statiques, rajoutez les simplement dans le dossier *static*. Ils seront copiés dans le dossier de destination.

### Le dossier 'special'

Ce dossier nomm&eacute; **special** peut contenir certains fichiers que vous devrez cr&eacute;er pour activer une fonctionnalit&eacute; : 

  * *about.md* : Contient le contenu d'une page d'&agrave; propos au sujet de votre site. Cela va ajouter une entr&eacute;e dans le menu principal du site (si votre th&egrave;me le supporte).
  * *sidebar.md* : Ajoute une barre lat&eacute;rale sur votre site. Le th&egrave;me doit supporter cette fonction.
  * *introduction.md* : Affiche le contenu de ce fichier comme introduction sur l'ensemble de vos pages. Varie selon le th&egrave;me choisi.
  * *footer.md* : Affiche le contenu de ce fichier comme d'un pied de page sur l'ensemble de vos pages. Varie selon le th&egrave;me choisi.

## Utilisez le !

Apr&egrave;s avoir cr&eacute;e le fichier *makefly.rc* (depuis le fichier makefly.rc.example) et avoir cr&eacute;e quelques articles, faites simplement : 

    pmake

Ceci g&eacute;n&egrave;rera un blog Makefly dans le dossier **pub**.

Note: *pmake* est sur les distributions Debian et d&eacute;riv&eacute;es. Pour les autres distributions, je vous sugg&egrave;re d'utiliser **bmake**.

## Publier le r&eacute;sultat sur le web

Le r&eacute;sultat de Makefly est compatible avec tous le serveurs HTML. En effet vous pouvez probablement utiliser le r&eacute;sultat sur le site web de votre h&eacute;bergeur. Il suffit d'envoyer le contenu du r&eacute;pertoire **pub** dans celui de votre h&eacute;bergeur.

### Sur un serveur web

Si vous lancez Makefly sur votre propre serveur ou tr&egrave;s certainement sur le serveur de votre h&eacute;bergeur, vous pourrez utiliser l'installation automatis&eacute;e. Lancez simplement la commande suivante : 

    pmake install

...et cela copiera tous les fichiers dans le r&eacute;pertoire **~/public\_html**.

**ATTENTION**: Cela supprimera tous les fichiers contenus dans le dossier *public\_html* !

**Note**: Vous pouvez personnaliser la destination en changeant le fichier **makefly.rc** et plus particuli&egrave;rement la ligne suivante : 

    INSTALLDIR=${HOME}/public_html

Relancez ensuite la commande `pmake install` pour recompiler le blog.

### Vers un ordinateur distant : la commande *publish*

Pour publier votre blog vers une machine distante, vous devez : 

  * avoir un acc&egrave;s SSH &agrave; la machine distante
  * avoir le programme rsync
  * configurer la variable **PUBLISH\_DESTINATION** dans le fichier **makefly.rc**
  * lancer la commande **publish**

C'est tout!

&Agrave; noter que la variable **PUBLISH\_DESTINATION** ressemble &agrave; : 

    monUtilisateurDistant@domaineDistant.tld:/mondossierhome/dossier_public

Une fois cette variable renseign&eacute;e dans le fichier **makefly.rc**, lancez simplement : 

    pmake publish

Pour les d&eacute;velopeurs : Vous pouvez aussi modifier le fichier **tools/publish.sh** et changer le contenu du script par votre propre code.

## Cr&eacute;er un nouveau th&egrave;me

Afin de vous faciliter la tâche de cr&eacute;ation d'un nouveau th&egrave;me, vous pouvez utiliser la commande suivante :

    pmake theme name="myTheme"

o&ugrave; **myTheme** est &agrave; remplacer par le nom de votre th&egrave;me.

Note : Ceci utilise le th&egrave;me nomm&eacute; *Base* comme exemple.

## Traduction

Une fa&ccedil;on simple de traduire Makefly dans votre langage est de copier le fichier **lang/translate.en** dans un autre fichier. Par exemple, pour le Fran&ccedil;ais (avec le code fr), vous pouvez copier **lang/translate.en** en **lang/translate.fr** et changez les valeurs. Puis changez simplement l'option *BLOG\_LANG* dans le fichier **makefly.rc**.

## Sauvegardes

Peut-&ecirc;tre voudriez-vous sauvegarder les fichiers importants de Makefly ? C'est possible via la **commande backup**. Lancez la simplement de cette mani&egrave;re : 

    pmake backup

Requis : 

  * tar
  * gzip

Fichiers sauv&eacute;s : 

  * makefly.rc
  * le r&eacute;pertoire static
  * le r&eacute;pertoire special
  * le r&eacute;pertoire db
  * le r&eacute;pertoire src
  * le r&eacute;pertoire contenant le th&egrave;me choisi (par exemple *templates/default/*)

R&eacute;sultat : Ceci cr&eacute;era une *archive* nomm&eacute;e *YYYYMMDD\_makefly.tar.gz* (20120823\_makefly.tar.gz par exemple) dans le dossier **mbackup**. Vous pouvez ainsi sauvegarder votre Makefly chaque jour.

### Astuces

Vous pouvez personnaliser (dans votre fichier **makefly.rc**) :

  * le dossier de sauvegarde en utilisant l'option **BACKUPDIR**
  * l'outil de compression en utilisant l'option **COMPRESS_TOOL**, par exemple avec **gzip**
  * l'extension du fichier de sauvegarde en utilisant l'option **COMPRESS_EXT**, par exemple avec **.gz** (ne pas oublier le point)

## Sources

Les sources sont disponibles :  

  * [Sur gitorious](http://gitorious.org/makefly/master.git/)
  * [Sur github](https://github.com/blankoworld/makefly)
  * [Sur mon propre d&eacute;p&ocirc;t git](http://git.dossmann.net/blogbox/makefly.git/)

## Documentation

Ce fichier est la documentation. Vous pouvez [le lire sur github](https://github.com/blankoworld/makefly "Lire la documentation sur Github") ou simplement g&eacute;n&eacute;rer un fichier HTML &agrave; l'aide de cette commande : 

    pmake doc

Note: La commande pmake command est pour Debian et d&eacute;riv&eacute;s. Pour les autres distributions, utilisez **bmake** au lieu de pmake.

## Astuces

### &Eacute;crire des billets en avance

Dans Makefly vous pouvez &eacute;crire des billets en avance. Il suffit pour cela que le fichier de m&eacute;ta-donn&eacute;es de votre billet poss&egrave;de un timestamp sup&eacute;rieur &agrave; celui du moment o&ugrave; est g&eacute;n&eacute;r&eacute; le blog.

Par exemple nous sommes le 6 mars 2013, &agrave; 12:30, le timestamp est : 1362569400. Il faut que dans le dossier **db**, votre article ait un timestamp inf&eacute;rieur &agrave; celui d'aujourd'hui.

### &Eacute;crire directement le contenu de l'article &agrave; sa cr&eacute;ation

Utilisez juste la variable 'content' au d&eacute;but de la commande : 

    content="mon petit contenu" pmake add

Ceci ajoutera "mon petit contenu" dans votre nouvel article.


### Ne pas perdre les commentaires quand on migre d'un vieux domaine &agrave; un nouveau

Quand vous migrez de **vieux.domaine.tld** &agrave; **nouveau.domaine.tld**, les commentaires n'appara&icirc;tront plus.

Pour r&eacute;gler le probl&egrave;me, utilisez simplement la **commande migratefrom** : 

    domain="http://vieux.domaine.tld" pmake migratefrom

Ceci va mettre &agrave; jour tout les anciens articles avec l'identifiant des vieux commentaires (votre vieux domaine) et les commentaires r&eacute;appara&icirc;tront.

## Le fichier de configuration makefly.rc

Voici quelques options que vous pouvez changer : 

  * BLOG\_TITLE : Titre de votre blog
  * BLOG\_SHORT\_DESC : Une courte description de votre blog
  * BLOG\_DESCRIPTION : Une description plus compl&egrave;te de votre blog
  * BLOG\_LANG : votre code langue. &Agrave; noter qu'un fichier lang/translate.VOTRE\_CODE\_LANGAGE doit exister. Par exemple si je configure ce param&egrave;tre &agrave; *fr*, un fichier *lang/translate.fr* doit exister !
  * BLOG\_CHARSET : votre configuration d'encodage. Doit ressembler &agrave; quelque chose comme **UTF-8** ou **ISO-8859-1**. Si vous ne savez pas ce que c'est, laissez la param&eacute;tr&eacute;e &agrave; *UTF-8*.
  * BLOG\_URL : adresse URL absolue de votre blog. Par exemple http://makefly.depotoi.re/.
  * BLOG\_AUTHOR : Auteur principal du blog. Permet un r&eacute;f&eacute;rencement dans les moteurs de recherche.
  * BLOG\_COPYRIGHT : Copyright du blog. Permet un r&eacute;f&eacute;rencement dans les moteurs de recherche.

  * BLOG\_KEYWORDS : Mots-cl&eacute;s qui doivent appara&icirc;trent pour l'ensemble des pages du blog. Permet un r&eacute;f&eacute;rencement dans les moteurs de recherche.
  * RSS\_FEED\_NAME : Titre affich&eacute; dans le flux RSS.
  * MAX\_POST : Nombre maximum d'articles qui seront affich&eacute;s sur la page d'accueil.
  * MAX\_POST\_LINES : Nombre de lignes qui seront montr&eacute;es sur la page d'accueil. Si param&eacute;tr&eacute; &agrave; 0 ou inexistant dans le fichier *makefly.rc*, alors les articles sont enti&egrave;rement montr&eacute;s.
  * DATE\_FORMAT : Format de la date affich&eacute;e pour chaque article. Lisez les pages du manuel *date* pour plus d'informations.
  * MAX\_PAGE : Nombre maximal d'articles qui devrait s'afficher sur la liste des articles. Si param&eacute;tr&eacute; &agrave; 0 ou inexistant du fichier *makefly.rc*, alors une seule page sera faite avec tout les articles !
  * SHORT\_DATE\_FORMAT : Format court de la date. Sera utilis&eacute; sur la page de la liste des articles. Pour plus d'informations, lire les pages du manuel *date*.
  * INDEX\_FILENAME : Nom donn&eacute; &agrave; toutes les pages index. Par exemple avec **INDEX\_FILENAME = mainpage**, la liste des articles se nommera *mainpage.html*.
  * PAGE\_EXT : suffixe que toutes les pages auront. **NE PAS OUBLIER D'AJOUTER UN POINT AVANT LE SUFFIXE**. Par exemple avec **PAGE\_EXT = .html**, toutes les pages seront de la forme : *index.html*.
  * ABOUT\_FILENAME : Comme son nom l'indique, c'est le titre du fichier utilis&eacute; pour la page "&Agrave; propos". Si vous le param&eacute;trez &agrave; "apropos" par exemple, vous devez cr&eacute;er un fichier "apropos.md" dans le r&eacute;pertoire nomm&eacute; **special** afin de permettre  l'obtention d'une page d'&agrave; propos. Si vous le changez &agrave; *toto*, vous devez cr&eacute;er un fichier *toto.md* dans le dossier **special**.
  * POSTDIR\_NAME : Le nom que vous voudriez afficher dans l'URL quand un utilisateur se rend sur la page de la liste des articles. Par exemple, param&eacute;tr&eacute; &agrave; "mesarticles" : http://makefly.depotoi.re/mesarticles/ affichera la liste de vos articles. Ceci est utile pour divers langages.
  * TAGDIR\_NAME : M&ecirc;me chose que pour le param&egrave;tre *POSTDIR\_NAME*, mais pour les mots-cl&eacute;s (tags) cette fois. Modifiez le en "motcle" par exemple et l'adresse suivante affichera la liste des mots-cl&eacute;s : http://makefly.depotoi.re/motcle/.
  * THEME : Nom du th&egrave;me choisi. Les th&egrave;mes sont disponibles dans le dossier nomm&eacute; **template**. Chaque th&egrave;me poss&egrave;de son propre r&eacute;pertoire. Par exemple, le th&egrave;me *default* poss&egrave;de son propre r&eacute;pertoire **template/default**.
  * FLAVOR: Ce nom sera utilis&eacute; pour choisir la couleur de votre th&egrave;me (si elle existe)
  * BACKUPDIR : Nom du dossier o&ugrave; seront sauv&eacute;s les fichiers r&eacute;sultant de la commande *backup*.
  * SIDEBAR\_FILENAME : Comme d&eacute;crit, nom du fichier utilis&eacute; pour la barre lat&eacute;rale. Elle contient des liens et tout un tas d'autres choses. Si vous la param&eacute;trez &agrave; "sidebar.md", par exemple, vous devez cr&eacute;er le fichier dans le r&eacute;pertoire **special** pour obtenir cette barre. &Agrave; noter que votre th&egrave;me doit inclure les barres lat&eacute;rales !
  * SIDEBAR : Mis &agrave; 1 permet d'activer la barre lat&eacute;rale sur Makefly. &Agrave; noter que votre th&egrave;me doit inclure les barres lat&eacute;rales !
  * PUBLISH\_DESTINATION : Adresse compl&egrave;te du lieu o&ugrave; envoyer les fichiers afin de les publier.
  * PUBLISH\_SCRIPT\_NAME : Nom du fichier script utilis&eacute; pour envoyer les fichiers du dossier **pub** vers une destination renseign&eacute;e dans la variable *PUBLISH\_DESTINATION*.
  * SEARCH\_BAR : Mis &agrave; 1 permet d'activer une barre de recherche sur Makefly. &Agrave; noter que votre th&egrave;me doit supporter la barre de recherche.
  * MAX\_RSS : Nombre d'articles RSS maximum qui sera r&eacute;cup&eacute;r&eacute; par vos utilisateurs.
  * JSKOMMENT : Mis &agrave; 1 permet d'activer un syst&eacute;me de commentaires pour Makefly. &Agrave; noter que votre th&egrave;me doit supporter le syst&eacute;me de commentaires. Attention, par d&eacute;faut cela utiliser jskomment.appspot.com en tant que serveur, il ne garantit pas un archivage &agrave; long terme des commentaires. Plus d'informations sont disponibles [sur la page d'installation du projet jskomment](http://code.google.com/p/jskomment/wiki/Installation "Se rendre sur la page du projet pour en savoir plus").
  * JSKOMMENT\_CAPTCHA\_THEME (optionnel) : D&eacute;finissez un th&egrave;me suivant la [page reCaptcha](https://developers.google.com/recaptcha/docs/customization "Plus d'infos sur les th&egrave;mes reCaptcha") pour les Catpcha dans le syst&egrave;me de commentaires JSKOMMENT.
  * JSKOMMENT\_URL (optionnel) : D&eacute;finit un serveur JSKOMMENT sur lequel envoyer les commentaires. Par d&eacute;faut **http://jskomment.appspot.com/**.
  * JSKOMMENT\_MAX (optionnel) : D&eacute;finit une limite de commentaires &agrave; afficher pour le syst&egrave;me de commentaire JSKOMMENT. Par d&eacute;faut **2**.
  * ELI\_USER: Si utilis&eacute;, ceci active un cadre pour identica. &Agrave; noter que votre th&egrave;me doit supporter le widget ELI. Par d&eacute;faut cette fonctionnalit&eacute; utiliser l'API d'IDENTICA.
  * ELI\_TYPE (optionel) : Changer cet &eacute;l&eacute;ment par "group" pour suivre un groupe plut&ocirc;t qu'un utilisateur d'IDENTICA. Par d&eacute;faut "user".
  * ELI\_MAX (optionnel) : Permet de choisir le nombre de statuts affich&eacute;s. Sur IDENTICA ceci ne peut d&eacute;passer 20 &eacute;l&eacute;ments. Valeur par d&eacute;faut : 5.
  * ELI\_API (optionnel) : Acc&egrave;s &agrave; l'API de votre syst&egrave;me StatusNet.
  * INSTALLDIR : Permet de choisir le dossier de destination lors de l'utilisation du script **install.sh** (Cf. Chapitre Publier le r&eacute;sultat sur le web).
  * COMPRESS_TOOL (optionnel) : Outil console utilis&eacute; pour la compression lors des sauvegardes via la commande *backup* (Cf. Chapitre *Sauvegardes*). Exemple : **gzip**.
  * COMPRESS_EXT (optionnel) : Extension des fichiers de sauvegarde. Attention &agrave; ne pas oublier le caract&egrave;re point. Exemple : **.gz**.
  * SORT (optionnel) : Tri la liste des billets. Utilisez ASC pour que les billets soient triés du plus anciens au plus récent. DESC (valeur par défaut) tri les billets du plus récent au plus ancien.

