int buttonPin = 4;
int ledPin = 2;
int buttonRead;
int dt = 500;

void setup() {
	Serial.begin(9600);
	pinMode(buttonPin,INPUT);
	pinMode(ledPin,OUTPUT);
}


void loop() {
	buttonRead = digitalRead(buttonPin);
	Serial.println(buttonRead);
	delay(dt);
	if (buttonRead == 0){
		digitalWrite(ledPin,1);
	}else{
		digitalWrite(ledPin,0);
	}
	
}