#!/usr/bin/python3
# -*- coding: UTF-8 -*-

import board, busio
import adafruit_ads1x15.ads1115 as ADS
from adafruit_ads1x15.analog_in import AnalogIn

i2c = busio.I2C(board.SCL, board.SDA)
ads = ADS.ADS1115(i2c)

c0 = AnalogIn(ads, ADS.P0)
c1 = AnalogIn(ads, ADS.P1)
c2 = AnalogIn(ads, ADS.P2)
c3 = AnalogIn(ads, ADS.P3)

print("0: ", c0.value, c0.voltage)
print("1: ", c1.value, c1.voltage)
print("2: ", c2.value, c2.voltage)
print("3: ", c3.value, c3.voltage)
