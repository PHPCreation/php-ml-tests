#!/usr/bin/env bash

echo "Current Space"
df -h

echo "Clean up"
apt-get update
apt-get autoremove --purge -y
apt-get clean
apt-get autoclean
apt-get autoremove --purge -y
purge-old-kernels

echo "Current Space"
df -h