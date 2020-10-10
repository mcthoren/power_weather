#!/usr/bin/python3
# -*- coding: UTF-8 -*-
# https://www.adafruit.com/product/1085

import board, busio, time, datetime, sys
import adafruit_ads1x15.ads1115 as ADS
from adafruit_ads1x15.analog_in import AnalogIn

sys.path.append('/home/ghz/wxlib')
import wxlib as wx

i2c = busio.I2C(board.SCL, board.SDA)
ads = ADS.ADS1115(i2c)

vals = {}
p_vals = {}

dat_fname='power'
wx_dir = "/home/ghz/power_wx"

c0 = AnalogIn(ads, ADS.P0)
c1 = AnalogIn(ads, ADS.P1)
c2 = AnalogIn(ads, ADS.P2)
c3 = AnalogIn(ads, ADS.P3)

ads.gain = 1

if __name__ == "__main__":
	while True:

		for i in range(0, 4):
			p_vals[i] = vals[i] = 0

		# hope that 150 samples will find the peak of a 50Hz sin wave...
		for m in range(0, 150):
			try:
				vals[0] = c0.voltage
				vals[1] = c1.voltage
				vals[2] = c2.voltage
				vals[3] = c3.voltage
			except:
				# warn. clear. bail.
				print("ad read error. prly from deep in the bowels of a lib somewere.")
				for k in range(0, 4):
					vals[k] = 0
				continue

			# "peak detection". this code was orig written for a µC, where our sample freq was
			# well above nyquist for [56]0Hz power. python's not really fast enough to do this.
			for j in range(0, 4):
				if vals[j] > p_vals[j]:
					p_vals[j] = vals[j]

		ts = datetime.datetime.fromtimestamp(time.time()).strftime("%Y%m%d%H%M%S")

		dat_s = "%s\tph0: %.4f V,\tph1: %.4f V,\tph2: %.4f V,\tBatt: %.2f V\n" % \
		(ts, p_vals[0], p_vals[1], p_vals[2], p_vals[3])

		wx.write_out_dat_stamp(ts, dat_fname, dat_s, wx_dir)
