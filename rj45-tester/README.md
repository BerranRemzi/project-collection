# RJ45 Ethernet Cable Tester

A simple and effective firmware solution for testing Ethernet cables using the CH32V003F4P6 microcontroller. This project sequentially lights up LEDs to verify each wire in an RJ45 connector, helping identify cable faults and connection issues.

## Overview

This firmware creates an automated cable tester that cycles through each of the 8 pins in an RJ45 Ethernet connector, lighting up corresponding LEDs one at a time. This sequential testing approach makes it easy to:

- **Identify broken wires**: If an LED doesn't light when its pin is activated
- **Detect short circuits**: If multiple LEDs light up simultaneously  
- **Find open circuits**: If there's no continuity on specific wires
- **Verify correct wiring**: Ensure proper pin-to-pin connections

## Hardware Requirements

### Microcontroller
- **CH32V003F4P6** (or compatible CH32V series microcontroller)
- 8 configurable I/O pins for LED control

### External Components
- **8 LEDs** (any color, typically green for good visibility)
- **8 current limiting resistors** (220Ω - 470Ω recommended)
- **RJ45 connector** for cable attachment
- **Breadboard or PCB** for connections
- **Power supply** (5V or 3.3V depending on LED specifications)

### Pin Connections

The firmware uses these specific pins on the CH32V003F4P6:

| LED Index | Pin    | RJ45 Pin | Wire Color    |
|-----------|--------|----------|---------------|
| 0         | PC4    | 1        | White-Orange  |
| 1         | PC3    | 2        | Orange        |
| 2         | PC2    | 3        | White-Green   |
| 3         | PC1    | 4        | Blue          |
| 4         | PC0    | 5        | White-Blue    |
| 5         | PA2    | 6        | Green         |
| 6         | PA1    | 7        | White-Brown   |
| 7         | PD6    | 8        | Brown         |

## Features

### Sequential Testing
- Cycles through all 8 pins automatically
- 200ms display time per pin
- 500ms pause between complete test cycles
- Visual feedback through LED indicators

### Fault Detection
The tester helps identify these common cable issues:

| Fault Type | Symptoms | LED Behavior |
|------------|----------|--------------|
| **Broken Wire** | No continuity | Corresponding LED doesn't light |
| **Short Circuit** | Multiple wires connected | Multiple LEDs light simultaneously |
| **Open Circuit** | Disconnected wire | LED remains off during its turn |
| **Wrong Wiring** | Incorrect pin connections | LEDs light in wrong sequence |

## Installation & Setup

### Prerequisites
- **PlatformIO IDE** or **Arduino IDE**
- **CH32V platform support** installed
- **USB-to-UART programmer** for firmware upload

### Build & Upload

1. **Clone or download** this project
2. **Open project** in PlatformIO or Arduino IDE
3. **Connect** your CH32V003F4P6 programmer
4. **Build** the project: `pio run`
5. **Upload** firmware: `pio device upload`

### Wiring Connections

```
CH32V003F4P6    →    Components
─────────────────────────────────
PC4 (Pin 1)     →    LED1 + Resistor → RJ45 Pin 1
PC3 (Pin 2)     →    LED2 + Resistor → RJ45 Pin 2  
PC2 (Pin 3)     →    LED3 + Resistor → RJ45 Pin 3
PC1 (Pin 4)     →    LED4 + Resistor → RJ45 Pin 4
PC0 (Pin 5)     →    LED5 + Resistor → RJ45 Pin 5
PA2 (Pin 6)     →    LED6 + Resistor → RJ45 Pin 6
PA1 (Pin 7)     →    LED7 + Resistor → RJ45 Pin 7
PD6 (Pin 8)     →    LED8 + Resistor → RJ45 Pin 8
```

## Usage Instructions

### Basic Testing Procedure

1. **Power on** the tester
2. **Insert** the Ethernet cable into the RJ45 connector
3. **Observe** the LED sequence:
   - LEDs should light one at a time in order (1→2→3→4→5→6→7→8)
   - Each LED stays lit for 200ms
   - 500ms pause between complete cycles
4. **Interpret results**:
   - **All LEDs work correctly**: Cable is good
   - **LED missing**: Broken wire or poor connection
   - **Multiple LEDs**: Short circuit between wires
   - **Wrong sequence**: Incorrect wiring

### Expected Behavior

```
Normal Operation:
LED1 (Pin 1) ─200ms─── LED2 (Pin 2) ─200ms─── LED3 (Pin 3) ...
   │                       │                       │
  OFF ──────────────────── ON ──────────────────── OFF
                        500ms pause
```

### Troubleshooting

| Problem | Possible Cause | Solution |
|---------|---------------|----------|
| No LEDs light | Power connection issue | Check power supply and connections |
| All LEDs stay on | Short circuit | Check for damaged cable or incorrect wiring |
| Intermittent operation | Loose connections | Secure all solder joints and connectors |
| Wrong pin sequence | Incorrect wiring | Verify connections match pinout table |

## Technical Details

### Firmware Architecture

```
main.cpp
├── Global Constants & Pin Definitions
├── setup() - Initialization routine  
└── loop() - Main testing cycle
    ├── activateTestLED() - LED control
    └── Timing control
```

### Timing Specifications

- **Individual LED duration**: 200ms
- **Cycle interval**: 500ms (all LEDs off)
- **Complete cycle time**: ~2.1 seconds (8 × 200ms + 500ms)

### Code Structure

- **Pin Definitions**: Clearly commented array of LED pins
- **Modular Functions**: Separate functions for LED control and timing
- **Safety Features**: Bounds checking for pin indices
- **Comments**: Comprehensive documentation throughout

## Customization Options

### Timing Adjustments

To modify LED display timing, edit these values in `main.cpp`:

```cpp
delay(200);  // Individual LED duration (increase/decrease as needed)
delay(500);  // Cycle pause time
```

### LED Sequence Control

Modify the loop in `loop()` function to:
- Test in reverse order
- Random sequence testing  
- Custom timing patterns

### Pin Reassignment

Change the `LED_PINS` array to use different microcontroller pins:

```cpp
const uint8_t LED_PINS[RJ45_PIN_COUNT] = {
  NEW_PIN_1, NEW_PIN_2, // ... etc
};
```

## Contributing

This is a simple utility project, but improvements are welcome:

- Additional test patterns
- Enhanced fault detection algorithms
- Support for other RJ45 variations
- User interface improvements
- Documentation enhancements

## License

This project is released under the MIT License - feel free to use, modify, and distribute as needed.

## Support

For issues or questions:
- Check the troubleshooting section above
- Verify all connections match the pinout table
- Ensure proper power supply (5V recommended)
- Test with a known-good cable first

---

**Note**: This firmware is designed specifically for the CH32V003F4P6 microcontroller. Porting to other platforms may require pin reassignment and timing adjustments.