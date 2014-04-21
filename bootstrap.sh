#!/bin/bash

sudo sed -i 's/us\.archive\.ubuntu\.com/ftp.cuhk.edu.hk\/pub\/Linux/g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install build-essential ruby1.9.1-dev --no-upgrade --yes
sudo gem install chef --version 11.4.2 --no-rdoc --no-ri --conservative

