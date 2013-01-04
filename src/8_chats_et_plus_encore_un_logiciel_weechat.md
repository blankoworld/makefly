> Sont où les chats ? Il y en a 8 ou plus finalement ?

Non, nous ne parlerons pas de chat ici ! Lisez les catégories sous ce billet, nous sommes hors nature, animaux, etc. Nous parlons de logiciel, c'est à dire __weechat__.

### On aime :

> Qu'a weechat de mieux que les autres ?

N'en venons pas aux pénibles explications en long et en large qui ne convainquent personne, faisons simplement étalage de quelques petites choses sympathiques :

  * weechat est en mode console par interface semi - graphique (ne partez pas ! Cela joue énormément, comme nous le verrons dans un billet ultérieur !
  * L'apparence principale est comme Xchat, c'est à dire le salon de discussion au centre, la liste des contacts à droite et les message à écrire en bas. En haut, nous voyons le titre du canal lisible de gauche à droite à l'aide des touches F10 et F11. Cette apparence n'est pas proposée dans irssi, et on se fait ch*er pour avoir un truc presque similaire
  * weechat est jeune, une communauté quasie "possédée" s'attache donc au projet et répond aux questions sur irc.freenode.net #weechat-fr
  * weechat possède une bonne panoplie de plugins à l'adresse suivante : [Plugins Weechat](http://weechat.flashtux.org/plugins.php)
  * Son mode de fonctionnement permet l'insertion de script Perl, Ruby, Lua, Python
  * Un plugin directement intégré permet d'avoir ASPELL, le correcteur orthographique, c'est un méga hypra supra trop gros avantage de la mort qui tue (et encore je ne surenchérie pas)
  * Je l'aime, ça vous suffit pas ?

Bref, tout ça pour dire qu'il a ses avantages, tout comme ses inconvénients, mais pour devenir un GEEK que ne ferions nous pas !

### Rapidement, quelques manipulations

Je vous fais grâce des commandes ennuyeuses pour installer weechat, si vous avez Debian et dérivées, bravo c'est inclus, un .deb existe et vous êtes chanceux. Sinon ... allez sur le salon de discussion irc.freenode.net #weechat-fr ou lisez la [documentation](http://weechat.flashtux.org/doc.php).

Ensuite, pour se connecter à un serveur, il faut taper une méga longue commande. Voilà pourquoi je vous invite à apprendre l'utilisation de la commande __/help__ !

**/help** permet d'avoir un ensemble de commande, les touches précédentes et suivantes de votre clavier permettent de naviguer de bas en haut (ou inversement) afin de tout pouvoir lire. Une fois une commande intéressante, tapez __/help commande__. Ceci aura pour effet de vous renseigner sur les paramètres de la commande en question.

	 [w]  /server  [nom_serveur] | [nom_serveur nom/IP port [-auto | -noauto] [-ipv6] [-ssl] [-pwd mot_de_passe]
	 [-nicks pseudo1 pseudo2 pseudo3] [-username nom_utilisateur] [-realname nom_réel] [-command commande] [-autojoin
	 canal[,canal]] ] | [del nom_serveur]
	
	 liste, ajoute ou retire des serveurs
	
	     nom_serveur: nom du serveur, pour usage interne et affichage
	          nom/IP: nom ou adresse IP du serveur
	            port: port pour le serveur (nombre entier)
	            ipv6: utiliser le protocole IPv6
	             ssl: utiliser le protocole SSL
	    mot_de_passe: mot de passe pour le serveur
	         pseudo1: premier pseudo pour le serveur
	         pseudo2: pseudo alternatif pour le serveur
	         pseudo3: second pseudo alternatif pour le serveur
	 nom_utilisateur: nom d'utilisateur
	        nom_réel: nom réel de l'utilisateur

Ceci est apparu après un **/help server**. On sait alors que pour enregistrer un serveur on fait : 

	/server dreamsfr irc.dreams-fr.net 6600 -auto -ssl -pwd mot2passe -nicks Blanko Blanko_ Blanko__ -username blankoworld -realname Olivier DOSSMANN -autojoin #sharemanga

De là notre serveur va se connecter directement, mais la prochaine fois il faudra utiliser la commande **/connect dreamsfr** ou encore **/disconnect dreamsfr** pour se déconnecter.

Autre commande très importante, le changement de fenêtre ! Si les touches Alt + Shift + 1 ou Alt + Shift + 2 fonctionnent, nous sommes très vite limités. Voilà pourquoi il faut utiliser la commande __/buffer X__ où X est à remplacer par le numéro de fenêtre que vous voulez rejoindre.

### Aller plus loin

Pour en savoir plus je vous recommande vivement de lire la documentation dont nous parlions précédemment, mais également de rejoindre le canal #weechat-fr sur irc.freenode.net où les développeurs principaux pourront directement vous répondre. Tâchez simplement de ne pas paraître trop bête ;)

### Liens

  * [Site officiel](http://weechat.flashtux.org/)
  * [Démarrage rapide](http://weechat.flashtux.org/doc/weechat_quickstart.fr.txt)


