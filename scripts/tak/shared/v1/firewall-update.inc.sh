#!/bin/bash

printf $warning "\n\n------------ Updating UFW Firewall Rules ------------\n\n"

SOURCE=$1
while [ -z "${SOURCE}" ]; do
    read -p "What is the ip/range for the traffic source? " SOURCE
done

printf $info "Allow 22 [SSH]\n"
sudo ufw allow OpenSSH;
printf $info "\nAllow 8089 [API]\n"
sudo ufw allow proto tcp from ${SOURCE} to any port 8089
printf $info "\nAllow 8443 [certificate auth]\n"
sudo ufw allow proto tcp from ${SOURCE} to any port 8443
printf $info "\nAllow 8446 [user/pass auth]\n"
sudo ufw allow proto tcp from ${SOURCE} to any port 8446
printf $info "\nAllow 9000 [federation]\n"
sudo ufw allow proto tcp from ${SOURCE} to any port 9000
printf $info "\nAllow 9001 [federation]\n"
sudo ufw allow proto tcp from ${SOURCE} to any port 9001