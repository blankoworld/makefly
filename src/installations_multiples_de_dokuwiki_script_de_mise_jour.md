### Introduction

[Dokuwiki](http://dokuwiki.org/ "Se rendre sur le site officiel de Dokuwiki") est un outil formidable qui permet de créer un wiki simplement avec un serveur ayant PHP.

Il est tellement formidable que je l'ai installé dans quasiment chacun de mes projets. Seulement voilà, sa qualité est telle qu'il est régulièrement mis à jour ; ce qui me demande beaucoup de temps à chaque nouvelle version pour mettre à jour mes multiples installations.

### Recherche d'une solution

Je me suis dit récemment qu'il y avait forcément d'autres personnes qui avaient le même problème que moi. Et j'ai eu raison, d'autres personnes comme [Johannes Thönes explique comment mettre à jour de multiples installations de Dokuwiki à l'aide d'un script](http://blog.jthoenes.net/2010/01/24/a-ruby-script-for-upgrading-multiple-dokuwiki-installations/ "En savoir plus sur l'article de Johannes Thönes au sujet de l'installation de multiples Dokuwiki").

### Le couac

Cependant, en voyant [le script de Johannes Thönes](https://gist.github.com/jthoenes/285219 "Étudier le code de Johannes Thönes sur Github"), je me suis vite rendu compte qu'il n'était plus fonctionnel sur les versions courantes de Dokuwiki.

J'ai donc mis la main à la pâte et [je vous ai mis à jour le script de mise à jour de multiples installations de Dokuwiki](https://gist.github.com/blankoworld/10530850/revisions "Étudier les différences entre le script mis à jour par Olivier DOSSMANN et celui de Johannes Thönes sur Github").

Tout content de moi, je tente de lancer le script sur ma machine distante et BAM. Cela ne fonctionne pas à cause de dépendances avec le **gem libarchive**. Impossible de l'installer/compiler sous GNU/Linux Debian. Alors que sous Ubuntu cela passait sans problème. **Sgrumblblbl**.

Ainsi je me suis lancé dans une tâche inutile, ardue, futile, mais tellement enrichissante : la création d'un **script BASH** pour mettre à jour de multiples installations de Dokuwiki.

### Mettre à jour ses Dokuwiki à l'aide d'un script Bash

Après tout, me suis-je dis, Dokuwiki donne les commandes pour GNU/Linux, 80% des serveurs sont sous GNU/Linux, et puis cela demande moins de dépendances branlantes d'avoir BASH que d'avoir un script Ruby, non ?

Quoiqu'il en soit, [j'ai écrit un script BASH pour mettre à jour de multiples installations de Dokuwiki](https://github.com/blankoworld/divers/blob/master/upgrade_dokuwiki.sh "Découvrir le script d'Olivier DOSSMANN pour mettre à jour de multiples installations de Dokuwiki").

Tout ce que je demande pour que cela fonctionne, c'est : 

  * d'avoir CURL installé sur votre machine
  * d'avoir BASH (évidemment)
  * de modifier le fichier pour renseigner vos installations de Dokuwiki
  * lancer le script avec un utilisateur ayant les permissions totales sur les installations de Dokuwiki
  * donner le lien, en argument au lancement du script, de la [dernière version de Dokuwiki](http://download.dokuwiki.org "Vérifier la dernière version de Dokuwiki")

Ce que fait le script : 

  * Vérifie l'existence des répertoires d'installation
  * Vérifie la présence de CURL
  * Crée un répertoire temporaire et en donne l'adresse absolue
  * Télécharge la dernière version de Dokuwiki et l'extraie dans le dossier temporaire
  * Télécharge un fichier contenant la liste des fichiers obsolètes dans Dokuwiki
  * Pour chacun de vos Dokuwiki : 
    * Création d'un répertoire de sauvegarde dans le répertoire temporaire crée précédemment
    * Copie de sauvegarde de vos fichiers dans le répertoire temporaire
    * Copie des nouveaux fichiers Dokuwiki dans votre répertoire d'installation de Dokuwiki
    * Suppression des fichiers de Dokuwiki obsolètes
    * Mise à jour du message apparaissant à l'écran sur l'interface de Dokuwiki
    * Changement des permissions de votre installation de Dokuwiki avec l'utilisateur www-data et le groupe www-data (peut être changé dans le script)

### Conclusion

Première utilisation, première joie, première pause pendant que ça met à jour alors que nous sommes dans le fauteuil, peinard.

Je conseille évidemment ce script à tout le monde et suis curieux de savoir s'il servira à plus d'un ! [Contactez-moi](http://m.depotoi.re/ "Me contacter") pour plus d'informations.

### Liens utiles

  * [Dokuwiki](http://dokuwiki.org/ "Se rendre sur le site officiel de Dokuwiki")
  * [Dernière version de Dokuwiki](http://download.dokuwiki.org "Vérifier la dernière version de Dokuwiki")
  * [Johannes Thönes explique comment mettre à jour de multiples installations de Dokuwiki à l'aide d'un script](http://blog.jthoenes.net/2010/01/24/a-ruby-script-for-upgrading-multiple-dokuwiki-installations/ "En savoir plus sur l'article de Johannes Thönes au sujet de l'installation de multiples Dokuwiki")
  * [Script de Johannes Thönes](https://gist.github.com/jthoenes/285219 "Étudier le code de Johannes Thönes sur Github")
  * [Mise à jour du script de Johannes Thönes](https://gist.github.com/blankoworld/10530850/revisions "Étudier les différences entre le script mis à jour par Olivier DOSSMANN et celui de Johannes Thönes sur Github")
  * [Script BASH pour mettre à jour de multiples installations de Dokuwiki](https://github.com/blankoworld/divers/blob/master/upgrade_dokuwiki.sh "Découvrir le script d'Olivier DOSSMANN pour mettre à jour de multiples installations de Dokuwiki")
