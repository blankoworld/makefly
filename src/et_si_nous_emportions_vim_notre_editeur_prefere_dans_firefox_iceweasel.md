Ne vous est il jamais arrivé de vouloir posséder la coloration syntaxique d'un texte que vous entriez dans Firefox/Iceweasel ? De pouvoir appliquer des méthodes **SED** sur le texte pour ne pas vous enquiquiner à modifier des morceaux de votre paragraphe, ou même de tout le texte d'un wiki ?

Eh bien aujourd'hui je vais vous présenter [It's All Text](https://addons.mozilla.org/fr/firefox/addon/4125 "Se rendre sur la page des modules de Firefox. En français."), une extension de Firefox/Iceweasel dont vous me direz des nouvelles !

### Présentation

[It's All Text](https://addons.mozilla.org/fr/firefox/addon/4125 "Se rendre sur la page des modules de Firefox. En français.") est une extension Firefox/Iceweasel qui permet d'ajouter un bouton javascript à l'un des coins des entrées de formulaires (élements INPUT ou TEXTAREA) et permettant de lancer notre éditeur de texte favori/choisi.

### Installation

Pour récupérer et installer l'extension, c'est très simple, ouvrez Firefox/Iceweasel, rendez vous sur le site de Mozilla (lien indiqué au paragraphe *Liens utiles*), et cliquez sur le bouton "Ajouter à Firefox".

Au redémarrage du navigateur, l'extension sera installée, il ne reste plus qu'à la configurer.

### Configuration

Pour une première configuration ce n'est pas très sorcier, allez dans le menu suivant : 

	Outils > It's All Text > Préférences

Une fenêtre apparaît dans laquelle vous devez donner le chemin absolu de votre éditeur, pour ma part **/usr/bin/gvim**, puis donner un bouton de raccourci, puis valider.

Redémarrez Firefox/Iceweasel, cela devrait être effectif.

### Astuce

> Le bouton *Edit* n'apparaît pas autour de mon encadré à éditer, que faire ?

Si comme moi vous avez rencontré ce manque du bouton EDIT, cliquez de droit sur l'encadré à modifier, puis dans le menu contextuel, choisissez ceci : 

	It's All Text > Edit as .txt

Normalement gvim ou votre éditeur préféré apparaît avec le texte de votre champ à modifier.

#### Sous Gvim

Une fois que vous avez procédé à vos modifications, changements, ajouts, suppressions, etc. il suffit de faire [Échap], [:], [x]. Le champ INPUT ou la TEXTAREA du formulaire se met à jour, magique !

### Conclusion

Je crois ne pas mentir en disant que cela va vraisemblablement améliorer mon temps de travail sur les Wiki auxquels je n'ai pas d'accès SSH ou par dépôt GIT (comme le propose DokuWiki, Ikiwiki, Nanoblogger, etc.).

Pouvoir modifier un texte à l'aide de raccourcis tels que la suppression d'un mot entier, celle d'une ligne entière, couper une ligne entière par simple raccourcis de deux caractères, changer un ensemble de mots suivant une expression régulières, etc. est un luxe que nous pouvons nous permettre, si tant est que nous possédons ... une interface graphique et ... Firefox/Iceweasel.

J'avoue que de côté là, ceux qui apprécie d'autres navigateurs Web vont encore enrager.

PS : Si vous connaissez une astuce similaire pour Epiphany, Galeon, elinks, w3m, je suis intéressé ;)

### Liens utiles

  * [Extension It's All Text sur le site de Mozilla](https://addons.mozilla.org/fr/firefox/addon/4125 "Se rendre sur la page des modules de Firefox. En français.")


