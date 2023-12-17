int ledGreen = 3;
int ledRed = 5;
int ledBlue = 6;
String msg1 = "Escribe un color de led (ROJO|VERDE|AZUL): ";
String color;

void setup() {
  Serial.begin(9600);
  pinMode(ledGreen,OUTPUT);
  pinMode(ledBlue,OUTPUT);
  pinMode(ledRed,OUTPUT);

}

void loop() {
  Serial.println(msg1);

  while (Serial.available() == 0){
      
  }

  color = Serial.readString();

  if (color == "AZUL" || color == "azul"){
      digitalWrite(ledGreen,LOW);
      digitalWrite(ledRed,LOW);
      digitalWrite(ledBlue,HIGH);
    }

   if (color == "ROJO" || color == "rojo"){
      digitalWrite(ledGreen,LOW);
      digitalWrite(ledRed,HIGH);
      digitalWrite(ledBlue,LOW);
    }

    if (color == "VERDE" || color == "verde"){
      digitalWrite(ledGreen,HIGH);
      digitalWrite(ledRed,LOW);
      digitalWrite(ledBlue,LOW);
    }

}
