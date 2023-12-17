int ledPin = 7;
int buttonPin = A0;
int ledState = 0;
int buttonOld = 1;
int buttonNew; 
int dt = 500;

void setup() {
	Serial.begin(9600);
	pinMode(ledPin,OUTPUT);
	pinMode(buttonPin,INPUT);
}

void loop() {
	buttonNew = digitalRead(buttonPin);
	delay(dt);
	if (buttonNew == 0 && buttonOld == 1){
		if (ledState == 0){
			digitalWrite(ledPin,1);
			ledState = 1;
		}else{
			digitalWrite(ledPin,0);
			ledState = 0;
		}
	}
	
	buttonOld = buttonNew;
}