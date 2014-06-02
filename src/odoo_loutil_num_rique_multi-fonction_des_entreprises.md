### Introduction

Ça y est, OpenERP a **enfin** réussi à fonctionner et à émarger 10 millions d'euros, mais…

OpenERP, pour ceux qui ne connaissent pas, est un logiciel libre de gestion d'entreprise qui s'occupe, entre autre, de votre gestion clientèle, votre comptabilité - enfin il l'enregistre - et votre logistique (gestion de stock, enlèvement marchandise, commande client/fournisseur, etc.).

![Logo d'Odoo](${BLOG_URL}/images/logos/odoo.png)

### Il y a fort longtemps dans un royaume très très lointain

Jusqu'à maintenant OpenERP vivait sa vie bien tranquillement, fort heureux de sa communauté, des partenaires, de leurs contributions et des remontées de bugs conséquentes.

C'est alors que, sorti de sous les racines d'un arbre, une [bourse remplie d'or surgit](http://www.lemondeinformatique.fr/actualites/lire-openerp-leve-3-millions-d-euros-pour-poursuivre-son-expansion-29989.html "En savoir plus sur la levée de fonds d'OpenERP il y a quelques années") et dit :

> Veux-tu 3 millions d'euros pour t'étendre ?

De là, ce fut la course - je précise, c'est mon ressenti. Les développeurs semblent s'être remontés les manches, les commerciaux couraient dans tous les sens, et Open tchatcher se mit en route. Le but : Innover !

### L'innovation se répandit à travers tout le royaume

On ne sait pas ce que firent les bricoleurs du dimanche pendant tout ce temps, toujours est-il que plusieurs années après, OpenERP sorti en version 7 et fit un foin pas possible, pour ne plus parler de lui juste après la sortie. Rappelez-vous, cet OpenERP super-méga-social où tu peux twitter et faire du jabber pendant les heures de boulot. Je suis sûr qu'on peut envoyer le numéro de facture et les infos clients directement sur Twitter d'un simple clic ^_^.

Quoiqu'il en soit, même après la sortie les commerciaux ne semblaient pas satisfaits. Il fallait encore gonfler le buste, alors on a eu droit à [une campagne Indiegogo pour le point of sale façon OpenERP](https://www.indiegogo.com/projects/opensource-your-shop).

Mais quelques choses de plus sombre, de plus noir, de plus *innovant* se tramait. Tapie dans l'ombre : une souris filaire !

> Quoi, une souris ?

Non, c'est une blague. L'innovation continua jusqu'à son paroxysme et OpenERP se diversifia - encore plus.

### Diversifier pour mieux régner

OpenERP sort donc quelques **grosses** fonctionnalités supplémentaires, assez conséquentes : 

  * Générateur de site Web
  * Blog
  * eCommerce

Eh oui, même l'eCommerce, parce que ça suffit pas que d'autres outils galèrent pendant des années pour faire un produit robuste qui puisse défier la concurrence. OpenERP fait pareil, en moins de temps !

Et c'est récemment que nous a été révélé le but ultime - à mon avis il y a encore plus - d'OpenERP : lever 10 millions. Mais… en fait non. Ce n'est pas vraiment OpenERP qui en bénéficiera.

### OpenERP change pour devenir Odoo

L'entreprise, le produit, les dépôts, les bugs, ?les développeurs?, tout change dans OpenERP (ou pas. Reste encore la documentation et les tutoriels vidéos/écrits à mettre en place et à migrer).  Désormais l'entreprise est/sera Odoo S.A. Le logiciel sera Odoo.

Les dépôts migrent de Launchpad à Github. Fini le bazaar dans les dépôts, désormais on se noiera dans la multitude de commandes incompréhensible avec Git - et pourtant j'aime Git.

Les bugs ? Bah… on est passé à Github. Refaites-les ;)

Cherchez sous "la conduite du changement en entreprise", vous trouverez des articles intéressant qui vous expliqueront comment on mène à bien un changement "en douceur".

Ne vous inquiétez pas, on ne changera pas de clients. Avant c'était 18 euros par mois par utilisateur, désormais ce serait 12 euros par utilisateur par mois **ET** par module (**Edit**: Cf. plus bas, les prix étaient de 35 euros par utilisateur par *fonctionnalité* et sera désormais de **12 euros par utilisateur par fonctionnalité**). Mais puisqu'on vous dit que c'est moins cher ! Et en plus, 2 utilisateurs sont gratuits, mais faites attention à toujours éviter les dépassements, car à partir du troisième utilisateur, vous casquez pour 3 par mois par module. La facture est donc très salée. Pensez à licencier souvent pour une meilleure gestion (il y a un module gestion des ressources humaines dans Odoo si vous voulez) !

### Conclusion

Le changement fait toujours peur. Que ce soit pour une entreprise, une communauté, des utilisateurs, des clients, des investisseurs. Changer d'OpenERP vers Odoo fait donc peur, il est normal d'en rigoler un peu plutôt que d'en pleurer.

Nous verrons bien si - avec le temps - Odoo saura nous émerveiller autant que TinyERP, puis OpenERP a su le faire ces dernières années. Le cas échéant, le code source reste ouvert, et Tryton - le projet fork d'OpenERP - est toujours là pour prendre la relève cas échéant. Ça fait pas le café, mais il y a un dépliant sur comment procéder. La doc, il, n'y a que ça de vrai.

### Liens utiles

  * [Dépêche sur LinuxFR à propos du passage d'OpenERP vers Odoo](linuxfr.org/news/odoo-le-nouveau-openerp-avec-10-millions-de-plus)
  * [Campagne Indiegogo pour le "point of sale" d'OpenERP](https://www.indiegogo.com/projects/opensource-your-shop)
  * [OpenERP lève 3 millions](http://www.lemondeinformatique.fr/actualites/lire-openerp-leve-3-millions-d-euros-pour-poursuivre-son-expansion-29989.html "En savoir plus sur la levée de fonds d'OpenERP il y a quelques années")

### Edit du 02 juin 2014

Fabien Pinckaers m'a écrit pour quelques informations complémentaires suite à la lecture de ce billet, voici son courriel : 

<pre>
Petites corrections:

- Une levée de fonds de 10 millions n'est pas un but mais un moyen. L'objectif est d'accélérer les améliorations produits.
- La v7 n'a fait du bruit qu'à sa sortie car on n'avait pas de département marketing. L'action de communication était donc un one-shot. Mais,s ur le terrain, la v7 a fait encore plus de bruits par la suite; rythme d'acquisition d'utilisateurs 2.87x plus important qu'en v6.1, seulement 3 mois après la sortie de la v7.
- Le prix: Odoo passe de 35€ par mois à 12€ par mois par "bundle" d'applications. Exemple: CRM, Ventes, Devis en Ligne, c'est un seul bundle. (et non pas de 18€ à 12€)
- 18€ (17.5€ pour être exact) était le prix des partenaires ready (qui ont 50% de ristourne sur le prix public). Les partenaires ont toujours leur ristourne sur le prix public. Le prix partenaire passe donc à 6€ par mois et par bundle d'application, et non pas 12€.

Plus d'infos sur le changement de prix ici:
<a href="https://www.odoo.com/blog/Odoo-Blog-1/post/Odoo-The-New-Pricing-Q3-2014-158">https://www.odoo.com/blog/Odoo-Blog-1/post/Odoo-The-New-Pricing-Q3-2014-158</a>

Odoo est environ deux fois moins cher que la concurrence, ce qui est exceptionnel sur le marché (où les moins chers sont plutôt aux environs de 15% moins cher):
<a href="https://www.odoo.com/website/image?max_height=768&field=datas&model=ir.attachment&id=537400&max_width=1024">href="https://www.odoo.com/website/image?max_height=768&field=datas&model=ir.attachment&id=537400&max_width=1024</a>
</pre>
