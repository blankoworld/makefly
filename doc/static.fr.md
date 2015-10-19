# Créer un site vitrine simple avec ${PROJECTNAME}

[English version](${PROJECTURL}static.html.en) (version originale française)

[Site officiel](${PROJECTURL} "Aller sur le site web")

## Introduction

Les sites vitrines sont principalement employés pour présenter une entreprise, un projet ou une personne. À cet effet nous n'avons généralement besoin que de quelques pages : 

  * la page d'accueil
  * une page d'à propos
  * une page expliquant le projet

On peut évidemment agrémenter, mais pour l'exercice qui va suivre nous allons rester simple.

## En bref

Le travail consiste à : 

  * copier le thème de base
  * créer les pages nécessaires (page expliquant le project)
  * adapter la page d'à propos
  * créer un nouvel article comme message d'accueil
  * modifier le thème pour avoir les bons liens vers les autres pages

## En détail

### Création d'un nouveau thème

Nous allons donc créer un nouveau thème et l'utiliser afin d'obtenir le résultat attendu : 

<pre name="code" class="Bash">
cd makefly
./makefly theme SiteVitrine
echo "THEME = SiteVitrine" >> makefly.rc
</pre>

Vous avez donc un thème nommé **SiteVitrine**.

### Utilisation de la fonctionnalité de pages statiques et des pages spéciales

De là nous pouvons créer une à plusieurs pages que nous souhaitons voir apparaître : 

<pre name="code" class="Bash">
mkdir pages
touch pages/project.md
</pre>

Remplissez le fichier **pages/project.md**.

Remplissez ensuite le fichier **special/about.md** qui contient la page d'à propos, souvent utilisez comme d'un *Qui sommes nous ?*.

### La page d'accueil

Pour la page d'accueil nous allons utiliser un article qui fera office de texte d'accueil. Rajoutez donc un article comme ceci : 

<pre name="code" class="Bash">
./makefly add
</pre>

Renseignez les informations demandées et écrivez votre article.

Il ne nous reste plus qu'à modifier un peu notre thème.

### Personnalisation du thème nommé SiteVitrine

Le thème **SiteVitrine** se trouve dans le dossier **template**.

L'idée est de modifier le menu utilisé par ${PROJECTNAME} afin d'avoir l'ensemble des pages que nous venons de rajouter. Cela se passe dans le fichier **template/SiteVitrine/footer.tmpl** qui contient le menu de navigation du site. Il suffit donc d'adapter le code suivant : 

<pre name="code" class="Xml">
    <aside id="navigation">
      <nav id="secondary">
        <h2 id="nav">Navigation</h2>
        <ul>
          <li><a href="${BLOG_URL}">${HOME_TITLE}</a></li>
          <li><a href="${BLOG_URL}/${POSTDIR_NAME}/${POSTDIR_INDEX}">${POST_LIST_TITLE}</a></li>
          <li><a href="${BLOG_URL}/${TAGDIR_NAME}/${TAGDIR_INDEX}">${TAG_LIST_TITLE}</a></li>${ABOUT_LINK}
        </ul>
      ${SEARCHBAR}
      </nav>
    
      ${SIDEBAR}
    </aside>
</pre>

en : 


    <aside id="navigation">
      <nav id="secondary">
        <h2 id="nav">Navigation</h2>
        <ul>
          <li><a href="${BLOG_URL}">${HOME_TITLE}</a></li>
          <li><a href="${BLOG_URL}/project.html">Mon projet</a></li>${ABOUT_LINK}
        </ul>
      ${SEARCHBAR}
      </nav>
    
      ${SIDEBAR}
    </aside>

Il suffit ensuite d'agrémenter le thème selon vos préférences.

Par exemple pour n'avoir que le premier billet sur l'accueil (afin de toujours avoir le même), on va modifier les paramètres suivants de notre fichier ${PROJECTNAMELOWER}.rc : 

    MAX_POST = 1

Ensuite nous enlevons le lien "Tous les articles" au bas de la page pour éviter que le visiteur aille sur une liste d'articles dont il ne saurait que faire. Pour cela éditez le fichier **template/SiteVitrine/post.footer.tmpl** et supprimez en le contenu.

On compile à nouveau le blog et le tour est joué ;).

**Astuce** : Une autre astuce aurait été de supprimer l'ensemble des fichiers **.md** du dossier **src**, de faire de même avec les fichiers **.mk** dans le dossier **db** puis de modifier le fichier **template/SiteVitrine/post.footer.tmpl** pour y inclure le contenu HTML que vous désiriez pour la page d'accueil.

## Conclusion

Faire un site vitrine statique n'est pas compliqué quand on connaît le HTML et le CSS. Concernant ${PROJECTNAME} il suffit également d'en connaître un peu les ficelles, notamment les composantes des templates. Mais une fois ces éléments en main, il devient facile de rajouter une simple page Markdown afin de rajouter du contenu. Puis de faire un lien.

Quoiqu'il en soit, et qu'importe l'outil, vous aurez de toute manière du temps à passer sur l'apparence et donc le HTML et le CSS.
