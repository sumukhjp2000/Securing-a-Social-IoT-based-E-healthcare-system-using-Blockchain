#include <SoftwareSerial.h>
SoftwareSerial espSerial(5, 6);
String str;
int PulseSensorPurplePin = A0;
int Signal; 
void setup(){
Serial.begin(115200);
espSerial.begin(115200);
delay(2000);
}
void loop()
{
Signal = analogRead(PulseSensorPurplePin);
Serial.print("Bpm: ");
Serial.print(Signal);
str =String("coming from arduino: ")+String("= ")+String(Signal);
espSerial.println(str);
delay(1000);
}
