# Make a simple shop website with ${PROJECTNAME}

[Version française](${PROJECTURL}static.html.fr) (original french version)

[Official website](${PROJECTURL} "Go to the official website")

## Introduction

Shop websites are mainly used to show your business, a project or someone. As a consequence we only need some pages:

  * homepage
  * about's page
  * a page explaining your project

Sure you can add some, but let keeping this tutorial as easy as possible.

## In brief

The work consist in:

  * duplicate default theme
  * create needed pages (page explaining the project)
  * adapt about's page
  * create a new post as homepage message
  * modify the theme so that having right links to other pages

## In detail

### Creating a new theme

We will so create a new theme and use it to obtain the final result:

<pre name="code" class="Bash">
cd makefly
./makefly theme ShopWebsite
echo "THEME = ShopWebsite" >> makefly.rc
</pre>

You have so a theme named **ShopWebsite**.

### Using static and special pages features

From that point we can create one or more pages that we want to appear:

<pre name="code" class="Bash">
mkdir pages
touch pages/project.md
</pre>

Fill in the **pages/project.md** file.

Then **special/about.md** file which contains the about's page, oftenly used as "Who are we?".

### Homepage

For homepage we will use a post that will represent the homepage. Add a new post as this:

<pre name="code" class="Bash">
./makefly add
</pre>

Fill in all asked data and write the post.

Customizing a little bit our theme remains.

### ShopWebsite theme customization

The **ShopWebsite** theme is in **template** directory.

The idea is to modify ${PROJECTNAME} menu so that see all previously added pages. It happens into **template/ShopWebsite/footer.tmpl** file which contains the website navigation menu. You just need to adapt the following code:

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

to:

<pre name="code" class="Xml">
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
</pre>

Then embellish your theme regarding your preferences.

For an example to have only 1 post on homepage, just change the following parameter in our ${PROJECTNAMELOWER}.rc file:

    MAX_POST = 1

Finally we delete the "All posts" link on the bottom page to avoid visitors to go to the post list. Edit the **template/ShopWebsite/post.footer.tmpl** file and delete the content.

We compile again our blog. Enjoy ;).

**Tip**: Another tip would be to delete all **.md** files in **src** directory ;  make the same for all **.mk** files in **db** directory ; then edit **template/ShopWebsite/post.footer.tmpl** file to include some HTML want to appear on homepage.

## Conclusion

Make a static shop website is not complex when you know what HTML and CSS is. Concerning ${PROJECTNAME} you just need to know a little bit templates and it will be OK. First the elements owned, it becomes easy to add a simple Markdown page so that you add content. Then make a link.

Anyway, skipping the tool, you will have to spend time on HTML and CSS while customizing your website appearance.
