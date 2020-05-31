#ifdef __SDCC__
  #include "stm8s.h"
#else
  #include <inttypes.h>
  #include "stm8s_sim.h"
#endif

#include "queue.h"
#include "uart.h"

static queue_t rx_queue, tx_queue;


void uart_init(void) {
    // bautrate 9600 / 2Mhz F_CPU
    UART1->BRR2 = 0x00;
    UART1->BRR1 = 0x0D;
    // bautrate 9600 / 8Mhz F_CPU
    //UART1->BRR2 = 0x01;
    //UART1->BRR1 = 0x34;
    UART1->CR2 = UART1_CR2_TEN | UART1_CR2_REN | UART1_CR2_RIEN;
}


void uart_cp2txbuf(const uint8_t *buff, uint8_t len) {
    while(len--) {
        if ( add_queue(&tx_queue, *buff++) ) {
            // TX buff full - enable interrupt and waite for empty space
            __asm__("bres 0x5235, #2"); // Clear REN bit in CR2 reg.
            __asm__("bset 0x5235, #7"); // Set TIEN bit in CR2 reg.
            while( !(UART1->SR & UART1_SR_TXE) );
        }
    }
    // Enable TX interrupt
    //UART1->CR2 &= ~(UART1_CR2_REN);
    //UART1->CR2 |= UART1_CR2_TIEN;
    __asm__("bres 0x5235, #2"); // Clear REN bit in CR2 reg.
    __asm__("bset 0x5235, #7"); // Set TIEN bit in CR2 reg.
}


int8_t uart_putc(uint8_t c) {
    // Disable RX for RS-485 (halfduplex)
    UART1->CR2 &= ~(UART1_CR2_REN);
    if ( !add_queue(&tx_queue, c) ) {
        // Enable TX
        //SetBit(UART1->CR2, 7); // Set TIEN bit in CR2 reg.
        __asm__("bset 0x5235, #7"); // Set TIEN bit in CR2 reg.
        return 0;
    } else {
        return -1;
    }
}

void uart_puts(const uint8_t *str) {
    while( *str ) {
        if( !uart_putc( *str ) ) {
            *(str++);
        }
    }
}

int8_t uart_recv(uint8_t *data) {
    return get_queue(&rx_queue, data);
}


// ---------------------
//  Interrupt functions
// ---------------------
#ifdef __SDCC__
void uart1_tx(void) __interrupt (IT_UART1_TX)
#else
void uart1_tx(void)
#endif
{
    uint8_t sr_reg = UART1->SR;
    uint8_t data;

	// TX buffer empty
	if ( sr_reg & UART1_SR_TXE ) {
		if ( !get_queue(&tx_queue, &data) ) {
			UART1->DR = data;
		} else {
            // Enable RX for RS-485 (halfduplex)
            //UART1->CR2 |= UART1_CR2_REN;
            __asm__("bset 0x5235, #2"); // Set REN bit in CR2 reg.
            // Disable TX
            //UART1->CR2 &= ~(UART1_CR2_TIEN);
            __asm__("bres 0x5235, #7"); // Clear TIEN bit in CR2 reg.
        }
	}
}

#ifdef __SDCC__
void uart1_rx(void) __interrupt (IT_UART1_RX)
#else
void uart1_rx(void)
#endif
{
    if ( UART1->SR & UART1_SR_RXNE ) {
        add_queue(&rx_queue, UART1->DR);
    }
}