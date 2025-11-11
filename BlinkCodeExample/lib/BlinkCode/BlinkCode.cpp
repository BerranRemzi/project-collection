#include "BlinkCode.h"
#include <Arduino.h>

// Private constants
#define LED_BLINK_TIME_MS           200U   /**< Duration LED stays on/off during blink */
#define LED_MIN_DELAY_MS            10U    /**< Minimum delay value */
#define LED_MAX_DELAY_MS            10000U /**< Maximum delay value */

// Ring buffer structure for blink commands
typedef struct
{
    uint16_t blink_count;           /**< Number of blinks to execute */
    uint32_t blink_delay_ms;        /**< Delay between blinks */
    uint16_t remaining_count;       /**< Remaining blinks to execute */
} BlinkCommand_t;

typedef struct
{
    BlinkCommand_t commands[BLINKCODE_BUFFER_SIZE];  /**< Command buffer array */
    uint8_t head_index;                         /**< Head index for adding new commands */
    uint8_t tail_index;                         /**< Tail index for removing commands */
    uint8_t command_count;                      /**< Number of commands in buffer */
    uint8_t is_full;                           /**< Buffer full flag */
} CommandBuffer_t;

// LED control state machine
typedef struct
{
    LedState_t current_state;                  /**< Current state of LED state machine */
    uint32_t state_timer_ms;                   /**< Timer for state transitions */
    BlinkCommand_t* current_command;           /**< Pointer to currently executing command */
    uint16_t blink_phase;                      /**< Current blink phase (on/off) */
    uint32_t blink_timer_ms;                   /**< Timer for blink timing */
} LedStateMachine_t;

// Global LED control variables
static LedStateMachine_t led_state_machine = {0};
static CommandBuffer_t command_buffer = {0};
static LedConfig_t led_configuration = {0};

// Private function prototypes
static void InitializeCommandBuffer(CommandBuffer_t* buffer);
static void InitializeLedStateMachine(LedStateMachine_t* state_machine);
static BlinkCodeResult_t AddCommandToBuffer(CommandBuffer_t* buffer, uint16_t count, uint32_t delay_ms);
static BlinkCommand_t* GetNextCommand(CommandBuffer_t* buffer);
static void ProcessLedStateMachine(LedStateMachine_t* state_machine);
static void SetLedState(LedState_t state);
static uint8_t ValidateBlinkParameters(uint16_t count, uint32_t delay_ms);
static uint32_t ClampDelayValue(uint32_t delay_ms);

// Public API Implementation

BlinkCodeResult_t BlinkCode_Init(const LedConfig_t* config)
{
    // Initialize with default configuration if none provided
    if (config == NULL)
    {
        led_configuration.pin = LED_BUILTIN;
        led_configuration.active_high = 1U;
        led_configuration.blink_delay_ms = BLINKCODE_DEFAULT_DELAY;
    }
    else
    {
        led_configuration = *config;
    }
    
    // Validate configuration
    if ((led_configuration.pin > 255U) || 
        (led_configuration.blink_delay_ms < LED_MIN_DELAY_MS) ||
        (led_configuration.blink_delay_ms > LED_MAX_DELAY_MS))
    {
        return BLINKCODE_RESULT_ERROR;
    }
    
    // Initialize hardware
    pinMode(led_configuration.pin, OUTPUT);
    digitalWrite(led_configuration.pin, led_configuration.active_high ? LOW : HIGH);
    
    // Initialize internal structures
    InitializeCommandBuffer(&command_buffer);
    InitializeLedStateMachine(&led_state_machine);
    
    return BLINKCODE_RESULT_SUCCESS;
}

void BlinkCode_Task(void)
{
    ProcessLedStateMachine(&led_state_machine);
}

