### Introduction

Connaissez-vous les machines virtuelles ? Ces espèces de boîtes dans lesquelles on peut faire tourner un système d'exploitation entier et qui permettent de quasiment de faire fonctionner des services de la même manière sous différentes plateformes ?

Si vous lisez l'article, je suis sûr que oui ! La virtualisation est un outil formidable, plus encore avec [VirtualBox](http://virtualbox.org "Se rendre sur la page officielle de VirtualBox").

Le problème, quand on a un serveur distant, c'est que nous n'avons pas d'interface graphique pour créer et gérer ses machines virtuelles.

![VirtualBox About Image](${BLOG_URL}/images/logiciels/virtualbox_ose.png "Image du 'à propos' de VirtualBox")

### Description du problème

En effet, quand on installe VirtualBox sur un serveur sans interface graphique, on ne sait pas trop comment créer une machine virtuelle ni comment la lancer. Certes on pourrait créer la machine virtuelle sur notre ordinateur, puis l'envoyer sur notre serveur. Mais comment la lancer ensuite ?

Il existe bien un VBoxManage (commande console) pour gérer les machines virtuelles, mais c'est très fastidieux.

L'idée serait d'avoir une interface qui se connecte au serveur distant afin de pouvoir créer et gérer nos machines virtuelles.

### L'interface qui va se connecter au serveur distant

Cette interface existe, elle se nomme [RemoteBox](http://remotebox.knobgoblin.org.uk/ "Aller sur le site officiel de RemoteBox").

Cela permet de se connecter à notre VirtualBox distant et de voir quelles machines virtuelles existent, en créer de nouvelles et les gérer.

Et le mieux dans tout ça : l'interface ressemble très fortement à VirtualBox, ce qui ne nous dépayse pas ;)

### En bref, comment procédons-nous ?

Pour résumer la manière de procéder, en quelques étapes ([que je détaille sur dans un tutoriel](https://olivier.dossmann.net/wiki/configurations/virtualbox/index "En savoir plus sur l'installation et la configuration de VirtualBox en mode webservice")): 

  * On installe VirtualBox sur le serveur distant
  * On installe le pack d'extension qui permet de lancer le Web Service sur le serveur distant
  * On enlève la vérification identifiant/mot de passe du Web Service (sachant que nos ports sont fermés)
  * On lance le service web sur le serveur distant
  * On installe RemoteBox sur notre machine locale
  * On ouvre les ports 18083 et 3389 en SSH (tunnel)
  * On utilise RemoteBox pour s'y connecter

Il y a plus de détails sur mon wiki au sujet de l'[installation et configuration de VirtualBox en mode serveur et utilisation de RemoteBox pour s'y connecter](https://olivier.dossmann.net/wiki/configurations/virtualbox/index "En savoir plus sur l'installation et la configuration de VirtualBox en mode webservice").

### Conclusion

Avec RemoteBox, l'utilisation de VirtualBox sur nos machines distantes est facile et sécurisée (puisqu'on utilise des tunnels SSH). Je n'ai plus peur de créer une machine virtuelle et d'en suivre son installation mais aussi de gérer l'allumage et l'extinction de ces dernières.

À noter qu'il existe aussi une interface nommée [phpvirtualbox](http://sourceforge.net/projects/phpvirtualbox/ "Découvrir le projet phpVirtualBox") qui permet d'avoir l'interface via un navigateur Web.

En revanche les machines virtuelles demandent d'allouer un espace mémoire vive à ces dernières et bloquent donc une partie de la mémoire. Si on veut utiliser 5 machines à 1Go de mémoire vive, on bloque 5Go.

Des solutions plus efficace existent pour ne lancer que quelques services dans des *genres* de machines virtuelles : les conteneurs. Par exemple [Docker](http://docker.io "Découvrir Docker") qui est une solution qui se fait connaitre de plus en plus et qui sera probablement le sujet d'un prochain article !
