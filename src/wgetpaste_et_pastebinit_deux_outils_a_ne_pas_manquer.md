### Introduction

Vous est-il arrivé, dans le domaine du libre, de devoir donner un ensemble de résultats d'une commande GNU/Linux à quelqu'un de la communauté ? Par exemple devoir donner le contenu de son fichier /etc/rc.conf sous ArchLinux, ou encore de donner le contenu de /etc/apt/sources.list sous Debian/Ubuntu ? Ou tout simplement le fichier /etc/X11/xorg.conf (oui celui là nous emm**de !) :P 

> Oui cela m'est déjà arrivé

Ah ! Quand je vous disais que cela nous arrive !

Figurez-vous que le fait tout **bête** de devoir envoyer un fichier ou le résultat d'une commande, n'est, au final, pas toujours aisé ! Au début on lance la commande, on voit le résultat, faut copier, puis coller dans un courriel, un espace Web prévu à cet effet ou encore un canal IRC et/ou Jabber. Bref, c'est pas très beau, c'est long, c'est ennuyeux et pénible.

Pour se simplifier la vie, il se trouve que des personnes utilisent une autre méthode ! Voyons plus en détail ces méthodes.

### Un début de solution

Vous l'apprendrez sûrement sur les forums, via IRC ou Jabber, il existe des sites tout prêts pour ce genre de copier/coller, en voici quelques-uns : 

  * [http://pastebin.ca/](http://pastebin.ca/ "Se rendre sur le site http://pastebin.ca/")
  * [http://pastebin.com/](http://pastebin.com/ "Se rendre sur le site http://pastebin.com/")
  * [http://pastie.org/](http://pastie.org/ "Se rendre sur le site http://pastie.org/")
  * [http://pastebin.wikistuce.info/](http://pastebin.wikistuce.info/ "Se rendre sur le site http://pastebin.wikistuce.info/")

Grâce à ces interfaces, vous pouvez copier/coller du texte, ajouter quelques informations, et donner ensuite l'adresse du billet à vos interlocuteurs pour continuer votre discussion au sujet d'un problème que vous rencontrez, d'une configuration aux petits oignons à faire, etc... :D 

Mais cela ne résoud pas le souci du copier/coller manuel à faire, c'est très dérangeant !

### La solution

Pour pallier ces soucis de lignes de commandes et de fichiers, des personnes ont développés des outils. De VRAIS outils cette fois, qui utilisent à la fois la ligne de commande ET les outils en ligne d'affichage de texte.

En voici deux : 

  * wgetpaste
  * pastebin

#### wgetpaste

Cet outil est disponible, à ma connaissance, sous ArchLinux, Gentoo, et bien évidemment [NuTyX](${BASE_URL}/archives/2009/07/05/nutyx_une_distribution_gnulinux/index.html "Relire le billet de Blanko sur la distribution GNU/Linux NuTyX") !

Pour l'utiliser, voici quelques commandes : 

    wgetpaste -S

Permet de lister les services disponibles.

    wgetpaste -L

Permet de lister les langages supportés, pour la coloration syntaxique.

    wgetpaste -E

Permet de lister les durées de vie possible d'un envoi de texte sur le service.

Utilisez les mêmes commandes en minuscule avec comme paramètre votre choix, pour informer wgetpaste du service ou de l'option à prendre.

    wgetpaste -s ca

Permettra de choisir pastebin.ca comme service d'envoi. Mais cette commande manque encore d'un paramètre principal : le fichier à envoyer !

    wgetpaste -s ca /etc/X11/xorg.conf

Permet d'envoyer le contenu du fichier */etc/X11/xorg.conf* à pastebin.ca et d'en retourner l'URL.

    wgetpaste -l Ruby gateau.rb

Enverra le contenu du fichier gateau.rb sur dpaste.com en mettant le tout au format Ruby.

> et pour envoyer une commande ?

Là c'est un peu différent, il suffit de faire : 

    free -mt | wgetpaste -l "Plain Text"

Ce qui aura pour effet d'envoyer le résultat de la commande **free -mt** sur dpaste.com en mode *Plain Text*.

#### pastebinit

Cette fois, wgetpaste n'étant pas disponible sur mon serveur Debian, il m'a fallu trouver autre chose. C'est avec pastebinit que la solution s'est offerte à moi. Le programme gère le support des sites suivants : 

  * [http://*.pastebin.com](http://*.pastebin.com "Se rendre sur le site http://*.pastebin.com")
  * [http://pastebin.mozilla.org](http://pastebin.mozilla.org "Se rendre sur le site http://pastebin.mozilla.org")
  * [http://rafb.net](http://rafb.net "Se rendre sur le site http://rafb.net")
  * [http://yourpaste.net](http://yourpaste.net "Se rendre sur le site http://yourpaste.net")
  * [http://paste.ubuntu.com](http://paste.ubuntu.com "Se rendre sur le site http://paste.ubuntu.com")
  * [http://*.paste.f-box.org](http://*.paste.f-box.org "Se rendre sur le site http://*.paste.f-box.org")
  * [http://*.1t2.us](http://*.1t2.us "Se rendre sur le site http://*.1t2.us")
  * [http://paste.stgraber.org](http://paste.stgraber.org "Se rendre sur le site http://paste.stgraber.org")

Que l'on peut choisir à l'aide de la commande :

    pastebinit -b http://pastebin.mozilla.org

Il ne faut pas oublier de lui donner quelque chose à envoyer, un fichier par exemple : 

    pastebinit -b http://pastebin.mozilla.org -i /etc/X11/xorg.conf

Ce qui envoie le contenu du fichier **/etc/X11/xorg.conf** sur le site pastebin.mozilla.org.

    free -mt | pastebinit -

Permet l'envoi du résultat de la commande **free -mt** sur le site par défaut.

### Astuce

Vous pouvez coupler ces commandes à votre logiciel de messagerie instantané **irssi** ou **weechat** via la commande */shell -o*.

Pour weechat, le script est disponible ici : [http://weechat.net/files/scripts/shell.py](http://weechat.net/files/scripts/shell.py "Récupérer le script shell.py pour Weechat").

### Conclusion

Ces commandes sont très utiles pour récupérer simplement un lien et le copier/coller sur un courriel, un IRC ou tout autre système de communication. Vous gagnez du temps puisque vous ne tapez que la commande pastebinit ou wgetpaste en supplément.

Désormais je crois n'utiliser que ça, dès que je le peux ! Ceci fait le bonheur à la fois des personnes que j'aide (puisqu'on leur explique rapidement comment installer puis utiliser ces commandes), et des personnes qui m'aident puisqu'elles reçoivent rapidement l'URL pour visionner le contenu qu'elles demandent.

C'est désormais à vous de faire de même ! :D

