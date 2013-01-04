Suite à [ce délicat billet](http://glenux.net/index.php?2008/04/04/58-bd-on-croyait-et-esperait-que-ca-n-existait-plus "Visionner le billet de Glenux"), puis encore [celui là](http://glenux.net/index.php?2008/04/11/64-bd-backups-strike-again "Visionner le billet numéro 2 de Glenux") de Glenux, et de nombreuses années de rêves, j'ai enfin décidé de me lancer dans la pseudo - création de sauvegardes du serveur ! Cela vous intéresse ? C'est par ici !

### Recherches

On ne peut pas dire que cela manque sur le net les solutions de sauvegardes, mais je les trouve un peu anciennes, pas trop complètes, bref c'est le boxon. Je suis principalement tombé sur deux sujets intéressants donc je vous donne les liens : 

  * [Article sur LinuxFR.org](https://linuxfr.org/~Louis/18318.html "Se rendre à l'article concernant une liste de solutions de sauvegardes") sur lequel j'ai notamment retenu [les scripts de Mike Rubel](http://www.mikerubel.org/computers/rsync_snapshots/ "Visiter le site de Mike Rubel")
  * [Script de sauvegarde mysql par ftp](http://www.billyboylindien.com/linux/script-de-backup-mysql-par-ftp.html "Visionner le script de sauvegarde des bases de données MySQL")

A cela je tiens à ajouter qu'un article intéressant sur la création d'un serveur de sauvegardes incrémentales était paru dans le magazine n°32 de Linux Pratique de novembre / décembre 2005 à la page 46 par Pierre Lafaye de Micheaux. Article intéressant à la lecture, à conseiller si vous faites les marchés aux puces / vide - grenier (des fois que vous trouviez un de ces magazines).

### Résultats et application

De là, pas compliqué, de l'huile de coude, quelques copies de scripts, et le tour est joué !

 :huh: Ce que j'ai utilisé ? Ah oui, eh bien j'ai opté pour l'utilisation de rsync, ce qui évite de copier un million de fichiers et on ne sait combien de Mo / Go de données (oui c'est ça la notion de sauvegarde incrémentale). Du coup le script pour la sauvegarde de base de données MySQL a été adopté, avec modification pour le faire fonctionner par ssh et en utilisant rsync.

Mon serveur se connecte sur mon ordinateur fixe (dans ma chambre), aux heures où je l'utilise, à l'aide de la commande suivante : 

	rsync -e ssh -av --delete --hard-links --progress /home/olivier/joueb blanko@192.168.1.11:/home/blanko/sauvegarde/

Ceci est à mettre dans un script, évidemment. Et pour éviter d'avoir à toujours taper votre mot de passe, allez sur votre serveur, puis créez une clé une paire de clé, comme ceci :

	ssh-keygen -t rsa

Appuyez 3 fois sur entrée sans demander votre reste. Puis faites : 

	cat ~/.ssh/id_rsa.pub | ssh blanko@192.168.1.11 'cat - >> ~/.ssh/authorized_keys'

Sur l'ordinateur fixe (192.168.1.11) faites alors, en tant qu'utilisateur root : 

	chmod go-w /home/blanko/.ssh

Et le tour est joué !

A partir de cette méthode, et de quelques ajouts dans la tables de tâches crontab, on peut automatiser la synchronisation de ses fichiers et de sa base de données.

### Pour aller plus loin

Mon système n'est pas des plus tops, mais fonctionnel. On pourrait penser à ajouter à cela une copie de ma station fixe sur un DD externe (ce que je ferais après la création de ce billet), ou encore la sauvegarde manuelle hebdomadaire de l'ensemble d'une partition ou des configurations du système. Sur la page LinuxFR que j'ai donnée en lien au début de cet article, un logiciel permet de gérer correctement les sauvegardes d'une partition entière, à voir. Bien que partimage le fasse très bien, mais pour des partitions non actives (autrement dit pour un système qui n'est pas en cours d'utilisation).

On pourrait donc imaginer une sauvegarde rsync au travers du net vers un autre serveur permettant l'utilisation de rsync, par exemple un ami à vous, les chances pour que vos deux serveurs GNU / Linux plantent en même temps est mince, donc pensez à sauver à deux endroits différents.
