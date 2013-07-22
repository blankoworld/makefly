ikiwiki, ou ikiwiki (à l'envers), est un moteur de wiki très intéressant dont je vous parlais quelque peu dans [mon billet consacré à l'espace de démonstration](${BLOG_URL}/archives/2008/09/29/espace_de_d%C3%A9monstration_dans_le_blankoworld/index.html "Lire le billet de Blanko sur son espace de démonstration sur le Web").

### Présentation

Pour faire simple ikiwiki est un compilateur de wiki statique. C'est à dire qu'ikiwiki va traiter un certain nombre de fichiers pour en ressortir un ensemble de pages statiques HTML.

L'avantage d'un tel traitement et d'un tel résultat : vos pages dites statiques sont exportables vers n'importe quelle plateforme web (serveur possédant un service web tel qu'Apache, lighttpd, etc.) et les visiteurs n'attendent pas des milliers d'années pour afficher vos pages puisqu'aucun traitement ou aucune lecture dans une base de données ne sont effectués.

> Mais alors comment modifier les pages ?

Les pages peuvent être modifiées à l'aide d'un script CGI, lui aussi compilé selon la configuration faite dans un et un seul fichier dit SETUP.

### Il faut le voir pour le croire

Pour une petite démonstration, ne faites ni plus ni moins qu'un tour sur ma [salle de démonstration du Blankoworld](http://blankoworld.homelinux.com/demo/ikiwiki/ "Se rendre dans la salle de démonstration du Blankoworld"), cliquez sur un des dossiers/thèmes que vous souhaitez observer, puis entrez dans le dossier **htdocs** qui contient le site en question. Vous pourrez voir par vous même les possibilités offertes par ikiwiki.

### Quelques avantages

  * Les sources du wiki peuvent être dans un dépôt tel sur Subversion, GIT, Mercurial, etc., ce qui permet un suivi efficace des changements
  * Le langage Markdown utilisé pour créer des pages est très simple et très facile à assimiler
  * De nombreux plugins sont disponibles et croissent en nombre
  * Rapidité des pages ainsi créées
  * Portabilité du wiki
  * Légèreté du résultat
  * Personnalisation par des templates + CSS

### Quelques inconvénients

  * Par d'interface web de type Javascript toute belle pour modifier les pages
  * Impossibilité de modifier la langue pour les formulaires d'édition et préférences
  * Langage Perl, donc nécessite pour certains plugins de nombreuses dépendances parfois ennuyeuses à installer
  * Vous en voulez d'autres ? Installez et cherchez :)

### Conclusion

Pour le site que j'ai fait pour [Alsace Billard](http://alsace-billard.eu "Visiter le site de l'association de billard d'Alsace"), celui donné en lien ci - après, celui fait dans mon entreprise, je peux affirmer qu'il est de bon ton d'utiliser ikiwiki <u>quand on aime les gestionnaires de versions et que les interfaces web façon clignotant ne nous intéressent pas</u>.

Ikiwiki présente d'énormes possibilités, à vous de les mettre en place et de les utiliser.

### En savoir plus

Je vous invite très vivement à faire un tour sur mon Wiki (non pour cette fois je n'ai pas ikiwiki pour mon usage personnel, mais je l'utilise sur [Nanoblogger Francophone\[wiki\](Découvrir le wiki du site Nanoblogger Francophone), et plus particulièrement sur [la page consacrée à ikiwiki](/wiki/doku.php?id=configurations:ikiwiki:index).

