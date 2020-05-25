#include "stm8s.h"
#include "stm8s_it.h"
#include "common.h"


// TIM4 ISR
void tim4_update(void) __interrupt (IT_TIM4_OVR_UIF) {
    static uint8_t sec = 100;
    TIM4->SR1 &= ~TIM4_SR1_UIF;

    if ( !sec-- ) {
        sec = 100;
    }
}


// EXTI ISR
void exti2_irq(void) __interrupt (IT_EXTI2) {
    sys_t *sys = GetSysHeader();

    if( !(GPIOC->IDR & (PIN_3)) ) {
        // Faling edge on PC3 (NRF24L01 IRQ)
        SetBit(sys->flags, N_IRQ);
    }

    if( !(GPIOC->IDR & (PIN_4)) ) {
        // Faling edge on PC4 (External INPUT)
        SetBit(sys->flags, E_IRQ);
    }
}