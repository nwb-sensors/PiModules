#!/usr/bin/python

""" Returns the SSD's current temp """

import subprocess

def get_ssd_temp(path="/dev/sdb"):
    ''' Calls smartctl, and returns the tempurature reading for the drive '''
    cmd = ["sudo","smartctl", path, "-a"]
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    o, e = proc.communicate()
    temp = o.split(b"\n")[66][-2:]

    return int(temp)

