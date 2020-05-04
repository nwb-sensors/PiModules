#!/bin/bash
while true; do
    python3 /home/pi/PiModules-nwb/pico_status/logstatus.py >> /home/pi/agcamtest.log
    ip -4 addr show dev wlan0 >> /home/pi/agcamtest.log
    sleep 2m
done
