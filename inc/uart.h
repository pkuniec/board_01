#ifndef UART__H
#define UART__H

#define IT_UART1_TX			17
#define IT_UART1_RX			18

void uart_init(void);
int8_t uart_putc(uint8_t c);
void uart_puts(uint8_t *str);
int8_t uart_recv(uint8_t *data);

// ISR
#ifdef __SDCC__
void uart1_tx(void) __interrupt (IT_UART1_TX);
void uart1_rx(void) __interrupt (IT_UART1_RX);
#else
void uart1_tx(void);
void uart1_rx(void);
#endif


#endif