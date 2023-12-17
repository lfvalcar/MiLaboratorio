int blinkTimes;
int delayBlink = 1000;
int ledPin = 3;
int i;
String msg1 = "Por favor ingresa el numero de parpadeos: ";

void setup() {
  Serial.begin(9600);
  pinMode(ledPin,OUTPUT);

}

void loop() {
  Serial.println(msg1);
  while(Serial.available() == 0){
    
  }

  blinkTimes = Serial.parseInt();

  for (i=1; i<=blinkTimes; i++){
    digitalWrite(ledPin,HIGH);
    delay(delayBlink);
    digitalWrite(ledPin,LOW);
    delay(delayBlink);
  }

}
