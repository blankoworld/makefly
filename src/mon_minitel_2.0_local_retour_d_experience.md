### Introduction

Ne vous a-t-on jamais dit qu'il fallait avoir son blog chez soi ? Avoir son *Google* chez soi (agenda, courriel, contacts), son lecteur de flux RSS - surtout avec Google Reader qui veut prochainement fermer - ou encore son Dropbox like pas loin ? Ça fait beaucoup, je sais, allons-y doucement.

On appelle souvent cela **s'auto-héberger**, c'est à dire - grossomodo - mettre un ordinateur chez soi, le brancher sur sa FAIbox et le laisser allumé toute l'année...

Non ! Ne partez pas ! Restez quelques instants pour en savoir plus, tout n'est pas perdu - et surtout pas votre argent - il y a encore de l'espoir que ce soit possible et cela facilement !

Comme j'ai vécu l'essai en conditions réelles, je vous propose tout d'abord de vous expliquer mon expérience et mes découvertes avant de croiser ces dernières avec celles d'autres pour finalement terminer sur une solution possible pour vous, oui vous lecteurs qui me lisez !

**NB : Le rédacteur de ce billet, le blog tout entier et le billet lui-même ne sont pas responsables de tout éventuel bug du cerveau suite à la lecture de tout ou partie de ce billet.**

![Pissenlit pour essaimage](${BASE_URL}/images/nature/pissenlit.jpg)

Photo sous licence Creative Commons CC-BY-NC-SA 2.0 trouvé sur [l'album Flickr de GnondPomme](http://www.flickr.com/photos/gnondpomme/6126647498/).

### Ma petite histoire de l'Internet

#### Découverte

Je commençais à découvrir l'outil informatique en 1995, après quoi, en 1998, un ami me donnait une vingtaine de pages imprimées pour apprendre à faire des pages web au **format HTML**. Je tentais d'utiliser Microsoft FrontPage 95 pour cela. Au final le rendu était bien meilleur quand on faisait soi-même avec un éditeur (comme Notepad++ que je découvrais bien plus tard).

Je n'avais pas d'accès à Internet à cette époque. D'une part j'étais mineur, d'autre part c'était encore un "privilège" de pouvoir y accéder. J'ai bravé les interdits familiaux, et entouré d'une serviette, pendant la nuit, un modem 56K s'étouffait en tentant de se connecter au réseau des réseaux : **Internet**.

En 2001 je découvrais **GNU/Linux** - 10 ans après sa création/publication. Ce système semblait être sans limite, plein de richesses, complet et stable. Avide de savoir je surfais sur le web à la recherche de nouvelles astuces ou solutions à des problématiques qui se posaient. Je découvrais alors des communautés inter-connectées qui avaient un point commun avec ma personnalité : **le partage**. Internet est un réseau de communication. Communiquer implique de diffuser un message envers un ou plusieurs interlocuteurs. C'est bien de cela dont il est question : le partage.

#### Les hébergeurs web gratuits

J'avais accès libre à des hébergeurs gratuits, des espaces où déposer mon site web, mais rien de "stable" ni de réellement concret. Je commençais à blogguer sur Lycos, puis sur Skyblog, mais les résultats n'étaient pas probant.

Fin 2004 un ami me parlait d'un opérateur internet qui s'était implanté dans la région : Free. Il proposait un **service d'hébergement**, pas loin de 100Mo avec un domaine facile à retenir. Ça semblait même fonctionner si vous n'étiez plus client !

Pour faire simple : j'avais une connexion internet, et parce que j'avais cette connexion internet, je pouvais mettre des pages sur le net à disposition de tout le monde. J'étais référencé, avait un nom de domaine, etc. Ça commençait à devenir intéressant car le fait d'être possesseur d'un accès à Internet devenait la possibilité d'en devenir acteur, même sans posséder les câbles ni la location de ces derniers.

Tout allait donc pour le mieux.

#### Le minitel 2.0

Un jour, un gus - Benjamin Bayard -, lors d'une rencontre de geeks nommée les RMLL (Rencontres Mondiales du Logiciel Libre), fait une [conférence nommée "Internet Libre ou Minitel 2.0"](http://www.fdn.fr/Internet-Libre-ou-Minitel-2,94.html). Je ne peux malheureusement pas expliquer aussi bien que lui le contenu de cette conférence, mais retenez ceci : si vous créez du contenu (photos, images, dessins, vidéos, musiques, blog, livres, textes, jeux, etc.) qu'il soit pourrave ou vaut de l'or, qu'il soit libre ou non, si vous le diffusez sur Internet, vous devriez être au minimum détenteur de ce même contenu. Diffusez le comme vous l'entendez, mais gardez-le au minimum chez vous (et accessible) !

En utilisant des services comme ``Y*utube, F*ceb*ok, Skybl*g``, **vous donnez à d'autres personnes de quoi vivre sur vos contenus**. On peut également supprimer votre contenu sans aucun problème, sans vous avertir et sans que vous ayez à donner votre avis. Toute manière on s'en fout de votre avis. Vous êtes un porte-monnaie ambulant qui régurgitez de l'or dont vous n'êtes pas conscient. On a même pas besoin de venir vous cherchez, vous venez directement chez nous pour nous donner tout vos biens.

Bref, tout mettre sur les services distants, c'est faire du Minitel 2.0. Tout mettre à un endroit n'est pas bon. Mais si chacun mettait du Minitel 2.0 chez soi, c'est à dire si tout les contenus étaient chacun **chez soi, on créerait de l'Internet** - du vrai. Ce pour quoi il a été réellement crée : **partager**. Sans limite, sans contraintes et sans modalité autre que d'avoir une connexion, de l'électricité, un ordinateur et accessoirement un logiciel qui comprenne la langue de votre ordinateur :-) .

