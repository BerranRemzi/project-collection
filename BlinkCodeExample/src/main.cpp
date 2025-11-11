#include <Arduino.h>
#include "BlinkCode.h"

// Configuration constants
#define BLINKCODE_INTERVAL_MS       125U   /**< Task execution interval in milliseconds */
#define TASK_PERIOD_MS              5U     /**< Main loop delay in milliseconds */
#define BUTTON_DEBOUNCE_DELAY_MS    50U    /**< Debounce delay for button inputs */
#define INPUT_PIN_BUTTON_1          2U     /**< First button input pin */
#define INPUT_PIN_BUTTON_2          3U     /**< Second button input pin */

// Button states structure
typedef struct
{
    uint8_t current_state;      /**< Current button reading */
    uint8_t previous_state;     /**< Previous stable button reading */
    uint8_t debounce_counter;   /**< Debounce counter */
    uint8_t is_stable;          /**< Flag indicating stable reading */
} ButtonState_t;

// Global button state tracking
static ButtonState_t button1_state = {0};
static ButtonState_t button2_state = {0};

/**
 * @brief Initialize button input pins and states
 * @param button Pointer to button state structure
 * @param pin Pin number to initialize
 */
static void InitializeButton(ButtonState_t* button, uint8_t pin)
{
    pinMode(pin, INPUT);
    button->current_state = digitalRead(pin);
    button->previous_state = button->current_state;
    button->debounce_counter = 0U;
    button->is_stable = 1U; // Assume initial state is stable
}

/**
 * @brief Debounce button input with proper state management
 * @param button Pointer to button state structure
 * @param pin Pin number to read
 * @return uint8_t 1 if button just became pressed (rising edge), 0 otherwise
 */
static uint8_t DebounceButton(ButtonState_t* button, uint8_t pin)
{
    button->current_state = digitalRead(pin);
    
    // If button state changed, reset debounce counter
    if (button->current_state != button->previous_state)
    {
        button->debounce_counter = 0U;
        button->is_stable = 0U;
    }
    else
    {
        // State is stable, increment counter
        button->debounce_counter++;
        
        // If debounce threshold reached, mark as stable
        if (button->debounce_counter >= BUTTON_DEBOUNCE_DELAY_MS / TASK_PERIOD_MS)
        {
            button->is_stable = 1U;
        }
    }
    
    // Return 1 if button just became pressed (stable HIGH from stable LOW)
    uint8_t result = 0U;
    if ((button->is_stable) && 
        (button->current_state == HIGH) && 
        (button->previous_state == LOW))
    {
        result = 1U;
    }
    
    button->previous_state = button->current_state;
    return result;
}

void setup()
{
    // Initialize BlinkCode system with default configuration
    BlinkCode_Init(NULL);
    
    // Initialize button input handling
    InitializeButton(&button1_state, INPUT_PIN_BUTTON_1);
    InitializeButton(&button2_state, INPUT_PIN_BUTTON_2);
}

void loop()
{
    // Handle button inputs with debouncing
    uint8_t button1_pressed = DebounceButton(&button1_state, INPUT_PIN_BUTTON_1);
    uint8_t button2_pressed = DebounceButton(&button2_state, INPUT_PIN_BUTTON_2);
    
    // Process button press events - transmit data using BlinkCode
    if (button1_pressed)
    {
        // Send data value 1 (blink once)
        BlinkCode_SendData(1U, 0U);
    }
    
    if (button2_pressed)
    {
        // Send data value 3 (blink three times)
        BlinkCode_SendData(3U, 0U);
    }
    
    // Example: Send sensor data or status information
    // This demonstrates the main use case of BlinkCode for data transmission
    static uint16_t counter = 0U;
    counter++;
    
    // Every 10 seconds, send a sample data value
    if (counter >= (10000U / TASK_PERIOD_MS))
    {
        BlinkCode_SendData(42U, 300U); // Send data value 42 with custom timing
        counter = 0U;
    }
    
    // Implement timed task execution for BlinkCode processing
    static uint16_t tick_counter = 0U;
    tick_counter++;
    
    // Execute BlinkCode task at configured interval
    if (tick_counter >= (BLINKCODE_INTERVAL_MS / TASK_PERIOD_MS))
    {
        BlinkCode_Task();
        tick_counter = 0U;
    }
    
    // Maintain consistent timing
    delay(TASK_PERIOD_MS);
}
