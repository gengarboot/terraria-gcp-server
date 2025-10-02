#!/bin/bash

# Update system
apt update && apt upgrade -y

# Set swap file as needed for terraria server to start - on micro instance 
# Needs to be in fstab to be persistent across reboot, or added here to startup script
# dd if=/dev/zero of=/mnt/swapfile bs=1M count=1024
# mkswap /mnt/swapfile
# swapon /mnt/swapfile

if [ ! -f /.FIRST_BOOT_FLAG ]; then
    apt install vim -y
    apt install unzip -y
    apt install screen -y
    touch .FIRST_BOOT_FLAG
    adduser terraria --disabled-password --comment ""
    sudo -i -u terraria bash <<EOF
    mkdir server
    cd server
    wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-1449.zip
    unzip terraria-server-1449.zip 
    chmod +x 1449/Linux/TerrariaServer.bin.x86*
    exit
EOF

# Terraria systemd service running as terraria user
    cat <<'EOF' >> /etc/systemd/system/terraria.service
[Unit]
Description=server daemon for terraria
Wants=network-online.target
After=network-online.target

[Service]
Type=forking
TimeoutStartSec=900
User=terraria
Group=terraria
KillMode=none
ExecStart=/usr/bin/screen -dmS terraria /bin/bash -c "/home/terraria/server/1449/Linux/TerrariaServer.bin.x86_64 -port 7777 -players 4 -world /home/terraria/.local/share/Terraria/Worlds/world.wld -autocreate 2 -secure"
ExecStop=/usr/local/bin/terrariad exit

[Install]
WantedBy=multi-user.target
EOF

# terrariad script for shutdown and save
# as seen https://www.linode.com/docs/guides/host-a-terraria-server-on-your-linode/
    cat <<'EOF' >> /usr/local/bin/terrariad
#!/usr/bin/env bash

send="`printf \"$*\r\"`"
attach="screen -r terraria"
inject="screen -S terraria -X stuff $send"

if [ "$1" = "attach" ] ; then cmd="$attach" ; else cmd="$inject" ; fi

if [ "`stat -c '%u' /var/run/screen/S-terraria/`" = "$UID" ]
then
    $cmd
else
    su - root -c "$cmd"
fi
EOF

# Enable shutdown script to be run
chmod +x /usr/local/bin/terrariad

# Reload, enable and start the terraria service
systemctl daemon-reload
systemctl enable terraria.service
systemctl start terraria.service
fi