Ainsi j'ai commencé à vouloir faire hébergeur, chez moi, dans la cave, comme tout les gus qui avaient suivi ce que l'autre gus des RMLL disait.

Je me lançais donc en 2008 à trouver une machine, un système d'exploitation, des logiciels et **surtout des tutoriels**.

### Bilan

Au fil des années, j'ai noté les problèmes que je rencontrais. D'une part la **difficulté apparente** pour installer un service web est nulle quand on sait qu'il y a non seulement des tutoriels à tout va sur Internet, mais en plus il y a **tout un tas de communautés prêtes à vous aider**. Certaines proposent même de vous héberger par le biais d'associations. C'est très sympathique et très stimulant. On apprend beaucoup. D'autre part certaines autres difficultés ne pouvaient être évitées comme : 

  * être mineur : pour prendre des décisions et faire des achats sur Internet, vous repasserez...
  * les contraintes familiales : vous empêchent parfois de régler un souci e-vital (électroniquement vital)
  * les coupures de courant : votre serveur tombe et les services associés sont indisponibles le temps de régler le souci
  * les pannes matérielles
  * l'ignorance : les gens ignorants font énormément de dégâts, je vous assure !
  * la stupidité : certains sont stupides, mais d'une force inégalable. Cela s'oppose parfois à l'auto-hébergement

Cependant, et je le répète, ce sont des choses qu'on apprend à contourner via l'**expérience acquise**. Pour vous donner du concret, voici les chiffres du nombre de pannes et problèmes que j'ai rencontrés au fil des années : 

  * 2008 : 12
  * 2009 : 4
  * 2010 : 2
  * 2011 : 5
  * 2012 : 1
  * 2013 : 378

> 378 problème en 2013 ?!!!!!!!

Non je blague, c'est le nombre de jours que mon serveur est resté allumé sans interruptions ni problèmes. Oh j'ai bien eu une coupure de courant cette année, mais j'ai un onduleur - sorte de batterie temporaire - qui se charge de prendre la relève temporairement. **On apprend** de ses expériences. Cet onduleur en est une des preuves.

Mon expérience montre donc que la chose est possible, mais qu'il faut être **patient** ! J'appréhende forcément bien mieux la mise en place et l'utilisation d'un hébergement chez moi désormais.

### Les "on dit que" à propos de l'auto-hébergement

Cherchez un peu dans un moteur de recherche à propos de l'auto-hébergement. Vous trouverez des fils de discussions qui se contredisent. Certains disent que c'est génial, d'autres que ce n'est pas une partie de plaisir. Au final, on s'en fou, **ce qu'il faut, c'est que vous ayez envie de vous auto-héberger, qu'importe ce que vous disent les gens**.

Bon, je vous le dis quand même - parce qu'ici c'est gratuit -, l'auto-hébergement c'est cool :-) . Trouvez du monde intéressé aussi, des personnes l'ayant déjà fait, et posez leur des questions à ce sujet. N'hésitez pas !

Je suis d'ailleurs disponible pour toute demande d'information supplémentaire.

