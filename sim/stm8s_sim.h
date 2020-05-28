#ifndef STM8_SIM_H
#define STM8_SIM_H

// UART1
#define UART1_CR2_REN	0x04
#define UART1_CR2_TEN	0x08
#define UART1_CR2_RIEN	0x20
#define UART1_CR2_TCIEN	0x04
#define UART1_CR2_TIEN	0x80

#define UART1_SR_RXNE	0x20
#define UART1_SR_TC		0x40
#define UART1_SR_TXE	0x80

struct stm8_uart_reg {
	uint8_t BRR1;
	uint8_t BRR2;
	uint8_t DR;
	uint8_t CR1;
	uint8_t CR2;
	uint8_t SR;
};

extern struct stm8_uart_reg* UART1;


// Simulation
void sim_isr_tx(void);
void sim_isr_rx(uint8_t data);

#endif
