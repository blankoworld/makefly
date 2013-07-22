### Introduction

[Je vous parlais il y a plus d'un an d'une alternative à Dropbox : Owncloud](${BLOG_URL}/archives/2012/03/12/owncloud_une_alternative_de_dropbox/index.html "Lire l'article sur l'alternative de Dropbox : Owncloud"). Pour un utilisateur lambda, ce n'est déjà pas facile de pouvoir l'installer, mais alors mettre à jour fait froid dans le dos ! Cet article explique une mise à jour de owncloud 4.0.5 vers la version 4.5.x.

![Logo d'owncloud](${BLOG_URL}/images/logos/owncloud.png "Logo d'owncloud")

### Connaître sa version d'Owncloud

  * Connectez vous en administrateur
  * Rendez-vous sur l'icône d'une roue dentée (configuration) puis dans le sous-menu **Personnel**
  * Allez en bas de page : la version d'Owncloud apparaît, par exemple 4.0.6

### Comment fonctionne une mise à jour d'une ancienne version à une nouvelle version pour le logiciel Owncloud ?

**Avant toute chose, SAUVEGARDEZ VOS DONNÉES**. Je ne suis en aucun cas responsable d'éventuelles pertes de données résultantes de la mise à jour de votre logiciel suite à la lecture de mon article. J'en décline donc toute responsabilité.

#### En bref

Si on passe d'une version 4.0.x à une autre version 4.0.x, on extrait les fichiers de l'archive dans le dossier actuel et on recharge la page web.

Si on passe d'une version 4.0.y (où y est la DERNIÈRE version de la 4.0) à une version 4.x.z, on désactive les applications tierces (3RD applications) et on garde le dossier **/data/** et le dossier **/config**, on supprime le reste. On extrait alors l'archive dans le dossier et on recharge la page. Puis on **nettoie le cache de son navigateur web**.

#### En moins bref.

Comme [expliqué sur le site d'owncloud concernant la mise à jour (en)](https://owncloud.org/support/upgrade/ "lire la documentation d'Owncloud sur la mise à jour"), il faut faire attention à la version d'origine vers la version de destination.

Une mise à jour mineure s'effectue quand vous mettez à jour d'une version 4.0.6 par exemple à une version 4.0.13 (4.0.X à 4.0.Y par exemple).

Une mise à jour majeure s'effectue quand vous mettez à jour d'une version 4.0.6 à une version 4.5.8 (4.0.X à 4.Y.Z par exemple).

Pour une mise à jour mineure, extrayez simplement le contenu de l'archive d'Owncloud dans votre répertoire actuel et actualisez votre page web Owncloud.

Pour une mise à jour majeure : 

  * Passez déjà à la **dernière version mineure** de votre application owncloud. Par exemple si vous êtes en 4.0.6, passez en 4.0.13 avant tout !
  * Ensuite désactivez toutes les applications tierces
  * Gardez le dossier **/data** et le dossier **/config**, supprimez les autres
  * Extrayez le contenu de l'archive d'Owncloud dans le dossier principal (dans lesquels sont contenus /data et /config)
  * Vérifiez les permissions et l'utilisateur (sous Debian www-data:www-data)
  * Videz le cache de votre navigateur web
  * Relancez la page web
  * Réactivez les applications tierces si besoin

### J'ai perdu mes contacts !

Nettoyez le cache de votre navigateur web. Les contacts et le calendrier devraient reprendre leur forme originelle avec l'ensemble de son contenu.

### Conclusion

L'astuce consiste donc, pour la perte de contacts et calendrier à vider le cache du navigateur web !

### Liens

  * [Owncloud (en)](https://owncloud.org/ "Site officiel d'Owncloud")
  * [Mise à jour d'Owncloud](https://owncloud.org/support/upgrade "lire la documentation d'Owncloud sur la mise à jour")
  * [Comment procéder après mise à jour si le calendrier et les contacts ne s'affichent plus ? (en)](https://github.com/owncloud/apps/issues/453#issuecomment-12264431 "Lire un commentaire sur owncloud à propos de la mise àjour et pertes de calendrier/contacts apparents")

