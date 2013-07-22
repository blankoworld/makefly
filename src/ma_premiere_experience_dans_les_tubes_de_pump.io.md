### Introduction

Je suis utilisateur de certains réseaux sociaux tels qu'[Identi.ca](http://identi.ca "Découvrir identica") ou encore [Twitter](http://twitter.com "Se rendre sur le portail Twitter") (notamment grâce à un pont entre identica et twitter).

Pour rappel ces deux réseaux sociaux sont considérés de [Microblog](http://fr.wikipedia.org/wiki/Microblog "Définition de Microblog par Wikipedia FR"), c'est à dire une courte phrase limitée à 140 caractères pour exprimer quelque chose. C'est d'ailleurs plus court que les anciennes limites du texto sur téléphone mobile.

Ainsi, dans le monde d'Identica s'est déroulé récemment une succession d'évènements plutôt déroutants : le mainteneur principal du logiciel statusnet (utilisé par Identica) a laissé le projet à la communauté et s'est tourné vers un nouveau produit assez proche : [pump.io](http://pump.io "Découvrir le site officiel du projet pump.io").

À la rigueur ce n'est pas un problème, [sauf si ledit mainteneur, Evan Prodromou, compte passer le site identi.ca à pump.io](https://e14n.com/evan/note/CuaONBbwQcyenRzC93R6Mw "Découvrir la note d'Evan au sujet du passage d'identica à pump.io").

Cet article donne mon expérience et mes impressions sur ce nouvel outil (pump.io) que j'ai testé en local.

![Water pump](${BLOG_URL}/images/nature/water_pump.jpg)

Photo par Darmin70 sur [son album Flickr](http://www.flickr.com/photos/darwin70/1200152443/in/photostream/ "Découvrir l'album de Darwin70").

### Concrètement que faire dans pareille situation ?

On a le choix entre : 

  * [Option 1] installer une instance de statusnet et rappatrier son historique identi.ca puis se réabonner à toutes les personnes qu'on suit
  * [Option 2] utiliser la nouvelle mouture de pump.io qui sera installée sur identi.ca
  * [Option 3] installer une instance de pump.io chez soi

Sachant qu'avec l'option 2 on sait :

  * que les personnes ayant leur propre instance d'identi.ca chez eux ne seront plus visibles dans la liste de nos abonnées et/ou des personnes que nous suivons
  * que les logiciels que nous utilisons pour consulter identi.ca, publier un message ou suivre de nouvelles personnes ne fonctionneront pas

Pour faire bien, il me faudrait installer une instance compatible avec statusnet pour continuer de suivre les personnes qui ont ce type d'instance, et trouver des clients ou adapter des clients pour se connecter à la nouvelle mouture de pump.io.

Qu'en est-il de statusnet ?

### Ma réflexion sur la création d'une instance statusnet

J'ai listé 2 possibilités d'instances statusnet (comprendre compatible avec l'actuel statusnet) : 

  * [statusnet](http://status.net/ "Aller sur le site de la communauté statusnet") tel qu'il a été laissé par Evan (normalement entre de bonnes mains)
  * [rstat.us](https://rstat.us/ "Aller sur le site officiel de rstat.us"), une alternative plus légère à statusnet

#### Le logiciel statusnet

Il m'ennuie car : 

  * Il faut réussir à l'administrer correctement
  * Je ne vois pas de page sur comment l'installer (un peu le boxon)
  * Il fonctionne avec MySQL, je n'ai pas MySQL sur mon serveur et ne compte plus du tout l'installer car j'en ai horreur (ceci est personnel)
  * Il faut installer pleins de plugins pour arriver à reproduire les quelques fonctionnalités sympas d'Identi.ca, et là on se lance dans quelque chose de grand !

Il est cependant intéressant pour le fait qu'il peut être "mono-utilisateur", c'est à dire restreint à une personne. Ce qui limite ensuite le suivi des enregistrements véritables ou non.

Passons à autre chose.

#### Le logiciel rstat.us

Il semble sympathique pour les raisons suivantes : 

  * Utilise une autre base de données que MySQL, à savoir : MongoDB
  * Est en RubyOnRails que j'utilise déjà pour différents sites sans problème majeur

En revanche :

  * Il ne fonctionne pas toujours au top avec les instances statusnet
  * MongoDB semble pas mal, mais utilise beaucoup le disque dur et la mémoire vive, à utiliser avec modération je pense

#### Ainsi

Je me suis alors tourné vers l'option 3 : installer et tester pump.io.

### Quelques mots doux pour pump.io

Pump.io est un projet encore très jeune, il est en version 0.2.1 mais avance assez vite dans son développement.

Il fonctionne sur un mode décentralisé (chacun peut avoir son instance et se connecter à celle des autres) et permet de partager ce qu'il appelle des "notes" sans aucune limite du nombre de caractères ;  mais aussi des images afin de partager des moments clés de notre vie ou des éléments hilarants trouvés ici ou là.

L'outil est développé en javascript et n'en est qu'à ses débuts, donc le peu de fonctionnalités et de routines font de lui un outil plus rapide que ses concurrents/prédécesseurs.

À noter que l'outil est un serveur à part entière. Il fournit le serveur et le client.

Pour [plus d'informations au sujet de pump.io](http://pump.io "En savoir plus sur pump.io"), je vous renvoie au [site officiel de pump.io](http://pump.io "En savoir plus sur pump.io").

### Particularités de l'installation

Je ne décrirai pas l'installation de pump.io car vous pouvez [lire l'installation de pump.io 0.3-trunk sur le Quicky Blanko](https://olivier.dossmann.net/wiki/configurations/pumpio/index "Comment installer pump.io sur Debian Squeeze selon Olivier DOSSMANN").

Cependant sachez que vous pouvez choisir quelle base de données vous allez utiliser ou tout simplement si vous voulez utiliser des fichiers pour stocker les résultats de l'utilisation de votre instance pump.io.

Ainsi je suis resté sur une base de données Redis qui semble facile à installer et à utiliser sous GNU/Linux Debian.

Ensuite il suffit de quelques commandes simples pour réussir à installer/configurer et lancer une instance pump.io. C'est un avantage certain.

Une telle configuration système ne peut pas s'effectuer sur la plupart des hébergeurs, cela restreint donc l'utilisation à grande échelle, mais largement suffisant pour tester et utiliser chez soi ! Ce qui, en passant, est le but des logiciels décentralisés : l'utiliser et le garder chez soi.

### Première utilisation sur pump.io

Je tiens à rappeler que j'ai utilisé une version "en cours de développement", il se peut donc qu'il y ait des incohérences entre un pump.io que vous testez et celui que j'ai eu sous la main.

Avant tout c'est une interface simple et claire qui nous accueille sur l'instance. Très peu de texte, très peu d'options : on sait directement où aller, c'est sur "Register" que je me rends donc pour devenir le premier utilisateur de ma propre instance.

Vous sentez d'ailleurs cette modification de ma voix dans "ma propre instance" ? Non ? Toujours pas ? Ça secoue un peu de pouvoir dire qu'on a sa propre instance d'un outil décentralisé. On se sent à la fois fier et libre. Libre de choisir un autre outil… ou de réutiliser un outil moins libre… ou tout simplement d'adapter à ses besoins !

Donc pour reprendre, une fois enregistré/connecté en deux coups de cuillère à pot, on se retrouve sur notre "mur" - nommé **Activity**.

Ensuite on peut y poster facilement une note ou une image puis la partager en sélectionnant des groupes d'utilisateurs ou des utilisateurs.

### Ce que j'aime

  * interface simple
  * intuitif
  * rapide
  * clair (dans les objectifs, les noms choisis, la façon de trouver)
  * il y a peu de fonctionnalités mais les quelques existantes semblent suffisantes
  * pas de limitation dans le nombre de caractères
  * ajout d'images possibles
  * utilisable comme d'un blog/microblog
  * gestion fine des permissions pour les groupes/utilisateurs pour CHAQUE billet/note/image et ce de manière très simple ! Un pur bonheur.

Tout n'est cependant pas rose, surtout à partir du moment où j'ai voulu papoter avec d'autres personnes sur d'autres instances pump.io.

### Ce que je n'aime PAS

  * se connecter sur une instance distante peut prendre parfois 2 à 5 minutes (jusqu'à ce que le serveur en ait marre j'imagine)
  * le flux est très lent à l'affichage
  * pas de page suivante/précédente pour le flux, on commence de la dernière publication au plus ancienne en déroulant la page encore et encore…
  * pas de bouton "Unshare" (ou pas fonctionnel) sur une note que j'ai partagée de manière malhabile (après une fausse manipulation).
  * on peut commenter une note sans choisir de la rendre publique ou non à telle ou telle personne. Par défaut ça partage à ceux qui suivent déjà l'utilisateur dont provient ladite note
  * parfois le logiciel tourne dans le vide (c'est une impression j'imagine). Pas de réponse visuelle, on ne sait pas si cela a fonctionné ou non une fois récupéré
  * pas de traduction de l'interface ni de choix possible d'une quelconque langue
  * mes clients habituels ne fonctionnent pas sur pump.io, TOUT doit être fait sur l'interface web
  * comment trouver/retrouver quelqu'un dans une instance donnée sans appel à l'API ?
  * on ouvre le menu, on clique => la page s'affiche mais le menu reste ouvert. WTF?
  * on supprime une catégorie : aucun rafraîchissement de la page -__-
  * j'ai un souci pour suivre des personnes extérieurs, [je n'ai pas encore trouvé l'explication](https://github.com/e14n/pump.io/issues/570 "en savoir plus sur mon problème"). C'est complètement bloquant pour un logiciel qui se veut être un réseau social en relation avec le monde extérieur
  * quand on a cliqué sur le lien pour lire un commentaire, on a plus de lien vers la note initiale. On est perdu.
  * parfois j'ai la liste des personnes à qui je veux écrire, parfois pas
  * on peut partager une note qu'on a déjà publiée publiquement (à quoi cela sert ?)

Il doit y avoir encore pleins de critères, mais je vous fais fi de tout cela.

### Critiques / Bugs / Problèmes

Je considère certains points problématiques. Voici les explications.

#### Internationalisation

D'après [le ticket suivant](https://github.com/e14n/pump.io/issues/502) il semble qu'il n'y ait encore aucune idée pour régionaliser l'application. Rien de rien. Même pas une petite idée d'un système logiciel pouvant le faire ou ayant été fait en javascript pour cela. Néant complet.

On se sent seul.

Très seul.

Bref, d'un point de vue logique, cela m'échappe de faire une application de **réseau social**, oui oui réseau social, je le répète, **réseau social**. Comment créer des liens entre des personnes qui ne peuvent même pas avoir l'application transformée suivant leur propre langue ?

C'est très curieux de ne pas avoir mis ça en haut de liste dans les contraintes. Identica est en plusieurs langues.

#### Trouver de nouvelles personnes à suivre

Twitter vous propose de suivre des stars (que ce soit leur compte réel ou pas on s'en fou). Identica vous offre le luxe de voir les derniers billets/messages sur un "mur public".

Chez pump.io, vous ne savez pas qui utilise votre serveur. Vous ne voyez pas les autres, vous ne savez pas qu'ils existent. Ça ressemble donc à un réseau d'autistes.

> Super, je viens de m'inscrire à un outil de réseau social, je ne sais pas qui suivre ni qu'ils existent et mes amis sont restés sur Facebook, Twitter, Identica, etc.

C'est exactement ça.

**Edit** : [Mart-e nous explique sur son instance Statusnet que Ofirehose devrait s'occuper de trouver des gens](http://status.dotzero.me/conversation/76249#notice-85433).

**Fin de l'Edit**

#### Points techniques

Côté technique, je relève deux points car je n'ai pas été plus en profondeur : 

  * pour mettre à disposition du public son instance, tout en pouvant se connecter à celle des autres, vous devez utiliser le port 80. Ce qui bloque la possibilité de faire d'autres accès web sur le port 80. Grossomodo vous devez avoir un serveur et un sous-domaine rien que pour pump.io. Nul ? Non, ARCHInul !
  * un système de permissions a été mis en place : Oauth 1.0. Je ne comprends pas pourquoi le projet n'a pas démarré de suite avec la version 2.0. Surtout que l'auteur avoue comprendre peu de la version 1.0… Ce n'est pas très rassurant pour un outil sur lequel on publie tout un tas de choses sur nous.

**Edit** : Ce sur quoi je voulais vraiment insister pour Oauth 1.0 est surtout une phrase lue sur le wiki de pump.io au [sujet de la connaissance de Oauth 1.0 vs. Oauth 2.0 par Evan Prodromou](https://github.com/e14n/pump.io/blob/master/API.md#authentication "Lire la phrase dont je parle sur le wiki Github du projet pump.io"). Notamment la phrase suivante : 

> I can barely understand OAuth 1.0 and I can't figure out OAuth 2.0 at all, so I'm sticking with 1.0.

**Fin de l'Edit**

### Conclusion

Vous préférez pomper l'eau vous-même au puit sans assurance de continuité ou utiliser l'eau courante à domicile ? Peut-être préférez-vous un système qui soit un mélange des deux ? 

À vous de choisir, dans mon cas ce ne sera probablement pas pump.io. J'ai besoin d'être rassuré sur la régionalisation de l'interface, l'accès aux instances distantes et la possibilité de mettre le service derrière un proxy afin de pouvoir disposer de plusieurs services webs sur le port 80.

Je ne le conseille que pour une utilisation privée au sein d'une entreprise par exemple ou bien pour une association ou un évènement spécifique.

### Liens

  * [Site officiel de pump.io](http://pump.io "Se rendre sur le site officiel de pump.io")
  * [Article francophone sur la découverte de pump.io par Mart-e](http://mart-e.be/post/2013/04/02/pump-io-un-nouveau-reseau-social-libre-et-decentralise/ "Lire l'article de Mart-e concernant pump.io")
  * [Définition du mot Microblog suivant Wikipédia FR](http://fr.wikipedia.org/wiki/Microblog "Définition du mot Microblog suivant Wikipédia FR")

