#include <Arduino.h>

/**
 * RJ45 Ethernet Cable Tester - Optimized Version
 *
 * This firmware sequentially tests each wire in an RJ45 Ethernet cable by
 * lighting up corresponding LEDs one at a time. This helps identify:
 * - Broken wires
 * - Incorrect pin connections
 * - Short circuits between wires
 * - Open circuits (disconnected wires)
 *
 * Hardware Requirements:
 * - CH32V003F4P6 microcontroller (or compatible)
 * - 8 LEDs connected to the specified pins
 * - Current limiting resistors for LEDs
 * - RJ45 connector for cable testing
 */

// ============================
// CONFIGURATION CONSTANTS
// ============================

#define RJ45_PIN_COUNT 8

// Timing configuration (milliseconds)
#define LED_DISPLAY_TIME    200   // Time each LED stays on
#define CYCLE_PAUSE_TIME    500   // Pause between test cycles
#define TEST_CYCLE_COMPLETE RJ45_PIN_COUNT  // Special index for "all LEDs off"

// Standard RJ45 pinout mapping
// Pin numbers correspond to RJ45 connector pins 1-8
const uint8_t LED_PINS[RJ45_PIN_COUNT] = {
  PC4,  // Pin 1 - White-Orange
  PC3,  // Pin 2 - Orange
  PC2,  // Pin 3 - White-Green
  PC1,  // Pin 4 - Blue
  PC0,  // Pin 5 - White-Blue
  PA2,  // Pin 6 - Green
  PA1,  // Pin 7 - White-Brown
  PD6   // Pin 8 - Brown
};

/**
 * Control individual LED state with safety checks
 * @param pinIndex Index of LED to control (0-7 for individual LEDs, 8 for all off)
 */
void controlTestLED(uint8_t pinIndex) {
  // Validate input range
  if (pinIndex > RJ45_PIN_COUNT) {
    return; // Invalid index, ignore
  }
  
  // Turn off all LEDs first
  for (uint8_t i = 0; i < RJ45_PIN_COUNT; i++) {
    digitalWrite(LED_PINS[i], LOW);
  }
  
  // Turn on selected LED if valid individual pin requested
  if (pinIndex < RJ45_PIN_COUNT) {
    digitalWrite(LED_PINS[pinIndex], HIGH);
  }
  // If pinIndex == RJ45_PIN_COUNT, all LEDs stay off (cycle complete)
}

/**
 * Initialize all test hardware
 */
void setup() {
  // Initialize serial communication for debugging (optional)
  Serial.begin(115200);
  Serial.println("RJ45 Cable Tester Starting...");
  
  // Configure all LED pins as outputs and set initial state
  for (uint8_t i = 0; i < RJ45_PIN_COUNT; i++) {
    pinMode(LED_PINS[i], OUTPUT);
    digitalWrite(LED_PINS[i], LOW);
  }
  
  Serial.println("Initialization complete. Ready for testing.");
}

/**
 * Main testing cycle - continuously test RJ45 cable
 */
void loop() {
  // Test each pin sequentially
  for (uint8_t pin = 0; pin < RJ45_PIN_COUNT; pin++) {
    controlTestLED(pin);
    delay(LED_DISPLAY_TIME);
  }
  
  // Complete cycle - turn off all LEDs briefly
  controlTestLED(TEST_CYCLE_COMPLETE);
  delay(CYCLE_PAUSE_TIME);
}
