#!/usr/bin/python3
# -*- coding: UTF-8 -*-
# https://www.adafruit.com/product/1085

import board, busio, time, datetime
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

ads.gain = 1

if __name__ == "__main__":
	while True:

		for i in range(0, 4):
			p_vals[i] = vals[i] = 0

		for i in range(0, 150):
			vals[0] = c0.voltage
			vals[1] = c1.voltage
			vals[2] = c2.voltage
			vals[3] = c3.voltage

			# "peak detection" python's not really fast enough to do this.
			for i in range(0, 4):
				if vals[i] > p_vals[i]:
					p_vals[i] = vals[i]


		ts = datetime.datetime.fromtimestamp(time.time()).strftime("%Y%m%d%H%M%S")

		# in theory, if we measure peak to peak AC voltage with a current probe that
		# reads 1V for every 15A, and if our voltage and current are in phase. then:
		# rms power [W] = current probe reading [Vpp] * sqrt(2) * line voltage [V] * 15[A/V]
		theory_power = p_vals[0] * .707106781 * 229 * 15
		# dat_s = "%s\t0:\t%.4f V, 1:\t%.2f V, 2:\t%.2f V, 3:\t%.2f V" % (ts, p_vals[0], p_vals[1], p_vals[2], p_vals[3])
		dat_s = "%s\tph0: %.4f V,\tBatt: %.2f V,\tPower: %.0f W" % (ts, p_vals[0], p_vals[1], theory_power)
		print(dat_s)
