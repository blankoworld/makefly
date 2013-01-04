Nous établissions, dans l'article précédent [concernant Weechat](${BASE_URL}/archives/2008/08/index.html#e2008-08-08T23_26_28.txt) (logiciel de messagerie instantanée pour IRC), une façon particulière de discuter sur internet. Ce jour nous allons voir comment pouvoir laisser notre logiciel de discussion toujours ouvert / allumé afin de pouvoir se connecter après sans avoir pour autant perdu un fil de la conversation.

### Screen, la console virtuelle

**screen** permet de faire des consoles virtuelles sous GNU / Linux.

> À quoi cela sert d'avoir des consoles virtuelles dans une console physique ? C'est complètement idiot !

Pas si idiot que cela ! En effet, imaginez que vous ayez accès à un serveur Linux par le biais de [ssh](/wiki/doku.php?id=astuces:chiffrement:index), comme le serveur s'éteind peu ou pas souvent, vous pouvez laisser tourner une application. Et la console virtuelle va vous éviter de fermer votre accès en éteignant par la même le logiciel lancé dans la session.

Grossomodo vous aurez Weechat qui tourne dans une console virtuelle à laquelle vous pouvez accéder de n'importe où pourvu que le serveur soit connecté à internet, laisse passer le port 22 pour la connexion SSH et que vous soyez aussi connecté au net pour aller sur le serveur.

__screen__ propose une façon particulière d'aller sur la console virtuelle, de s'en détacher, s'en rattacher, etc. Nous allons voir les commandes les plus utiles pour faire fonctionner Weechat. :p

### De l'utilisation de screen

Une fois votre screen installé à l'aide de la commande

	apt-get install screen 

(par exemple), vous pouvez de suite l'utiliser.

Tapez **screen -S test** puis sur la touche Entrée pour vous rendre dans une console virtuelle nommée __test__. Cela ne change pas de la console habituelle, sauf si vous faites Ctrl+d ce qui aura pour effet de vous sortir de la console virtuelle.

Une fois dans la console virtuelle, lancez weechat pour tester. Puis faites Ctrl + A, puis tapez sur d. Vous sortez de la console virtuelle.

	screen -ls

vous donnera la liste des screen actuellement lancés. Comme nous l'avons nommé test, nous pourrons nous y connecter à l'aide de la commande suivante : 

	screen -r test

Si cela ne fonctionne pas, la commande -r (rattacher) manque d'un argument : -d

	screen -d -r test

Ceci oblige screen à détacher la console virtuelle avant de la rattacher.

Une fois la commande tapée, vous vous retrouverez dans weechat (ou tout autre logiciel lancé alors).

Pratique non ? Nous disposons alors d'un weechat qui peut être connecté 24/24h 7/7j ! Encore faut il posséder un serveur ...

### Conlusion

Grâce à screen, nous est offert bien plus de possibilités pour peu que nous possédions un serveur fonctionnel et allumé fréquemment. Je vous invite à suivre les liens utiles pour de plus amples informations sur screen et les fonctions qu'il propose.

Depuis cette découverte de screen, je dois dire que j'ai moins peur de perdre le travail en cours, puisque je peux me rattacher à la session screen même après coupure de la connexion, extinction de mon pc portable pour manque de batterie, etc. Mais cela demande une connexion internet ...

### Liens utiles

  * [Tutoriel screen sur Laboratoire SupInfo](http://www.labo-linux.org/articles-fr/gnu-screen/presentation-de-screen)
  * [screen sur le Wiki du Blankoworld](/wiki/doku.php?id=astuces:console:linux:screen)
