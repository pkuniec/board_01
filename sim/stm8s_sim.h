#ifndef STM8_SIM_H
#define STM8_SIM_H

#include "stm8s_sim_def.h"


struct stm8_uart_reg {
	uint8_t BRR1;
	uint8_t BRR2;
	uint8_t DR;
	uint8_t CR1;
	uint8_t CR2;
	uint8_t SR;
};

extern struct stm8_uart_reg* UART1;


// GPIO
struct gpio {
	uint8_t ODR;
	uint8_t DDR;
	uint8_t IDR;
	uint8_t CR1;
	uint8_t CR2;
};

extern struct gpio *GPIOA;
extern struct gpio *GPIOB;
extern struct gpio *GPIOC;


// EXTI
struct exti {
	uint8_t CR1;
	uint8_t CR2;
};

extern struct exti *EXTI;


// ADC
struct adc {
	uint8_t CSR;
	uint8_t CR1;
	uint8_t TDRL;
};

extern struct adc *ADC1;


// SPI
struct spi {
	uint8_t CR1;
	uint8_t CR2;
	uint8_t DR;
	uint8_t SR;
};

extern struct spi *SPI;


// Timers
struct timer {
	uint8_t ARRH;
	uint8_t ARRL;
	uint8_t EGR;
	uint8_t PSCR;
	uint8_t CCMR1;
	uint8_t CCMR2;
	uint8_t CCER1;
	uint8_t CCER2;
	uint8_t CCR1H;
	uint8_t CCR1L;
	uint8_t CCR2H;
	uint8_t CCR2L;
	uint8_t ARR;
	uint8_t CR1;
	uint8_t IER;
};

extern struct timer *TIM2;
extern struct timer *TIM4;



// Simulation
void sim_isr_tx(void);
void sim_isr_rx(uint8_t data);


void nop(void);

#endif
