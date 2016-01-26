# WARNING

**WARNING: After having discovered [Hugo static site generator](http://gohugo.io/), and [compared it to Makefly](https://github.com/blankoworld/makefly/wiki/Fonctionnalit%C3%A9s), I decided to close Makefly project with its last version: 0.4.1.**

You can find a [script to migrate from Makefly to Hugo on Github](https://github.com/blankoworld/makefly2hugo).

**Note**: If you're a warrior and want to check the code, have a look here:

  * https://github.com/blankoworld/makefly-devtools : Some tools to attempt to test Makefly
  * https://github.com/blankoworld/makefly-extras : Some themes
  * https://github.com/blankoworld/docker-makefly : Makefly in a Docker
  * https://github.com/blankoworld/nb2makefly : Migrate from Nanoblogger to Makefly
  * https://github.com/blankoworld/quinoa : A fork from Makefly to make a microblog
  * https://github.com/blankoworld/rave-comment : Comment system for Makefly

# ATTENTION

**ATTENTION : Après avoir découvert le [générateur de site statique Hugo](http://gohugo.io/) et l'avoir [comparé à Makefly](https://github.com/blankoworld/makefly/wiki/Fonctionnalit%C3%A9s), j'ai décidé de fermer le projet Makefly avec sa dernière version: 0.4.1.**

Vous pouvez trouver un [script de migration de Makefly à Hugo sur Github](https://github.com/blankoworld/makefly2hugo).

**Note** : Si vous êtes un *warrior* et voudriez vérifier le code, jetez un œil ici : 

  * https://github.com/blankoworld/makefly-devtools : Quelques outils pour tenter de tester Makefly
  * https://github.com/blankoworld/makefly-extras : Quelques thèmes
  * https://github.com/blankoworld/docker-makefly : Makefly dans un Docker
  * https://github.com/blankoworld/nb2makefly : Migrer de Nanoblogger à Makefly
  * https://github.com/blankoworld/quinoa : Un fork de Makefly pour faire un microblog
  * https://github.com/blankoworld/rave-comment : Système de commentaire pour Makefly

# For Users

It's not recommanded to use this version as it's a development version.

I suggest you to use the [stable version of Makefly](https://github.com/blankoworld/makefly/releases/tag/0.4.1 "Download Makefly 0.4.1 stable version") and read [Makefly 0.4.1 documentation](https://github.com/blankoworld/makefly/blob/master/doc/README.md "Read Makefly 0.4.1 documentation") to use it.

# Aux utilisateurs

Il n'est pas conseillé d'utiliser cette version puisque c'est une version de développement.

Je vous suggère de vous tourner vers [la version stable de Makefly](https://github.com/blankoworld/tag/0.4.1 "Télécharger la version stable 0.4.1 de Makefly") et de lire [la documentation de Makefly 0.4.1](https://github.com/blankoworld/makefly/blob/master/doc/README.md "Lire la documentation de Makefly 0.4.1").

# For those who are interested in the code

You can clone this repository as this:

    git clone https://github.com/blankoworld/makefly.git

First you need to install dependancies. Search these elements on your system:

  * lua 5.1
  * lua filesystem

Then you need to **copy** default configuration (*makefly.rc.example*) to the **makefly.rc** file. For an example:

    cp makefly.rc.example makefly.rc

Finally compile the doc:

    ./makefly doc

And read it in *doc/README.html*.

# Pour ceux qui sont intéressés par le code

Vous pouvez dupliquer le dépôt ainsi : 

    git clone https://github.com/blankoworld/makefly.git

Il faut avant tout installer les dépendances du projet. Cherchez les éléments suivants sur votre système : 

  * lua 5.1
  * lua filesystem

Puis vous devez **copier** la configuration par défaut (*makefly.rc.example*) vers le fichier **makefly.rc**. Par exemple : 

    cp makefly.rc.fr.example makefly.rc

Finalement compilez la documentation : 

    ./makefly doc

Et lisez la dans *doc/README.fr.html*.
