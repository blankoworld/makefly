> De quoi il cause avec son Efikace ? D'abord ça s'écrit efficace pour ta gouverne Blanko !

Ca y est, j'ai même pas encore écrit une ligne que vous êtes déjà en train de me tomber dessus ! Non non, vous ne rêvez pas, nous allons parler de l'Efika ! Et Justement pour voir si c'est efficace, l'intérêt d'un tel système, bref c'est le billet découverte et démarrage ! :) 

Il y aura sûrement un second billet, voire un troisième sur l'Efika, à voir !

### Présentation

Pour une brève présentation, l'Efika, c'est ça : ![Image représentative de l'Efika](${BASE_URL}/images/materiel/efika.jpg "L'Efika, dans toute sa splendeur").

En somme c'est une carte toute petite qui contient / propose (selon la notice) : 

  * Freescale MPC5200B PowerPC SoC 400Mhz (32 Bits PowerPC with FPU, 603e processor core (e300), Dhrystone 2.1, 760 MIPS)
  * 1 emplacement PCI (compatible 33Mhz et 66Mhz PCI 2.2 3.3volt) et optionnnelement une card / connecteur AGP à brancher dessus
  * 1 connecteur IDE 44 pin (pour brancher un disque dur 2.5 pouces)
  * Une horloge interne RTC
  * 1 connecteur ATX pour brancher une alimentation vendue dans le commerce
  * 1 port infrarouge (pour peu que vous ayez le matériel qui va bien
  * 2 ports USB 1.1
  * 1 port ethernet 10/100 Mbits/sec (Realtek 8201 Pyceiver)
  * 1 port série RS232 (D-SUB9)
  * Connecteurs Audio : Microphone, Entrée audio, Sortie Audio (casque, haut - parleurs) et sortie optique S/PDIF
  * Ports audio internes : Audio in (CD_IN), Audio in (VID_IN), Audio in (AUX_IN), Headphones (HP), Microphone (MIC)
  * Quelques pins pour les lumières disque dur, "power on", et pour lancer ou non la machine (reset, boot)

Je peux vous garantir qu'avec ça vous avez déjà une belle bête !

> Et le prix dans tout ça ?

Oh je dirais aux alentours de 200 euros pour la carte. Ce qui vous laissez une bonne marge pour acheter un disque dur 2.5 pouces, une alimentation dite picoPSU et à la rigueur un câble série pour contrôler la bête (ou bien une carte graphique, mais il faut acheter un modèle spécial).

### Pourquoi l'Efika et pas d'autres ?

Vous n'avez pas tort, au début je visais plus ou moins les solutions suivantes : 

  * [Un serveur dans un TUX](http://www.acmesystems.it/?id=21 "Voir le serveur TUX") :D
  * [Fit-pc, l'ordinateur qui consomme 5W](http://www.fit-pc.com/new/ "Site officiel de Fit-pc")
  * [Le NSLU2](http://www.ldlc.com/fiche/PB00023353.html "NSLU2 sur LDLC") -> lien mort à terme
  * [Site de Synology et leurs solutions](http://www.synology.com/enu/products/DS107/index.php "Visiter le site de Synology")
  * [Linutop](http://www.linutop.com/linutop2/index.fr.html "Visiter le site officiel de linutop") (j'en profite pour dire que c'est pas le top contrairement au nom)

Pourquoi il me fallait une solution comme celles ci ? Tout simplement pour le fait d'avoir un serveur Web qui consomme moins qu'un ordinateur normal, d'où l'intérêt de prendre de petits serveurs.

Et finalement, pourquoi l'Efika ? Car je connais une personne qui m'a proposé de m'en prêter un, et que si cela me plaît je pouvais le prendre ;) . Forcément, on ne dit pas non !

### Le début du commencement

C'est hier ( lundi 21 avril 2008 ) que j'ai acquis la carte. Après quelques conseils, je m'en suis allé chercher quelques bricoles : 

  * Une alimentation 350W (en attendant de prendre une [alimentation picoPSU](http://images.google.fr/images?hl=fr&ie=UTF-8&oe=UTF-8&q=pico%20psu&um=1&sa=N&tab=wi "Voir une image de la picoPSU selon Google Image")) trouvé dans un carton
  * Un disque dur 2.5 pouces de 20 Go (trouvé dans un vieil ordinateur portable)
  * Un câble ethernet (celui de mon pc portable)
  * Un câble série "null modem" femelle DB9 - femelle DB9 (vous moquez pas, j'ai eu le culot de me tromper, cela m'a retardé d'un jour)

De là pas de soucis, on branche le disque dur, on branche le port série sur la carte et sur notre ordinateur, puis l'alimentation.

Sur notre ordinateur nous faisons : 

	apt-get install minicom
	minicom -s -o

Dans le cas où vous voudriez une interface plus sympatique pour configurer ce qui va suivre, faites (en supplément) : 

	apt-get install gtkterm

On enregistre les options suivantes (en se baladant dans le menu) : 

  * L'adresse du câble série (pour ma part un câble USB convertisseur de type ttyUSB0)
  * Le débit du câble : 115200
  * Bit / Parité : 8N
  * Contrôle de flux : aucun !

Avec minicom vous faites : 

	minicom -s -o

Avec gtkterm, lancez simplement le programme.

Puis démarrez votre Efika en mettant un tournevis entre les PINs

Cela démarre, faites un **show-scsi** pour voir votre disque dur ou votre clé USB. Pour éteindre, faites **halt**.

Comme la clé USB est reconnue, vous pouvez installer une Debian par exemple, ce qui est expliqué dans le manuel ou encore [sur cette page (en Anglais)](http://www.littlefe.net/mediawiki/index.php/EfikaInstall#The_Debian_Installation "Visiter le site de Littlefe sur l'installation d'un Efika").

Nous ferons sûrement quelques explications supplémentaire, comme par exemple la petite *astuce* de base pour démarrer à partir de sa clé USB : 

  * Éteindre l'Efika
  * Démarrer le minicom (ou gtkterm) avec les bons paramètres
  * Branchez votre clé USB sur votre ordinateur personnel
  * Chargez les fichiers di_efika, kernel_efika et modules_efika.tgz sur le [site officiel](http://www.efika.de/index_en.html "Site officiel de l'Efika")
  * Copiez les fichiers sur votre clé
  * Démontez et/ou débranchez la clé pour l'insérer dans l'Efika
  * Vérifiez d'avoir du DHCP sur votre réseau, et un câble ethernet branché sur votre Efika (pensez à brancher l'autre extrémité du câble ethernet à votre réseau :roll: )
  * Démarrez l'Efika
  * Sur gtkterm (préférable), faites une commande du genre : 

	boot hd0:0 di_efika root=/dev/sda console=ttyPSC0 rootdelay=20

C'est de cette manière que j'ai lancé l'installation Debian, mais nous en reparlerons une autre fois. Vous avez déjà là pas mal de chose !

### Liens utiles

Pour plus de détails sur l'Efika, je vous conseille les liens suivants : 

  * [Caractéristiques et quelques explications sur un site en FR](http://obligement.free.fr/articles/efika.php "Visiter le site obligement.free.fr")
  * [Livre officiel de l'Efika en FR](http://www.efika.org/fr/LeLivreDeLEfika_V1.5.pdf "Télécharger le livre officiel de l'Efika en FR")
  * [Documentation Efika](http://book.efika.org/ "Visiter le site officiel de la documentation pour l'Efika")
  * [Site officiel de l'Efika](http://efika.de/index_en.html "Visiter le site officiel")

