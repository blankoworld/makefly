Vous êtes étudiant ? Vous avez des serveurs UNIX et/ou linux à l'Université ? Vous voudriez contacter quelqu'un qui travaille sur la même machine serveur que vous ? Mais vous ne savez pas où il est ni comment le joindre ?

Qu'à cela ne tienne, impossible n'est pas <strike>français</strike> Linux !

### Vérifier la présence de votre collègue

Pour se faire, tapez : 

    who

Vous aurez l'identifiant de la personne, le numéro de console qu'elle utilise et d'autres informations non nécessaires ici. Comme ici par exemple : 

    olivier  pts/0        2008-11-09 15:27 (portedesetoiles.homelinux.com)
    bob6784  pts/1        2008-11-09 18:02 (95.xxx.x-xx.rev.gaoland.net)

De là passons à l'envoi d'un message

### Lui envoyer un message

Rien de plus simple, on utilise pour cela la commande **write**. Comme ceci : 

    write bob6784 << "FIN"

Tapez ensuite le message que vous voulez, pour terminer la commande, tapez *FIN*.

### Conclusion

Il faut bien se rendre compte que cette astuce est très dérangeante pour la personne qui reçoit le message, car cela perturbe l'affichage de sa propre console / terminal. Veillez donc à ne pas en abuser, et utiliser cette commande qu'en cas d'urgence si vous êtes dans un lieu gigantesque tel qu'une université, et que vous cherchez une personne qui est sous linux (et qui ne connaît pas la technologie des téléphones mobiles pour raisons politiques, personnelles et/ou financières).

