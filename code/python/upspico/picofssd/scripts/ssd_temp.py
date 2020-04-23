#!/usr/bin/python

""" Returns the SSD's current temp """

import subprocess

def get_ssd_temp(path="/dev/sdb"):
    ''' Calls smartctl, and returns the tempurature reading for the drive '''
    cmd = ["sudo","smartctl", path, "-a"]
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    o, e = proc.communicate()
    output_list = o.split(b"\n")
    temp_line = [x for x in olist if b"Airflow_Temperature_Cel" in x]
    temp = temp_line[0][-2:]

    return int(temp)

print(get_ssd_temp())

