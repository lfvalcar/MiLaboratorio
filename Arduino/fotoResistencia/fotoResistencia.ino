int gPin = 9;
int rPin = 8;

int lightPin = A5;
int lightVal;
int dt = 500;


void setup() {
	Serial.begin(9600);
	pinMode(lightPin,INPUT);
	pinMode(rPin,OUTPUT);
	pinMode(gPin,OUTPUT);
}

void loop() {
	lightVal = analogRead(lightPin);
	Serial.println(lightVal);
	delay(dt);
	
	if(lightVal < 700){
		digitalWrite(gPin,1);
		digitalWrite(rPin,0);
	}
	
	if else(lightVal >= 700){
		digitalWrite(gPin,0);
		digitalWrite(rPin,1);
	}
}