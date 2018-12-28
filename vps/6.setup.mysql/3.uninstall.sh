#!/bin/bash
sudo apt-get -qq remove --purge mysql*
sudo apt-get -qq purge mysql*
sudo apt-get -qq autoremove
sudo apt-get -qq autoclean
sudo apt-get -qq remove dbconfig-mysql
sudo apt-get -qq dist-upgrade
sudo apt-get -qq install mysql-server