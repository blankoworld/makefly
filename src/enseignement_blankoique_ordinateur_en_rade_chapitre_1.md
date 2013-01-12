Il y a environ 2 semaines, un membre de la famille d'un [ami à moi, Irpdev](http://www.irpdev.fr/ "Se rendre sur le blog d'Irpdev") a eu un souci d'ordinateur. Un souci matériel. Figurez-vous qu'en ce moment j'ai un problème similaire !

> Blanko ? On s'en bat les ieuxes de ton souci d'ordinateur.

Ah mais attendez ! Je vais en profiter pour vous montrer les étapes suivies au fur et à mesure pour découvrir le problème, le régler ou agir en conséquences !

> Ah j'aime mieux ça. Alors ? Qu'as-tu fait ?

### Symptômes

Voici quelques symptômes visibles : 

  * Écran bleu sous Windows Vista (pas de raillerie sur le SE merci)
  * GNU/Linux figeait
  * Plus que 1024Mo reconnus alors que je possède 2 barettes de mémoire vive. (Sous GNU/Linux, faites **free -mt** pour le savoir, sous Windows pressez simultanément les touches [Windows] + [Pause/Attn].
  * Le disque dur *grattait* souvent sous Windows, beaucoup trop à mon goût
  * [vu plus tard] Pendant une copie de gros fichiers du disque à un autre, un autre accès simultané comme voir combien d'espace occupe un dossier faisait planter la machine (figé)

Nous allons voir un peu ce qu'on peut ressortir de cela.

### Apprendre à trouver des pistes en fonction des symptômes déclarés

Je vais vous décrire en quelques paragraphes, les choses que je peux plus ou moins déduire des symptômes. **Apprenez** vous aussi cette logique si vous la trouvez bonne ;) 

#### Plantages de 2 SE (Systèmes d'Exploitation)

Le fait que des écrans bleus arrivent sous Windows, **ET** que GNU/Linux plante amènent forcément à se diriger vers un souci matériel ! En dehors du troll qui consiste à chercher si Windows ou Linux sont meilleurs l'un envers l'autre, il faut avouer qu'avoir les deux permet au moins de dégager un interprétation correcte des symptômes : **Si Windows ET Linux plantent, alors le souci est probablement matériel**. Pratique non ? Et on peut avoir des licences Windows pour 50 euros environ, soit 10 euros moins cher qu'un diagnostic d'un informaticien callé :P 

#### Mémoire vive amenuisée

Si le total de la mémoire vive diminue, c'est forcément qu'il y a un souci de mémoire vive !

> Dingue Blanko, t'a une logique de fou !

Bon c'est vrai, ça paraît totalement logique, mais croyez-moi, certains n'ont pas cette logique de "plus trop de mémoire, alors souci de mémoire".

#### Disque dur défaillant

Votre disque dur a des râtés pendant de grosses copies, il y a de fortes chances pour qu'il rende l'âme bientôt.

Si **en plus** il vous fait des misères de *grattage* c'est pas bon signe.

### Que faire ?

#### Matériel

Nous avons vu que le matériel fait défaut, dans ce cas là il faut **tester chaque périphérique**.

La plupart du temps, ces tests sont dits ** tests empiriques** : On procède au remplacement **un à un** des périphériques.

Exemple : on remplace le disque dur, on relance la machine et on voit si les bugs interviennent toujours. Si plus de bug, il se peut que ce soit le disque dur qui soit l'origine du problème. Si toujours un bug, on remet le disque dur de départ, et on change une autre pièce. On continue jusqu'à plus de bug. Une fois toutes les pièces changées une à une et le bug continue, il faut tenter de changer deux par deux (en faisant des couples). C'est long, très long, mais ça peut donner de bons résultats, des résultats **précis** !

#### Mémoire vive

Pour le test de la mémoire vive, on peut procéder déjà à ce qu'on appelle un **memtest**. C'est un outil de test de la mémoire vive.

Pour cela je vous propose d'utiliser le fameux [System Rescue CD](http://www.sysresccd.org/Page_Principale "Se rendre sur la page principale de System Rescue CD").

