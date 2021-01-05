#!/bin/bash
# install guest additions for virtualbox 6.1.16

# VBOxLinuxAdditions6.1.16 is bugged so use 6.1.4

# start script with root or sudo

# prepare virtualbox for guest additions
apt install build-essential module-assistant -y
m-a prepare -y

# get version 6.1.4 and install
wget https://download.virtualbox.org/virtualbox/6.1.4/VBoxGuestAdditions_6.1.4.iso
mkdir /mnt/iso
mount -o loop VBoxGuestAdditions_6.1.4.iso /mnt/iso
bash /mnt/iso/VBOxLinuxAdditions.run

# reboot
# fullscreen OK on debian 10 guest with debian 10 host
