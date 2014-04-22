### Introduction

Hello everybody, what's happen for you this summer? Do you want some news about Makefly's project?

If yes, it's the right moment because the project continue to be developped!

### What does the project do since 2013, May?

After some convincing test with Lua, I developped a Lua version of the project named **Makefly 0.2.1-lua**. You can have a look on github to [download Makefly 0.2.1-lua version](https://github.com/blankoworld/makefly/releases/tag/0.2.1-lua "Download a ZIP or a tar.gz Makefly 0.2.1-lua version file") and test it.

I do some tests and the Lua language improve the result. For 1000 posts with 0.2.1 it takes approximatively 6 minutes, with 0.2.1-lua version it takes 2 minutes maxi. For my personnal blog that have 133 posts and that I have since 2005 (8 years), it takes 5 seconds!

### Which other improvements do you do?

Here is novelties:

  * Use a translation system to display compilation message into your language (if translated)
  * Change template format to *.tmpl extension
  * Add possibility to add keywords on page for robot
  * Idem with blog author
  * Idem with a copyright
  * Idem for the description of your blog
  * Delete useless theme and only support "base" and "minisch" ones
  * Complete technical documentation in the code for developers
  * Improve displayed message in compilation to be more readable
  * Improve RSS factory to only compile posts that are needed for the file (which was not the case for old versions)
  * Add a migration script for comments that comes from an old domain to a new one
  * Permit to add a post via a script file
  * Fix some bugs
  * Transform BASE\_URL to BLOG\_URL (into makefly.rc)

That's not heavy changes because the real work was in Bash to Lua migration.

### What's next?

For the coming 0.3 version I hope to finish [all planned tasks as described in the roadmap](http://forge.depotoi.re/projects/makefly/roadmap).

What I especially want to do is to improve tests, continuous integration and tarball generation for next releases. This will depend on the way I resolve issues on *forge.depotoi.re*.

### Conclusion

As used I'm happy to develop Makefly. Lua language is a real benefit. It will give us more functionnalities than the BSD Makefile one.
