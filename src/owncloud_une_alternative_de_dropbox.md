### Présentation

[Owncloud](http://owncloud.org/ "Se rendre sur le site officiel d'Owncloud") est une alternative à [DropBox](https://www.dropbox.com/ "Découvrir le site officiel de DropBox"), un outil permettant d'accéder, via une interface web ou un client spécifique, à l'ensemble de ses fichiers et cela de manière sécurisée.

À la différence de DropBox, Owncloud peut s'installer chez soi, ce qui permet de garder le contrôle sur ses propres données.

Owncloud étant sous licence AGPL, je me suis permis de le tester. Il possède les fonctionnalités suivantes :

  * Multi-utilisateur
  * Stockage de fichiers
  * Partage des fichiers à d'autres utilisateurs
  * Carnet de contacts
  * Calendrier
  * Lecture en direct de fichiers audios
  * Marque-pages
  * Éditeur de fichiers

![Logo Owncloud](${BASE_URL}/images/logos/owncloud.png "Le petit nuage d'Owncloud")

### Mes attentes

À titre privé je dispose d'une webradio fonctionnant à l'aide de MusicPlayerDaemon et Icecast2. J'ai entendu dire qu'Owncloud utilisait un outil nommé Ampache pour fonctionner. Ce qui permet de connecter des clients Ampache pour lire la musique contenue sur notre compte. C'est l'occasion de remplacer ma webradio !

J'ai aussi vu qu'Owncloud proposait un outil permettant de sauver les adresses de nos sites webs préférés et de les partager. C'est ce que fait déjà [l'outil que je vous présentais : SemanticScuttle](${BASE_URL}/archives/2008/04/15/partager_ses_marques_-_pages__signets_internet/ "Lire l'article sur le partage de ses marques-pages sur le BlankoJoueb"). Je me suis dis qu'Owncloud pouvait potentiellement me délester d'un outil supplémentaire.

De base le système Owncloud dispose d'un calendrier et d'un carnet de contacts. Ce qui lui donne la possibilité de synchroniser ces derniers avec ceux d'un appareil mobile tel que [mon téléphone mobile N900](${BASE_URL}/archives/2009/11/30/r%C3%A9ception_du_nokia_n900/index.html "Lire l'article sur le N900 du BlankoJoueb").

J'ai testé Funambol, et cela ne m'a pas convaincu, c'est très lourd (plus de 100Mo de mémoire vive utilisée) pour pas grand chose. Sachant que l'utilisation de MPD + Icecast2 + SemanticScuttle (avec MySQL) prend certaines ressources, savoir qu'un outil tel qu'Owncloud inclus les même fonctionnalités en utilisant simplement Apache2 + SQLite, cela me semblait être une meilleure idée de l'utiliser.

### Premières impressions

  * Installation : impeccable, très facile à utiliser
  * Configuration : idem, l'interface web est d'une simplicité enfantine
  * Utilisation : comme l'installation et la configuration : un plaisir

Vous trouverez les détails de l'installation [sur la page suivante](http://owncloud.org/support/setup-and-installation/linux-server/ "Découvrir comment installer owncloud sur sa machine").

Mon opinion rapide pour une première utilisation : très simple et très agréable, joli. Je suis donc passé à l'étape supérieure c'est à dire une utilisation avec des cas concrets : synchroniser ses contacts, son calendrier et écouter de la musique sur son mobile ou un pc utilisant un client Ampache.

### Critiques

Owncloud propose diverses fonctionnalités qui sont intéressantes et utilisables, mais pas forcément assez developpées pour être complètes.

Au départ j'ai utilisé une version 3 de Firefox sur un vieil ordinateur. Les éléments de l'interface s'amusaient littéralement ici ou là de l'écran : ils sortaient du cadre du navigateur (donc difficile de les utiliser).

Après avoir mis à jour Firefox en version 10, l'interface était plus qu'agréable, un vrai régal. Je suis donc aller fouiner dans le paramétrage d'Owncloud.

Il n'y a pas à dire, Activer/Desactiver un plugin se fait en un clic. C'est simple, efficace.

Je me lance dans l'utilisation des marques-pages ; cependant je ne vois pas de bouton supplémentaire pour l'import/export dans les marques-pages. Dommage, importer depuis SemanticScuttle va être impossible. À noter que je m'attelerai prochainement à installer [Shaarli](http://sebsauvage.net/wiki/doku.php?id=php:shaarli "En savoir plus sur Shaarli") qui permet apparemment de faire de l'import/export de marque-pages. Cela me sera plus utile que l'outil d'Owncloud.

