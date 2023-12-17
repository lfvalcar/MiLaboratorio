int analogPin = A0;
float V2; // float para los decimales
int dt = 500;
int analogVal;

void setup() {
  pinMode(analogPin,INPUT);
  Serial.begin(9600); // Activamos el monitor de serie
}

void loop() {
  analogVal = analogRead(analogPin); // Con analogRead, leemos la entrada de los pines analógicos de este caso A0 (0-1023)
  V2 = (5.*analogVal)/1023.; // Así pasamos las medidas de 0-1023 a voltios
  Serial.println(V2); // Imprimimos por el monitor de serie el contenido de la variable V2 // Los puntos como "1023." permiten los decimales en los resultados 
  delay(dt);

}