On raconte qu'avoir un serveur chez soi consomme de l'Internet : c'est vrai, mais tout dépend comment vous consommez Internet. Si tout vos ordinateurs sont sur ``Micr*s*ft Wind*ws`` et restent allumés toute la journée, bourrés de virii (pluriel de virus), alors oui vous consommez un max ! Si vous utilisez parfois le service TV de votre FAIbox le soir et que pendant la journée vous bossez, alors non, ça ne consomme pas des masses.

Ça consomme du courant ? Trouvez d'autres arguments : un [RaspberryPi](http://blogbox.e-mergence.org/materiel/#index1h4) est une petite machine [facile à installer et à utiliser avec quelques tutoriels](http://tropfacile.net/). Elle consomme environ **5 euros par AN** en électricité si elle reste allumée toute la journée. Oui **5 euros par an**. Le prix d'achat de cette machine ? Au total environ **60 euros**. Alors à d'autres le "prix élevé" d'un serveur chez soi !

Système bruyant ? Le précédent appareil - RaspberryPi - ne consomme rien, ne fait pas de bruit, est petit, se branche derrière une box, voire se cache bien derrière/dessous et ne chauffe quasiment pas. Que demander de plus ? 10 balles et un Mars ?

### Quelques problèmes posés

Tout comme [Jbfavre l'explique en partie sur son Blog-Notes](http://blog-notes.jbfavre.org/?lautohebergement-ou-le-risque-de-lotohebergement,3034) - que je complète ici -, plusieurs problèmes se posent avec l'auto-hébergement comme : 

  * les problèmes techniques rencontrés
  * le besoin de présence en ligne, sachant qu'un problème survient et ne peut-être résolu dans l'heure
  * l'ignorance, voire l'imperméabilité de certains à l'outil informatique
  * comment expliquez-vous à quelqu'un la problématique des sauvegardes ?
  * la fainéantise des utilisateurs les amène au MIEUX à créer un compte sur un service, mais acheter un appareil, le brancher, le lancer, le configurer... ça fait trop !

Il reste donc la bonne volonté. Avec un peu de volonté, on arrive à tout, même à brancher un appareil et le configurer.

Quelles sont donc les solutions possibles pour faire du Minitel 2.0 (auto-hébergement) chez soi ?

### Quelques solutions

Après avoir mis en lumière la plupart des problèmes, quels peuvent-être les solutions à mettre en œuvre ? Là encore il n'y a pas de solution toute faite, mais plusieurs : 

  * faire fonctionner le tissu associatif et s'y regrouper pour proposer des services d'hébergement sans publicité ni toute une pléthore d'outils inutiles, gourmands, pas libres, etc.
  * trouver une personne pour nous guider dans l'auto-hébergement : un parainnage en quelque sorte.
  * la même chose mais une communauté entière
  * s'inscrire à un service mutualisé comme [Legtux](http://www.legtux.org/) ou [Kegtux](http://www.kegtux.org/)
  * se lancer dans [Yunohost](http://yunohost.org/), une distribution GNU/Linux ULTRA simplifiée pour avoir ses données chez soi

### Conclusion

Si vous êtes encore là, c'est que l'aventure et l'auto-hébergement vous intéresse très probablement ! Si c'est le cas, foncez ! Chercher des personnes pour vous conseiller ou vous rediriger si besoin, renseignez vous et lancez vous ! En cas de doute, je suis disponible pour des conseils sur [olivier[@]dossmann[point]net](mailto:olivier+joueb@dossmann.net).

Me concernant, l'auto-hébergement a fonctionné, ça fonctionne toujours et ça devrait encore fonctionner pour les jours/mois/années/décennies à venir. J'aime beaucoup l'auto-hébergement au point d'avoir quelques projets à ce sujet. Mais c'est une autre histoire :-) 

Très bonne aventure dans l'auto-hébergement et rappelez vous ce que [Framasoft](http://framablog.org) raconte : La route est longue, mais la voie est Libre !

### Liens utiles

  * [Conférence nommée "Internet Libre ou Minitel 2.0](http://www.fdn.fr/Internet-Libre-ou-Minitel-2,94.html)
  * [Réflexion sur l'auto-hébergement racontée par jbfavre](http://blog-notes.jbfavre.org/?lautohebergement-ou-le-risque-de-lotohebergement,3034)
  * [Une contre-histoire des Internets, documentaire d'ARTE TV](http://lesinternets.arte.tv/42/)
  * [Exemple de contre-histoire des internets par Reflets](http://reflets.info/ma-contre-histoire-de-linternet/)
  * [Appel à la reconstruction des Internets](http://faitmain.org/volume-2/ffdn.html)

