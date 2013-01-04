### Introduction

Dans [mon dernier billet concernant ma nouvelle galerie de photos](${BASE_URL}/archives/2009/06/10/ouverture_de_la_galerie_blankoesque/index.html "lire le billet sur la nouvelle galerie blankoesque du Blankoworld"), j'évoquais l'ouverture de la Galerie Blankoesque](http://images.dossmann.net/ "découvrir et visionner la galerie Blankoesque").
À moins que cela n'ait changé, je me suis doté d'un outil fort intéressant : SPGM (ou Simple Picture Gallery Manager), disponible à l'adresse suivante : [http://spgm.sourceforge.net/](http://spgm.sourceforge.net/ "Se rendre sur le site officiel de SPGM").

> Et ? À quoi cela nous avance - t - il de savoir que, toi, Blanko, a utilisé SPGM ?

Je me disais que possiblement vous seriez ravis d'apprendre que l'utilisation de cet outil n'est pas si facile qu'au premier abord, et le *manque* d'une interface Web semble ne donner que très peu de possibilité d'utilisation.

SPGM ne requièrt aucune base de données, ce qui m'a beaucoup plus, en revanche il ne possède pas non plus de système de création de miniatures, d'ajout de commentaires et de descriptions de galerie, un petit faible qu'un simple script pourrait changer !

Vous l'aurez compris, je vous fais part ici de deux choses :

 * la possibilité de charger les scripts que j'ai faits
 * la création d'une page wiki concernant SPGM et quelques astuces

### De la recherche d'un logiciel de galerie photos

####Piwigo

Ainsi je cherchais quelle galerie photo pourrait me saillir assez pour s'utiliser facilement. Autrefois la [galerie Blankoesque se trouvait sur Free](http://blankoworld.free.fr/images/ "Visionner l'ancienne galerie de photo de Blanko"), propulsée par phpWebGallery.

Je me suis dit : 

> Pourquoi ne pas passez à la nouvelle version de phpWebGallery : Piwigo.

[Piwigo](http://fr.piwigo.org/ "Se rendre sur le site officiel de Piwigo") est le successeur de phpWebGallery. J'étais très alléché par cette nouvelle version qui apportait de nombreuses fonctionnalités.
Seulement voilà, j'avais deux contraintes vis-à-vis de ma migration de Free vers un serveur personnel : 

  * je n'ai que postegreSQL sur le serveur qui contient assez de place pour mes photos
  * je dois pouvoir m'occuper d'ajouter des photos par FTP, et à la rigueur avoir un traitement rapide, ET/OU pouvoir m'occuper d'envoyer les fichiers par SSH (donc rsync, scp, etc.)

Piwigo ne gère que MySQL. C'était vite réglé.

> Sur le banc de touche

#### iGalerie

Je me tournais vers [iGalerie](http://www.igalerie.org/ "Se rendre sur la page officielle d'iGalerie"), un très bon logiciel que j'ai utilisé pour [Oasisdebali.eu](http://oasisdebali.eu/ "Visiter le site de l'Oasis de Bali, vente de meuble"). Mais cela était tout de même bien plus sophistiqué que ce que j'en ferais. Je laissais donc cette possibilité de côté.

> iGalerie, accepté, mis sur la liste.

#### Bildo

Je me suis alors penché sur un ancien outil que j'avais utilisé rapidement, sans trop le tester : Bildo. Très prometteur à l'époque, ne demandait l'installation d'aucune base de données, et permettait d'ajouter des images par une interface Java (côté admin), et ne demandait quasiment rien du côté client.

Cependant le projet semble mort ou mis d'un côté commercial (sans l'avoir été dit), et donc il fut difficile de trouver les fichiers sources et autres. Après quelques recherches, j'ai mis à disposition la dernière version de Bildo à l'adresse suivante : [ftp://portedesetoiles.net/logiciels/glandbourg/internet/galeries/bildo-stable-0.9.94/](ftp://portedesetoiles.net/logiciels/glandbourg/internet/galeries/bildo-stable-0.9.94/ "Se rendre sur le FTP du Blankoworld pour récupérer des fichiers de Bildo").

J'ai testé l'outil, je n'ai pas réussi à en faire ce que je voulais, je trouvais ça dommage.

Il est surtout prévu pour créer une galerie <u>à partir de rien</u>.

> Aichaic

#### Framasoft, libère moi !

Bon ça suffit, voyons ce que propose [framasoft](http://www.framasoft.net/ "Se rendre sur la page d'accueil de Framasoft") à la [rubrique Galerie Photos](http://www.framasoft.net/rubrique387.html "Se rendre sur la page dédiée à la galerie photo sous Framasoft").

Plusieurs logiciels se présentaient à moi, mais d'aucun n'avait une chose (ou plutôt ne l'avait pas) : tourner sans avoir besoin d'une base de données.

C'est alors que, sur la page, je vis **SPGM, Simple Picture Gallery Manager**.

### SPGM

Il ne faut pas se fier aux apparences ni au noms, je trouve que le mot *manager* est un peu surenchéri, puisque SPGM ne fait qu'afficher des images, rien de plus. Aucune gestion particulière n'est faite.

Bon ça vaut tout de même son pesant d'or, comme nous allons le voir.

#### Tests concluants

Quelques tests en quelques minutes : SPGM fonctionne à la décompression de l'archive. Miracle de la nature ! (ou de l'homme plutôt).

On peut cependant configurer SPGM via les fichiers **spgm.conf** dans chaque galerie (ou tout simplement ne garder qu'UN seul spgm.conf).

> Mais ... euh comment je fais pour ajouter des images ? Il me fait une énormité d'erreurs.

#### Scripts

C'est bête, mais SPGM a besoin que nous déposions à la fois les images, et leurs miniatures, et attention, il veut qu'elles soient préfixées de **__thb__**, auquel cas il ne veut rien savoir !

Soit vous vous occupez de rester à [genethumb](http://sam.zoy.org/projects/genethumb/ "Se rendre sur la page officielle du projet genethumb"), un script qui crée des pages html à partir de dossiers, soit vous utilisez un script bash fait maison.

Par chance je me suis dit qu'il vous intéresserait d'avoir ceux que j'ai fait, j'ai tout expliqué dans ma page Wiki (cf titre suivant).

#### Page Wiki

Ainsi le [Quicky Blanko](/wiki/ "Se rendre sur la page d'accueil du Quicky Blanko") possède une [nouvelle page consacrée à SPGM, Simple Picture Gallery Manager](/wiki/doku.php?id=configurations:spgm:index "Se rendre sur la page proposant les scripts de SPGM produits par Blankoworld").

Cette page ne devrait pas avoir à proposer d'autres astuces que celle présentes, à moins que vous ne m'en donniez ;) 

### Conclusion

Il fait du bien de devoir à nouveau pouvoir vous écrire, sans trop de maux de tête (Cf. [tourments blankoïques](${BASE_URL}/archives/2009/04/07/tourment_blanko&iuml;que/index.html) qui expliquent en partie quelques soucis).

Cette galerie me convient désormais, et n'est plus sur un site Free à la limite de tomber dans un gouffre pour ne plus jamais en ressortir !

Profitez des photos sur la [galerie Blankoesque](http://images.dossmann.net/ "Découvrir la galerie Blankoesque").


