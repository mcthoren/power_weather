#### This is a project to measure and graph power use at our flat.

It started as a project to do the same at a house in north america back in ~2012, this can be found in the branches.

To install the prerequisites one needs sth like the following:
* apt install python3-pip
* pip3 install adafruit-circuitpython-ads1x15

##### Many thanks to Adafruit for all the wonderful docs, boards, and examples.
* Docs can be found here:
  * https://www.adafruit.com/product/1085
  * https://learn.adafruit.com/adafruit-4-channel-adc-breakouts/overview
  * https://learn.adafruit.com/raspberry-pi-analog-to-digital-converters?view=all#ads1015-slash-ads1115
  * https://cdn-shop.adafruit.com/datasheets/ads1115.pdf
  * https://www.poweruc.pl/collections/split-core-current-transformers2/products/split-core-current-transformer-sct013-rated-input-5a-100a

* This code can be found in the following places:
  * https://wx0.slackology.net/power_weather/power.html		<--page
  * https://github.com/mcthoren/power_weather			<--code
  * https://wx0.slackology.net/power_weather/			<--code, data, plots, page

to do:
- [x] lic
- [x] readme
- [x] protoype hardware
- [x] build hardware
- [x] wedge hardware into breaker box
- [x] hook up plotting
- [x] webpage
- [ ] calibrate
