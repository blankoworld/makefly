### Introduction

Vous avais je parlé du cadre de travail [Rails](http://2008.rmll.info/IMG/pdf/RubyOnRails.pdf "Télécharger une présentation au format PDF de ce qu'est Rails et de ce qu'il apporte.") que j'utilise ?

> Non.

Ok, bien, alors voici comment nous allons répartir l'article, qui sera un peu long, mais qui vous apportera sûrement l'envie de développer vos sites Webs avec ce cadre de travail / framework qu'est Rails :

  * Présentation de Rails (et ce quels avantages en tirer)
  * Le modèle MVC et plus particulièrement les vues avec le RHTML
  * HAML, le façon de mieux présenter les vues, mais pas seulement ...
  * Conclusion

Cela vous va t il ?

> Non.

Vous dites toujours non ?

> Non.

Commençons donc, voulez vous !

### Présentation rapide de Rails

Je vais me répéter, mais nul autre choix que de le faire dans ce paragraphe : Rails est un framework, un cadre de travail, c'est à dire qu'il encadre le développeur pour lui faciliter la tâche et rendre les choses plus simples, plus rapides, et plus fonctionnelles que jamais !

Rails, ou plutôt Ruby On Rails (= RoR), permet de développer une application Web du début à la fin. Le nom implique également que le langage utilisé pour développer est le langage Ruby. Le système permet de faire une application Web en deux temps trois mouvements. Par exemple, sur le net, on trouve des [tutoriels pour faire un blog en Ruby On Rails en 10 minutes](http://www.netbeans.org/kb/60/ruby/rapid-ruby-weblog.html "Découvrir comment créer son blog en Rails en moins de 10 minutes à l'aide de Netbeans."). D'autres encore proposent la création d'un wiki ou d'un moteur de recherche mondial en quelques minutes !

Vous trouverez plus de tutoriels et informations sur le [site officiel de Rails](http://rubyonrails.com/ "Se rendre sur le site officiel de Ruby On Rails"), notamment à travers le lien **Screencast**.

Nous allons désormais nous pencher sur l'un des aspects intéressant de RoR : le schéma MVC.

### Le modèle MVC, la puissance de Rails

L'une des choses qui rend Rails très puissant, très apprécié, et très propre, c'est l'utilisation du schéma MVC. M pour modèle, V pour vues et C pour contrôleurs.

> Et qu'est ce dont que le schéma MVC ?

J'aimerais vous expliquer en détail, mais comme une image vaut mieux que de grands discours, voici un aperçu du schéma MVC : 

![Image décrivant le modèle MVC](${BASE_URL}/images/schemas/MVC.png "Le contrôleur appelle les modèles et les vues ; le modèle renvoie les données à la vues ; et les vues envoient des demandes au contrôleur et des données au modèle")

Pour de plus amples renseignements sur le modèle MVC, veuillez vous référer à [Wikipedia et son article sur les Modèles - Vues - Contrôleurs](http://fr.wikipedia.org/wiki/Mod%C3%A8le-Vue-Contr%C3%B4leur "Lire l'article de Wikipédia sur le contenu du schéma MVC").

Dans le cas de Rails et de MVC, on remarque que : 

  * Les modèles sont des objets, dits couche métier, qui permet d'aller papoter avec la base de données et rendre compte des résultats des requêtes
  * Les contrôleurs commandent les modèles et récupèrent le résultat
  * Les vues utilisent les sorties des contrôleurs et les ordonne comme elles veulent pour l'afficher à l'utilisateur
  * Rails a crée aussi des "helpers" qui permettent aux vues de faire appel à des fonctions d'affichage spécifique qu'on retrouve plusieurs fois dans plusieurs vues différentes

Sous Rails d'ailleurs, les vues sont similaires à ce que nous pourrions appeler des **templates**. À cet effet le format par défaut est le **RHTML**, qui ressemble à ceci : 

	<h2><%= @article.titre %></h2>`
	  <p><%= @article.contenu %></p>`
	  <div class="auteur">Écrit par <%= @article.auteur %></div>`

Cela permet d'utiliser du ruby à l'intérieur du code HTML (ou XHTML pour les gens sérieux :P ).

Mais récemment, un évènement a fait tomber mon estime de RHTML à zéro : j'ai découvert le HAML !

### HAML, une vue plus propre pour un code plus sain

Le HAML est une autre vision de l'écriture d'une vue, cela simplifie la vie et les vues :) . Cette simplification amène le développeur à factoriser son code pour le rendre simple, à faciliter la tâche de création de vues pour un infographiste en relation avec les développeurs, et à <u>indenter le code correctement</u> à la sortie de notre application !

Voici le résultat du code précédent, transformé en HAML : 

	%h2= @article.titre
	  %p= @article.contenu
	  .auteur= "Écrit par #{@article.auteur}"

Avouez que c'est plus simple et que l'on tape moins de caractères ;) 

Voilà pourquoi je n'ai pas hésité, j'ai installé HAML dans mes projets Rails selon le [tutoriel officiel de HAML](http://haml.hamptoncatlin.com/download/ "Lire le tutoriel d'installation de HAML sur notre ordinateur et dans nos projets Rails").

Comme le dit d'ailleurs [le site officiel](http://haml.hamptoncatlin.com/ "Visiter le site officiel de HAML"), les 20 premières minutes sont un peu déroutantes, mais par suite on ne pourra plus s'en passer !

### Conclusion

Certes nous n'avons pas vu tout les détails et tout les avantages d'un tel système pour les templates de Rails, mais je suis certain que si vous vous y mettez, que vous testez, et que vous utilisez, vous serez vite pris par le jeu et ne pourrez plus vous arrêter.

HAML n'apporte pas qu'une modification d'écriture et une indentation parfaite, il apporte aussi au développeur d'avoir de la jugeotte pour factoriser son code et mettre plus de choses dans les "helpers" de Rails.

Je vous conseille donc vivement HAML, nul doute cela sert et vous plaira !

### Liens utiles

  * [Site officiel de Ruby On Rails](http://rubyonrails.com/ "Visiter le site officiel de Ruby On Rails")
  * [Rails France](http://railsfrance.org/ "Se rendre sur le site francophone de Ruby On Rails")
  * Serveur IRC : irc.freenode.net, canal #rubyonrails.fr, mais aussi le canal #rubyfr
  * [Railscast](http://railscasts.com/ "Découvrir des vidéos d'explication de l'utilisation de Rails")
  * [Site officiel de HAML](http://haml.hamptoncatlin.com/ "Visiter le site officiel de HAML")
  * [Tutoriel d'installation de HAML (selon le site officiel)](http://haml.hamptoncatlin.com/download/ "Apprendre comment installer HAML dans son ordinateur et l'inclure à un projet Rails")

