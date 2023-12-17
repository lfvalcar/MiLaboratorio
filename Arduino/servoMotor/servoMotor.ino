// INCLUDES
#include <Servo.h>

// VARIABLES GLOBALES
int servoPin = 9;
float servoPos;
int lightPin = A1;
int lightVal;
int dt = 100;
Servo myServo;



void setup(){
    Serial.begin(9600);
    myServo.attach(servoPin);
    pinMode(lightPin,INPUT);
}

void loop(){
    lightVal = analogRead(lightPin);
    Serial.println(lightVal);
    servoPos = (170./500.) * (lightVal - 500.)
    myServo.write(servoPos);
}
