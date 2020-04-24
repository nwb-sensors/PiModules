#!/usr/bin/python

""" Returns the RPi's current CPU temp """

from gpiozero import CPUTemperature

def get_pi_temp():
    cpu = CPUTemperature()
    return cpu.tempurature