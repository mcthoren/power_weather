/* thanks to Ladyada!
 * http://www.ladyada.net/learn/sensors/tmp36.html
 * http://www.ladyada.net/make/tweetawatt/software.html
 * and Arduino
 * http://www.arduino.cc/en/Main/ArduinoEthernetShield
 * this makes extensive use of sample code from both places
 */

#include <Ethernet.h>
#include <WProgram.h>
#include <avr/interrupt.h>  
#include <avr/io.h>

#define VREF 2.263; /* external voltage devider */
/*
 * we apply a correction factor i'm guessing is compensating for
 * internal uC resistance. this way the readings out of the uC
 * agree with the multimeter 
 */
#define analog_to_mv_scale 2.1636278; /* VREF * 1000 / 1024 * CF */

byte mac[] = { 0x90, 0xA2, 0xDA, 0x00, 0x05, 0xAD };
byte ip[] = { 192, 168, 1, 4 };
byte gateway[] = { 192, 168, 1, 1 };
byte subnet[] = { 255, 255, 255, 0 };

int i = 0, x = 0, max = 0, probe_read[34]; /* 34ms for two cycles (2 * 1 / 60Hz) */
float analog_mV[] = {0, 0, 0};
float temp_V = 0, temp_C = 0;

Server server = Server(80);

void setup()
{
	Ethernet.begin(mac, ip, gateway, subnet);
	server.begin();

	analogReference(EXTERNAL); /* (VREF) */

	/* seems to need to settle a bit */
	delay(1280);
}

void loop()
{
	Client client = server.available();
	if (client) {

		for (i = 0; i <= 1; i++) {

			analogRead(i);
			delay(10);

			for (x = 0; x <= 33; x++) {
				probe_read[x] = analogRead(i);
				delay(1);
			}

			max = 0;
			for (x = 0; x <= 33; x++) {
				if (probe_read[x] > max) max = probe_read[x];
			}

			analog_mV[i] = max * analog_to_mv_scale;
		}

		analogRead(2);
		delay(10);
		analog_mV[2] = analogRead(2) * analog_to_mv_scale;

		for (i = 0; i <= 2; i++) {
			server.print(analog_mV[i]);	
			server.print("mV ");
		}

		temp_V = analog_mV[2] / 1000;
		temp_C = (temp_V - 0.5) * 100;
		server.print(temp_C);	
		server.print("C ");

		server.println("END");
		delay(50);
		client.stop();
	}
}
