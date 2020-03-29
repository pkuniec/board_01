#include "stm8s.h"

#include "common.h"
#include "uart.h"


void uart_init(void) {
	// bautrate 9600 / 2Mhz F_CPU
	UART1->BRR2 = 0x00;
	UART1->BRR1 = 0x0D;
	// bautrate 9600 / 8Mhz F_CPU
	//UART1->BRR2 = 0x01;
	//UART1->BRR1 = 0x34;
	UART1->CR2 = UART1_CR2_TEN | UART1_CR2_REN | UART1_CR2_RIEN;
}


int8_t uart_putc(uint8_t c) {
	// Disable RX for RS-485 (halfduplex)
	UART1->CR2 &= ~(UART1_CR2_REN);

	uint8_t head_temp = uart_tx_Buff.head + 1;

	if ( head_temp == TX_BUFF_SIZE ) {
		head_temp = 0;
	}

	if ( head_temp == uart_tx_Buff.tail ) {
		// brak miejsca w buforze
		return -1;
	}

	uart_tx_Buff.buffer[head_temp] = c;
	uart_tx_Buff.head = head_temp;

	// Enable TX
	UART1->CR2 |= UART1_CR2_TIEN | UART1_CR2_TCIEN;

	return 0;
}

void uart_puts(uint8_t *str) {
	while( *str ) {
		if( !uart_putc( *str ) ) {
			*(str++);
		}
	}
}

int8_t uart_recv(uint8_t *data) {

	if ( uart_rx_Buff.head == uart_rx_Buff.tail ) {
		return -1;
	}

	uart_rx_Buff.tail++;

	if ( uart_rx_Buff.tail == RX_BUFF_SIZE ) {
		uart_rx_Buff.tail = 0;
	}

	*data = uart_rx_Buff.buffer[uart_rx_Buff.tail];
	return 0;
}