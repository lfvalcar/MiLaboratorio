int envPin = A0;
int readingEnv;
int buzzPin = 5;
float dtBuzz;

void setup() {
	pinMode(buzzPin,5);
}

void loop() {
	readingEnv = analogRead(envPin);
	dtBuzz = (9./400.) * (readingEnv-300) + 1;
	
	digitalWrite(buzzPin,1);
	delay(dtBuzz);
	digitalWrite(buzzPin,0);
	delay(dtBuzz);
			
	readingEnv = analogRead(envPin);
	dtBuzz = (9./400.) * (readingEnv-300) + 1;

}