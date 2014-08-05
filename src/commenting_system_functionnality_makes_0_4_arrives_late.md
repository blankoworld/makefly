### Introduction

As you can see [on the 0.4 planned version of Makefly](http://forge.depotoi.re/versions/show/22), we will be late. This post will explain why.

### A ticket that blocks the project

The main ticket of this 0.4 version on which it depends the result is the [#150](http://forge.depotoi.re/issues/150 "See more about embedded comment system").

I planned to make a system that permit to activate comments on your blog. For now we use [jskomment](https://github.com/monperrus/jskomment) on Makefly. But this tool doesn't permit to notify the blogger that some people comment a specific post and we have a very simple use of this tool.

So I'm searching for another solution among:

  * Disqus
  * Isso
  * Discourse

If you have any suggestion, you're welcome!

### What about each solution?

For Disqus, I will use it as a last resort. Perhaps we can permit user to choose it as its favorite solution. But for the moment I search a free solution.

For Isso and Discourse, if any solution is choosed, we need to give Makefly's users to use a finished solution (as Disqus). So we need to make a server that permit to register its domain and to permit to add comments on it.

That's why the most important in the choose of Isso/Discourse is to achieve a public server with free registration.

During the last two weeks, I failed to create this kind of server. That's why I need to accomplish it the next weeks. It's important for Makefly to have a possibility to use a free software for commenting so that user can install its own free commenting system if it wants.

### Conclusion

If anyone can help me on deploying a commenting server, tell me on <olivier+makefly@dossmann.net>.

Next weeks I will focus on this commenting server creation so that we can offer a service to our Makefly's user!
