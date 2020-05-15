#!/bin/bash

# sudo access check
  source ./auth.sh
  set -e

# main
  echo '--- update'
  sudo apt-get update
  echo '--- upgrade'
  sudo apt-get upgrade -y
  echo '--- dist-upgrade'
  sudo apt-get dist-upgrade -y
  # echo '--- rpi-update'
  # sudo rpi-update
  echo '--- install some packages'
  sudo apt-get install -y git htop wget dialog sqlite3 python3-pip python3-smbus nmap vim smartmontools
  sudo apt-get install -y python-dev python-pip python-serial python-smbus python-jinja2 python-xmltodict python-psutil i2c-tools libi2c-dev
  echo '--- pip install rpi.gpio'
  sudo pip install RPi.GPIO
  echo '--- pip install psutil'
  sudo pip install psutil
  echo '--- pip install python3 stuff'
  sudo pip3 install simplejson
  sudo pip3 install pysmart
  echo '--- pip install xmltodict'
  sudo pip install xmltodict
  echo 'updating Rpi4 bootloader'
  sudo rpi-eeprom-update -a
  echo '--- all done, rebooting'
  sudo reboot
  exit 0
