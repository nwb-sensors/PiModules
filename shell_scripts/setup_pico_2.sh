#!/bin/bash
# sudo access check
  source ./auth.sh
  
  echo '--- show picofssd service status'
  service picofssd status
  echo '--- is UPS PICo running on Cable (0x01) or Bat (0x02)'
  sudo i2cget -y 1 0x69 0x00
  echo '--- is UPS PIco running? both returned hex codes should be different'
  sudo i2cget -y 1 0x69 0x22 w && i2cget -y 1 0x69 0x22 w
  echo '--- is the Hardware Clock working?'
  sudo hwclock -w
  sudo hwclock -r
  echo 'Set Battery Type and Time To run on Battery'
  # 0x46 = "LiFePO4 (ASCII : F) Stack/Top-End"
  # 0x51 = "LiFePO4 (ASCII : Q) Plus/Advanced"
  # 0x53 = "LiPO (ASCII: S) Stack/Top-End"
  # 0x50 = "LiPO (ASCII: P) Plus/Advanced"
  # 0x49 = "Li-Ion ASCII : I) Stack/Top-End"
  # 0x4f = "Li-Ion (ASCII : O) Plus/Advanced"
  # 0x48 = "NiMH (ASCII : H) Stack/Top-End"
  # 0x4d = "NiMH (ASCII : M) Plus/Advanced"
  # 0x4c = "SAL (ASCII : L) Stack/Top-End"
  # 0x41 = "SAL (ASCII : A) Plus/Advanced"
  i2cset 1 0x6b 0x07 0x4f
  i2cset 1 0x6b 0x01 0x3b
  
  python3 ../pico_status/pico_status_python3.py
  # echo '--- toggling Buzzer'
  # sudo i2cset -y 1 0x6D 0x00 # Deactivate permanently the buzzer (no sunds wil be played)
  # sudo i2cset -y 1 0x6D 0x01
  # sudo i2cset -y 1 0x6B 0x0e 1047 w # Set the frequency to C (1047 Hz) note
  # sudo i2cset -y 1 0x6B 0x10 100 # Set the duration to 1 second
  # echo '--- toggling Orange, Green and Blue LEDS'
  # sudo i2cset -y 1 0x6b 0x09 0x01 # for ON the Orange LED
  # sleep 2s
  # sudo i2cset -y 1 0x6b 0x09 0x00 # for OFF the Orange LED
  # sudo i2cset -y 1 0x6b 0x0A 0x01 # for ON the Green LED
  # sleep 2s
  # sudo i2cset -y 1 0x6b 0x0A 0x00 # for OFF the Green LED
  # sudo i2cset -y 1 0x6b 0x0b 0x01 # for ON the Blue LED
  # sleep 2s
  # sudo i2cset -y 1 0x6b 0x0b 0x00 # for OFF the Blue LED
  # echo '--- is any of the buttons pressed? should return 1, 2 or 3'
  # sudo i2cget -y 1 0x69 0x1A
  # sudo i2cset -y 1 0x69 0x1A 0x00 # reset pressed state
  # echo '--- reset and set bistable relay'
  # sudo i2cset -y 1 0x6B 0x0c 0x00 # reset
  # sudo i2cset -y 1 0x6B 0x0c 0x01 # set
