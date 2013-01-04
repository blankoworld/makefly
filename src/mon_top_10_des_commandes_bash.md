En lisant les flux RSS de ci de là, j'ai vu que certains s'amusent désormais à donner leur top 10 des commandes bash utilisées dans leurs terminaux.

Pour cela il faut taper ceci dans une console :

	history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}'|sort -rn|head

Ce qui me donne : 

	65 ssh
	57 exit
	46 su
	36 ping
	31 cd
	30 ls
	29 vim
	18 apt-cache
	18 alsamixer
	17 minicom

Avouez qu'on peut pas faire plus bête que ça comme billet ! Mais il fallait que je donne mon top 10 !

 :roll: Et si vous en faisiez autant ? Donnez moi votre top 10 ! Je suis curieux :P !
