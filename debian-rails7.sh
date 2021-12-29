#!/bin/bash

# LITTLE MEMO SCRIPT TO INSTALL/UPGRADE RAILS 7
# with stable tools on debian bullseye

# ASDF MUST BE INSTALLED BEFORE

a_install="asdf install"
a_global="asdf global"

# stable
ruby_v="3.0.2"
nodejs_v="16.13.1"
yarn_v="1.22.17"

deps="sqlite3 libsqlite3-dev"

$a_install ruby $ruby_v
$a_install nodejs $nodejs_v
$a_install yarn $yarn_v

$a_global ruby $ruby_v
$a_global nodejs $nodejs_v
$a_global yarn $yarn_v

sudo apt install $deps -y

gem install rails -v 7.0.0

#asdf current
#rails --version