BlinkCodeResult_t BlinkCode_SendData(uint16_t data, uint32_t delay_ms)
{
    // Validate input parameters
    if (!ValidateBlinkParameters(data, delay_ms))
    {
        return BLINKCODE_RESULT_ERROR;
    }
    
    // Add command to buffer
    BlinkCodeResult_t result = AddCommandToBuffer(&command_buffer, data, delay_ms);
    
    // If this is the first command, start state machine
    if ((result == BLINKCODE_RESULT_SUCCESS) && (led_state_machine.current_state == LED_STATE_IDLE))
    {
        led_state_machine.current_command = GetNextCommand(&command_buffer);
        if (led_state_machine.current_command != NULL)
        {
            SetLedState(LED_STATE_ON);
        }
    }
    
    return result;
}

BlinkCodeResult_t BlinkCode_SendBlink(uint8_t count)
{
    return BlinkCode_SendData(count, BLINKCODE_DEFAULT_DELAY);
}

BlinkCodeResult_t BlinkCode_Toggle(void)
{
    digitalWrite(led_configuration.pin, !digitalRead(led_configuration.pin));
    return BLINKCODE_RESULT_SUCCESS;
}

BlinkCodeResult_t BlinkCode_On(void)
{
    digitalWrite(led_configuration.pin, led_configuration.active_high ? HIGH : LOW);
    return BLINKCODE_RESULT_SUCCESS;
}

BlinkCodeResult_t BlinkCode_Off(void)
{
    digitalWrite(led_configuration.pin, led_configuration.active_high ? LOW : HIGH);
    return BLINKCODE_RESULT_SUCCESS;
}

LedState_t BlinkCode_GetState(void)
{
    return led_state_machine.current_state;
}

uint8_t BlinkCode_IsTransmitting(void)
{
    return (led_state_machine.current_state != LED_STATE_IDLE) ? 1U : 0U;
}

BlinkCodeResult_t BlinkCode_ClearQueue(void)
{
    InitializeCommandBuffer(&command_buffer);
    SetLedState(LED_STATE_IDLE);
    return BLINKCODE_RESULT_SUCCESS;
}

uint8_t BlinkCode_GetPendingCount(void)
{
    return command_buffer.command_count;
}

// Private function implementations

static void InitializeCommandBuffer(CommandBuffer_t* buffer)
{
    buffer->head_index = 0U;
    buffer->tail_index = 0U;
    buffer->command_count = 0U;
    buffer->is_full = 0U;
    
    // Initialize all command slots to zero
    for (uint8_t i = 0U; i < BLINKCODE_BUFFER_SIZE; i++)
    {
        buffer->commands[i].blink_count = 0U;
        buffer->commands[i].blink_delay_ms = 0U;
        buffer->commands[i].remaining_count = 0U;
    }
}

static void InitializeLedStateMachine(LedStateMachine_t* state_machine)
{
    state_machine->current_state = LED_STATE_IDLE;
    state_machine->state_timer_ms = 0U;
    state_machine->current_command = NULL;
    state_machine->blink_phase = 0U;
    state_machine->blink_timer_ms = 0U;
}

static BlinkCodeResult_t AddCommandToBuffer(CommandBuffer_t* buffer, uint16_t count, uint32_t delay_ms)
{
    if (buffer->command_count >= BLINKCODE_BUFFER_SIZE)
    {
        return BLINKCODE_RESULT_FULL;
    }
    
    // Store command at head index
    buffer->commands[buffer->head_index].blink_count = count;
    buffer->commands[buffer->head_index].blink_delay_ms = delay_ms;
    buffer->commands[buffer->head_index].remaining_count = count;
    
    // Update head index and count
    buffer->head_index = (buffer->head_index + 1U) % BLINKCODE_BUFFER_SIZE;
    buffer->command_count++;
    
    // Check if buffer is now full
    if (buffer->command_count >= BLINKCODE_BUFFER_SIZE)
    {
        buffer->is_full = 1U;
    }
    
    return BLINKCODE_RESULT_SUCCESS;
}

static BlinkCommand_t* GetNextCommand(CommandBuffer_t* buffer)
{
    if (buffer->command_count == 0U)
    {
        return NULL;
    }
    
    BlinkCommand_t* command = &buffer->commands[buffer->tail_index];
    buffer->tail_index = (buffer->tail_index + 1U) % BLINKCODE_BUFFER_SIZE;
    buffer->command_count--;
    buffer->is_full = 0U;
    
    return command;
}

