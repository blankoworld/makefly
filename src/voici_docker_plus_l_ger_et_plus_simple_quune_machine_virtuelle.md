### Introduction

[Nous parlions précédemment de VirtualBox pour créer des machines virtuelles](${BLOG_URL}/article/serveur_de_machines_virtuelles_avec_virtualbox.html "Lire l'article Serveur de machines virtuelles avec VirtualBox") sur sa machine. C'est une solution pratique qui permet de tester un environnement sans avoir à installer quoique ce soit de plus que VirtualBox sur sa machine et sans perdre de données. Un environnement fermé.

Mais quand il s'agit de lancer plusieurs services sur une machine (un serveur web, un serveur de base de données, une application web, etc.) cela devient tout de suite lourd et consommateur de mémoire vive + espace disque.

Des solutions alternatives existent, comme l'utilisation de LXC qui sont des conteneurs qui utilisent communément le noyau Linux mais fonctionnent à peu de choses prêts comme ce que nous appelons des **chroots**. Cependant cette solution n'est pas si simple car il faut gérer les conteneurs, leur lancement, etc.

Une solution plus simple, se basant sur les LXC existe : [Docker](http://docker.io "Visiter la page officielle de Docker.").

![Logo de Docker](${BLOG_URL}/images/logos/docker.png "Logo du projet Docker")

### Présentation de Docker

Pour [en savoir plus sur Docker](https://www.docker.io/learn_more/ "Leanr more about Docker"), il faut se rendre sur la [page prévue à cet effet sur le site officiel](https://www.docker.io/learn_more/ "Learn more about Docker").

Mais pour vous résumer un peu ce que j'en ai compris : 

  * Docker permet de créer des applications dans un conteneur
  * Un conteneur est plus léger en terme de taille et en terme de consommation mémoire qu'une machine virtuelle entière
  * Les conteneurs peuvent être construits à partir d'un simple fichier nommé le Dockerfile
  * Les conteneurs peuvent être partagés via un dépôt public ([Index Docker](http://index.docker.io "Trouver un docker particulier"))
  * La création d'un conteneur peut se faire via l'utilisation de **commit**, ce qui permet de versionner les conteneurs
  * La création d'un conteneur peut se faire via l'héritage d'un autre conteneur

Ainsi : 

  * faire tourner plusieurs conteneurs est plus léger que créer plusieurs machines virtuelles
  * le versionnement de ses conteneurs permet de redémarrer depuis un précédent commit, de rejouer certaines choses ou améliorer des conteneurs précédents
  * le Dockerfile est un simple fichier, ce qui permet de partager/déplacer une application contenue dans un conteneur de manière très rapide
  * plus de soucis avec les collègues au sujet d'un environnement différent d'un développeur à l'autre : tout le monde utilise la même version du conteneur

Vous l'aurez compris, cela n'a que des avantages - quasiment.

### Installation et utilisation

Le site de Docker nous apprend [comment installer et utiliser Docker en quelques points](https://www.docker.io/gettingstarted/ "Getting started on Docker"), mais aussi [la page Docker de mon Recueil d'astuces](https://olivier.dossmann.net/wiki/configurations/docker/index "Apprendre à installer et utiliser Docker sur Debian AMD64").

Ce que je pense qu'il faut au minimum retenir ce sont les commandes suivantes : 

<pre name="code" class="bash">
# Créer un nouveau conteneur basé sur Ubuntu
docker run -i -t ubuntu /bin/bash
# Voir les conteneurs lancés
docker ps
# Voir tout les conteneurs crées
docker ps -a
# Voir les images disponibles sur notre machine (à partir desquelles créer de nouveaux conteneurs)
docker images
# Supprimer un conteneur (ID est l'identifiant donné par la commande docker ps -a)
docker rm ID
# Donner un nom à son conteneur (--name). Utile à la place d'utiliser un ID
docker run -i -t --name SuperNom ubuntu /bin/bash
</pre>

Et évidemment, le plus intéressant est de regarder [l'index des fichiers Docker disponibles](http://index.docker.io "Découvrir de nouveaux fichiers Docker").

### Quelques regrets

En faisant quelques conteneurs Docker, on peut regretter : 

  * le fait qu'il faille utiliser supervisord de manière systématique pour lancer plusieurs services dans un conteneurs.
  * l'utilisation d'espace partagés ne nous prévient pas qu'on risque d'écraser nos propres données sur la machine hôte
  * ne fonctionne que sur architecture am64
  * ne fonctionne que pour Linux (puisque basé sur LXC), donc sous windows il faut utiliser une machine virtuelle avec Ubuntu

Si on se soustrait de ses inconvénients, cela reste un outil intéressant !

### Conclusion

Docker est un outil intéressant comparé à la gestion, la création et l'utilisation de conteneurs LXC, c'est une surcouche très attrayante.

J'apprécie qu'on puisse générer un environnement commun à l'ensemble d'une équipe de développeurs afin qu'ils aient toujours les mêmes bibliothèques et outils. En revanche, pour de la production je ne trouve pas cela encore assez au point car réussir à lancer plusieurs services sur un conteneur est vite décourageant et demande pas mal de connaissances !

Mon utilisation de Docker resterait donc du côté développement, afin d'utiliser un fichier simple qui génère un environnement complet de développement et de déploiement local d'un ou plusieurs services. Par exemple pour avoir un serveur OpenERP ou bien un serveur postgreSQL.

Je pense que ça peut-être déployé sur un serveur distant (machine virtuelle ou non) avec plusieurs conteneurs, un par service afin de permettre de déployé/déplacer un service rapidement, sans effort et sans pertes.

Je verrais cela à l'utilisation, et je vous invite à en faire autant !

### Liens utiles

  * [En savoir plus sur Docker (en)](https://www.docker.io/learn_more/ "Learn more about Docker")
