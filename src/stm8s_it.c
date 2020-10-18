#include "stm8s.h"
#include "stm8s_it.h"
#include "common.h"
#include "queue.h"
#include "uart.h"

static uint8_t usec = 100;
static uint8_t msec = 100;
static uint8_t irq_flags;

uint8_t *GetTimeHandler(void) {
    return &irq_flags;
}

// TIM4 ISR (100 us)
void tim4_update(void) __interrupt (IT_TIM4_OVR_UIF) {
    TIM4->SR1 &= ~TIM4_SR1_UIF;

    // Timer 10ms
    if ( !usec-- ) {
        usec = 100;
        msec--;
        SetBit(irq_flags, 1);
    }

    // Timer 1s
    if ( !msec ) {
        msec = 100;
        SetBit(irq_flags, 2);
    }

    SetBit(irq_flags, 0);
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