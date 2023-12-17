int vRead = A0;
int out;
float vOut;
int dt = 1000;

void setup() {
  Serial.begin(9600);
  pinMode(vRead,INPUT);
}

void loop() {
  out = analogRead(vRead);
  vOut = (out * 5.) / 1023.;
  Serial.print("El voltaje actual es de: ");
  Serial.print(vOut);
  Serial.println(" voltios");
  delay(dt);

}
