Cette semaine j'ai décidé de tester une distribution : Frugalware.

> Pourquoi cette soudaine recherche d'une autre distribution ?

C'est ce que nous allons rapidement expliquer avant de vous présenter Frugalware.

### Critères de recherche

[J'avais récemment adopté la distribution NuTyX dont je vous parlais récemment](${BLOG_URL}/archives/2009/07/05/nutyx_une_distribution_gnulinux/index.html "Lire l'article précédent parlant de la distribution NuTyX"), seulement pour un ordinateur particulier de mon parc, un [ordinateur Acer Aspire One reçu l'année dernière](${BLOG_URL}/archives/2009/02/18/blankovractrapage_012009_022009/index.html "Lire l'article BlankoVractrapage et chercher le paragraphe sur l'ACER Aspire One A110"), je n'avais et n'ai toujours pas les choses suivantes : 

  * des paquets binaires à jour (NuTyX possède des paquets binaires, mais ceux les plus à jour sont les paquets sources et je ne possède encore aucune chaîne de compilation ou d'arbre personnel pour l'instant)
  * certaines applications que j'aimerais ne figurent pas dans la liste de celles proposées par NuTyX, comme par exemple :
    * awesome (j'ai fait un paquet pour NuTyX, mais il n'est pas encore intégré)
    * scribes (idem, paquet fait, mais pas encore envoyé)
    * URxvt possédant la personnalisation de terminal (j'ai fait une correction, mais elle n'a pas été intégrée)
    * GCStar patché correctement (pour qu'il fonctionne tout simplement, ce que j'ai fait, mais mise à jour non intégrée dans NuTyX)
    * LaTeX (inexistant sous NuTyX)
    * rubygems (inexistant sous NuTyX)
    * xfe (non disponible en binaire)

Ce ne sont pas beaucoup de choses, mais cela suffit à me couper de la nouveauté et de l'utilisation simple.

Certes je fais ce que je peux pour obtenir tout cela sous NuTyX, mais en attendant je teste d'autres produits. Et il semble que Frugalware répondait à ces besoins !

### Frugalware

Frugalware est une distribution construite - apparemment - à partir de rien.

Son gestionnaire de paquet **pacman-g2** est un bienfait puisque c'est le projet pacman, affublé des patchs de la communauté (l'auteur de pacman était trop réticent pour accepter l'aide de contributeurs). Ce gestionnaire de paquets permet d'installer des binaires, et chose intéressante : il contient les paquets dont j'ai besoin.

[Le site officiel de Frugalware](http://frugalware.org/ "Se rendre sur le site officiel de Frugalware") contient à lui seul l'ensemble des informations dont nous avons besoin avant de choisir d'installer la distribution. Il propose notamment un wiki et un forum ainsi qu'une liste de discussion. La structure du site permet de connaître l'infrastructure de Frugalware qui semble être assez intéressante. En somme c'est assez transparent que ce soit pour un développeur et mainteneur de paquets qu'un utilisateur.

Par ailleurs une forte communauté francophone existe pour Frugalware, c'est un bonheur absolu pour vous amis francophones !

### Résultats de l'opération

L'installation s'est déroulée sans problèmes majeurs, l'ensemble du matériel de mon ordinateur portable Acer Aspire One A110 a été détecté. Le processus d'installation m'a d'ailleurs surpris en détectant ma carte wifi et en utilisant cette dernière pour installer. C'est la première fois que j'installe une distribution en wifi.

Cependant, j'ai cru ne jamais pouvoir installer la distribution. Je n'avais pas de lecteur CD et je ne voyais pas comment installer à partir d'une clé USB (je ne suis possiblement pas tombé sur le bon tutoriel). Malgré tout, en regardant les différents modes d'installation, j'ai vu qu'on pouvait utiliser [Unetbootin](http://unetbootin.sourceforge.net/ "Visiter le site officiel d'Unetbootin") pour installer sur une clé USB. Je l'ai utilisé pour installer directement sur … le disque dur de mon ordinateur portable ! Et cela a fonctionné ! À noter qu'il fallait que ma distribution possède Unetbootin, ce qui n'aurait pas été le cas de NuTyX (le paquet unetbootin n'existe tout simplement pas).

J'ai ensuite installé petit à petit les applications dont j'avais besoin, puis ai personnalisé awesome. Je vous laisse voir le résultat ci-dessous : 
[![Image de l'environnement de bureau awesome avec le fond d'écran de Frugalware et le menu gauche d'awesome ouvert, comportant quelques entrées](${BLOG_URL}/images/distributions/20091231_frugalware_awesome-48.jpg "Awesome revêt les couleurs de Frugalware !")](${BLOG_URL}/images/distributions/20091231_frugalware_awesome.jpg "Cliquez ici pour voir l'image aggrandie")

J'en ai profité pour faire une [page consacrée à l'Acer Aspire One sur le wiki de frugalware](http://wiki.frugalware.org/index.php/Aspire_One_%28Fran%C3%A7ais%29 "Découvrir la page wiki sur l'Acer Aspire One sur wiki.frugalware.org"), dont la communauté francophone, sur l'IRC, semble très accueillante, chaleureuse, et à l'écoute !

### Conclusion

Frugalware est une distribution intéressante, que je vais continuer de tester sur mon ordinateur portable en attendant que je trouve une astuce pour avoir un arbre binaire correct sous NuTyX mais également l'ensemble des paquets dont j'ai besoin.

En attendant, NuTyX et Frugalware sont deux distributions à absolument tester pour des personnes de niveau intermédiaire (et encore, je ne trouve pas si difficile car la communauté aide beaucoup).

