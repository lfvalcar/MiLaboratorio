float V2;
int readVal;
int ledGreen = 8;
int ledYellow = 9;
int ledRed = 10;
int analogPin = A4;
int dt = 500;

void setup() {
  Serial.begin(9600);
  pinMode(analogPin,INPUT);
  pinMode(ledGreen,OUTPUT);
  pinMode(ledYellow,OUTPUT);
  pinMode(ledRed,OUTPUT);
}

void loop() {
  readVal = analogRead(analogPin);
  V2 = (5.*readVal)/1023.;
  
  Serial.print("El voltaje es de: ");
  Serial.print(V2);
  Serial.println(" voltios");

// ***** OPERADORES *****
// < , > , <= , >= , == , !=


  if (V2 <= 3.0){
    digitalWrite(ledGreen,HIGH);
    digitalWrite(ledYellow,LOW);
    digitalWrite(ledRed,LOW);
    }
  else if (V2 > 3.0 && V2 <= 4.0){
    digitalWrite(ledGreen,LOW);
    digitalWrite(ledYellow,HIGH);
    digitalWrite(ledRed,LOW);
    }
  
  else if (V2 > 4.0){
    digitalWrite(ledGreen,LOW);
    digitalWrite(ledYellow,LOW);
    digitalWrite(ledRed,HIGH);
  }
  
  delay(dt);

}
