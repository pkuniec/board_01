#ifdef __SDCC__
  #include "stm8s.h"
#else
  #include <inttypes.h>
  #include "stm8s_sim_def.h"
  #include "stm8s_sim.h"
#endif

#include "common.h"
#include "stm8s_it.h"
#include "uart.h"
#include "spi.h"
#include "nrf24l01.h"
#include "nrf24l01_mem.h"
#include "mnprot.h"
#include "modbus.h"
#include "timer.h"

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
    os_timer_init(sys_timer_func);
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
			uart_putc('E');
		}
	}
}


// Timer event
void timer_event(void) {
    uint8_t *flags = GetTimeHandler();

    if ( (*flags) & 0x01 ) {
        ClrBit(*flags, 0);
        modbusTickTimer();
    }

    if ( (*flags) & 0x04 ) {
        ClrBit(*flags, 2);
        os_timer_event();
    }
}

// System timer function
void sys_timer_func(void) {
    //const uint8_t hello[] = {"M\n\r"};
    //uart_cp2txbuf(hello, 3);
    nop();
}


/*
// Reada one byte from EEPROM
// addr: address of EEPROM memory to read
uint8_t eeprom_read(uint8_t addr) {
	uint8_t *eemem = (char *) 0x4000;
	return *(eemem + addr);
}
*/

/*
// Write data tu EEPROM
// addr: address memory to start save data
// *data: poiter to data with will be save
// len: length in bytes to save
void eeprom_write(uint8_t addr, uint8_t *data, uint8_t len) {
	uint8_t *eemem = (char *) 0x4000;

	if( !(FLASH->IAPSR & FLASH_IAPSR_DUL) ) {
	// Write lock
		FLASH->DUKR = 0xAE;
		FLASH->DUKR = 0x56;
		while ( !(FLASH->IAPSR & FLASH_IAPSR_DUL) );
	}

	for( uint8_t i = 0; i<len; i++) {
		*(eemem + addr + i) = data[i];
		while ( !(FLASH->IAPSR & FLASH_IAPSR_EOP) );
	}

	FLASH->IAPSR &= ~FLASH_IAPSR_DUL; 
}
*/

/*
// Get ADC value
// *adc: pointer to word (uint16_t) wher by stored ADC value
void adc_get(uint16_t *adc) {
	// wake up ADC
	SetBit(ADC1->CR1, 0);
	delay(100);
	// Start conversion
	SetBit(ADC1->CR1, 0);
	while(ADC1->CSR & ADC1_CSR_EOC)
	ClrBit(ADC1->CSR, 7);
	*adc = (uint16_t)(ADC1->DRH << 8);
	*adc |= (uint8_t)(ADC1->DRL);
	// Sleep ADC
	ClrBit(ADC1->CR1, 0);
}
*/

// Transmit bit to shift register
// data: byte to transmit
void reg_transfer(uint8_t data) {
	spi_transmit(data);
	//SetBit(GPIOA->ODR, LATCH);
    // Set bit 1 (LATCH) in GPIOA-ODR
    __asm__("bset 0x5000, #1");
	delay(10);
	//ClrBit(GPIOA->ODR, LATCH);
    // Clear bit 1 (LATCH) in GPIOA-ODR
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
	// Debug only
	// for (uint8_t x=4; x<8; x++) {
	// 	uart_putc(nrf->data_rx[x]);
	// }
    // uart_putc('\n');
    // uart_putc('\r');

	// if ( nrf->data_rx[4] == 'C' ) {
	// 	output_set(3 ,1);
	// }

	// if ( nrf->data_rx[4] == 'O' ) {
	// 	output_set(3, 0);
	// }

	nrf_clear_rxbuff();
}