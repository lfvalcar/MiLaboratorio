int pinRed = 9;
int pinBlue = 10;
int pinGreen = 11;
String question = "Que color quieres ver (rojo|verde|azul|turquesa|magenta|amarillo|naranja|blanco): ";
String color;

void setup() {
	Serial.begin(9600);
	pinMode(pinRed,OUTPUT);
	pinMode(pinBlue,OUTPUT);
	pinMode(pinGreen,OUTPUT);
}

void loop() {
	Serial.println(question);
	while (Serial.available() == 0){}
	color = Serial.readString();
	
	if (color == "rojo" || color == "ROJO"){
		digitalWrite(pinRed,HIGH);
		digitalWrite(pinBlue,LOW);
		digitalWrite(pinGreen,LOW);
	}
	else if (color == "verde" || color == "VERDE"){
		digitalWrite(pinRed,LOW);
		digitalWrite(pinBlue,LOW);
		digitalWrite(pinGreen,HIGH);
	}
	else if (color == "azul" || color == "AZUL"){
		digitalWrite(pinRed,LOW);
		digitalWrite(pinBlue,HIGH);
		digitalWrite(pinGreen,LOW);
	}
	else if (color == "turquesa" || color == "TURQUESA"){
		analogWrite(pinRed,64);
		analogWrite(pinGreen,224);
		analogWrite(pinBlue,208);
	}
	else if (color == "naranja" || color == "NARANJA"){
		digitalWrite(pinRed,HIGH);
		analogWrite(pinGreen,128);
		digitalWrite(pinBlue,LOW);
	}
	else if (color == "magenta" || color == "MAGENTA"){
		digitalWrite(pinGreen,LOW);
		digitalWrite(pinBlue,HIGH);
		digitalWrite(pinRed,HIGH);
	}
	else if (color == "amarillo" || color == "AMARILLO"){
		digitalWrite(pinRed,HIGH);
		digitalWrite(pinBlue,LOW);
		digitalWrite(pinGreen,HIGH);
	}
	else if (color == "blanco" || color == "BLANCO"){
		digitalWrite(pinRed,HIGH);
		digitalWrite(pinBlue,HIGH);
		digitalWrite(pinGreen,HIGH);
	}
}
