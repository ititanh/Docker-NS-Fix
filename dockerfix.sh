#!/bin/bash

clear
echo "Select Your VPS Location"
echo "[1] Romania"
echo "[2] Germany"

read location



systemctl stop wings
apt remove docker-ce
apt install docker-ce
docker network remove pterodactyl_nw
docker network create pterodactyl_nw
cd /etc/docker
rm daemon.json
case $location in
    1)
        echo "Docker configuration will be set to Romania nameservers"
        wget https://github.com/ititanh/Docker-NS-Fix/blob/main/Romania/daemon.json
        ;;
    2)
        echo "Docker configuration will be set to Germany nameservers"
        wget https://github.com/ititanh/Docker-NS-Fix/blob/main/Germany/daemon.json
        ;;
    *)
        echo "Invalid selection. Please choose either 1 or 2."
        ;;
esac
systemctl restart docker
docker network ls
systemctl start wings


echo "Docker his now fixed."
