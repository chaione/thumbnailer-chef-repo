#!/bin/bash

# Set up chef repositories for Ubuntu 12.04LTS Precise

echo "Adding Opscode to sources.list"
echo "deb http://apt.opscode.com/ precise-0.10 main" > /etc/apt/sources.list.d/opscode.list

echo "Requesting Opscode gpg key"
mkdir -p /etc/apt/trusted.gpg.d
gpg --keyserver keys.gnupg.net --recv-keys 83EF826A
gpg --export packages@opscode.com | tee /etc/apt/trusted.gpg.d/opscode-keyring.gpg

echo "Updating apt"
apt-get update

echo "Installing chef-server"
apt-get install opscode-keyring
apt-get install chef chef-server