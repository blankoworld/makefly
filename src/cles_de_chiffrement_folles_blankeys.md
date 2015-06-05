Ces derniers jours ont été mouvementés ! En effet une nouvelle des plus ennuyante a été publiée chez [Debian](http://www.debian.org "Visiter le site officiel de Debian") concernant un [problème de sécurité sur openssl/openssh spécifique à Debian et dérivée](http://article.gmane.org/gmane.linux.debian.security.announce/1614 "Se rendre sur la nouvelle concernant le souci de sécurité de openssl/openssh").

### Résultats

Comme vous vous en doutez, il a fallu regénérer une paire de clé : 

	ssh-keygen -t rsa -b 4096

En faire un export pour putty (utilisé sous Windows) : 

	puttygen ~/.ssh/id_rsa -O private -o cle.ppk

Ensuite je me suis permis de regénérer les clés du serveur : 

	rm /etc/ssh/*key* && dpkg-reconfigure openssh-server

Et finalement j'ai remis les clés publiques sur le serveur en copiant les id_rsa.pub sur le serveur dans le /home de l'utilisateur et en faisant : 

	cat ~/.ssh/id_rsa.pub >> authorized_keys

Ça fait un peu de travail, mais on aime bien tester nos connaissances dans ces cas là et vérifier que tout fonctionne. J'en ai profité pour faire un recueil de quelques astuces sur le Quicky Blanko (Cf. Liens de ce billet.

### Et les clés à Blanko dans tout ça ?

Il pense qu'il serait intéressant de vous donner ses clés publiques, à tout hasard, voici un lieu où vous pourrez en disposer sans commune mesure : [Portedesetoiles, l'espace de stockage de Blanko](https://olivier.dossmann.net/fichiers/cles/olivier/ "Découvrir les clés publiques de Blanko").

Prenez en soin, et ne faites pas de bêtises !

### Lien

  * [La nouvelle officielle](http://article.gmane.org/gmane.linux.debian.security.announce/1614 "Lire la nouvelle anglaise")
  * [La nouvelle chez LinuxFR](http://linuxfr.org/2008/05/15/24092.html "Se rendre sur la nouvelle chez LinuxFR")
  * [Astuces sur le Quicky Blanko](http://olivier.dossmann.net/wiki/doku.php?id=astuces:chiffrement:index "Apprendre des astuces sur le Quicky Blanko")
