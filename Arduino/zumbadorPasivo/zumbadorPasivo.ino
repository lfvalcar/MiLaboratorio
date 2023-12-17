int buzzPin = 4;
int potIn = A0;
int readingPotIn;
float buzzDelay;

void setup() {
	Serial.begin(9600);
	pinMode(buzzPin,OUTPUT);
	pinMode(potIn,INPUT);
}

void loop() {
	readingPotIn = analogRead(potIn);
	buzzDelay = (9940./1023.) * readingPotIn + 60;

	digitalWrite(buzzPin,HIGH);
	delayMicroseconds(buzzDelay);
	digitalWrite(buzzPin,LOW);
	delayMicroseconds(buzzDelay);

	Serial.println(readingPotIn);
}