Par la suite, j'ai déposé une musique que je possède au format OGG. Pour des raisons de limitations d'envoi maximum de données par PHP, j'ai du passer par la console. Il faut donc un peu paramétrer PHP pour permettre l'envoi de fichiers de plus de 2Mb.<br />
Je lance ensuite la lecture de la musique via l'interface web : aucun problème. Je suis très agréablement surpris d'avoir un lecteur de musique integré à Owncloud.<br />
Je me lance ensuite dans la volonté, tout à fait normale, de faire de même avec un client lourd sur Windows, Linux et sous mon mobile N900.<br />
Résultat : rien, rien et... rien ! Le client Windows [Tomahawk](http://www.tomahawk-player.org/splash "Se rendre sur le site officiel Tomahawk") n'arrive pas à se connecter à ma bibliothèque de musique. Le client VLC ne veut pas non plus, mais surtout parce que je n'arrive pas à le configurer : vraisemblablement aucune documentation sur Internet. Je dois mal chercher.<br />
Je me risque donc à utiliser [amaroK sur KDE](http://amarok.kde.org/ "Découvrir le logiciel amaroK"), mais pareil, je n'arrive pas à lire quoique ce soit.<br />
Je tente donc désespérement MaAmp sur le N900 : il n'arrive pas à s'y connecter.<br />
Peut-être que ces erreurs sont dues à l'utilisation de SSL, mais j'en doute.

Tentons désormais la synchronisation avec les contacts et le calendrier. Pour cela j'utilise [un tutoriel sympathique mis à disposition par un certain tanghus](http://tanghus.net/2012/01/syncing-your-n900-with-owncloud/ "Lire l'article de Tanghus à propos de la synchronisation avec un N900"). Très vite j'obtiens un résultat concluant. Tout est synchronisé comme il se doit. À noter qu'il faut ABSOLUMENT VEILLER à faire une sauvegarde du mobile avant de commencer. Dans mon cas c'était sous le logiciel propriétaire livré avec mon appareil : OVI. Même si cela m'est assez rebutant encore, je dois avouer que sans lui j'aurais perdu 530 contacts !<br />
En effet j'ai fait une mauvaise manipulation et je me suis retrouvé avec 18 contacts dans l'appareil. Comme cela synchronisait avec un service payant sur Internet, le service lui-même a perdu l'ensemble des contacts... Autant dire que dans ses cas là, il fait plaisir d'avoir une sauvegarde, support propriétaire ou non !

Je n'ai pas testé plus de choses que ça, mais cela me paraît déjà pas mal. Récapitulons donc.

### Ce qu'il faut retenir

  * Installation facile, très facile ! 
  * Configuration et utilisation simple
  * Interface agréable
  * Il est primordial d'avoir un navigateur supportant le HTML5 et CSS3
  * Ampache, pour Owncloud 3 en tout cas, ne fonctionne pas
  * Pas d'import/export des marques-pages
  * La synchronisation du calendrier et du carnet d'adresses est bien utile

### Conclusion

Après avoir testé Owncloud sur différents aspects, je ne l'utiliserais que pour :

  * le carnet d'adresses
  * le calendrier
  * la synchronisation avec SyncEvolution sur le mobile N900

Pour d'autres fonctionnalités je préfère utiliser :

  * Shaarli pour la gestion des marque-pages (adresses URL)
  * MusicPlayerDaemon + icecast2 pour écouter de la musique

Si vous avez une expérience à l'installation/configuration/utilisation d'Owncloud, je vous invite à m'en faire part via courriel (olivier+joueb[chez]dossmann[point]net) ou bien en commentaire de ce billet ou encore via mon compte bl4n sur identi.ca

### Liens utiles

  * [Owncloud.org](http://owncloud.org/ "Site officiel d'Owncloud")
  * [amaroK](http://amarok.kde.org/ "Découvrir le logiciel amaroK")
  * [Synchroniser son N900 avec Owncloud (en)](http://tanghus.net/2012/01/syncing-your-n900-with-owncloud/ "Lire l'article de Tanghus à propos de la synchronisation avec un N900")
  * [Syncrho N900](http://olivier.dossmann.net/wiki/materiel/nokia_n900#synchronisation "Liens divers sur le Quicky Blanko")
  * [Alternatives à Dropbox](http://alternativeto.net/software/dropbox/ "Liste de quelques alternatives à DropBox")
  * [DropBox](https://www.dropbox.com/ "Site officiel de DropBox")

