#include "mcc.h"

#define ENABLE_OUTPUT_ON_INIT false
#define TIMER_FLASH_ADDRESS (END_FLASH - 1u - ERASE_FLASH_BLOCKSIZE)

enum {
    TIMER_VALUE,
    TIMER_PRESCALER,
    TIMER_COMPARE_VALUE,
    TIMER_PARAM_SIZE
} Timer_Param_t;

/* Define the possible states of the system */
typedef enum {
    IDLE_STATE,
    PRESCALER_ADJUST_STATE,
    TIMER_VALUE_ADJUST_STATE,
    PWM_OUTPUT_STATE,
    SAVE_STATE
} State_t;

/*
 Main application
 */
void main(void) {
    /* initialize the device */
    SYSTEM_Initialize();

    /* Initialize the state machine to the idle state */
    State_t currentState = IDLE_STATE;

    uint8_t timer[TIMER_PARAM_SIZE];
    uint8_t lastTimerValue = 255;

    bool lastValue = LOW;

    while (1) {
        bool currentValue = Dio_ChannelRead(PWM_INPUT);
        bool risingEdge = (currentValue == HIGH) && (lastValue == LOW) ? true : false;

        switch (currentState) {
        case IDLE_STATE:
            if (currentValue == LOW) {
                currentState = PWM_OUTPUT_STATE;
                Flash_Read(TIMER_FLASH_ADDRESS, timer, sizeof(timer));

                Tmr_ClkDivSet(timer[TIMER_PRESCALER], TMR0);
                Tmr_WriteTimer(TMR0, timer[TIMER_VALUE]);
                Tmr_Init(TMR0);
            } else {
                Tmr_Reload(TMR0);
                currentState = PRESCALER_ADJUST_STATE;
            }
            break;

        case PRESCALER_ADJUST_STATE:
            if (risingEdge == true) {
#if ENABLE_OUTPUT_ON_INIT == true
                Dio_ChannelToggle(PWM_OUTPUT);
#endif /* ENABLE_OUTPUT_ON_INIT */
                if (Tmr_HasOverflowOccured(TMR0) == true) {
                    currentState = TIMER_VALUE_ADJUST_STATE;

                    timer[TIMER_PRESCALER]++;
                } else {
                    timer[TIMER_PRESCALER]--;
                }
                Tmr_ClkDivSet(timer[TIMER_PRESCALER], TMR0);
                Tmr_Reload(TMR0);
            }
            break;

        case TIMER_VALUE_ADJUST_STATE:
            if (risingEdge == true) {
                if (Tmr_HasOverflowOccured(TMR0)) {
#if ENABLE_OUTPUT_ON_INIT == true
                    Dio_ChannelToggle(PWM_OUTPUT);
#endif /* ENABLE_OUTPUT_ON_INIT */
                    Tmr_Init(TMR0);
                } else {
                    timer[TIMER_VALUE]++;
                }

                if (timer[TIMER_VALUE] == lastTimerValue) {
                    currentState = SAVE_STATE;

                    uint8_t timerValueInv = (uint8_t)(~timer[TIMER_VALUE]);
                    uint8_t adc = (Adc_GetConversion(PWM_LIMIT) * timerValueInv) >> 8u;
                    timer[TIMER_COMPARE_VALUE] = (uint8_t)(timer[TIMER_VALUE] + adc);
                }
                lastTimerValue = timer[TIMER_VALUE];
                Tmr_WriteTimer(TMR0, timer[TIMER_VALUE]);
            }
            break;

        case SAVE_STATE:
            currentState = PWM_OUTPUT_STATE;

            /* Write timer[TIMER_PRESCALER], timer[TIMER_VALUE], timer[TIMER_COMPARE_VALUE] to FLASH */
            Flash_Write(TIMER_FLASH_ADDRESS, timer, sizeof(timer));
            break;

        case PWM_OUTPUT_STATE:
            if ((currentValue == HIGH) && (Tmr_ReadTimer(TMR0) < timer[TIMER_COMPARE_VALUE])) {
                Dio_ChannelWrite(PWM_OUTPUT, HIGH);
            } else {
                Dio_ChannelWrite(PWM_OUTPUT, LOW);
            }

            if(currentValue == LOW){
                Tmr_Reload(TMR0);
            }

            if (Tmr_HasOverflowOccured(TMR0)) {
                Tmr_Init(TMR0);
            }
            break;

        default:
            break;
        }
        lastValue = currentValue;
    }
}
/**
 End of File
 */
