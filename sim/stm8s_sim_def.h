#ifndef STM8_SIM_DEF_H
#define STM8_SIM_DEF_H


#define SetBit(VAR,Place)         ( (VAR) |= (uint8_t)((uint8_t)1<<(uint8_t)(Place)) )
#define ClrBit(VAR,Place)         ( (VAR) &= (uint8_t)((uint8_t)((uint8_t)1<<(uint8_t)(Place))^(uint8_t)255) )


// PINS
#define PIN_0	0
#define PIN_1	1
#define PIN_2	2
#define PIN_3	3
#define PIN_4	4
#define PIN_5	5
#define PIN_6	6
#define PIN_7	7


// UART1
#define UART1_CR2_REN	0x04
#define UART1_CR2_TEN	0x08
#define UART1_CR2_RIEN	0x20
#define UART1_CR2_TCIEN	0x04
#define UART1_CR2_TIEN	0x80
#define UART1_SR_RXNE	0x20
#define UART1_SR_TC		0x40
#define UART1_SR_TXE	0x80


// TIM2
#define TIM2_CR1_ARPE    ((uint8_t)0x80) /*!< Auto-Reload Preload Enable mask. */
#define TIM2_CR1_OPM     ((uint8_t)0x08) /*!< One Pulse Mode mask. */
#define TIM2_CR1_URS     ((uint8_t)0x04) /*!< Update Request Source mask. */
#define TIM2_CR1_UDIS    ((uint8_t)0x02) /*!< Update DIsable mask. */
#define TIM2_CR1_CEN     ((uint8_t)0x01) /*!< Counter Enable mask. */
#define TIM2_IER_CC3IE   ((uint8_t)0x08) /*!< Capture/Compare 3 Interrupt Enable mask. */
#define TIM2_IER_CC2IE   ((uint8_t)0x04) /*!< Capture/Compare 2 Interrupt Enable mask. */
#define TIM2_IER_CC1IE   ((uint8_t)0x02) /*!< Capture/Compare 1 Interrupt Enable mask. */
#define TIM2_IER_UIE     ((uint8_t)0x01) /*!< Update Interrupt Enable mask. */
#define TIM2_SR1_CC3IF   ((uint8_t)0x08) /*!< Capture/Compare 3 Interrupt Flag mask. */
#define TIM2_SR1_CC2IF   ((uint8_t)0x04) /*!< Capture/Compare 2 Interrupt Flag mask. */
#define TIM2_SR1_CC1IF   ((uint8_t)0x02) /*!< Capture/Compare 1 Interrupt Flag mask. */
#define TIM2_SR1_UIF     ((uint8_t)0x01) /*!< Update Interrupt Flag mask. */
#define TIM2_SR2_CC3OF   ((uint8_t)0x08) /*!< Capture/Compare 3 Overcapture Flag mask. */
#define TIM2_SR2_CC2OF   ((uint8_t)0x04) /*!< Capture/Compare 2 Overcapture Flag mask. */
#define TIM2_SR2_CC1OF   ((uint8_t)0x02) /*!< Capture/Compare 1 Overcapture Flag mask. */
#define TIM2_EGR_CC3G    ((uint8_t)0x08) /*!< Capture/Compare 3 Generation mask. */
#define TIM2_EGR_CC2G    ((uint8_t)0x04) /*!< Capture/Compare 2 Generation mask. */
#define TIM2_EGR_CC1G    ((uint8_t)0x02) /*!< Capture/Compare 1 Generation mask. */
#define TIM2_EGR_UG      ((uint8_t)0x01) /*!< Update Generation mask. */
#define TIM2_CCMR_ICxPSC ((uint8_t)0x0C) /*!< Input Capture x Prescaler mask. */
#define TIM2_CCMR_ICxF   ((uint8_t)0xF0) /*!< Input Capture x Filter mask. */
#define TIM2_CCMR_OCM    ((uint8_t)0x70) /*!< Output Compare x Mode mask. */
#define TIM2_CCMR_OCxPE  ((uint8_t)0x08) /*!< Output Compare x Preload Enable mask. */
#define TIM2_CCMR_CCxS   ((uint8_t)0x03) /*!< Capture/Compare x Selection mask. */
#define TIM2_CCER1_CC2P  ((uint8_t)0x20) /*!< Capture/Compare 2 output Polarity mask. */
#define TIM2_CCER1_CC2E  ((uint8_t)0x10) /*!< Capture/Compare 2 output enable mask. */
#define TIM2_CCER1_CC1P  ((uint8_t)0x02) /*!< Capture/Compare 1 output Polarity mask. */
#define TIM2_CCER1_CC1E  ((uint8_t)0x01) /*!< Capture/Compare 1 output enable mask. */
#define TIM2_CCER2_CC3P  ((uint8_t)0x02) /*!< Capture/Compare 3 output Polarity mask. */
#define TIM2_CCER2_CC3E  ((uint8_t)0x01) /*!< Capture/Compare 3 output enable mask. */
#define TIM2_CNTRH_CNT   ((uint8_t)0xFF) /*!< Counter Value (MSB) mask. */
#define TIM2_CNTRL_CNT   ((uint8_t)0xFF) /*!< Counter Value (LSB) mask. */
#define TIM2_PSCR_PSC    ((uint8_t)0xFF) /*!< Prescaler Value (MSB) mask. */
#define TIM2_ARRH_ARR    ((uint8_t)0xFF) /*!< Autoreload Value (MSB) mask. */
#define TIM2_ARRL_ARR    ((uint8_t)0xFF) /*!< Autoreload Value (LSB) mask. */
#define TIM2_CCR1H_CCR1  ((uint8_t)0xFF) /*!< Capture/Compare 1 Value (MSB) mask. */
#define TIM2_CCR1L_CCR1  ((uint8_t)0xFF) /*!< Capture/Compare 1 Value (LSB) mask. */
#define TIM2_CCR2H_CCR2  ((uint8_t)0xFF) /*!< Capture/Compare 2 Value (MSB) mask. */
#define TIM2_CCR2L_CCR2  ((uint8_t)0xFF) /*!< Capture/Compare 2 Value (LSB) mask. */
#define TIM2_CCR3H_CCR3  ((uint8_t)0xFF) /*!< Capture/Compare 3 Value (MSB) mask. */
#define TIM2_CCR3L_CCR3  ((uint8_t)0xFF) /*!< Capture/Compare 3 Value (LSB) mask. */

