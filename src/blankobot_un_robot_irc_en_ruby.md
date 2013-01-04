### Introduction

Le net est rempli de robot IRC en tout genre. Notamment en ruby, nous trouvons quelques outils tels que :

 * [Ruby-irc](http://rubyforge.org/frs/?group_id=1784 "Aller sur la page officiel du projet Ruby-IRC") : un ensemble de bibliothèques pour gérer l'IRC en Ruby
 * [autumn](http://github.com/RISCfuture/autumn/tree/master "Voir le dépôt officiel du projet Autumn") : un cadre de travail pour les robots IRC
 * [butler](http://butler.rubyforge.org/ "Aller sur le site officiel de Butler, le robot IRC") : un robot IRC multi-fonctions qui accepte les plugins, utile pour développer simplement des fonctions à notre robot IRC

Cependant, n'ayant pas beaucoup développé en Ruby, je trouvais ça assez difficile à comprendre, utiliser, etc.

J'ai préféré me lancer (grand fou :P !) dans la création d'un script ruby pour me faire un robot personnel : le BlankoBot.

### Comment tout a commencé

Que faut il pour développer un robot à part un éditeur (vim), un langage (ici ruby) ?

Eh bien tout d'abord il faudrait possiblement [lire la RFC sur IRC](http://www.ietf.org/rfc/rfc1459.txt "Lire la RFC concernant IRC") non ? Je ne m'en suis servi que comme d'un support, je n'ai pas encore tout lu en entier.

Ensuite, j'ai trouvé un [script de base qui montre comment se connecter à IRC en Ruby via les sockets](http://snippets.dzone.com/posts/show/1785), j'ai tout de suite sauté sur l'occasion pour prendre appui sur le script.

### Au final

J'ai codé, encore et encore, jusqu'à obtenir un simili de robot : le BlankoBot.

Comme je trouvais ça déjà pas mal, bien que le code doit être sûrement très maladroit pour le moment, j'ai mis sous licence GPLv3 le code, et j'ai crée un [dépôt GIT pour le BlankoBot](http://git.dossmann.net/?p=projets/blankobot;a=summary "Visiter le dépôt GIT du projet BlankoBot").

### Conclusion

Le BlankoBot est né, profitez en ! N'hésitez pas à me contacter pour tout renseignement sur le dépôt GIT et la possibilité de contribuer à l'évolution de ce dernier.

### Liens utiles

Voici quelques liens utiles : 

  * [RFC 1459 sur IRC](http://www.ietf.org/rfc/rfc1459.txt "Lire la documentation de la RFC 1459")
  * [dépôt GIT du BlankoBot](http://git.dossmann.net/?p=projets/blankobot;a=summary "Visiter le dépôt GIT du projet BlankoBot")
  * [télécharger la version stable-v0.1](http://git.dossmann.net/?p=projets/blankobot;a=snapshot;h=e4d910f2932d4419256dcd2bcada9f540b05238a;sf=tgz "Enregistrer au format .tgz le projet BlankoBot stable-v0.1")
  * [Page Wiki du projet BlankoBot](http://ordyz/wiki/doku.php?id=developpement:blankobot "Se rendre sur la page Wiki du projet BlankoBot et apprendre à l'utiliser")

