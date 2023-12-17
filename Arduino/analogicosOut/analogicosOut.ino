int blueLed = 9;
int brightness1 = 0;
int brightness2 = 125;
int brightness3 = 255;
int dt = 500;

void setup() {
  pinMode(blueLed,OUTPUT);

}

void loop() {
  analogWrite(blueLed,brightness1); // Con analogWrite controlamos la salida de los pines en modo analógico (0-255)
  delay(dt);
  analogWrite(blueLed,brightness2);
  delay(dt);
  analogWrite(blueLed,brightness3);
  delay(dt);
}
