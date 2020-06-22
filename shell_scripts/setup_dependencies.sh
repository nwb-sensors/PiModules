#!/usr/bin/env bash

# sudo access check
source $HOME/PiModules/auth.sh
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
sudo apt-get install -y git htop wget dialog sqlite3 python3-pip python3-smbus nmap vim smartmontools --fix-missing
sudo apt-get install -y python-dev python-pip python-serial python-smbus python-jinja2 python-xmltodict python-psutil i2c-tools libi2c-dev --fix-missing
echo '--- pip install rpi.gpio'
sudo pip install RPi.GPIO
echo '--- pip install psutil'
sudo pip install psutil
echo '--- pip install python3 stuff'
sudo pip3 install simplejson
sudo pip3 install pythonping
sudo pip3 install pysmart
sudo pip3 install mysql-connector
echo '--- pip install xmltodict'
sudo pip install xmltodict
echo 'updating Rpi4 bootloader'
sudo rpi-eeprom-update -a
echo 'Configuring static ip stuff'
if grep -Fxq "profile static_wlan0" /etc/dhcpcd.conf; then
	echo "Profile set"
else
	sudo echo 'profile static_wlan0' >> /etc/dhcpcd.conf
fi

if grep -Fxq "static ip_address=192.168.0.117" /etc/dhcpcd.conf; then
	echo "Address set"
else
	sudo echo 'static ip_address=192.168.0.117' >> /etc/dhcpcd.conf
fi

if grep -Fxq "static routers=192.168.0.1" /etc/dhcpcd.conf; then
	echo "Router set"
else
	sudo echo 'static router=192.168.0.1' >> /etc/dhcpcd.conf
fi

if grep -Fxq "fallback static_wlan0" /etc/dhcpcd.conf; then
	echo "Fallback set"
else
	sudo echo 'fallback static_wlan0' >> /etc/dhcpcd.conf
fi
echo '--- all done, rebooting'
#sudo reboot
exit 0
