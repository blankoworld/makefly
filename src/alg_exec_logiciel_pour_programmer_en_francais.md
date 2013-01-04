Cette nuit je pensais à mes algorithmes toujours foireux, à moitié décousus et sans trop de validité. Puis je me remémorrais le programme que nous utilisions en BTS pour apprendre à programmer quand nous n'avions jamais vu une bribe de code : Alg'exec. Au moins là dessus mes programmes étaient réfléhis !

### Présentation d'Alg'exec

Alg'exec est un programme écrit par M. André GUNTZ, mon professeur de réseau en 2006 à l'IUT René Cassin de Strasbourg (bah allez y faites des recherches pour me retrouver, je vous attends, le café et les buiscuits sont prêts :D ) Il est disponible sur [http://algexec.free.fr](http://algexec.free.fr "Visiter la page officielle d'Alg'exec").

Ce logiciel permet de créer des programmes à l'aide de mots clés Français. Il n'a pas une syntaxe trop compliquée et des exemples sont fournis. Par ailleurs il contient un système permettant de lancer notre programme et d'en voir le résultat. A cela s'ajoute un système de débogage (pas à pas, boucle par boucle, etc.).

Pour certains il n'est pas de grande utilité, mais les professeurs de BTS utilisent ce logiciel pour apprendre les bases à leurs élèves. C'est alors à eux de se prendre en main et de choisir le langage de programmation qu'ils désirent.

Donc Alg'exec présente des avantages et des inconvénients, à vous de les trouver ! Pour ma part c'est notamment le fait que le programme soit propriétaire (code fermé) et que ce ne soit disponible que sous Windows (forcément c'est en VB ou .NET ce truc ...).

Et pourquoi ne pas l'utiliser sous GNU / Linux ? Par exemple Debian ?

### Utilisation de Wine pour installer Alg'exec

Figurez vous que j'ai eu la bonne idée, ce jour, d'installer Alg'exec sur Wine ! Et bien ce n'était pas du gâteau, j'en ai bavé pour trouver une solution, et au final c'est tellement simple, que ça fait peur pour le temps passé à chercher !

Nous avons donc deux méthodes : 

  * Utiliser l'ancien Alg'exec, et donc simplement installer Wine
  * Utiliser le nouveau Alg'exec, et là faut installer d'autres choses

#### L'ancien Alg'exec

Son adresse se trouve sur le [site de Free](http://algexec.free.fr/anc_vers/anc_vers.html "Lire la page de l'ancien Alg'exec").

  * Installez Wine
<pre><code>
	apt-get install wine wine-utils lib32nss-mdns
</code></pre>

  * Téléchargez **algexec1.zip**
  * Décompressez l'archive
<pre><code>
	tar xvf algexec1.zip -d algexec
</code></pre>
  * Lancez l'installeur
<pre><code>
	cd algexec
	wine Algexec.exe
</code></pre>
  * Lancez Algexec
<pre><code>
	wine ~/.wine/drive_c/Program\ Files/Alg_exec/Algexec.exe
</code></pre>
Amusez vous bien !

#### Le nouveau Alg'exec

Là encore, c'est sur le [site de Free](http://algexec.free.fr/nou_vers/nou_vers.html "Se rendre sur la page de la nouvelle version d'Algexec") qu'il faut se rendre.

  * Installez Wine
<pre><code>
	apt-get install wine wine-utils lib32nss-mdns
</code></pre>
  * Récupérez winetricks (remballez le jeu de mot avec la trique :roll: !)
<pre><code>
	wget http://kegel.com/wine/winetricks
</code></pre>
  * Installer les polices nécessaires
<pre><code>
	winetricks corfonts
</code></pre>
  * Faites croire que vous posséder MSIE
<pre><code>
	winetricks fakeie6
</code></pre>
  * Télécharger dotnetfx.exe sur [Clubic](http://www.clubic.com/lancer-le-telechargement-23052-0-microsoft-net-framework.html "Se rendre sur la page de téléchargement de Microsoft .NET Framework 2.0 sur clubic")
  * Utilisez Wine pour lancer l'installation de Dotnet
<pre><code>
	wine dotnetfx.exe
</code></pre>
  * Créez un dossier AlgExec dans Program Files
<pre><code>
	mkdir ~/.wine/drive_c/Program\ Files/AlgExec/
</code></pre>
  * Mettez dedans tout les fichiers récupérés sur le site comme indiqué sur la page officielle de la nouvelle version d'Alg'exec
  * Lancez Algexec
<pre><code>
	wine ~/.wine/drive_c/Program\ Files/AlgExec/AlgExec.exe
</code></pre>
Des soucis au niveau de l'installation de Dotnetfx.exe ? Si oui, c'est que j'ai peut être oublié de vous parler de MSIE 5.0, 5.5, 6.0 et 7.0 sous Linux ! Faites en donc l'installation (pour la version 5.5 par exemple, puis recommencer à la ligne **winetricks fakeie6**.

### Microsoft Internet Explorer sous GNU / Linux, possible ?

En faisant des recherches à droite et à gauche concernant mes soucis d'installation, je suis tombé sur [IES4Linux](http://www.tatanka.com.br/ies4linux/page/Fr/Page_D%27Accueil "Page officiel de IES4Linux") !

> Koikssa IES4Linux ?

Ah cela vous intéresse ? (ou pas!) IES4Linux est un script libre permettant d'ajouter Internet Explorer (MSIE) à la liste de ses logiciels sous GNU / Linux.

> Wai wai, sasserarien !

Oh que si ! Imaginez les développeurs de sites Webs qui, dans un élan de conscience professionelle voudraient tester la compatibilité de leur site avec MSIE ? Ou encore autre chose : vous n'accédez pas à un site simplement parce que vous ne posséder pas MSIE ? Certains sites ou forums de jeux vous jette comme des malpropres simplement car vous n'avez pas MSIE. Donc oui cela sert à quelque chose.

> Et comment procédons nous alors pour l'installer ?

Tout est décrit sur le site Internet, suffit de lire ! Hop je vous donne le [lien d'installation](http://www.tatanka.com.br/ies4linux/page/Fr/Installation "Se rendre sur la documentation pour installer IES4Linux").

Une fois installé, il suffit de lancer la commande **sh ~/bin/ie5** et MSIE se lance !

### Conclusion

Bien que la valeur réelle d'AlgExec reste encore pour certains bien moindre, j'ai débuté là dessus en programmation informatique, ne vous en déplaise ! Mes camarades de l'époque aussi y ont eu droit. Malgré le fait que j'ai un peu galéré pour l'installer, je suis content d'avoir à nouveau retrouvé le projet IES4Linux auquel on ne pense pas tout de suite quand on veut MSIE sous GNU / Linux. Ce script simplifie la vie !

Donc on part sur un truc propriétaire genre AlgExec, et on se retrouve admirablement sur un truc libre qui vous permet de faire de bonnes choses :) .
