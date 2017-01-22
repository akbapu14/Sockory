#include <Arduino.h>
#include <SoftwareSerial.h>

int startSensor = A0;
int endSensor = A5;

void setup() {
  Serial.begin(9600);

  for (int i = startSensor; i <= endSensor; i++) {
    pinMode(i, INPUT);
  }
}

void loop() {
  Serial.print("[");
  for (int i = startSensor; i <= endSensor; i++) {
    Serial.print(analogRead(i));
    if (i < endSensor) {
      Serial.print(", ");
    }
  }
  Serial.println("]");

  delay(20);
}
