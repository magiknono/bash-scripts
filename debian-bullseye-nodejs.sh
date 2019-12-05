#!/usr/bin/env bash

#     _      _     _                                   _       _     
#     _      _     _                   _           _ _                     
#  __| | ___| |__ (_) __ _ _ __       | |__  _   _| | |___  ___ _   _  ___ 
# / _` |/ _ \ '_ \| |/ _` | '_ \ _____| '_ \| | | | | / __|/ _ \ | | |/ _ \
#| (_| |  __/ |_) | | (_| | | | |_____| |_) | |_| | | \__ \  __/ |_| |  __/
# \__,_|\___|_.__/|_|\__,_|_| |_|     |_.__/ \__,_|_|_|___/\___|\__, |\___|
#                                                               |___/      
#                       _       _     
#       _ __   ___   __| | ___ (_)___ 
# _____| '_ \ / _ \ / _` |/ _ \| / __|
#|_____| | | | (_) | (_| |  __/| \__ \
#      |_| |_|\___/ \__,_|\___|/ |___/
#                            |__/      
# *******************************************************************
#
# NAME	: 	    debian-bullseye-nodejs.sh
#
# VERSION : 	    0.3
#
# DESCRIPTION :     Install the latest nodejs LTS 12 for debian testing (bullseye) 32/64 bits
#
# USAGE : 	    curl https://raw.githubusercontent.com/magiknono/bash-scripts/master/debian-bullseye-nodejs.sh > debian-bullseye-nodejs.sh
#               chmod u+x debian-bullseye-nodejs.sh  
#	 	           ./debian-bullseye-nodejs.sh 
        

# LTS
echo -e "\033[32mwelcome to nodejs quick install for debian\033[0m"


#check_debian
 sudo apt-get update
 sudo apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates

#download selected nodejs script

sudo curl -sL https://node.melroy.org/deb/setup_12.x | sudo bash -


#install nodejs
 sudo apt-get install -y nodejs

#build-essential for npm addons compilation
 sudo apt-get install build-essential -y
 
curl -sL https://https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

node -v
yarn -v

#see version of nodejs & yarn
echo -e "\033[032mnodejs version\033[0m :"
node -v
