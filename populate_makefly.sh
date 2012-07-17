#!/usr/bin/env bash

# populate_makefly.sh
#
# permit to create some post for Makefly

#####
## LICENSE
###

# Makefly, a static weblog engine using a BSD Makefile
# Copyright (C) 2012 DOSSMANN Olivier
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# VARIABLES

# POST 1
POST1_TITLE="Welcome to makefly!"
POST1_DESC="Makefly discovering"
POST1_DATE="2012-06-29"
POST1_TAGS="makefly, news"
IFS='' read -r -d '' POST1_CONTENT<<'EOF'
# Welcome to Makefly!

Makefly is a *static weblog engine* working thanks to a BSD **makefile**.

It's composed of:

  * home page
  * post's list
  * tag's list

and includes somes functionalities like:

  * RSS feed
  * tags
  * permalink
  * possibility to set posting date (using a _timestamp_)
  * customization using options like max post on homepage
  * translation: English, French

In fact, it's a lightweight weblog engine that generate some HTML files.
EOF
IFS="\\"

# POST 2
POST2_TITLE="Makefly project"
POST2_DESC="How to contribute?"
POST2_DATE="2012-07-01"
POST2_TAGS="makefly, social, programmation"
IFS='' read -r -d '' POST2_CONTENT<<'EOF'
# Makefly project

## About

Makefly could be followed on [the official Makefly weblog](http://makefly.e-mergence.org/ "Visit official website").

But for those who prefer status.net, you could use the [makefly identica's group](http://identi.ca/group/makefly).

## Social coding

> How could we contribute?

Don't forget our github repository on which Makefly could be found: [https://github.com/blankoworld/makefly](https://github.com/blankoworld/makefly).

Some others information could be seen @ohloh: [http://www.ohloh.net/p/makefly](http://www.ohloh.net/p/makefly).

## Contact

For other piece of information, you could contact me at this email address: [olivier [AT] dossmann [DOT] net](mailto:olivier+makefly@dossmann.net "Contact me").
EOF
IFS="\\"

# POST 3
POST3_TITLE="Official weblog: Open"
POST3_DESC="Makefly is now available on the web"
POST3_DATE="2012-07-04"
POST3_TAGS="news, web"
IFS='' read -r -d '' POST3_CONTENT<<'EOF'
# Official weblog: Open

Just remember one address for last makefly news: [http://makefly.e-mergence.org/](http://makefly.e-mergence.org/ "Visit official Makefly weblog to have news about Makefly!").

I will post some tips & tricks, news and event about Makefly here. For this, I could use some example like this to be changed in a file:

    YOURVAR = the content of your variable

But those who prefer to be more connected, I suggest you [to follow Makefly identica's group](http://identi.ca/group/makefly).

Don't forget to have fun with Makefly ;-)
EOF
IFS="\\"

# BEGIN

# create POST 1
./create_post.sh -q < <(echo ${POST1_TITLE}; echo ${POST1_DESC}; echo ${POST1_DATE}; echo ${POST1_TAGS}) && echo -e ${POST1_CONTENT} > src/welcome_to_makefly.md || exit 1

# create POST 2
./create_post.sh -q < <(echo ${POST2_TITLE}; echo ${POST2_DESC}; echo ${POST2_DATE}; echo ${POST2_TAGS}) && echo -e ${POST2_CONTENT} > src/makefly_project.md || exit 1

# create POST 3
./create_post.sh -q < <(echo ${POST3_TITLE}; echo ${POST3_DESC}; echo ${POST3_DATE}; echo ${POST3_TAGS}) && echo -e ${POST3_CONTENT} > src/official_weblog_open.md || exit 1

# Change TIMESTAMP of posts
mv db/*,welcome_to_makefly.mk "db/`date -d ${POST1_DATE} +'%s'`,welcome_to_makefly.mk"
mv db/*,makefly_project.mk "db/`date -d ${POST2_DATE} +'%s'`,makefly_project.mk"
mv db/*,official_weblog_open.mk "db/`date -d ${POST3_DATE} +'%s'`,official_weblog_open.mk"

# END
exit 0
