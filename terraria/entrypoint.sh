#!/bin/bash
cd /home/container

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP


export DOTNET_ROOT=/usr/share/

# print the wine version on startup
#printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mwine --version\n"
#wine --version
chmod 770 TerrariaServer.bin.x86_64

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}