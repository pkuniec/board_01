#ifndef UART__H
#define UART__H

#include "queue.h"

queue_t *GetRxHandler(void);
queue_t *GetTxHandler(void);

void uart_init(void);
int8_t uart_putc(uint8_t c);
void uart_puts(uint8_t *str);
int8_t uart_recv(uint8_t *data);

#endif