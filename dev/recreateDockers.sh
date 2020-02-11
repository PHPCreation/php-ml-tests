#!/usr/bin/env bash

echo ""; #Start Spacer

echo "Script recreates Docker Images, Volumes, Containers as new";

docker-compose up --force-recreate

echo ""; #End Spacer
