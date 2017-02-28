#!/usr/bin/env bash

#     _      _     _                                   _       _     
#  __| | ___| |__ (_) __ _ _ __        _ __   ___   __| | ___ (_)___ 
# / _` |/ _ \ '_ \| |/ _` | '_ \ _____| '_ \ / _ \ / _` |/ _ \| / __|
#| (_| |  __/ |_) | | (_| | | | |_____| | | | (_) | (_| |  __/| \__ \
# \__,_|\___|_.__/|_|\__,_|_| |_|     |_| |_|\___/ \__,_|\___|/ |___/
#                                                           |__/     
# *******************************************************************
#
# NAME	: 	    debian-nodejs.sh
#
# VERSION : 	    0.1
#
# DESCRIPTION :     Install the latest nodejs LTS 6.X or EXPERIMENTAL 7 for debian 8 (jessie) 32/64 bits
#
# USAGE : 	    curl https://raw.githubusercontent.com/magiknono/bash-scripts/master/debian-nodejs.sh > debian-nodejs.sh
#                   chmod u+x debian-nodejs.sh  
#	 	    ./debian-nodejs.sh 
        

# LTS OR EXPERIMENTAL
echo -e "\033[32mwelcome to nodejs quick install for debian\033[0m"
echo -e "\033[32mEnter 6 for LTS install or 7 for EXPERIMENTAL install, followed by [ENTER]\033[0m :"
read nodejs_setup

#check_debian
 sudo apt-get update
 sudo apt-get install curl

#download selected nodejs script
if [ "$nodejs_setup" == "7" ];then
sudo curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
else 
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
fi

#install nodejs
 sudo apt-get install -y nodejs

#build-essential for npm addons compilation
 sudo apt-get install build-essential -y

#see version of nodejs
echo -e "\033[032mnodejs version\033[0m :"
node -v
