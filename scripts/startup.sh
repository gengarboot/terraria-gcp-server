#!/bin/bash

apt update && apt upgrade -y

if [ ! -f /.FIRST_BOOT_FLAG ]; then
    apt install vim -y
    apt install unzip -y
    apt install tmux -y
    touch .FIRST_BOOT_FLAG
    adduser terraria --disabled-password --comment ""
    sudo -i -u terraria bash <<EOF
    mkdir server
    cd server
    wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-1449.zip
    unzip terraria-server-1449.zip 
EOF
fi