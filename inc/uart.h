#ifndef UART__H
#define UART__H

#define TX_BUFF_SIZE	8
#define RX_BUFF_SIZE	8


typedef struct {
	volatile uint8_t * buffer;
	uint8_t head;
	uint8_t tail;
} T_circ_buffer;

extern volatile T_circ_buffer uart_tx_Buff;
extern volatile T_circ_buffer uart_rx_Buff;

void uart_init(void);
int8_t uart_putc(uint8_t c);
void uart_puts(uint8_t *str);
int8_t uart_recv(uint8_t *data);

#endif
