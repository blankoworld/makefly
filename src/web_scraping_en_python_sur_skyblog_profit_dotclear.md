La semaine dernière je parlais de l'[internet libre](${BASE_URL}/archives/2008/04/11/nouveau_domaine_dossmann_net/index.html "Visionner le billet concernant l'internet libre"). Pour mener à bien cette mission, et sans reparler de mes actions faites, je devais aussi migrer le [joueb / blog de Filledou](http://filledou.skyblog.com) (ma soeur), sur Dotclear ou similaire.

### Le début

Evidemment, et c'est connu, les utilisateurs normaux veulent quelque chose de correct, pas de bidouillage ! Du coup, ma soeur me faisant chi*er pour que ça fonctionne comme avant, avec tout les billets de skyblog.

Il faut donc "simplement" récupérer les données de Skyblog ... :'(

### Le déroulement

Au départ j'entrepris d'apprendre les [REGEX PHP](http://www.siteduzero.com/tuto-3-168-1-les-expressions-regulieres-partie-1-2.html "Apprendre à utiliser les REGEX PHP sous Site du Zéro.com"). Après une bonne lecture et quelques essais je confirmais ce que je savais déjà : je ne suis pas doué pour les expressions régulières. Et pour parcourir un arbre HTML, c'est pas le top top (ou alors il faut plus d'expérience). :angry:

Ainsi je suivais le chemin qu'on me conseillait : Utiliser une bibliothèque Python pour le parcours d'un arbre HTML (les anglais disent HTML parser je crois). Pour cela, il faut utiliser la bibliothèque **[BeautifulSoup](http://www.crummy.com/software/BeautifulSoup/ "Aller sur le site officiel de BeautifulSoup")**. Mais en me documentant dessus, je remarquais aussi la chose suivante : C'est du **Web Scraping** ce que je fais !

### Le Web Scraping de Skyblog

Le Web scraping consiste en la récupération d'informations sur des pages Web prises au hasard ... ou pas ! Du coup mon idée de prendre les informations de Skyblog devient du Web scraping. Bien ou pas bien ? :roll: . Etant donné que je recupère des données crées par ma soeur, je considère ça comme étant correct, du coup je me suis lancé pleinement dans la tâche de parcours de l'arbre HTML résultant des pages Skyblog, puis dans l'enregistrement de ces données dans la table *dc_post* de Dotclear, car ce que nous voulons, c'est passer à Dotclear.

Après quelques jours d'essais en tout genre, de lecture de livres Python, etc. je parvins à un script correct, et réussis à passer à Dotclear ! Le résultat est sur le [nouveau site de ma soeur](http://filledou.net "Site de Filledou")(lien mort). Cependant j'ose supposer que vous voudriez voir un peu la tête du code ? Dès que possible je vous le mettrais ici, mais pourquoi ne pas commencer avec quelques exemples ?

### Le code

La structure du code est simple : 

  * Récupération de la page Skyblog
  * Parcours de l'arbre
  * Récupération des informations
  * Traitement
  * Remise en forme pour enregistrement
  * Enregistrement dans la base
  * Page suivante

Pour un exemple sur la récupération du code sur internet ainsi qu'une utilisation simple du Web Scraping, je vous invite à visiter le [billet de crowtheries](http://isparse.net/?p=57 "Apprendre le Web Scraping en Python") dans lequel il prend un exemple simple de récupération de données sur un site internet. Vous comprendrez non seulement la facilité avec laquelle, après quelques essais, on retire l'information, mais aussi la puissance d'un tel processus.

### Résultat

Bon aller, je suis sympa, je vous passe le code :P , amusez vous bien : [code de Blk_skyclear.py](http://git.dossmann.net/?p=scripts/skyclear "Descendre le code de transfert d'un skyblog vers un blog en Dotclear").

Si l'un de vous pourrait l'améliorer, voire en faire un plugin Dotclear, à votre aise ! Laissez moi un commentaire pour m'informer de votre travail, cela m'intéresse !
