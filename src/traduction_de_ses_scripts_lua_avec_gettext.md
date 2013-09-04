### Introduction

En ce moment j'avance sur un projet informatique écrit dans le language Lua. Je m'essaie ainsi à ce langage et en profite de sa puissance pour mes scripts de création de sites web comme [PorteAil](http://porteail.e-mergence.org) ou encore [Makefly](http://makefly.e-mergence.org).

Ainsi, pour l'un ou l'autre raison j'ai besoin de traduire les messages d'erreurs de l'application en la langue de l'utilisateur. Il y a probablement plusieurs méthodes, mais voici celle que j'utilise.

Notez que je donne le détail complet du code dans [mon tutoriel sur Gettext pour Lua](https://olivier.dossmann.net/wiki/developpement/lua/gettext).

![La Terre](${BLOG_URL}/images/nature/la_terre.jpg "Image de la Terre vue de l'espace")

Image sous Licence Creative Commons CC-BY 2.0 trouvée sur une galerie photo de [gsfc](http://www.flickr.com/photos/gsfc/ "Aller sur la galerie photo de gsfc").

### Gettext

L'outil le plus utilisé selon Internet est [Gettext](http://en.wikipedia.org/wiki/Gettext). Il permet de parcourir notre code afin d'en extraire les chaînes à traduire. Puis divers outils permettent de procéder à la traduction des chaînes, soit automatiquement, soit manuellement.

Enfin l'outil va générer des fichiers binaires pour une rapidité accrue de traitement/lecture/rendu.

### Implémentation 

Il n'y a pas d'implémentation à part entière pour Lua, il faut donc créer sa propre implémentation.

En premier lieu on doit créer une fonction qui va lire nos chaînes et donner la traduction (en lisant le fichier binaire spécifique à la langue de l'utilisateur. Généralement c'est une fonction **_** (espace souligné) qu'on utilise. Elle va lire le fameux fichier binaire (extension *.mo) de Gettext et donner le résultat.

Sachant que nous voulons retourner les erreurs du programme/script en plusieurs langues, il va falloire initialiser la fonction avant le début de nos traitements.

Vous pouvez voir tout ceci dans [le tutoriel sur Gettext pour Lua que je vous ai concocté](https://olivier.dossmann.net/wiki/developpement/lua/gettext).

### Résumé

Si on devait synthétiser, voici ce qu'il faut faire : 

  * faire une fonction **_** qui lit une chaîne et donne sa traduction
  * faire une fonction qui lit un fichier *.mo et cherche une chaîne donnée pour en sortir son résultat
  * initialiser le chargement du fichier *.mo et la fonction de traduction en début de script
  * ajouter les chaînes à traduire dans des fonctions **_()**
  * parcourir notre code avec gettext pour récupérer les chaînes à traduire
  * traduire
  * convertir en fichier binaire
  * joindre le binaire à notre programme et enlever les fichiers temporaire (*.po, *.pot, etc.)

### Conclusion

En dehors de la lecture du fichier binaire de gettext qui se résoud facilement en cherchant sur Internet, l'implémentation fût facile et le résultat est au-delà de mes espérances.

L'avantage d'avoir des fichiers à traduire au format ***.po**, c'est que des interfaces graphiques simples telles que gTranslator ou poedit permettent à des non-initiés au code de programmation de traduire votre application sans avoir à lire du code.

Des interfaces web permettent également de traduire en ligne sans installer quoique ce soit. C'est donc très utile pour des projets !

### Liens utiles

  * [Lua (site officiel)](http://www.lua.org/)
  * [Gettext selon Wikipédia](http://en.wikipedia.org/wiki/Gettext)
  * [Tutoriel Gettext pour Lua sur le Recueil d'astuces d'Olivier](https://olivier.dossmann.net/wiki/developpement/lua/gettext)
