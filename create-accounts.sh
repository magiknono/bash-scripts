#!/bin/bash

# DESCRIPTION : create a GROUP and add USERS into it with a PASSWORD
# REQUIREMENTS : sudo or root permissions
# FIRST : chmod +x create-accounts.sh
# USAGE : sudo ./create-accounts.sh

# Ask the name of the group to be created
read -p "Create a new group called : " group_name
echo " "
read -p "Set password for all users : " pass
echo " "
echo "The file name users.list will be readed fro creating accounts."

# create the group
groupadd $group_name
# we create accounts from file users.list in the current directory

for user in `more users.list`
do
# on affiche le prénom de l'élève à partir du fichier users.list
echo $user
# cerate a account for each user and add it to the secondary group
useradd -m -d /home/$user -G $group_name -s /bin/bash $user
# we create a web apache folder for each user 
mkdir /home/${user}/public_html
# we set the owner of the web folder
chown -R $user:$user /home/$user/public_html
# we set the passwd for each user
passwd $user <<< "$pass
$pass"
done
