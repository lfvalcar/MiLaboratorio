int potPin = A4;
int ledPin = 11;
int potVal;
int dt = 500;
 

void setup() {
  Serial.begin(9600);
  pinMode(potPin,INPUT);
  pinMode(ledPin,OUTPUT);

}

void loop() {
  potVal = analogRead(potPin);
  Serial.println(potVal);
  delay(dt);
  
  while(potVal>1000){
    digitalWrite(ledPin,HIGH);
    Serial.println(potVal);
    potVal = analogRead(potPin);
    delay(dt);
  }
  digitalWrite(ledPin,LOW);
}
