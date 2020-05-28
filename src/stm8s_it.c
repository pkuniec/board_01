#include "stm8s.h"
#include "stm8s_it.h"
#include "common.h"
#include "queue.h"
#include "uart.h"

static uint8_t msec = 100;

// TIM4 ISR
void tim4_update(void) __interrupt (IT_TIM4_OVR_UIF) {
    
    TIM4->SR1 &= ~TIM4_SR1_UIF;

    if ( !msec-- ) {
        msec = 100;
    }
}


// EXTI ISR
void exti2_irq(void) __interrupt (IT_EXTI2) {
    sys_t *sys = GetSysHandler();
    uint8_t port = GPIOC->IDR;

    if( !(port & (PIN_3)) ) {
        // Faling edge on PC3 (NRF24L01 IRQ)
        SetBit(sys->flags, N_IRQ);
    } else if( !(port & (PIN_4)) ) {
        // Faling edge on PC4 (External INPUT)
        SetBit(sys->flags, E_IRQ);
    }
}