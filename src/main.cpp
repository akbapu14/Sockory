#include <Arduino.h>
#include <SoftwareSerial.h>

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
unsigned int timeout = 0;
unsigned char state = 0;
void cleantime() {
  timeout = 0;
  state = 0;
}
ISR(TIMER2_OVF_vect) {
  TCNT2 = 0;
  timeout++;
  if (timeout > 61) {
    state = 1;
    timeout = 0;
  }
}
void init_timer2(void) {
  TCCR2A |= (1 << WGM21) | (1 << WGM20);
  TCCR2B |= 0x07;     // by clk/1024
  ASSR |= (0 << AS2); // Use internal clock - external clock not used in Arduino
  TIMSK2 |= 0x01;     // Timer2 Overflow Interrupt Enable
  TCNT2 = 0;
  sei();
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int startSensor = A0;
int totalSensors = 5;


void setup() {
  Serial.begin(9600);

  for (int i = startSensor; i < startSensor + totalSensors; i++) {
    pinMode(i, INPUT);
  }

  attachInterrupt(0, cleantime, FALLING);
  init_timer2();
}

void loop() {
  Serial.print("[");
  for (int i = startSensor; i < startSensor + totalSensors; i++) {
    Serial.print(analogRead(A0));
    if (i < startSensor + totalSensors - 1) {
      Serial.print(", ");
    }
  }
  Serial.println("]");

  delay(20);
}

// #include <Arduino.h>
// #include <SoftwareSerial.h>
//
// void setup() {
//   Serial.begin(9600);
// }
//
// // the loop routine runs over and over again forever:
// void loop() {
//   // read the input on analog pin 0:
//   int sensorValue = analogRead(A0);
//   // print out the value you read:
//   Serial.println(sensorValue);
//   delay(1);
// }
