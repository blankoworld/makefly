#!/usr/bin/env bash

# test_generation_posts.sh

# permit to create some post for Makefly

# VARIABLES

PWD=`pwd`

POST1_TITLE="Welcome to makefly!"
POST1_DESC="Makefly discovering"
POST1_DATE="2012-07-03"
POST1_TAGS="makefly, news"
IFS='' read -r -d '' POST1_CONTENT<<'EOF'
# Welcome to Makefly!

Makefly is a *static weblog engine* working thanks to a BSD **makefile**.

It's composed of:

  * a home page
  * a post's list
  * a tag's list

and includes somes functionalities like:

  * RSS feed
  * tags
  * permalink
  * possibility to set posting date (using a _timestamp_)
  * customization using options like max post on homepage
  * translation: English, French

EOF

IFS="\\"

# BEGIN

cd ../
./create_post.sh -q < <(echo ${POST1_TITLE}; echo ${POST1_DESC}; echo ${POST1_DATE}; echo ${POST1_TAGS}) && echo -e ${POST1_CONTENT} > src/welcome_to_makefly.md || exit 1
cd ${PWD}

# END
exit 0
