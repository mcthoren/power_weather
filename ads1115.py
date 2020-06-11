#!/usr/bin/python3
# -*- coding: UTF-8 -*-
# https://www.adafruit.com/product/1085

import board, busio, time
import adafruit_ads1x15.ads1115 as ADS
from adafruit_ads1x15.analog_in import AnalogIn

i2c = busio.I2C(board.SCL, board.SDA)
ads = ADS.ADS1115(i2c)

vals = {}
p_vals = {}

c0 = AnalogIn(ads, ADS.P0)
c1 = AnalogIn(ads, ADS.P1)
c2 = AnalogIn(ads, ADS.P2)
c3 = AnalogIn(ads, ADS.P3)

if __name__ == "__main__":
	while True:

		for i in range(0, 4):
			p_vals[i] = vals[i] = 0

		time0 = time1 = time.time()
		for i in range(0, 150):
			vals[0] = c0.voltage
			vals[1] = c1.voltage
			vals[2] = c2.voltage
			vals[3] = c3.voltage

			# "peak detection" python's not really fast enough to do this.
			for i in range(0, 4):
				if vals[i] > p_vals[i]:
					 p_vals[i] = vals[i]

		time1 = time.time()

		dat_s = "0:\t%.4f V, 1:\t%.2f V, 2:\t%.2f V, 3:\t%.2f V" % (p_vals[0], p_vals[1], p_vals[2], p_vals[3])
		print(dat_s)
		d_t = "%.2f" % (time1 - time0)
		print(d_t)
