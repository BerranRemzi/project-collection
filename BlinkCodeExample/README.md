# BlinkCode - LED Data Communication Library

BlinkCode is a professional Arduino library that enables data transmission using single LED blink patterns. Perfect for embedded devices that need to export data through visual LED signals.

## 🎯 **Use Case: Data Export via LED**

**Primary Purpose**: Transmit data from embedded devices to external observers using LED blink counts and patterns.

### **Real-World Applications**
- **IoT Sensors**: Transmit sensor readings without wired communication
- **Status Monitoring**: Report device health and operation modes
- **Remote Configuration**: Send configuration values or status codes
- **Debugging**: Visual data export during development and testing
- **Asset Tracking**: Simple identification codes for tagged items

## 🚀 **Quick Start**

### **Basic Data Transmission**
```cpp
#include "BlinkCode.h"

void setup() {
    // Initialize with default settings
    BlinkCode_Init(NULL);
}

void loop() {
    // Send data value 42 (blink LED 42 times)
    BlinkCode_SendData(42U, 300U);
    delay(5000); // Wait 5 seconds
}
```

### **Configurable Data Transmission**
```cpp
#include "BlinkCode.h"

void setup() {
    // Custom LED configuration
    LedConfig_t config = {
        .pin = 13,
        .active_high = 1,
        .blink_delay_ms = 200
    };
    BlinkCode_Init(&config);
}

void loop() {
    // Transmit sensor reading
    int sensor_value = analogRead(A0);
    uint16_t encoded_value = (uint16_t)(sensor_value / 5); // Scale to reasonable range
    
    BlinkCode_SendData(encoded_value, 250U);
    delay(10000);
}
```

## 📊 **Data Encoding Concept**

BlinkCode uses the principle of **blink count = data value**:

| Data Value | Blink Pattern | Meaning |
|------------|---------------|---------|
| 1 | ● | Single blink - minimal data |
| 3 | ● ● ● | Error code or special indicator |
| 42 | ●● (42 times) | Sensor reading, counter value |
| 255 | ●● (255 times) | Maximum value transmission |

### **Data Range Support**
- **Minimum**: 1 blink (data value 1)
- **Maximum**: 1000 blinks (data value 1000)
- **Recommended Range**: 1-255 blinks (fits in single byte)

## 🔧 **API Reference**

### **Core Functions**

#### `BlinkCode_Init(config)`
Initialize the communication system.

**Parameters:**
- `config`: LED configuration (NULL for defaults)

**Returns:** `BlinkCodeResult_t` - Operation status

#### `BlinkCode_SendData(data, delay_ms)`
Send data using LED blink pattern.

**Parameters:**
- `data`: Data value to transmit (1-1000)
- `delay_ms`: Delay between blinks in milliseconds

**Returns:** `BlinkCodeResult_t` - Operation status

**Example Usage:**
```cpp
BlinkCode_SendData(123U, 300U); // Send value 123
```

#### `BlinkCode_Task()`
Process pending transmissions.

**Usage:** Call periodically in main loop.

### **Monitoring Functions**

#### `BlinkCode_IsTransmitting()`
Check if LED is currently transmitting.

**Returns:** `1` if transmitting, `0` if idle

#### `BlinkCode_GetPendingCount()`
Get queued transmission count.

**Returns:** Number of pending operations (0-10)

## ⚙️ **Configuration Options**

### **LedConfig_t Structure**
```cpp
typedef struct {
    uint8_t pin;              // LED pin (default: LED_BUILTIN)
    uint8_t active_high;      // LED logic (1=HIGH, 0=LOW)
    uint32_t blink_delay_ms;  // Default blink delay
} LedConfig_t;
```

### **Timing Constants**
```cpp
#define BLINKCODE_BUFFER_SIZE      10U   // Max queued transmissions
#define BLINKCODE_DEFAULT_DELAY    250U  // Default delay (ms)
#define BLINKCODE_CHECK_INTERVAL   25U   // Processing interval (ms)
```

## 🔌 **Hardware Setup**

### **Minimal Setup**
- **LED**: Built-in LED (pin 13) or external LED with 220Ω resistor
- **Microcontroller**: Arduino Nano/Uno or compatible

### **External LED Setup**
```cpp
LedConfig_t custom_config = {
    .pin = 6,                    // External LED pin
    .active_high = 1,            // Common anode LED
    .blink_delay_ms = 300        // Custom timing
};
```

