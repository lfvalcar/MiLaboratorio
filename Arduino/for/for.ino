int redPin = 12;
int yellowPin = 13;
int dt = 500;
int yellow = 3;
int red = 5;
int i;


void setup() {
  pinMode(redPin,OUTPUT);
  pinMode(yellowPin,OUTPUT);

}

void loop() {
  for (i=0; i<yellow; i++){
    digitalWrite(yellowPin,HIGH);
    delay(dt);
    digitalWrite(yellowPin,LOW);
    delay(dt);
  }

  for (i=0; i<red; i++){
    digitalWrite(redPin,HIGH);
    delay(dt);
    digitalWrite(redPin,LOW);
    delay(dt);
  }

}
