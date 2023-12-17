int buzzPin = 8;
int potIn = A0;
int readingPotIn;
// int number;
// int dt = 500;
// String msg1 = "Por favor, introduce tu número";

void setup () {
	// Serial.begin(9600);
	pinMode(buzzPin, OUTPUT);
	pinMode(potIn,INPUT);
}

void loop () {
	readingPotIn = analogRead(potIn);
	Serial.println(readingPotIn);

	while (readingPotIn > 1000){
		digitalWrite(buzzPin,HIGH);
		readingPotIn = analogRead(potIn);
		Serial.println(readingPotIn);
	}

	digitalWrite(buzzPin,LOW);

	/* 
	   Serial.println(msg1);
	   while(Serial.available() == 0){}
	   number = Serial.parseInt();
	*/

	/* 
	if (number > 10) {
		digitalWrite(buzzPin,HIGH);
		delay(dt);
		digitalWrite(buzzPin,LOW);
	} 
	*/
}