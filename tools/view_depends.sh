#!/usr/bin/env bash

dot -Tpng -odepends.png ng_depends.dot && xdg-open depends.png
