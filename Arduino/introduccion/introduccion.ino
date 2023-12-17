  //Variables para facilitar el trabajo
  int dot = 100; 
  int dash = 300;
  int ledPin = 7;
  int finalDelay = 1500;

void setup() {
  pinMode(ledPin,OUTPUT); // con pinMode definimos que pin usaremos y su modo entrada/salida 

}

void loop() {
  digitalWrite(ledPin,HIGH); // Con digitalWrite controlamos la salida de los pines en modo digital (activo/inactivo = HIGH/LOW = 1/0)
  delay(dot); // Establecemos pausas en ms
  digitalWrite(ledPin,LOW);
  delay(dot);
  digitalWrite(ledPin,HIGH);
  delay(dot);
  digitalWrite(ledPin,LOW);
  delay(dot);
  digitalWrite(ledPin,HIGH);
  delay(dot);
  digitalWrite(ledPin,LOW);
  delay(dot);

  digitalWrite(ledPin,HIGH);
  delay(dash);
  digitalWrite(ledPin,LOW);
  delay(dash);
  digitalWrite(ledPin,HIGH);
  delay(dash);
  digitalWrite(ledPin,LOW);
  delay(dash);
  digitalWrite(ledPin,HIGH);
  delay(dash);
  digitalWrite(ledPin,LOW);
  delay(dash);

  digitalWrite(ledPin,HIGH); 
  delay(dot);
  digitalWrite(ledPin,LOW);
  delay(dot);
  digitalWrite(ledPin,HIGH);
  delay(dot);
  digitalWrite(ledPin,LOW);
  delay(dot);
  digitalWrite(ledPin,HIGH);
  delay(dot);
  digitalWrite(ledPin,LOW);
  delay(dot);

  delay(finalDelay);
}