## 📋 **Practical Examples**

### **Temperature Sensor Transmitter**
```cpp
#include "BlinkCode.h"

void setup() {
    BlinkCode_Init(NULL);
    Serial.begin(9600);
}

void loop() {
    int temp = readTemperature(); // Your sensor function
    
    // Convert to reasonable blink count (20-40°C = 20-40 blinks)
    uint16_t temp_blinks = (uint16_t)temp;
    
    Serial.print("Sending temperature: ");
    Serial.print(temp);
    Serial.print("°C (");
    Serial.print(temp_blinks);
    Serial.println(" blinks)");
    
    BlinkCode_SendData(temp_blinks, 400U);
    delay(30000); // Send every 30 seconds
}
```

### **Device Status Monitor**
```cpp
void loop() {
    uint8_t status = getDeviceStatus(); // Your status function
    
    switch(status) {
        case 0: BlinkCode_SendData(1U, 200U); break;   // Normal: 1 blink
        case 1: BlinkCode_SendData(3U, 200U); break;   // Warning: 3 blinks
        case 2: BlinkCode_SendData(5U, 200U); break;   // Error: 5 blinks
    }
    
    delay(5000);
}
```

### **Counter/Identifier Transmission**
```cpp
void loop() {
    static uint16_t counter = 0;
    
    // Send device ID or counter
    BlinkCode_SendData(counter % 100, 300U);
    counter++;
    
    delay(10000); // Every 10 seconds
}
```

## 📈 **Transmission Queue**

BlinkCode supports queuing multiple transmissions:

```cpp
// Queue several data values
BlinkCode_SendData(1U, 300U);   // First transmission
BlinkCode_SendData(42U, 300U);  // Queued
BlinkCode_SendData(255U, 300U); // Queued

// They will be transmitted sequentially
// Check transmission status
if (BlinkCode_IsTransmitting()) {
    // LED is busy transmitting queued data
}
```

## 🔍 **Monitoring & Debugging**

```cpp
void debugBlinkCode() {
    Serial.print("Pending transmissions: ");
    Serial.println(BlinkCode_GetPendingCount());
    
    Serial.print("Current state: ");
    switch(BlinkCode_GetState()) {
        case LED_STATE_IDLE: Serial.println("IDLE"); break;
        case LED_STATE_ON: Serial.println("TRANSMITTING"); break;
        case LED_STATE_WAIT: Serial.println("WAITING"); break;
        default: Serial.println("UNKNOWN"); break;
    }
}
```

## ⚡ **Performance Characteristics**

- **Data Rate**: ~0.5-2 data values per second (depending on blink timing)
- **Memory Usage**: ~200 bytes RAM
- **CPU Usage**: < 1% during normal operation
- **Transmission Delay**: < 5ms from SendData call to first blink

## 🛡️ **Error Handling**

```cpp
BlinkCodeResult_t result = BlinkCode_SendData(100U, 300U);

switch(result) {
    case BLINKCODE_RESULT_SUCCESS:
        Serial.println("Data queued for transmission");
        break;
    case BLINKCODE_RESULT_FULL:
        Serial.println("Transmission queue full");
        break;
    case BLINKCODE_RESULT_ERROR:
        Serial.println("Invalid parameters");
        break;
}
```

## 🔄 **Data Decoding Guide**

For observers receiving data via LED blinks:

1. **Count Blinks**: Count total number of blinks in sequence
2. **Extract Value**: The blink count equals the data value
3. **Timing Note**: Long pauses between sequences indicate separate transmissions

## 📝 **Best Practices**

### **Data Selection**
- Keep values between 1-255 for practical viewing
- Use scaling for large sensor values
- Reserve special values (1, 3, 5, 255) for status codes

### **Timing Optimization**
- Use 200-500ms delays for clear visibility
- Adjust based on observer reaction time
- Longer delays for complex data patterns

### **Queue Management**
- Monitor `BlinkCode_GetPendingCount()` to avoid overflow
- Use `BlinkCode_ClearQueue()` for emergency stops
- Space transmissions appropriately

## 🎓 **Learning Examples**

**Simple Counter**: Transmit incrementing values  
**Sensor Dashboard**: Regular environmental data  
**Status Panel**: Device health monitoring  
**Asset Tracker**: Unique identification codes  
**Debug Tool**: Variable value visualization  

---

**BlinkCode** - Simple, reliable LED data communication for embedded systems.