static void ProcessLedStateMachine(LedStateMachine_t* state_machine)
{
    switch (state_machine->current_state)
    {
        case LED_STATE_IDLE:
            // Check for new commands to process
            if (state_machine->current_command == NULL)
            {
                state_machine->current_command = GetNextCommand(&command_buffer);
                if (state_machine->current_command != NULL)
                {
                    SetLedState(LED_STATE_ON);
                    state_machine->blink_timer_ms = 0U;
                }
            }
            break;
            
        case LED_STATE_ON:
            // LED is currently on, wait for blink duration
            state_machine->blink_timer_ms += BLINKCODE_CHECK_INTERVAL;
            
            if (state_machine->blink_timer_ms >= LED_BLINK_TIME_MS)
            {
                SetLedState(LED_STATE_OFF);
                state_machine->blink_timer_ms = 0U;
                state_machine->blink_phase++;
                
                // Check if this blink is complete
                if (state_machine->blink_phase >= state_machine->current_command->remaining_count)
                {
                    // Move to wait state before processing next command
                    SetLedState(LED_STATE_WAIT);
                    state_machine->state_timer_ms = 0U;
                }
            }
            break;
            
        case LED_STATE_OFF:
            // LED is currently off, wait before next blink
            state_machine->blink_timer_ms += BLINKCODE_CHECK_INTERVAL;
            
            if (state_machine->blink_timer_ms >= state_machine->current_command->blink_delay_ms)
            {
                SetLedState(LED_STATE_ON);
                state_machine->blink_timer_ms = 0U;
            }
            break;
            
        case LED_STATE_WAIT:
            // Wait between commands or when buffer is empty
            state_machine->state_timer_ms += BLINKCODE_CHECK_INTERVAL;
            
            if (state_machine->state_timer_ms >= LED_BLINK_TIME_MS)
            {
                // Check if there are more commands to process
                BlinkCommand_t* next_command = GetNextCommand(&command_buffer);
                if (next_command != NULL)
                {
                    // Start next command
                    state_machine->current_command = next_command;
                    state_machine->blink_phase = 0U;
                    SetLedState(LED_STATE_ON);
                    state_machine->blink_timer_ms = 0U;
                    state_machine->state_timer_ms = 0U;
                }
                else
                {
                    // No more commands, return to idle
                    SetLedState(LED_STATE_IDLE);
                    state_machine->state_timer_ms = 0U;
                }
            }
            break;
            
        default:
            // Invalid state, reset to idle
            SetLedState(LED_STATE_IDLE);
            break;
    }
}

static void SetLedState(LedState_t state)
{
    led_state_machine.current_state = state;
    
    // Execute state-specific actions
    switch (state)
    {
        case LED_STATE_ON:
            BlinkCode_On();
            break;
        case LED_STATE_OFF:
            BlinkCode_Off();
            break;
        case LED_STATE_IDLE:
        case LED_STATE_WAIT:
        default:
            // No immediate action needed for these states
            break;
    }
}

static uint8_t ValidateBlinkParameters(uint16_t count, uint32_t delay_ms)
{
    // Validate blink count (must be > 0 and reasonable)
    if ((count == 0U) || (count > 1000U))
    {
        return 0U;
    }
    
    // Validate delay
    if ((delay_ms < LED_MIN_DELAY_MS) || (delay_ms > LED_MAX_DELAY_MS))
    {
        return 0U;
    }
    
    return 1U;
}

static uint32_t ClampDelayValue(uint32_t delay_ms)
{
    if (delay_ms < LED_MIN_DELAY_MS)
    {
        return LED_MIN_DELAY_MS;
    }
    else if (delay_ms > LED_MAX_DELAY_MS)
    {
        return LED_MAX_DELAY_MS;
    }
    else
    {
        return delay_ms;
    }
}