#!/usr/bin/env bash

# set -x
# DATE : 09-02-2021

# NAME : install-glpi.sh
# DESCRIPTION : setup quickly glpi on a debian buster (actually stable)
# USAGE : chmod +x glpi.sh && sudo ./glpi.sh

# INFO MYSQL : 
# login: glpiuser
# password: glpipassword
# database: glpi

# IMPORTANT : mariadb prompt for current user root password, and some secure questions.

# glpi version to use
glpi_v="9.5.3"

# where to dl glpi
ext="tar.gz"
glpi_url="https://github.com/glpi-project/glpi/archive/$glpi_v.$ext"

# which distro / used for checking dependancy
distro="$(lsb_release -c | awk '{print $2}')"

# php version to use
p="php7.3"
pv="7.3" # used only onetime below
p_ini="/etc/php/$pv/apache2/php.ini"
## for debian bullseye pv="php7.4"

# vhost conf file
vhost="glpi.conf"

# web folder for glpi
web_root="/var/www/glpi"

# set permissions
rule_wr="chmod -R go+w"
apply_perm_user="chown -R www-data:www-data $web_root"
apply_perm_files="$rule_wr $web_root/files/"
apply_perm_config="$rule_wr $web_root/config/"
apply_perm_marketplace="$rule_wr $web_root/marketplace/"

# functions

check_distro_deps ()
{
apt install -y tar gunzip
apt install -y apache2 libapache-mod-php7.3 

}

check_webserver ()
{
touch /etc/apache2/sites-available/$vhost

# to fix: $web_root & $vhost are set manually
cat <<EOF > /etc/apache2/sites-available/$vhost
<VirtualHost *:80>
  DocumentRoot /var/www/glpi
  ErrorLog /var/www/glpi-error.log
  CustomLog /var/www/glpi-access.log combined
  <Directory /var/www/glpi/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
  </Directory>
</VirtualHost>
EOF

a2ensite $vhost
a2dissite 000-default
systemctl reload apache2

}

check_glpi_deps ()
{
if [[ $distro == "buster" ]]; then
apt install $p $p-curl $p-common $p-gd $p-json $p-mbstring $p-mysql $p-xml $p-intl $p-cli $p-ldap $p-xmlrpc $p-cli $p-zip $p-bz2 $p-cli php-apcu php-cas -y
else
echo "not buster ..to do when bullseye is stable"
fi
}

get_glpi () 
{
wget -c $glpi_url  -O - | tar -xvz
}

set_glpi ()
{
mkdir $web_root
cp -aR glpi-$glpi_v/* $web_root/

# set permissions for web folder
$($apply_perm_user)
$($apply_perm_files)
$($apply_perm_config)
$($apply_perm_marketplace)

# set php ini for apache
sed -i 's/max_execution_time = 30/max_execution_time = 600/g' $p_ini
}

check_db ()
{
apt install mariadb-server -y
mysql_secure_installation

}

post_setup_glpi ()
{
# composer
wget -O composer-setup.php https://getcomposer.org/installer
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
# node lts & npm
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt update
apt install build-essential node-js -y
cd /var/www/glpi
php bin/console dependencies install
}

post_setup_db ()
{
mysql -u root <<EOF
CREATE USER 'glpiuser'@'%' IDENTIFIED BY 'glpipassword';
CREATE DATABASE glpi;
GRANT ALL PRIVILEGES ON glpi.* to 'glpiuser'@'%';
FLUSH PRIVILEGES;
EXIT;
EOF
}

check_cert ()
{
apt install python3-certbot-apache
certbot --apache
}


# execute
check_distro_deps
check_glpi_deps
get_glpi
set_glpi
check_db
post_setup_glpi
post_setup_db
check_webserver

read -p "Do you want to install a let's encrypt certificate ? [Y/n]" answer

if [[ $answer == "Y" ]]; then
check_cert
fi

systemctl restart apache2
# firefox http://localhost
echo -e "\033[32mLaunch your web browser at http://localhost/\033[0m"

## clean
## rm -Rf /var/www/glpi/install
