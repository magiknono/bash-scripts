#!/usr/bin/env bash

#
# |  _ \ ___  ___| |_(_)_ __  ___| |_ __ _| | |      _ __ ___ (_)_ __ (_)
# | |_) / _ \/ __| __| | '_ \/ __| __/ _` | | |_____| '_ ` _ \| | '_ \| |
# |  __/ (_) \__ \ |_| | | | \__ \ || (_| | | |_____| | | | | | | | | | |
# |_|   \___/|___/\__|_|_| |_|___/\__\__,_|_|_|     |_| |_| |_|_|_| |_|_|
#
#
# 
# ****************************************************************************
#
# NAME        : Postinstall-mini.sh
#
# VERSION     : 0.1
#
# TESTED on   : Debian Jessie 8.2
# 
# DESCRIPTION : Basic configuration tasks for post installation of a Debian Minimal Server.
#              
#	        Including -> uncomment deb cd rom repo in /etc/apt/sources.list
#			  -> check if eth0 network interface can reach internet
#			  -> Update repo and upgrade system
#		          -> Permit sudo cmd for an existing user
#			  -> Add a remote user, set passwd, with bash and sudo cmd
#			  -> Install openssh-server and allow only remote user ssh
#		          -> Adding minimal color prompt for remote user
#                         
# ----------------------------------------------------------------------
# Dependencies
# ----------------------------------------------------------------------
# sudo
# openssh-server openssh-sftp
# ufw
#
# ----------------------------------------------------------------------
#  INSTALL
# ----------------------------------------------------------------------
# After your debian minimal server installation,
# You have a root account and a user account.
# login root (su root) and type :
# mkdir /root/scripts && cd /root/scripts 
# curl https://raw.githubusercontent.com/magiknono/bash-scripts/master/Postinstall-mini.sh > Postinstall-mini.sh
# chmod u+x /root/scripts/Postinstall-mini.sh
#
# ----------------------------------------------------------------------
# USAGE
# ----------------------------------------------------------------------
# In root (for interactive mode):
# cd /root/scripts/ && ./Postinstall-mini.sh
#
# In root (for non interactive mode):
# ./Postinstall-mini.sh -h  (for HELP)
# OR ./Postinstall-mini.sh -cp (only check network and force color prompt)
# OR ./Postinstall-mini.sh -s arnaud (add arnaud to sudo group)
# *************************************************************************
# Functions

check_network ()
{
echo -e "\033[44mChecking eth0 and internet...\033[0m"
sleep 2
MY_IP=`ifconfig eth0 | grep "inet adr" | sed 's/.*adr:\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\).*/\1/'`
ping -c 1 www.debian.org  
if [ `echo $?` = 0 ]; then
echo -e "\033[32m Checking interface Eth0 ($MY_IP) & Internet : OK\033[0m"
sleep 2
else
echo -e "\033[41mChecking interface Eth0 & Internet  : KO ( check ifconfig)\033[0m"
fi
}

check_apt ()
{
echo -e "\033[32mRemoving Debian CDROM from repository...\033[0m"
sleep 3
sed -i "s|deb cdrom|#deb cdrom|" /etc/apt/sources.list 
echo -e "\033[32;7mDebian CDROM repository has been deactivated in /etc/apt/sources.list file\033[0m"
}

add_sudo_user ()
{
echo -e "\033[32mAdding sudo to existing user (Y/n) [ENTER]:\033[0m"
read response_sudo
if [ "$response_sudo" == "Y" ];then
apt-get install sudo
echo -e "\033[7mwhat is the name of the user who needs sudo cmd ? [ENTER]:\033[0m"
read existing_user
adduser "$existing_user" sudo
echo -e "\033[7m$existing_user can now perform root cmd with sudo cmdname\033[0m"
fi      
}

remote_ssh ()
{
echo -e "\033[7mDo you want SSH only with the user called REMOTE (with sudo rights) and forbid root ssh access ? (Y/n) [ENTER]:\033[0m"
read ssh_conf
if [ "$ssh_conf" == "Y" ]; then
apt-get install openssh-server
useradd -m remote -G sudo -s /bin/bash
passwd remote
sed -i -e "s/without-password/no\nAllowUsers remote/g" /etc/ssh/sshd_config
service sshd restart
echo -e "openssh-server install & configuration : OK" 
fi
}

prompt_color ()
{
echo "Adding minimum color for remote bash shell prompt..."
sed -i -e "s/#force_color_prompt=yes/force_color_prompt=yes/g" /home/remote/.bashrc
source /home/remote/.bashrc
}

help_menu ()
{
echo -e "\033[7myou are in non-interactive mod ! Execute the script whitout args to go in interactive mod\033[0m"
cat <<EOF
$(basename $0) [options]

Options        
       -c (check)              : checking eth0 and internet connexion
       -u (update)             : removing cd rom repos & update repos & upgrade system
       -s [username] (sudo)    : adding an user to sudo ( -s username)
       -r (remote ssh)         : install ssh server, forbid root login, and 
                                 create remote login with sudo rights 
       -p (prompt)             : force color prompt
       
EOF
exit

}
# for non-interactive mode
while getopts ":cus:rph" opt; do
  case $opt in
    h)
      clear
      help_menu
      exit 1
      ;;
    c)
      check_network
      exit 1 
       ;;
    u)
	check_apt
	exit 1
	;;	
    s)
       add_sudo_user
	exit 1
	;;
    r)
	remote_ssh
	exit 1
	;;
    p)
	prompt_color
	exit 1
	;;
    \?)
      echo -e "\033[41mInvalid option: -$OPTARG\033[0m" >&2
      echo "Test the script in interactive mode (without arguments)"
	exit 1
      ;;
    :)
      echo -e "\033[41mOption -$OPTARG requires an argument.\033[0m" >&2


      exit 1
      ;;
  esac
done

#interactive mode if you exec the scripts without args
clear
echo -e "Congrats \033[7m$LOGNAME\033[0m, you have successfully install"`lsb_release -d | cut -d: -f2 `
sleep 2
check_network
sleep 2
check_apt
sleep 2
add_sudo_user
sleep 2
remote_ssh
sleep 2
prompt_color

#END
