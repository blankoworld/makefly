### Introduction

Dans certain cas nous aimerions installer un service ou une application sans avoir d'incidence sur les services annexes d'une machine. On peut vouloir tester un outil, devoir utiliser une application sur une version particulière de notre distribution ou encore, dans notre cas, installer un serveur MySQL sur une machine Debian sur laquelle nous ne voulons pas influer.

Pour ces cas - et bien d'autres encore - une solution existe : les chroots. Le chroot est un espace isolé du reste de l'environnement et possède ses propres bibliothèques, outils, applications, etc. Il peut communiquer avec le reste du monde, la machine hôte, etc. Mais il ne peut pas influer sur autre chose que lui-même.

### Installation

Je vais donc vous décrire rapidement les commandes effectuées pour créer un chroot avec MySQL dedans. Pour des informations complémentaires je laisse les liens des tutoriels suivis dans le chapitre **Liens** de ce même article.

Voici donc les étapes successives (faites sur une Debian Squeeze) : 

  * Installation de l'outil **debootstrap**
  * Création d'un répertoire */srv/chroot/squeeze*
  * Initialisation de la variable CHROOT nécessaire à **toutes les opérations**
  * Création du chroot
  * Montage des répertoires importants
  * Identification sur le chroot
  * Mise à jour du chroot
  * Installation des *locales* et de nano
  * Modification de l'invite de commande pour savoir que nous sommes dans un chroot
  * Sortie puis entrée dans le chroot pour vérifier la modification de l'invite de commande
  * Installation de MySQL
  * Édition du fichier de configuration de MySQL
  * Redémarrage de MySQL
  * Édition de la configuration MySQL côté machine hôte

Et les différentes commandes : 

<pre name="code" class="bash">
su - root
apt-get install debootstrap
mkdir -p /srv/chroot/squeeze
CHROOT=/srv/chroot/squeeze
debootstrap --arch i386 squeeze $CHROOT http://ftp.fr.debian.org/debian/
mount -t proc proc $CHROOT/proc
mount -t devpts devpts $CHROOT/dev/pts
chroot $CHROOT /bin/bash --login
apt-get update
apt-get install locales nano
dpkg-reconfigure locales
echo "(CHROOT)" > /etc/debian_chroot
exit
chroot $CHROOT /bin/bash --login
apt-get install mysql-server mysql-client php5-mysql
nano /etc/mysql/my.cnf
</pre>

On édite les lignes suivantes : 

    bind-address    = localhost

puis on redémarre le serveur MySQL : 

<pre name="code" class="bash">
service mysql restart
</pre>

Ensuite on quitte le chroot et on édite le fichier de la machine hôte : 

<pre name="code" class="bash">
exit
nano /etc/mysql/my.cnf
</pre>

On édite les lignes suivantes : 

    [client]
    port    = 3306
    socket    = /srv/chroot/squeeze/var/run/mysqld/mysqld.sock

puis plus loin dans le même fichier : 

    bind-address    = localhost

et on ajoute la ligne suivante : 

    chroot = /srv/chroot/squeeze

Vous voilà désormais avec un chroot contenant MySQL !

### Conclusion

Créer un chroot n'est finalement pas compliqué. L'utiliser et installer des applications non plus. MySQL reste cependant particulier car il faut connaître l'option **chroot** du fichier de configuration. On rencontre aussi quelques difficultés avec PhpMyAdmin, mais ils peuvent être résolus via un [tutoriel de l'accès PhpMyAdmin à un chroot MySQL sur le Quicky Blanko](https://olivier.dossmann.net/wiki/configurations/mysql/index#acces_phpmyadmin "En savoir plus sur l'accès depuis PhpMyAdmin à un MySQL chrooté").

### Liens

  * [Installer un chroot](https://olivier.dossmann.net/wiki/configurations/chroot/index "Lire le tutoriel sur l'installation d'un chroot sous Debian GNU/Linux Squeeze")
  * [Installer MySQL dans un chroot](https://olivier.dossmann.net/wiki/configurations/mysql/index#installer_mysql_dans_un_chroot "Lire le tutoriel sur l'installation de MySQL dans un chroot sous Debian GNU/Linux Squeeze")

