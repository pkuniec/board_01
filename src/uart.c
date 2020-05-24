#include "stm8s.h"
#include "common.h"
#include "queue.h"
#include "uart.h"


queue_t *GetRxHandler(void) {
    static queue_t rx_queue;
    return &rx_queue;
}

queue_t *GetTxHandler(void) {
    static queue_t tx_queue;
    return &tx_queue;
}

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
	queue_t *handler = GetTxHandler();
	int8_t ret;
	// Disable RX for RS-485 (halfduplex)
	UART1->CR2 &= ~(UART1_CR2_REN);

	ret = add_queue(handler, c);

	// Enable TX
	UART1->CR2 |= UART1_CR2_TIEN | UART1_CR2_TCIEN;

	return ret;
}

void uart_puts(uint8_t *str) {
	while( *str ) {
		if( !uart_putc( *str ) ) {
			*(str++);
		}
	}
}

int8_t uart_recv(uint8_t *data) {
	queue_t *handler = GetRxHandler();
	return get_queue(handler, data);
}