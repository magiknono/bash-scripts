#!/usr/bin/env bash
#
#        _      _     _                             _ _     _
#     __| | ___| |__ (_) __ _ _ __        _ __ __ _(_) |___| |__   _____  __
#    / _` |/ _ \ '_ \| |/ _` | '_ \ _____| '__/ _` | | / __| '_ \ / _ \ \/ /
#   | (_| |  __/ |_) | | (_| | | | |_____| | | (_| | | \__ \ |_) | (_) >  <
#    \__,_|\___|_.__/|_|\__,_|_| |_|     |_|  \__,_|_|_|___/_.__/ \___/_/\_\
#
# ****************************************************************************
#
# NAME        : debian-railsbox.sh
#
# VERSION     : 0.1
#
# TESTED on   : Debian Jessie 8.6/8.7 (amd64) (with VirtualBox 5.1.12 r112440)
#
# DESCRIPTION : Setup a rails dev env ready on debian jessie with lewagon-dotfiles
#
# INSPIRATION : See le wagon-setup for ubuntu https://github.com/lewagon/setup/blob/master/UBUNTU.md
#               See lewagon-dotfiles https://github.com/lewagon/dotfiles
#
#
# BEFORE EXECUTION : You can see Postinstall-mini.sh OR :
#  		              - your user need sudo rights : apt-get install sudo && adduser [EXISTING_USER] sudo
#                    - you need a clean source file : sed -i "s|deb cdrom|#deb cdrom|" /etc/apt/sources.list
#                    - the script need to be executable : $chmod a+x debian-railsbox.sh
#                    - internet is OK
#
# TO DO : test the script to see it's OK on a fresh jessie 8.7! :-|                   

check_debian ()
{
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install -y curl git zsh jq vim imagemagick
}

install_latest_sublime3 ()
{
  curl https://www.sublimetext.com/3 |grep 'amd64.deb'| cut -c39-104 > st3-lastbuild-amd64
  wget -i st3-lastbuild-amd64
  sudo dpkg -i $(ls | grep 'sublime-text*')
  rm -f st3-lastbuild-amd64
  rm -f $(ls | grep 'sublime-text*')
  sudo ln -s /opt/sublime_text/sublime_text /usr/local/sublime_text_3
  sudo ln -s /usr/local/sublime_text_3 /usr/local/bin/sublime_text_3
  #you can launch sublime in the terminal with the command stt
}

install_latest_nodejs ()
{
  #install the lastest nodejs and npm with repos for auto update
  sudo curl -sL https://deb.nodesource.com/setup_7.x | sudo bash -
  sudo apt-get install -y nodejs
}

install_ohmyzsh ()
{
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

}

install_github ()
{
  echo -e "\033[32mEnter your email to configure github with ssh [ENTER]:\033[0m"
  read github_email
  mkdir -p ~/.ssh && ssh-keygen -t rsa -C "$github_email"
  ssh-add ~/.ssh/id_rsa
  echo -e "Copy this key to github ssh settings :"
  cat ~/.ssh/id_rsa.pub
  echo -e "\033[32mType [YES] when it's done:\033[0m"
  read github_ok
  if [ "$github_ok" == "YES" ];then
    ssh -T git@github.com
  fi
}

install_lewagon_dotfiles ()
{
  echo -e "\033[32mType your github username:\033[0m"
  read github_username
  #export GITHUB_USERNAME=$github_username
  mkdir -p ~/code/$github_username && cd $_ && git clone git@github.com:$github_username/dotfiles.git
  zsh install.sh
  zsh git_setup.sh
  stt
  sleep 80
}

install_rvm_ruby ()
{
  sudo apt-get install -y build-essential tklib zlib1g-dev libssl-dev libffi-dev libxml2 libxml2-dev libxslt1-dev libreadline-dev
sudo apt-get clean
sudo mkdir -p /usr/local/opt && sudo chown `whoami`:`whoami` $_
git clone https://github.com/rbenv/rbenv.git /usr/local/opt/rbenv
git clone https://github.com/rbenv/ruby-build.git /usr/local/opt/rbenv/plugins/ruby-build
source ~/.zshrc
rbenv install 2.3.3
rbenv global 2.3.3
ruby -v
#fix with "$dpkg-reconfigure locales" and add "en_US.UTF-8" to fix the error msg
gem install bundler rspec rubocop pry pry-byebug hub colored gist

}

install_postgres ()
{
  sudo apt-get install -y postgresql postgresql-contrib libpq-dev build-essential
echo `whoami` > /tmp/caller
sudo su - postgres
psql --command "CREATE ROLE `cat /tmp/caller` LOGIN createdb;"
exit
rm -f /tmp/caller

}

install_sqlite ()
{
sudo apt-get install sqlite libsqlite3-dev
}

install_rails5 ()
{
gem install rails -v 5.0.1
}
install_tools ()
{
gem install hub
}


# start program
clear
echo "Preparing debian for rails..."
check_debian
sleep 2
echo "Installing the last sublime text 3..."
install_latest_sublime3
sleep 2
echo "Installing the latest nodejs version..."
install_latest_nodejs
sleep 2
echo "Installing oh_my_zsh..."
install_ohmyzsh
sleep 2
echo "Installing github..."
install_github
sleep 2
echo "Installing lewagon dotfiles and sublime text addons..."
install_lewagon_dotfiles
sleep 2
echo "Installing rvm and ruby 2.3.3..."
install_rvm_ruby
sleep 2
echo "Installing postgresql db..."
install_postgres
sleep 2
install_sqlite
echo "Installing sqlite db..."
install_rails5
echo "Installing rails 5..."
sleep 2
echo "Installing other tools..."

