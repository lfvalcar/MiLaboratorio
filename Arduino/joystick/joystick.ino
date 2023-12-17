int pinX = A0;
int valX;
int pinY = A1;
int valY;
int buttonPin = 7;
int buttonVal;
int buzzPin = 8;
int dt = 100;

void setup(){
    Serial.begin(9600);
    pinMode(pinX,INPUT);
    pinMode(pinY,INPUT);
    pinMode(buttonPin,INPUT_PULLUP);
    pinMode(buzzPin,OUTPUT);
}

void loop(){
    valX = analogRead(pinX);
    valY = analogRead(pinY);
    buttonVal = digitalRead(buttonPin);
    Serial.print("Valor X = ");
    Serial.print(valX);
    Serial.print(" - Valor Y = ");
    Serial.print(valY);
    Serial.print(" - Valor boton = ");
    Serial.println(buttonVal);
    if (buttonVal == 0){
        digitalWrite(buzzPin,1);
    }else{
        digitalWrite(buzzPin,0);
    }
    delay(dt);
}
