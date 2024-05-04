#!/bin/bash

clear
echo "Select Your VPS Location"
echo "[1] Romania"
echo "[2] Germany"

read location



systemctl stop wings
apt remove -y docker-ce
apt install -y docker-ce
docker network remove pterodactyl_nw
docker network create pterodactyl_nw
cd /etc/docker
case $location in
    1)
        echo "Docker configuration will be set to Romania nameservers"
        rm daemon.json
        wget https://raw.githubusercontent.com/ititanh/Docker-NS-Fix/main/Romania/daemon.json
        ;;
    2)
        echo "Docker configuration will be set to Germany nameservers"
        rm daemon.json
        wget https://raw.githubusercontent.com/ititanh/Docker-NS-Fix/main/Germany/daemon.json
        ;;
    *)
        echo "Invalid selection. Please choose either 1 or 2."
        ;;
esac
systemctl restart docker
docker network ls
systemctl start wings


echo "Docker is now fixed."
