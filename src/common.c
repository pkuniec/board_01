#include "stm8s.h"
#include "common.h"
#include "stm8s_it.h"
#include "uart.h"
#include "spi.h"
#include "nrf24l01.h"
#include "nrf24l01_mem.h"
#include "mnprot.h"
#include "modbus.h"
#include "timer.h"

// for test only
static uint8_t pload[4] = {'0', '0', 'X', 'V'};


// Get SYS variable Handler
sys_t *GetSysHandler(void) {
    static sys_t sys;
    return &sys;
}

// Shift register handler
uint8_t *GetRegHandler(void) {
    static uint8_t reg_data;
    return &reg_data;
}


// Setup hardware
void setup(void) {

	// GPIO
	GPIOA->DDR = (1<<LATCH);
	GPIOA->CR1 = (1<<LATCH);

	// Ext. IRQ PC4 - Floating with interrupt
	GPIOC->CR2 = PIN_4;
	EXTI->CR1 |= 0x20; // PORTC faling edge
	
	// ADC - PD2
	ADC1->CSR = 0x03; // Channel 3;
	ADC1->CR1 = 0x70; // f.master/18
	ADC1->TDRL = 0x03;

	ClrBit(GPIOA->ODR, LATCH);

	// Tim2 - PWM / 2kHz
	TIM2->ARRH = 0x03; // 
	TIM2->ARRL = 0xE7; // ARR = 999
	TIM2->PSCR = 0x00; // PSCR = 1
	TIM2->EGR = TIM2_EGR_UG;
	TIM2->CCMR1 = 0x78; // PWM mode1
	TIM2->CCMR2 = 0x78; // PWM mode1
	TIM2->CCER1 = TIM2_CCER1_CC1E | TIM2_CCER1_CC2E;
	TIM2->CCR1H = 0x01;
	TIM2->CCR1L = 0xF4;
	TIM2->CCR2H = 0x00;
	TIM2->CCR2L = 0xFA;
	//TIM2->CR1 = TIM2_CR1_CEN;

	// Tim4 - time counter
    // IRQ - 100us
	TIM4->PSCR = 0x02; // pre. 4x
	TIM4->ARR = 49;
	TIM4->IER |= TIM4_IER_UIE;
	TIM4->CR1 |= TIM4_CR1_CEN;

    // Init aditional functions
    // Software timer
    os_timer_init(0, 1, 1);
    os_timer_setfn(0, sys_timer_func, 0);
}

// Simple block delay function
void delay(uint16_t time) {
	while( time ) {
		time--;
		nop();
	}
}


// UART evet
void uart_event(void) {
	uint8_t data = 0;

	if( !uart_recv( &data ) ) {
		// odebrano znak
        modbus_putdata(data);
	}
}


// System event check
void sys_event(void) {
    sys_t *sys = GetSysHandler();
	if ( sys->flags ) {
		// Flags from External IRQ
		if ( sys->flags & (1<<E_IRQ) ) {
			ClrBit(sys->flags, E_IRQ);
			//uart_putc('E');
		}
	}
}


// Timer event
void timer_event(void) {
    uint8_t *flags = GetTimeHandler();

	// 100 us
    if ( (*flags) & 0x01 ) {
        ClrBit(*flags, 0);
        modbusTickTimer();
    }

	// 10 ms
    if ( (*flags) & 0x02 ) {
        ClrBit(*flags, 1);
    }

	// 1s
    if ( (*flags) & 0x04 ) {
        ClrBit(*flags, 2);
		// Check retransmit ACK frame
		check_ack();

        os_timer_event();
    }
}

// System timer function
void sys_timer_func(void *arg) {

	static uint8_t cnt;

	if ( !(cnt%2) ) {

	if (!mn_send(3, DEFAULT_TTL, pload, 4, 1) ) {
		if (pload[0] == '9') {
        	pload[0] = '0';
        	pload[1]++;
    	} else {
        	pload[0]++;
    	}
	}
	}
	cnt++;

	// const uint8_t hello[] = {"--"};
    // uart_cp2txbuf(hello, 2;

	arg = (int8_t *)arg;
}


// Transmit bit to shift register
// data: byte to transmit
void reg_transfer(uint8_t data) {
	spi_transmit(data);
	
    // Set bit 1 (LATCH) in GPIOA-ODR
    //SetBit(GPIOA->ODR, LATCH);
    __asm__("bset 0x5000, #1");
	delay(10);
	
    // Clear bit 1 (LATCH) in GPIOA-ODR
    //ClrBit(GPIOA->ODR, LATCH);
    __asm__("bres 0x5000, #1");
}


// Usage Functions

// Set output
// num: number output
//		(0: NRF24L01, 1: AC1,   2: AC2,   3: Relay 1,
//		 4: Relay 2,  5: Out 1, 6: Out 2, 7: Out 3)
//  mode: output mode (0: off, 1: on)
void output_set(uint8_t num, uint8_t mode) {
	uint8_t *reg = GetRegHandler();

	if ( mode ) {
		SetBit(*reg, num);
	} else {
		ClrBit(*reg, num);
	}

	reg_transfer(*reg);
}


// NRF24L01 function
void nrf_recv(void) {
    nrf_t *nrf = GetNrfHandler();
	if ( nrf->status & RX_DR ) {
		mn_decode_frame();
		nrf->status &=~ RX_DR;
	}
}


// NRF24L01 mesh frame execute
void mn_exec(void) {
    nrf_t *nrf = GetNrfHandler();
    //Debug only
    for (uint8_t x=4; x<8; x++) {
        uart_putc(nrf->data_rx[x]);
	}
    uart_putc('\n');
    uart_putc('\r');

    // if ( nrf->data_rx[4] == 'C' ) {
    // 	output_set(3 ,1);
    // }

    // if ( nrf->data_rx[4] == 'O' ) {
    // 	output_set(3, 0);
    // }

    nrf_clear_rxbuff();
}