// TIM4
#define TIM4_CR1_ARPE ((uint8_t)0x80) /*!< Auto-Reload Preload Enable mask. */
#define TIM4_CR1_OPM  ((uint8_t)0x08) /*!< One Pulse Mode mask. */
#define TIM4_CR1_URS  ((uint8_t)0x04) /*!< Update Request Source mask. */
#define TIM4_CR1_UDIS ((uint8_t)0x02) /*!< Update DIsable mask. */
#define TIM4_CR1_CEN  ((uint8_t)0x01) /*!< Counter Enable mask. */
#define TIM4_IER_UIE  ((uint8_t)0x01) /*!< Update Interrupt Enable mask. */
#define TIM4_SR1_UIF  ((uint8_t)0x01) /*!< Update Interrupt Flag mask. */
#define TIM4_EGR_UG   ((uint8_t)0x01) /*!< Update Generation mask. */
#define TIM4_CNTR_CNT ((uint8_t)0xFF) /*!< Counter Value (LSB) mask. */
#define TIM4_PSCR_PSC ((uint8_t)0x07) /*!< Prescaler Value  mask. */
#define TIM4_ARR_ARR  ((uint8_t)0xFF) /*!< Autoreload Value mask. */

// SPI
#define SPI_CR1_LSBFIRST ((uint8_t)0x80) /*!< Frame format mask */
#define SPI_CR1_SPE      ((uint8_t)0x40) /*!< Enable bits mask */
#define SPI_CR1_BR       ((uint8_t)0x38) /*!< Baud rate control mask */
#define SPI_CR1_MSTR     ((uint8_t)0x04) /*!< Master Selection mask */
#define SPI_CR1_CPOL     ((uint8_t)0x02) /*!< Clock Polarity mask */
#define SPI_CR1_CPHA     ((uint8_t)0x01) /*!< Clock Phase mask */
#define SPI_CR2_BDM      ((uint8_t)0x80) /*!< Bi-directional data mode enable mask */
#define SPI_CR2_BDOE     ((uint8_t)0x40) /*!< Output enable in bi-directional mode mask */
#define SPI_CR2_CRCEN    ((uint8_t)0x20) /*!< Hardware CRC calculation enable mask */
#define SPI_CR2_CRCNEXT  ((uint8_t)0x10) /*!< Transmit CRC next mask */
#define SPI_CR2_RXONLY   ((uint8_t)0x04) /*!< Receive only mask */
#define SPI_CR2_SSM      ((uint8_t)0x02) /*!< Software slave management mask */
#define SPI_CR2_SSI      ((uint8_t)0x01) /*!< Internal slave select mask */
#define SPI_ICR_TXEI     ((uint8_t)0x80) /*!< Tx buffer empty interrupt enable mask */
#define SPI_ICR_RXEI     ((uint8_t)0x40) /*!< Rx buffer empty interrupt enable mask */
#define SPI_ICR_ERRIE    ((uint8_t)0x20) /*!< Error interrupt enable mask */
#define SPI_ICR_WKIE     ((uint8_t)0x10) /*!< Wake-up interrupt enable mask */
#define SPI_SR_BSY       ((uint8_t)0x80) /*!< Busy flag */
#define SPI_SR_OVR       ((uint8_t)0x40) /*!< Overrun flag */
#define SPI_SR_MODF      ((uint8_t)0x20) /*!< Mode fault */
#define SPI_SR_CRCERR    ((uint8_t)0x10) /*!< CRC error flag */
#define SPI_SR_WKUP      ((uint8_t)0x08) /*!< Wake-Up flag */
#define SPI_SR_TXE       ((uint8_t)0x02) /*!< Transmit buffer empty */
#define SPI_SR_RXNE      ((uint8_t)0x01) /*!< Receive buffer not empty */



#endif
