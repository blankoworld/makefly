### Introduction

Quand on maintient un serveur web et qu'on utilise quelques applications chez soi librement téléchargées sur le net, on a besoin de connaître les dernières versions de chacune desdites applications.

À cet effet on utilise très fréquemment les flux RSS. Le souci c'est qu'on a un flux RSS par projet. Cela fait très vite un joyeux bordèle dans notre lecteur de flux du fait des trop nombreuses applications.

Certaines catégorisent, mettent dans des dossiers à part, voire un compte RSS à part dans leur lecteur.

Je vais vous présenter ici quelques outils que j'ai utilisé pour me faciliter la tâche de veille technologique.

### Étape 1 : trouver les flux RSS

Ce n'est pas toujours simple de trouver un flux RSS contenant les dernières versions d'un outil. Dans ma liste, le seul outil que j'ai vu proposer directement les dernières version est [ikiwiki](http://ikiwiki.info/ "Se rendre sur le site officiel de ikiwiki"). Exemple : http://ikiwiki.info/news/index.rss

D'autres ne se tracassent pas avec ça. À la place, on dispose au mieux du flux RSS de leur blog. Ce qui n'est pas plaisant car les blogs donnent d'autres articles que simplement les dernières versions.

Une idée serait de suivre soit le flux RSS des blogs en ne filtrant que les dernières versions : quasi impossible car il n'y a pas de règles prédéfinies pour une sortie de version, soit tout simplement de suivre le flux RSS du **dépôt du code source en ne filtrant que les tags**. Par exemple avec les dépôts si connus de Github. Exemple : https://github.com/splitbrain/dokuwiki

Plusieurs outils existent pour cela, on nomme ça plus ou moins un **github-tags**. D'ailleurs celui que j'utilise est : [github-tags de Mic92](https://github.com/Mic92/github-tags "Découvrir le projet github-tags de Mic92").

Une [démonstration de l'outil github-tags est disponible sur le web](http://githubtags.higgsboson.tk/ "Tester github-tags").

### Étape 2 : FUUUUUU… SION !

![Soleil en fusion](${BLOG_URL}/images/nature/soleil_fusion.png "Image d'un soleil en fusion")

Image sous Licence Creative Commons CC-BY 2.0 trouvée sur une galerie photo de [gsfc](http://www.flickr.com/photos/gsfc/ "Aller sur la galerie photo de gsfc").

Une fois l'ensemble des flux récupérés, il serait intéressant de n'en faire qu'un. C'est le travail de l'outil [moonmoon](http://moonmoon.org/ "Se rendre sur le site officiel de moonmoon") qui se charge de prendre l'adresse de plusieurs flux et affiche le résultat.

Le tout est consultable par le web ou via un flux ATOM. On peut également récupérer le fichier OPML permettant d'importer tout les flux dans son propre lecteur de flux.

Avouez que c'est génial comme outil, non ?

### Conclusion

Grâce à **github-tags** et **moonmoon**, plus d'excuses d'avoir des applications à la ramasse ! Vous serez toujours au goût du jour.

