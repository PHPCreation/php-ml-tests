#!/usr/bin/env bash

# @doc https://tools.phpcreation.com/confluence/pages/viewpage.action?pageId=16484733
# @todo EachStep could be a specific fileScript

echo ""; #Start Spacer

echo "FreshInstall Script";

echo "THIS IS A WORK IN PROGRESS";
echo "Need to be test";
exit;

echo "CloneSource is already done";

echo "Docker-compose copy configuration";
# check if it exist
cp docker-compose.local.yml docker-compose.yml;

echo "Docker-compose UID configuration";
UID=$(id -u);
echo 'UID = ' $UID;
# Str replace in configuration ${UID} in docker-compose.yml

echo "Docker-compose up";
docker-compose up &

echo "Composer install vendor";
# Use ./exec ?
# ./composer install

echo "Create database config for tenant";
# check if the database exist
# connect to DB container "phprerp_db"
./dev/connectToContainer.sh phprerp_db
# create DB config Encodage UTF8_general_ci
mysql -p
CREATE DATABASE config;
show databases;
use config;
show tables;

#Transfert file into the container
#Ref : https://docs.docker.com/engine/reference/commandline/cp/
docker cp ./dev/config.sql 5c64edecfc2a:/config.sql

# Load / import database
# Use mysql command with file /config.sql
#In docker : mysql -proot config < /config.sql


echo "Docker-compose down";
docker-compose down &

echo "Docker-compose up";
docker-compose up &

echo "Restart DB";
./dev/restartDB.sh

echo "Clear cache include in restart DB";


echo ""; #End Spacer