#include <Arduino.h>

#define PIN_COUNT 8
uint8_t pins[PIN_COUNT] = {PC4, PC3, PC2, PC1, PC0, PA2, PA1, PD6};

void activateLed(uint8_t index) {
  for (uint8_t i = 0; i < PIN_COUNT; i++) {
    digitalWrite(pins[i], LOW);
  }
  if (index < PIN_COUNT) {
    digitalWrite(pins[index], HIGH);
  }
}
void setup() {
  for (uint8_t i = 0; i < PIN_COUNT; i++) {
    pinMode(pins[i], OUTPUT);
    digitalWrite(pins[i], LOW);
  }
}

void loop() {
  for (uint8_t i = 0; i < PIN_COUNT; i++) {
    activateLed(i);
    delay(200);
  }
  activateLed(PIN_COUNT);  // Turn off all LEDs
  delay(500);
}