L'utilisation est simple : on s'occupe de modifier le BIOS de l'ordinateur pour changer l'ordre de démarrage (boot) afin qu'il puisse démarrer sur un CD-ROM au lancement de la machine. Une fois le CD lancer, on tape *memtest* à l'invite de commande. Puis on laisse le programme s'effectuer jusqu'à ce qu'on obtienne l'un des 3 évènements suivants : 

  * En bas de l'écran apparaisse une phrase comme "Le logiciel a effectué une passe complète sans aucun problème". Dans ce cas votre mémoire vive n'a potentiellement aucun souci.
  * Des lignes rouges apparaissent à l'écran : votre mémoire vive est défaillante. Et il faut procéder à un test physique dont je parlerais après
  * L'ordinateur fige : il se peut que vous ayez des problèmes de mémoire vive **et/ou** de carte mère.

J'ai donc procédé à un test chez moi, sans aucun souci. Mais il faut savoir que Memtest ne m'affichait que 1024Mo sur les 2048 physiques ! J'ai donc décidé de procéder à un test empirique !

**Voici comment j'ai procédé pour la mémoire vive**

Sachant que je possède 2 barrettes de 1024Mo, voici les tests que je devais faire : 

  * Faire un memtest des 2 barrettes de mémoire vive : on teste tout (mais le logiciel ne reconnaissait que 1024Mo)
  * Débrancher la première mémoire vive, relancer la machine, et faire un memtest complet : cela permet de tester la seconde mémoire vive
  * Rebrancher la première mémoire vive, enlever la seconde, et faire un memtest complet : cela permet de tester la première mémoire vive
  * Débrancher la première mémoire vive, et la mettre dans le second emplacement (celui de la seconde), tout en laissant le premier emplacement vide et faire un memtest : on teste la première mémoire vive dans l'emplacement 2
  * Faire de même avec la seconde mémoire vive dans l'emplacement 1

Je donnerais le résultat des tests. Passons au disque dur.

#### Disque dur

J'avoue que pour les disques dur, je ne connais pas trop les solutions à adopter. En général les outils comme **fsck**, **testdisk** et **ddrescue** permettent de faire pas mal de choses. Mais il faut s'y connaître.

Vous devriez contacter une personne compétente pour en savoir plus.

Par contre si vous êtes sûrs que le disque dur déraille vraiment, et qu'il est à l'origine du problème, sauvez vos données et changez de disque dur !

### Résultats des tests

Après les tests de mémoire vive, il s'avère qu'un des emplacements fait planter le pc au démarrage même de l'ordinateur ! L'emplacement 1 est défectueux. Les deux mémoires fonctionnent car prises une à une sur l'emplacement 2, les memtest ne décèlent aucun souci !

Comme c'est l'emplacement le souci, c'est donc la carte mère entière le souci ! Il faut en changer.

Première chose à faire : **TOUT sauvegarder**.

### Sauvegarde des données

Je voudrais sauver mes données, il me faut donc : 

  * Un disque dur externe ayant autant de capacité que le mien, voire un boîtier externe pouvant accueillir le nouveau disque dur acheté
  * System Rescue CD donné en lien ci-avant
  * De la patience : une bonne après-midi selon l'étendue des données
  * Quelques connaissances en montage de partitions sous Linux

Sous System Rescue CD j'utilise principalement **partimage** pour les partitions contenant un système d'exploitation (en l'occurence Windows Vista et NuTyX).

Sinon j'utilise **rsync** pour les partitions de données et */home*. Rsync est simple, on fait : 

<pre name="code" class="bash">
rsync -avP /chemin/d/origine /chemin/de/destination
</pre>

Et on patiente. Si le pc plante entre temps : on relance la commande et ça reprend là où cela en été arrêté !

### Conclusion

Les ordinateur nous font bien des misères, mais on peut toujours trouver l'origine du souci, il suffit d'un peu de logique, de méthodes, et surtout de patience !

Je vous invite à lire les chapitres suivants de la saga **Ordinateur en rade** car ces prochains jours je vais forcément avancer dans cette histoire.

