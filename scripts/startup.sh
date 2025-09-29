#!/bin/bash

apt update && apt upgrade -y

if [ ! -f /.FIRST_BOOT_FLAG ]; then
    apt install vim -y
    touch .FIRST_BOOT_FLAG
    mkdir terraria-server
    cd  terraria-server
    wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-1449.zip
fi