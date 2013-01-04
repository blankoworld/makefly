Cela fait plusieurs années que je note sur des notes autocollantes (de couleur jaune et autres), des bouts de papiers et autres paperasses qui traînent l'ensemble de mes tâches et de mes idées saugrenues venues à l'esprit de manière temporaire.

Si j'ai des idées qui fusent aussi vite que la lumière, elles s'éloignent tout aussi vite, d'où le besoin de mettre à plat ces idées. C'était une bonne chose d'écrire, tout au moins je le pensais. Mais au fur et à mesure, s'est amoncelé sur mon bureau quantité et quantité de papiers, et là, catastrophe, il faut chaque fois relire les papiers, griffoner quand c'est effectué, on ne sait plus s'organiser car on a trop de choses à faire, un vrai **bordèle** !

Que faire pour y remédier ? Rien.

> Euh il sert à quoi ton billet Blanko si tu n'as aucune solution à nous donner ?

Ah mais pas si vite ! (disait le [Colonel Blanchet dans la 7ième compagnie](http://membres.lycos.fr/arnix23/septieme_compagnie/principal/actors/Blanchet.php "Voir une page consacrée au Colonel Blanchet de la 7ième compagnie, un film culte"))

Je pensais tout comme vous qu'à part s'ennuyer à utiliser [Tracks](http://www.rousette.org.uk/projects/ "Visiter le site officiel de Tracks") qui est un site en Rails mais en anglais, il n'y avait rien.

Puis un jour ... mon employeur me présenta Nurpawiki ! (Comme quoi les patrons sont pas si mauvais que ça hein ! En tout cas les vôtres peut être, pas le mien :P )

### Nurpawiki, ocamlairbien ça !

Vous l'aurez sûrement compris au travers mes jeux de mots nazes : Nurpawiki est fait en Ocaml (Prononcez *okamel*)! Ne partez pas en courant ! C'est pas si mal que ça, je vous assure !

Pour une brève explication de ce que Nurpawiki est : un wiki construit autour de la méthode [GTD](http://fr.wikipedia.org/wiki/GTD "Découvrir la méthode de gestion des tâches selon Wikipédia"), ceci au travers d'une interface simple et rapide à prendre en main, même si le site est anglais. Et Dieu sait Ô combien je déteste chercher des heures à comprendre les 3 pauvres mots qui sont écrits en anglais sur une page. Là on a 3 mots à savoir : 

  * Home : La page d'accueil
  * Scheduler : en gros le planning
  * Todo : mot clé dans le wiki pour créer une tâche
  * Edit page : pour modifier une page

Nurpawiki utilise la technique *Camelcase* qui transforme **NouvellePage** en un lien qui vous permettra de créer une nouvelle page dénommée **NouvellePage**.

Pour l'instant Nurpawiki se veut très très simple, donc on ne peut pas supprimer une page ni voir des pages orphelines. Après tout pourquoi faire ? Si une page est orpheline elle est simplement oubliée, basta. Si un jour on veut la réutiliser via un lien CamelCase, se sera actif, voilà tout :) .

Remarquez mon don du calcul de 3 à 4.

Autre chose, Nurpawiki étant en Ocaml, cela tourne sur Ocsigen, un serveur Web écrit en Ocaml. La configuration n'est pas compliquée. Ai je parlé de la base de données ? Non ? Bah c'est postgreSQL, pour l'instant, mais peut être qu'à l'avenir d'autres bases seront possiblement utilisables. N'oubliez pas que Nurpawiki est développé pour l'instant par une seule personne, et donc que cela se fait sur son temps libre. Mais qui sait, peut être auriez vous l'âme d'un développeur Ocaml et voudriez apporter votre aide ?

Même si vous ne savez pas programmer, pensez à [déposer votre opinion sur le projet](http://groups.google.com/group/nurpawiki "Déposer votre opinion sur le projet Nurpawiki, hébergé sur Google").

### Gérer ses tâches

Nous avions vu que le CamelCase permettait, lorsqu'on édite une page, d'ajouter des liens vers de nouvelles pages, voyons rapidement comment ajouter une tâche.

#### Ajouter une tâche

  * Éditez une page via la commande *Edit page* (si ce lien n'apparaît pas, c'est que vous n'êtes pas identifié, pensez à vous mettre en admin sans mot de passe d'abord, puis créez vous un utilisateur, après avoir modifié le mot de passe de l'administrateur via le lien *Preferences*
  * Faites le code suivant : 

	    [todo Faire les courses samedi] : Ne pas oublier de faire les courses samedi !

  * Appuyez sur *Save* pour Sauvegarder la page

Bon je n'ai pas pris un bon exemple de tâche, mais bon vous devriez tout de même avoir une tâche nommée *Faire les courses samedi* qui apparaît à la fois sur votre page et sur le côté gauche.

Notez la présence d'image sur la gauche de la tâche (dans la page) et sur la droite de celle ci dans la colonne gauche de votre page. Hum ... je sais, on comprend plus rien.

Bref il y a des images du type : 

  * Un crayon : permet d'éditer la tâche pour des modifications diverses
  * Triangle dont une des pointes vise le haut de la page : permet d'augmenter la priorité de votre tâche selon 3 priorités : 
    * Basse : couleur verte
    * Moyenne : couleur jaune
    * Haute : couleur rouge
  * Triangle dont une des points vise le bas de la page : permet réduite la priorité selon celles évoquées précédemment
  * Coche : permet de notifier l'achèvement d'une tâche

C'est un des moyens les plus simples que j'ai rencontré jusqu'à maintenant.

#### Scheduler, le planning

Le lien *Scheduler* vous affiche un gestionnaire des tâches. Il permet de repousser à plus tard un ensemble de tâches, c'est très utile pour ne pas trop vous surcharger de travail.

Il n'y a rien de plus à savoir selon moi, si ce n'est la syntaxe utilisée pour le Wiki, que vous trouverez sur le site avec le lien : WikiMarkup sur la page d'accueil.

### Installation

Je vous renvoie à [la page d'accueil du projet](http://code.google.com/p/nurpawiki/ "Visiter le site officiel de Nurpawiki"), mais aussi sur le réseau IRC, via les adresses suivantes : 

  * irc.freenode.net, *#ocsigen* (canal anglais, je sais, mais certains parlent Français dessus !, notamment votre serviteur|rédacteur)
  * Pas d'autres ? bah non !

Possible que prochainement vous ayez une page consacré à Ocsigen et Nurpawiki sur le [Quicky Blanko](/wiki/ "Voir le wiki de Blanko"), mais j'en doute, pour l'instant je ne sais plus où donner de la tête !

### Liens utiles

  * [Nurpawiki](http://code.google.com/p/nurpawiki/ "Visiter le site officiel de Nurpawiki"), au centre de ce billet
  * [Site d'essai de Nurpawiki](https://todo.crans.org/view?p=WikiStart "Visiter un site d'exemple de Nurpawiki")
  * [Tracks](http://www.rousette.org.uk/projects/ "Visiter le site officiel de Tracks"), une alternative en Ruby et en anglais
  * [GTD selon Wikipédia](http://fr.wikipedia.org/wiki/GTD "Découvrir la méthode de gestion des tâches selon Wikipédia") : une explication de ce que GTD est, selon Wikipédia

