### Fiche rapide

**Nom** : Bento Openbox Trusty RC (base Ubuntu Trusty 14.04)

**Version** : 64 bits

**Site web** : [Linux Village](http://linuxvillage.org "Se rendre sur le site de Linux Village")

**Méthode d'installation testée** : Clé USB Bootable - en utilisant Unetbootin et l'image ISO du CD

**Image** : Aucune

**Particularité du système** : Contrairement à [Elementary OS qui se focalise sur l'élégance au détriment de la rapidité](${BLOG_URL}/${POSTDIR_NAME}/se_elementary_os_freya_0_3.html "Lire l'article d'Elementary OS"), Bento Linux est une distribution souple et légère, rapide et simple !

### Apparence

[![Bureau Openbox sous Bento avec urxvt, tmux et elinks](${BLOG_URL}/images/distributions/20150604_bento_14.04-490.jpg)](${BLOG_URL}/images/distributions/20150604_bento_14.04.jpg "Aggrandir la photo")

**Note** : test effectué sur un ordinateur portable AMD double cœur 800Mhz avec 4GB de mémoire vive.

Bento Openbox est une découverte aussi alléchante que les fameux [Bento japonais](http://fr.wikipedia.org/wiki/Bento "Découvrir sur Wikipédia ce que sont les Bento japonais"). C'est une Ubuntu Trusty 14.04 à la sauce Openbox qui est un environnement de bureau léger et rapide.

On se concentre donc sur de menues applications qui font ce qu'on leur demande. Cela change des habituelles applications lourdes que nous avons l'habitude de voir.

Le bureau possède une barre des tâches, une barre de notification et même un menu de démarrage. Tout est à portée de clic !

À noter que nous pouvons mettre des raccourcis sur le bureau, ce qui me rappelle l'ère avant les nouveaux environnement de bureau tels que GNOME Shell ou Elementary qui ne nous le permettent plus.

### Ce que j'aime

Je soulève plusieurs points positifs :

  * l'installation est aussi facile que n'importe quelle Ubuntu. Cela se déroule sans accrocs pour une installation normale : utilisation de tout le disque pour la distribution, on donne notre fuseau horaire, le nom de l'ordinateur, notre pseudo utilisateur et on redémarre ;)
  * l'appareil consomme moins de mémoire vive et la diminution de services comparé à Xubuntu augmente indirectement le temps de disponibilité de la batterie.
  * la mémoire vive utilisé est de 350M avec le bureau. Si je coupe openbox et lightdm (service de gestion d'environnement de bureau et de session), je tombe à 175M. Ce qui me laisse pas mal pour les applications.
  * l'environnement fournit vraiment un peu plus que le minimul vital, ce qui est agréable à utiliser.

En somme une base simple et saine à partir de laquelle on peut commencer à travailler/s'amuser tout en perfectionnant petit à petit.

Je me suis donc permis d'ajouter les éléments suivants pour compléter le tableau : 

  * gmrun (exécuteur de commande quand vous faites Alt+F2)
  * xscreensaver (écran de veille + verouillage écran)
  * personnalisation de quelques raccourcis Openbox
  * ajout d'un moniteur de batterie dans la barre de notification
  * outil de gestion d'énergie tlp (descendant de Jupiter)
  * mon environnement de DEV zsh/tmux/vim
  * [redshift](${BLOG_URL}/${POSTDIR_NAME}/contraste_du_bureau_avec_redshift.html "Lire l'article de Redshift sur ce blog")
  * pilotes propriétaires ATI pour la lecture des contenus multimédias

### En moins bien

En revanche il y a plusieurs ombres au tableau : 

  * comme évoqué précédemment, à défaut il n'y a pas d'écran de verrouillage. C'est problématique quand vous quittez votre poste sans pouvoir le verrouiller…
  * les raccourcis clavier d'Openbox par défaut sont à chier. Certains ne fonctionnent pas car la commande n'est pas installée, d'autres très utilisés sont omis, etc.

On a connu mieux, mais on a aussi connu pire. Cela reste acceptable.

### Conclusion

Je pense que Bento Linux est clairement une distribution à tester pour se rendre compte de la simplicité et la légèreté du bureau sans perdre en efficacité et en gagnant en consommation et en performances.

Sachant qu'elle est plus rapide et plus économique que Xubuntu je vais continuer ces prochains moins de l'utiliser comme outil de développement et pour la rédaction de mes articles.

Si vous n'êtes pas à cheval sur l'utilisation des raccourcis claviers pour faire une impression écran, lancer une commande ou même lancer un écran de veille, alors cette distribution est faite pour vous !
