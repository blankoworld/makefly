### Introduction

L'Arduino est une carte électronique assez connue permettant grossomodo de transformer n'importe quel objet en objet intelligent puisque vous allez pouvoir programmer ce dernier afin d'avoir des comportements spécifiques suivant les données reçues par un certain nombre de capteurs.

![Image d'une carte électronique Arduino](https://www.arduino.cc/new_home/assets/illu-arduino-UNO.png "Notre carte Arduino")

Arduino permet de réunir le monde de l'informatique à celui de l'électronique et favorise le DIY (Do It Yourself = fait le toi-même).

Le [site officiel d'Arduino](http://arduino.cc "Se rendre sur le site officiel Arduino") propose de nombreuses documentations et surtout un logiciel pour développer, compiler et envoyer sur l'Arduino votre programme. C'est une interface simple, claire, compatible Windows, MacOSX et GNU/Linux car développée en Java. Cependant, je préfère très - ou trop ? - souvent développer des programmes sous VIM en mode console et faire les compilations et l'envoi en ligne de commande. Et je ne suis pas le seul. Voilà pourquoi j'ai décidé de vous partager mon environnement de travail pour Arduino.

### Sommaire

Programmer pour Arduino se résume finalement comme beaucoup d'autres projets aux 3 actions suivantes : 

  * développer un programme sur son éditeur préféré
  * compiler le programme (parfois sur le même éditeur)
  * envoyer le résultat en production. Dans notre cas ce sera dans l'Arduino

Si la première étape est facile pour tout le monde, puisque chacun a probablement déjà son éditeur préféré, les 2 dernières étapes sont moins simples.

Sous GNU/Linux, et plus particulièrement sous une distribution dérivée Debian, cela se résume quasiment à :

  * installer les paquets **arduino-core** et **arduino-mk**
  * initialiser des variables dans son **.bashrc**, **.zshrc** ou tout autre invite de commande
  * savoir créer pour chacun de ses projets Arduino un fichier Makefile
  * savoir quelle commande utiliser pour compiler et pour envoyer le résultat sur l'arduino

Passons donc à la préparation de l'environnement

### Installation et configuration

Comme vous l'avez vu, nous commençons par l'installation des paquets **arduino-core** et **arduino-mk** :

    apt-get install arduino-core arduino-mk

Ceci devrait, entre autre, installer **avrdude** qui nous facilitera l'envoi sur l'Arduino.

Ensuite nous éditons le fichier de configuration de notre shell préféré, ici **.bashrc** afin d'y initialiser les variables suivantes : 

  * ARDUINO\_DIR : le dossier dans lequel a été installé **arduino-core** qui contient, entre autres les bibliothèques nécessaires à la programmation d'un Arduino
  * ARDMK\_DIR : le dossier dans lequel a été installé **arduino-mk**
  * AVR\_TOOLS\_DIR : le dossier dans lequel chercher l'outil **avrdude**

Chez moi cela donne quelque chose comme : 

    export ARDUINO_DIR="/usr/share/arduino"
    export ARDMK_DIR="/usr/share/arduino"
    export AVR_TOOLS_DIR="/usr"
    export ISP_PORT="/dev/ttyACM0"

À noter que j'ai rajouté la variable **ISP\_PORT** pour définir d'emblée le port de communication avec mon Arduino. Ce n'est donc pas obligatoire dans votre cas (comme nous le verrons par la suite).

Passons à l'utilisation de tout cela.

### Utilisation

Si nous devions résumer une utilisation simple de cet environnement, voici les étapes que nous ferions : 

  * créer un dossier pour notre projet
  * créer un fichier avec l'extension **.ino** et remplir ledit fichier avec un programme
  * créer un fichier **Makefile** dans le dossier du projet
  * y ajouter quelques variables
  * lancer la commande **make**
  * brancher l'Arduino et faire un **make upload**

Et le tour est joué !

Je pense que le point à éclaircir ici est celui du fichier **Makefile** à remplir. Rien ne vaut un bon vieil exemple de mon fichier Makefile pour le projet Blink qui fait clignoter la LED 13 de mon Arduino MEGA 2560 : 

```
BOARD_TAG = mega2560
ARDUINO_LIBS = 
ARDUINO_PORT = /dev/ttyACM0

include /usr/share/arduino/Arduino.mk
```

Rien de plus, rien de moins. Avec ça, un simple **make && make upload** devrait faire l'affaire :-)

### Les commandes disponibles

Le fichier **Makefile** inclut celui fournit par le paquet **arduino-mk**. Et ce dernier est rempli de commandes en tous genre. Le mieux pour s'en rendre compte est de lancer la commande suivante dans votre projet : 

    make help

Vous aurez tout un tas de commandes possibles. Par exemple je souhaitais connaître les valeurs possibles de la variable BOARD\_TAG, ayant un modèle spécial d'Arduino. J'ai donc fait : 

    make show_boards

ce qui m'a permis de savoir que le modèle *mega2560* était disponible.

### Conclusion

Je trouve ce fichier Makefile parfait pour développer en toute sérénité sans avoir à installer l'environnement Java nécessaire au programme conseillé par Arduino et tout en gardant son outil de développement favori.

Petit bonus pour ceux qui aiment s'amuser avec la sortie série d'un Arduino : si votre programme ajoute des **Serial.print()**, vous pouvez voir la sortie de votre Arduino en utilisant le logiciel **minicom** de la manière suivante : 

    minicom -b 9600 -o -D /dev/ttyACM0

Ça me rappelle [mes débuts sous la carte Efika](${BLOG_URL}/${POSTDIR_NAME}/efikace.html "Lire l'article sur la carte Efika d'Olivier").
