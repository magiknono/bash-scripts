#!/usr/bin/env bash
#ping domains from file and display results in console
#create domains-dev.txt and add one domain per line

for ligne in `cat urls-dev.txt`
do
ping -c 1 $ligne > /dev/null 2>&1 
  if [ $? -eq 0 ]; then
      echo -e "ping url \e[1m$ligne \e[21m \e[32m: OK\e[0m"

    else
      echo -e "ping url \e[41m$ligne \e[21m \e[41m: KO\e[0m"

  fi
done
exit 1
