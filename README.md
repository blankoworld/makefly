# Makefly

## About

Makefly is a static weblog engine that used a BSD Makefile to work.

### Website

Stay tuned to [Makefly weblog](http://makefly.e-mergence.org/ "Visit Makefly official website").

### Contact

You can contact me [to this address](mailto:olivier+makefly@dossmann.net "Contact me").

### License

Will come ASAP.

### Stats

Some stats about projet could be found [on Ohloh.net](http://www.ohloh.net/p/makefly "See ohloh's analysis for Makefly project").

## Description

Makefly is a subproject of [BlogBox](http://blogbox.e-mergence.org/ "Read more about BlogBox project") that aims to give user a better way to host a blog at home.

## Dependencies

Some programs on which makefly depends: 

  * pmake or bmake
  * markdown command
  * lua 5.1 and earlier

## Installation

No need to install it. But after generation, perhaps would you install result in a specific directory?

You should so use **install.sh** which is a bash shell script. Just launch it:

    bash install.sh

## Configuration

The first time you use Makefly you don't have any configuration file. An example is available in *makefly.rc.example*. Copy it to **makefly.rc** to permit Makefly to work.

For more information please read **The makefly.rc configuration file** section.

## Create content

A bash shell script is available: **create_post.sh**. To use it:

    bash create_post.sh

Give script all information it needs. It will generate some files needed by Makefly.

Note that Makefly use the [markdown format](http://daringfireball.net/projects/markdown/ "Learn more about Markdown format") for its posts.

## Use it!

After having created *makefly.rc* (from makefly.rc.example) and having created some posts, just do this:

    pmake

It will generate a Makefly weblog to the **pub** directory.

## The makefly.rc configuration file

Here is some options you can change:

  * BLOG_TITLE: Title of your weblog
  * BLOG_SHORT_DESC: A short description of your weblog
  * BLOG_DESCRIPTION: A long description of your weblog
  * BLOG_LANG: your language. Note that file lang/translate.YOUR_LANGUAGE should exists. For an example if I set this parameter to *en*, a *lang/translate.en* file should exists!
  * BASE_URL: absolute URL of your blog
  * RSS_FEED_NAME: Title for the RSS Feed
  * MAX_POST: Max post that would be showed on home page
  * DATE_FORMAT: Date format. Please see man date's page for more information.
  * SHORT_DATE_FORMAT: Short date format that would be used on the post list page. Please see man date's page for more information.

## Translation

A simple way to translate Makefly to your language is to copy the **lang/translate.en** file to another translation file. For an example, for french (with fr code), you can copy **lang/translate.en** to **lang/translate.fr** and change values. Then just change *BLOG_LANG* option in **makefly.rc** file.

## Sources

Source are available: 

  * [On github](https://github.com/blankoworld/makefly)
  * [On personal git](http://git.dossmann.net/blogbox/makefly.git/)

