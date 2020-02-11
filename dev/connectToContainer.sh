#!/usr/bin/env bash

#docker ps | grep $@ | awk '{print "docker exec -t --user www-data "$1" bash"}' | bash

# it's have an -i that interact directly with the terminal
echo ""; #Start Spacer

echo "connectToContainer Script";

echo "Use this command for "$@" container : ";
docker ps | grep $@ | awk '{print "docker exec -it --user www-data "$1" bash"}'

echo ""; #End Spacer