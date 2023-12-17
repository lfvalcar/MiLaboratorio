float area;
float pi = 3.1415;
int rad = 3;
int wait = 500;
String mensaje1 = "El area de un circulo con radio de ";
String mensaje2 = " es de: ";


void setup() {
  Serial.begin(9600);
}

void loop() {
  
  area = pi * rad * rad;
  
  // Serial.print(i); Imprime todo en la misma línea
  // Serial.println(i); Imprime todo en diferentes líneas
  
  Serial.print(mensaje1);
  Serial.print(rad);
  Serial.print(mensaje2);
  Serial.println(area);
  delay(wait);
  
  rad++; // rad = rad + 1;

}
