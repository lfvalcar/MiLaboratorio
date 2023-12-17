// PRÁCTICA
// Al inicio el led apagado
// botón pulsador de la derecha sube intensidad de la luz del led
// botón pulsador de la izquierda baja la intensidad de la luz del led
// Cuando de llegue al mínimo o máximo de intensidad el zumbador suena
// Cuando el valor del brllo no puede ser menor de 0 ni mayor de 255

// COMPONENTES
// 3 resistencias
// 2 botones pulsadores
// 1 zumbador activo
// 1 led

// VARIABLES GLOBALES
int ledBlue = 3;
int buzzer = 9;
int buttonUp = 5;
int buttonDown = 6;
int buttonUpState;
int buttonDownState;
int brightness = 0;
int dt = 100;
int buzzDT = 300;

void setup() {
    Serial.begin(9600);
    pinMode(ledBlue,OUTPUT);
    pinMode(buzzer,OUTPUT);
    pinMode(buttonUp,INPUT);
    pinMode(buttonDown,INPUT);
}

void loop() {
    Serial.print("Brillo: ");
    Serial.println(brightness);
    Serial.print("Up: ");
    Serial.println(buttonUpState);
    Serial.print("Down: ");
    Serial.println(buttonDownState);
    buttonDownState = analogRead(buttonDown);
    buttonUpState = analogRead(buttonUp);

    if (buttonDownState == 0 && brightness > 0){
        brightness = brightness - 15;
        analogWrite(ledBlue,brightness);
    }

    if (brightness == 0){
        digitalWrite(buzzer,1);
        delay(buzzDT);
        digitalWrite(buzzer,0);
    }

    if (buttonUpState == 0 && brightness < 255){
        brightness = brightness + 15;
        analogWrite(ledBlue,brightness);
    }

    if (brightness == 255){
        digitalWrite(buzzer,1);
        delay(buzzDT);
        digitalWrite(buzzer,0);
    }

    delay(dt);
}
