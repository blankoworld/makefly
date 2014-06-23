
### Brief

In some words: 

  * [p|b]make will be abandonned for next version of Makefly. A pure lua program will be used instead
  * New Docker file to test Makefly
  * last month, [a french news about Makefly was published on LinuxFR](http://linuxfr.org/news/makefly-une-alternative-au-moteur-de-blog-statique-nanoblogger "Learn more about Makefly on the french Linuxfr website")
  * tip: AUTO_EDIT option

### Project is still active, pmake not

Due to this ticket: http://forge.depotoi.re/issues/240 in which I wanted strings to be translatable by gettext, I decided to use Lua to do all things in Makefly.

So I improve way Makefly works by using a main Lua file to launch all Makefly's commands. The new main program give a new command: **refresh** that permits to clean up files and compile the entire blog.
 This is very useful to refresh our weblog.

All script are not changed into Lua yet. But a new age is coming next months with this pure Lua version of Makefly.

### Makefly on Docker

You can find a Docker file to test Makefly on your computer. The official repository is here: https://registry.hub.docker.com/u/bl4n/docker-makefly/

Have fun with it ;)

### Makefly, on a french newspaper website: LinuxFR

Last month [Makefly was published on LinuxFR ](http://linuxfr.org/news/makefly-une-alternative-au-moteur-de-blog-statique-nanoblogger "Have a look to the french news on LinuxFR website").

This event permits to give a visibility of Makefly and to be more downloaded/tested (666 clicks at the date I wrote this post ^_^). Hope it will be more downloads.

As a consequence I reveived some user experiences about Makefly

### Thanks to users, Makefly is improved. AUTO_EDIT option.

User experience and suggestions permit to improve Makefly's functionnalities and to see what's missing.

For an example, a user explain me it would be better to edit a new post after its creation. As user should have the choice, I created the **AUTO_EDIT**
 option.

As other active/inactive options, if you don't set it, nothing happens. If you set it to 1, so system will open your favorite editor to write your post.

How Makefly knows your favorite editor? It's the *EDITOR* environment variable that gives the info.

Try it, it works very well and I'm using it to write this post

### Be there for the next 0.4 version

I planned to release the 0.4 version for October. As improvements depends on users suggestions, I invite you to give your opinion about Makefly. I thank you in advance for that. Enjoy Makefly !
