#include <inttypes.h>
#include "stm8s_sim.h"
#include "stm8s_sim_def.h"
#include "uart.h"



struct gpio reg_gpioa;
struct gpio *GPIOA = &reg_gpioa;

struct gpio reg_gpiob;
struct gpio *GPIOB = &reg_gpiob;

struct gpio reg_gpioc;
struct gpio *GPIOC = &reg_gpioc;

struct exti reg_exti;
struct exti *EXTI = &reg_exti;

struct adc reg_adc1;
struct adc *ADC1 = &reg_adc1;

struct spi reg_spi;
struct spi *SPI = &reg_spi;

struct timer reg_tim2;
struct timer *TIM2 = &reg_tim2;

struct timer reg_tim4;
struct timer *TIM4 = &reg_tim4;

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

void nop(void) { }
