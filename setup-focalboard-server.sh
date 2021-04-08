#!/bin/bash

# DESCRIPTION : install focalboard for testing purpose (without postgres)
# USAGE : ./setup-focalboard-server.sh --version [X.X.X]
# USAGE : ./setup-focalboard-server.sh --version 0.6.1
# REQUIREMENTS : sudo / debian based system
# AUTHOR : https://github.com/magiknono
# DATE : 08042021


check_deps() {
# check deps
## on kaisen linux
#sudo kaisen-update 

## on debian
sudo apt update && apt upgrade -y
sudo apt install -y wget tar nginx nginx-common 
}

install_focalboard() {
# get version parameter
if [[ $# -eq 2 ]] && [[ $1 = "--version" ]] && [[ -n $2 ]]; then
  # install focalboard
  wget https://github.com/mattermost/focalboard/releases/download/v$2/focalboard-server-linux-amd64.tar.gz
  # checking if wget worked
  if [[ $? -ne 0 ]]; then
    echo "ERROR : cannot get source release, check https://github.com/mattermost/focalboard/releases"
    exit
  fi
  tar -xvzf focalboard-server-linux-amd64.tar.gz
  sudo mv focalboard /opt 
  echo "* Focalboard downloaded and installed in /opt"
  else
    echo "ERROR : command not found, see exemple : $0 --version 0.6.1"
  exit
fi
}

config_nginx() {
cat <<EOF > focalboard.site
upstream focalboard {
   server localhost:8000;
   keepalive 32;
}

server {
   listen 80;

   #server_name focalboard;

   location ~ /ws/* {
       proxy_set_header Upgrade \$http_upgrade;
       proxy_set_header Connection "upgrade";
       client_max_body_size 50M;
       proxy_set_header Host \$http_host;
       proxy_set_header X-Real-IP \$remote_addr;
       proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
       proxy_set_header X-Forwarded-Proto \$scheme;
       proxy_set_header X-Frame-Options SAMEORIGIN;
       proxy_buffers 256 16k;
       proxy_buffer_size 16k;
       client_body_timeout 60;
       send_timeout 300;
       lingering_timeout 5;
       proxy_connect_timeout 1d;
       proxy_send_timeout 1d;
       proxy_read_timeout 1d;
       proxy_pass http://focalboard;
 }

   location / {
       client_max_body_size 50M;
       proxy_set_header Connection "";
       proxy_set_header Host \$http_host;
       proxy_set_header X-Real-IP \$remote_addr;
       proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
       proxy_set_header X-Forwarded-Proto \$scheme;
       proxy_set_header X-Frame-Options SAMEORIGIN;
       proxy_buffers 256 16k;
       proxy_buffer_size 16k;
       proxy_read_timeout 600s;
       proxy_cache_revalidate on;
       proxy_cache_min_uses 2;
       proxy_cache_use_stale timeout;
       proxy_cache_lock on;
       proxy_http_version 1.1;
       proxy_pass http://focalboard;
   }
}
EOF

sudo cp focalboard.site /etc/nginx/sites-available/focalboard
rm -f focalboard.site 
sudo ln -s /etc/nginx/sites-available/focalboard /etc/nginx/sites-enabled/focalboard
sudo rm -f /etc/nginx/sites-enable/default
sudo systemctl reload nginx 
 }
 
config_systemd() {
cat <<EOF > focalboard.service
[Unit]
Description=Focalboard server

[Service]
Type=simple
Restart=always
RestartSec=5s
ExecStart=/opt/focalboard/bin/focalboard-server
WorkingDirectory=/opt/focalboard

[Install]
WantedBy=multi-user.target
EOF

sudo cp -f focalboard.service /lib/systemd/system/
sudo rm -f focalboard.service
sudo systemctl daemon-reload 
sudo systemctl start focalboard.service 
sudo systemctl enable focalboard.service 
}

check_focalboard_http() {
http_check=$(curl localhost:8000)
if [[ $? -eq 0 ]]; then
echo "* Checking http service : OK"
echo "* Install done"
echo "Open firefox on http://localhost"
else
echo "ERROR : http service : KO"
fi
}

check_deps
install_focalboard "$@"
config_nginx
config_systemd
check_focalboard_http

