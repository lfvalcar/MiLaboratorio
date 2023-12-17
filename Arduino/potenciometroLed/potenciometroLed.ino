int ledPin = 6;
int potPin = A4;
int potVal;
int dt = 500;
int light;

void setup() {
  Serial.begin(9600);
  pinMode(ledPin,OUTPUT);
  pinMode(potPin,INPUT);

}

void loop() {
  potVal = analogRead(potPin);
  Serial.println(potVal);
  Serial.println(light);
  light = map(potVal,0,1023,0,255);
  analogWrite(ledPin,light);
  delay(dt);

}
