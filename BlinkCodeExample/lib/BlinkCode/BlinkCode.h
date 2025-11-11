#ifndef BLINKCODE_H
#define BLINKCODE_H

#include <stdint.h>

// Configuration constants
#define BLINKCODE_BUFFER_SIZE        10U    /**< Maximum number of pending blink commands */
#define BLINKCODE_DEFAULT_DELAY      250U   /**< Default delay between blinks in milliseconds */
#define BLINKCODE_CHECK_INTERVAL     25U    /**< Interval for state machine updates in milliseconds */

// Type definitions
/** 
 * @brief LED states enumeration
 * @details Used to track the current LED operation state
 */
typedef enum
{
    LED_STATE_OFF,      /**< LED is currently off */
    LED_STATE_ON,       /**< LED is currently on */
    LED_STATE_WAIT,     /**< LED is waiting between blinks */
    LED_STATE_IDLE      /**< LED is idle, no operations pending */
} LedState_t;

/**
 * @brief LED configuration structure
 * @details Contains LED control configuration parameters
 */
typedef struct
{
    uint8_t pin;                 /**< GPIO pin number for LED control */
    uint8_t active_high;         /**< Pin logic level for LED on (1 = HIGH, 0 = LOW) */
    uint32_t blink_delay_ms;     /**< Delay between individual blinks */
} LedConfig_t;

/**
 * @brief LED operation result enumeration
 * @details Used to indicate success/failure of LED operations
 */
typedef enum
{
    BLINKCODE_RESULT_SUCCESS,   /**< Operation completed successfully */
    BLINKCODE_RESULT_ERROR,     /**< Operation failed */
    BLINKCODE_RESULT_FULL,      /**< Buffer is full, cannot accept more commands */
    BLINKCODE_RESULT_EMPTY      /**< No operations pending */
} BlinkCodeResult_t;

// Public API functions

/**
 * @brief Initialize the BlinkCode system
 * @param config Pointer to LED configuration structure (NULL for defaults)
 * @return BlinkCodeResult_t Operation result
 */
BlinkCodeResult_t BlinkCode_Init(const LedConfig_t* config);

/**
 * @brief Main task function for BlinkCode state machine processing
 * @details Call this function periodically to process LED operations
 */
void BlinkCode_Task(void);

/**
 * @brief Send data using LED blink pattern
 * @param data Data value to encode as blink count
 * @param delay_ms Delay between blinks in milliseconds (0 = use default)
 * @return BlinkCodeResult_t Operation result
 */
BlinkCodeResult_t BlinkCode_SendData(uint16_t data, uint32_t delay_ms);

/**
 * @brief Send simple blink sequence with default timing
 * @param count Number of times to blink
 * @return BlinkCodeResult_t Operation result
 */
BlinkCodeResult_t BlinkCode_SendBlink(uint8_t count);

/**
 * @brief Toggle LED state immediately
 * @return BlinkCodeResult_t Operation result
 */
BlinkCodeResult_t BlinkCode_Toggle(void);

/**
 * @brief Turn LED on immediately
 * @return BlinkCodeResult_t Operation result
 */
BlinkCodeResult_t BlinkCode_On(void);

/**
 * @brief Turn LED off immediately
 * @return BlinkCodeResult_t Operation result
 */
BlinkCodeResult_t BlinkCode_Off(void);

/**
 * @brief Get current LED state
 * @return LedState_t Current LED state
 */
LedState_t BlinkCode_GetState(void);

/**
 * @brief Check if LED is currently transmitting
 * @return uint8_t 1 if LED is transmitting, 0 otherwise
 */
uint8_t BlinkCode_IsTransmitting(void);

/**
 * @brief Clear all pending transmission operations
 * @return BlinkCodeResult_t Operation result
 */
BlinkCodeResult_t BlinkCode_ClearQueue(void);

/**
 * @brief Get number of pending operations in buffer
 * @return uint8_t Number of pending operations
 */
uint8_t BlinkCode_GetPendingCount(void);

#endif /* BLINKCODE_H */