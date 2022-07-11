#include <Arduino.h> 
#if defined(ESP32)
  #include <WiFi.h>
#elif defined(ESP8266)
  #include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>
#include "addons/TokenHelper.h"
//Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"
#define DATABASE_URL  "https://health-tracker-1d38a-default-rtdb.firebaseio.com/"
#define API_KEY "AIzaSyDW8NPtWEFVk8Jkh3kOXAMV839i3-MJaYM"
#include <Adafruit_NeoPixel.h>
#define WIFI_SSID "1"
#define WIFI_PASSWORD "tocl0924"
FirebaseData fbdo;
FirebaseData fbd1;
FirebaseAuth auth;
FirebaseConfig config;
unsigned long sendDataPrevMillis = 0;
int intValue;
int intValue1;
float floatValue;
bool signupOK = false;
void setup() {
Serial.begin(115200);
pinMode(14, INPUT); // Setup for leads off detection LO +
pinMode(12, INPUT); // Setup for leads off detection LO -
 
while (!Serial) {
; 
}
Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
  

  config.api_key = API_KEY;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Sign up */
  if (Firebase.signUp(&config, &auth, "", "")) {
    Serial.println("ok");
    signupOK = true;
  }
  else {
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
 
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
             
}
void loop() { 
int ecg=0;
int bpm=0;
bpm= Serial.read();
  if((digitalRead(10) == 1)||(digitalRead(11) == 1)){
Serial.println('!');
}
else{
// send the value of analog input 0:
ecg=analogRead(A0);
//Wait for a bit to keep serial data from saturating
delay(1);
}
  if (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 2000 || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();
    if(Firebase.RTDB.getInt(&fbdo,"/bpm/int")){
      if (fbdo.dataType() == "int"){
        intValue = fbdo.intData();
        Serial.println(intValue);
      }
    }
       if(Firebase.RTDB.getInt(&fbd1, "/ecg/int")){
        if (fbd1.dataType()=="int") {
              intValue1=fbd1.intData();
                      Serial.println(intValue1);
    }
    }
    
    else {
      Serial.println(fbdo.errorReason());
      Serial.println(fbd1.errorReason());
    }
char bp[12];
if (Serial.available()) 
{
Serial.write(Serial.read());
}
 //Firebase.pushString("/vitals/BPM",bp);  
  if (Firebase.RTDB.setInt(&fbdo, "bpm/int", bpm))
  {
  if(Firebase.RTDB.setInt(&fbd1, "ecg/int", ecg)) 
  {
  Serial.println("PASSED");
  Serial.println("PATH: " + fbdo.dataPath());
  Serial.println("TYPE: " + fbdo.dataType());
    Serial.println("PATH: " + fbd1.dataPath());
  Serial.println("TYPE: " + fbd1.dataType());
  }
  }
else {
  Serial.println("FAILED");
  Serial.println("REASON: " + fbdo.errorReason());
  Serial.println("REASON: " + fbd1.errorReason());
}
}
 }
