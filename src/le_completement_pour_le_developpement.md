Que se soit dans le développement Web, le développement système ou encore le développement de logiciels, on apprend toujours à ne pas répéter deux fois une fonction, un code, etc. C'est l'effet DRY (Don't Repeat Yourself) connu principalement sous Ruby On Rails, mais pas seulement.

Cependant, si on tente de toujours appliquer la chose dans notre code, qu'en est il de nos éditeurs de texte ?

> Quoi toi parler Blanko ? Tu débloques ?

Comme l'indique le titre, je parle du complètement dans nos éditeurs.

### Pourquoi le complètement ?

C'est évident, le complètement suggestif et/ou automatique permet de gagner du temps. Mais comme pour l'éditeur en console Vim, il faut connaître un minimum de commandes, de raccourcis.

Ne vous inquiétez pas, je ne vous parlerez pas de [vim, même s'il existe des méthodes similaires](http://www.vim.org/scripts/script.php?script_id=2278 "jptemplate, une méthode pour ajouter des patrons de complètement dans vim") à celles que je vais vous présenter. Si vous désirez trouver des informations sur le complètement et votre éditeur de texte, utilisez le mot clé *snippet*.

Ce dont nous allons désormais parler : 

  * gedit
  * Scribes

Les deux programmes utilisent python pour le mode complètement et permettent bien plus encore ! Je ne ferais donc qu'une brève présentation de chacun des éditeurs puis je vous proposerais une liste des points positifs et négatifs. Nous terminerons alors avec une conclusion personnelle sur l'état des lieux et mon choix vis à vis de ces deux éditeurs.

### L'éditeur gedit

Sûrement l'un des éditeurs texte les plus connus car il est fourni avec l'[environnement de bureau Gnome](http://www.gnome.org/ "Visiter la page officielle de l'environnement de bureau Gnome"), gedit est souvent utilisé par les débutants sous GNU / Linux pour éditer les fichiers de configuration tout comme écrire d'autres fichiers.

Bien que certains le mettent de côté après avoir découvert [Vim](http://www.vim.org/ "Visiter le site officiel de Vim"), [Emacs](http://www.gnu.org/software/emacs/ "Visiter le site officiel d'Emacs") ou [Nano](http://www.nano-editor.org/ "Visiter le site officiel de Nano"), gedit permet bien plus qu'on ne le pense à l'aide d'un système de plugins appelés **greffons**.

Le greffon principal qui nous intéresse est **Extraits de code** ou snippet (en anglais). Pour l'activer, rien de plus simple, on va dans Édition > Préférences, onglet Greffons, puis on coche *Extraits de code*.

Ceci met en place tout ce qu'il faut pour le complètement. À noter que vous devez avoir installé le paquet **gedit-plugins** pour posséder les bons greffons. J'en ai profité pour activer aussi le greffon **Liste des balises** très utile quand nous n'avons pas encore pris l'habitude d'un langage de programmation spécifique.

### L'éditeur Scribes

Moins connu que gedit puisqu'il faut le vouloir pour l'avoir (grossomodo vous devez savoir qu'il existe et l'installer), il n'en est pas moins utile.

En effet Scribes est né de la volonté de développeurs Python pour le python et donc fait en Python (trop de serpents dans une phrase). Il s'est élargi à plus de 30 langages différents et permet le complètement (forcément sinon mon billet ne serait pas là). Il permet également l'édition via ssh, ftp, samba et webdav (mais je n'ai pas encore testé). Son interface est simple, plus simple encore que gedit, mais demande l'apprentissage de quelques raccourcis pour optimiser votre travail.

C'est comme tout, le logiciel permet de faire des choses, mais aidez vous et le ciel vous aidera !

### Comparaison selon Blanko

Après avoir testé ces derniers jours gedit 2.22.3 et Scribes 0.3.3.3 sous Debian puis sous ArchLinux, voici les points positifs et négatifs que j'ai relevés pour chacun des deux éditeurs, surtout concernant le HTML, le Ruby et Rails.

<u>**NB** :</u> Ceci a testé sous un environnement [LXDE](http://www.lxde.org/ "Visiter le site officiel de LXDE") et sous un environnement [awesome](http://awesome.naquadah.org/ "Visiter le site officiel de awesome"), ce qui pourrait expliquer certains dysfonctionnements tel que celui sur l'échappement de la fenêtre de complètement.

#### gedit

##### Points positifs

  * Quantité de patrons (template/snippets) pour le HTML  (contrairement à Scribes)
  * De petits greffons sympas comme la barre de navigation à gauche et la console en dessous (ce que Scribes n'a, à ma connaissance, pas)
  * On peut choisir plusieurs lignes, faire une tabulation, cela déplace tout le code d'une tabulation vers la droite (contrairement à Scribes)
  * Avec un greffon nommé Commentateur de code, on peut commenter du code par simple sélection puis raccourci clavier ([Ctrl] + [m])

##### Points négatifs

  * Retour dans les snippets impossible, soit on rempli de suite, soit on doit naviguer par nous même (Scribes est bien mieux pour ça)
  * Bien moins de patrons pour Ruby (contrairement à Scribes qui propose même des patrons pour Rails)
  * Le complètement des mots existants dans le document n'existe pas => corrigé avec un plugin nommé *completion* disponible à l'adresse http://users.tkk.fi/~otsaloma/gedit
  * Un complètement existe pour les mots clés, mais si vous vous trompez et ne voulez plus la fenêtre de complètement, ni la touche [Échap], ni des clics à l'extérieur de la fenêtre de proposition n'y fait quelque chose
  * sed me manque dans gedit :'( (même si on possède le remplacement et le greffon *Outils externe* prévu pour ça, mais non fonctionnel lors de mes tests)

#### Scribes

##### Points positifs

  * Une petite floppée de patrons pour le langage que j'utilise : Rails et Ruby
  * Vous vous êtes trompés dans un patron, vous voulez retourner dessus ? Une fois arrivé aux alentours du patron (à l'intérieur ou juste devant), une simple tabulation vous fait vous déplacer dans les termes modifiables (comme défini dans le patron et au moment de la saisie)
  * Vous tapez quelques lignes, selon le langage et selon le texte déjà inséré, vous avez du complètement ! (contrairement à gedit, sauf si vous activez un greffon)

##### Points négatifs

  * Comme dans le logiciel [Gobby](http://gobby.0x539.de/trac/ "Visiter la page officielle de Gobby"), si vous sélectionnez du texte, puis appuyez sur tabulation, la sélection est remplacée par une tabulation ... Les jeunes disent : ça "suxxe" (désolé du terme barbare mais tellement expressif !) => fonctionne dans la version de développement
  * Non utilisable juste avec le clavier, demande la souris pour agir, notamment lors de l'ouverture d'un fichier selon l'environnement de bureau nous n'atteignons la fenêtre de navigation QU'à l'aide de la souris
  * Si vous enregistrez un fichier avec Scribes, il enlève les droits d'exécution pour tout le monde ... (bug fixé dans la version de développement)
  * sed me manque toujours, bien qu'un système de remplacement automatique de chaînes existe. Ce qu'il faut savoir c'est que [sed ne fait pas que du remplacement](http://www.commentcamarche.net/faq/sujet-9536-sed-introduction-a-sed-part-i "Découvrir sed au travers du guide fourni par commentcamarche.net") !
  * Pas de possibilité de commentaire (comme sous gedit)

### Conclusion personnelle

Après avoir testé les deux, je dois avouer que j'ai légèrement plus apprécié gedit que Scribes notamment pour le panneau de navigation et la console sous la page d'édition. Cependant le complètement était bien meilleure sous Scribes et les patrons plus développés / présents pour Ruby. Même si sous gedit les patrons pour le HTML sont plus développés.

Je pense que pour l'instant, l'un ou l'autre est utilisable, il ne tient qu'à vous de tester puis choisir en fonction de vos besoins.

Pour ma part je vais continuer de les utiliser et adopter celui qui me conviendra selon le critère suivant : celui où je développerais le plus vite ;)

### Liens utiles

  * [gedit](http://www.gnome.org/projects/gedit/ "Visiter la page officielle de gedit")
  * [Scribes](http://scribes.sourceforge.net/ "Visiter le site officiel de Scribes")

