#!/usr/bin/env bash

echo ""; #Start Spacer

echo "Script that destroys all Docker Images, Volumes, Containers and recreates them as new";

echo "docker images ls"
docker images ls

echo "docker images -q | xargs docker rmi -f";
docker images -q | xargs docker rmi -f;

echo "docker ps -a | awk 'NR>1 { print $1 }' | xargs -l docker rm -f";
docker ps -a | awk 'NR>1 { print $1 }' | xargs -l docker rm -f;

echo "docker volume ls | awk '{ print $2 }' | xargs -l  docker volume rm -f";
docker volume ls | awk '{ print $2 }' | xargs -l  docker volume rm -f;

echo "docker images ls"
docker images ls

echo ""; #End Spacer
