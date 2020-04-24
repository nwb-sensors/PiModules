#!/bin/bash

#https://www.raspberrypi.org/forums/viewtopic.php?p=770339#p770339
# along with edits made by @htkoca

# sudo access check
  source ./auth.sh
  set -e

# main script
  echo '--- adding lines to config.txt ---'
  sudo cp /boot/config.txt /boot/config.old
  if [ "$(grep -c "^dtoverlay=i2c-rtc,ds1307" /boot/config.txt)" -eq 0 ]; then
    echo -e "\ndtoverlay=i2c-rtc,ds1307\n" | sudo tee -a /boot/config.txt
    echo 'ADDED to config.txt: dtoverlay=i2c-rtc,ds1307'
  else
    echo 'FOUND in config.txt: dtoverlay=i2c-rtc,ds1307'
  fi
  if [ "$(grep -c "^enable_uart=1" /boot/config.txt)" -eq 0 ]; then
    echo -e "\nenable_uart=1\n" | sudo tee -a /boot/config.txt
    echo 'ADDED to config.txt: enable_uart=1'
  else
    echo 'FOUND in config.txt: enable_uart=1'
  fi
  if [ "$(grep -c "^dtparam=i2c_arm=on" /boot/config.txt)" -eq 0 ]; then
    echo -e "\ndtparam=i2c_arm=on\n" | sudo tee -a /boot/config.txt
    echo 'ADDED to config.txt: dtparam=i2c_arm=on'
  else
    echo 'FOUND in config.txt: dtparam=i2c_arm=on'
  fi
  if [ "$(grep -c "^dtparam=i2c1_baudrate=25000" /boot/config.txt)" -eq 0 ]; then
    echo -e "\ndtparam=i2c1_baudrate=25000\n" | sudo tee -a /boot/config.txt
    echo 'ADDED to config.txt: dtparam=i2c1_baudrate=25000'
  else
    echo 'FOUND in config.txt: dtparam=i2c1_baudrate=25000'
  fi

  sudo cp /etc/modules /etc/modules.old
  echo '--- adding lines to /etc/modules ---'
  if [ "$(grep -c "^i2c-dev" /etc/modules)" -eq 0 ]; then
    echo -e "\ni2c-dev\n" | sudo tee -a /etc/modules
  fi
  if [ "$(grep -c "^i2c-bcm2708" /etc/modules)" -eq 0 ]; then
    echo -e "\ni2c-bcm2708\n" | sudo tee -a /etc/modules
  fi
  if [ "$(grep -c "^rtc-ds1307" /etc/modules)" -eq 0 ]; then
    echo -e "\nrtc-ds1307\n" | sudo tee -a /etc/modules
  fi

  echo '--- removing fake-hwclock'
  sudo apt-get -y remove fake-hwclock
  sudo update-rc.d -f fake-hwclock remove
  echo '--- installing & enabling daemon'
  #(cd ../code/python/package && sudo python setup.py install)
  echo '--- TO REMOVE/UNINSTALL:'
  echo '  cat $HOME/upspico_install.log | xargs sudo rm'
  (cd ../code/python/package && sudo python setup.py install --record $HOME/upspico_install.log)
  #(cd ../code/python/upspico/picofssd && sudo python setup.py install)
  echo '  cat $HOME/upsfssd_install.log | xargs sudo rm'
  (cd ../code/python/upspico/picofssd && sudo python setup.py install --record $HOME/upsfssd_install.log)
  sudo systemctl enable picofssd.service
  sudo systemctl start picofssd.service
  
  echo '--------------------------------------------------------------------------------'
  echo '--- MAKE SURE THE FOLLOWING LINES ARE COMMENTED OUT IN /lib/udev.hwclock-set ---'
  echo '--------------------------------------------------------------------------------'
  echo '   #if [ -e /run/systemd/system] ; then'
  echo '   # exit 0'
  echo '   #fi'
  echo '--- Press a key to continue ---'
  read key
  sudo nano /lib/udev/hwclock-set
  # sudo hwclock -w
  echo '--- all done, rebooting'
  sudo shutdown -r
  #exit 0
