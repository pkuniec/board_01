#include <inttypes.h>
#include "stm8s_sim.h"
#include "uart.h"

struct stm8_uart_reg reg_uart1;
struct stm8_uart_reg * UART1 = &reg_uart1;

void sim_isr_tx(void) {
	UART1->SR |= UART1_SR_TXE;
	uart1_tx();
}

void sim_isr_rx(uint8_t data) {
	UART1->DR = data;
	UART1->SR |= UART1_SR_RXNE;
	uart1_rx();
	UART1->SR &= ~UART1_SR_RXNE;
}
