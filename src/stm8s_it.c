#include "stm8s.h"
#include "stm8s_it.h"

#include "common.h"
#include "uart.h"
#include "queue.h"
#include "nrf24l01.h"

uint8_t sec = 100;


void tim4_update(void) __interrupt (IT_TIM4_OVR_UIF) {

	//static uint8_t sec = 100;
	TIM4->SR1 &= ~TIM4_SR1_UIF;

	if ( !sec-- ) {
		sec = 100;
	}
}


void uart1_tx(void) __interrupt (IT_UART1_TX) {
	uint8_t sr_reg = UART1->SR;

	queue_t *handler = GetTxHandler();
	uint8_t data;

	if( !get_queue(handler, &data) ) {
		if ( sr_reg & UART1_SR_TXE ) {
		// Rejester TX  pusty
			UART1->DR = data;
		}
	} else {
		// Enable RX for RS-485 (halfduplex)
		UART1->CR2 |= UART1_CR2_REN;
		// Disable TX
		UART1->CR2 &= ~(UART1_CR2_TIEN | UART1_CR2_TCIEN);
	}

	if ( sr_reg & UART1_SR_TC ) {
		// Transsmition complete
		UART1->SR &= ~(UART1_SR_TC);
	}
}


void uart1_rx(void) __interrupt (IT_UART1_RX) {
	queue_t *handler = GetRxHandler();

	if ( UART1->SR & UART1_SR_RXNE ) {
		add_queue(handler, UART1->DR);
	}
}


void exti2_irq(void) __interrupt (IT_EXTI2) {
	if( !(GPIOC->IDR & (PIN_3)) ) {
		// Faling edge on PC3 (NRF24L01 IRQ)
		SetBit(system.flags, N_IRQ);
	}

	if( !(GPIOC->IDR & (PIN_4)) ) {
		// Faling edge on PC4 (External INPUT)
		SetBit(system.flags, E_IRQ);
	}
}


// void spi_irq(void) __interrupt(IT_SPI) {
// 	uint8_t regstat = SPI->SPI_SR;

// 	// TX buffor empty
// 	if( regstat & SPI_SR_TXE ) {
// 		if( spi_data.flag & 0x01 ) {

// 		}
// 	}

// 	// RX buffor full
// 	if( regstat & SPI_SR_RXNE ) {
// 		spi_data.flag |= 0x10;
// 		spi_data.rx_data = SPI->DR;
// 	}

// }
