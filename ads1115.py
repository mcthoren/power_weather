#!/usr/bin/python3
# -*- coding: UTF-8 -*-
# https://www.adafruit.com/product/1085

import board, busio, time
import adafruit_ads1x15.ads1115 as ADS
from adafruit_ads1x15.analog_in import AnalogIn

i2c = busio.I2C(board.SCL, board.SDA)
ads = ADS.ADS1115(i2c)

c0 = AnalogIn(ads, ADS.P0)
c1 = AnalogIn(ads, ADS.P1)
c2 = AnalogIn(ads, ADS.P2)
c3 = AnalogIn(ads, ADS.P3)

if __name__ == "__main__":
	while True:
		dat_s = "0:\t%.2f V, 1:\t%.2f V, 2:\t%.2f V, 3:\t%.2f V" % (c0.voltage, c1.voltage, c2.voltage, c3.voltage)
		print(dat_s)
		time.sleep(0.5)
