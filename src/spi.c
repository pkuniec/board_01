#ifdef __SDCC__
  #include "stm8s.h"
#else
  #include <inttypes.h>
  #include "stm8s_sim_def.h"
  #include "stm8s_sim.h"
#endif

// Init SPI interface
void spi_init(void) {
	//SPI->ICR = SPI_ICR_TXIE | SPI_ICR_RXIE;
	SPI->CR2 = SPI_CR2_SSM | SPI_CR2_SSI;
	SPI->CR1 = SPI_CR1_MSTR | SPI_CR1_SPE;// | (SPI_CR1_BR & 0x08);
}


// Transmit SPI data
// data: byte to write
// return: byte read from SPI
uint8_t spi_transmit(uint8_t data) {
	SPI->DR = data;
	while( !(SPI->SR & SPI_SR_TXE) );
	while( !(SPI->SR & SPI_SR_RXNE) );
	return SPI->DR;
}


// void spi_irq(void) __interrupt(IT_SPI) {
// 	uint8_t regstat = SPI->SPI_SR;

// 	// TX buffor empty
// 	if( regstat & SPI_SR_TXE ) {
// 		if( spi_data.flag & 0x01 ) {

// 		}
// 	}

// 	// RX buffor full
// 	if( regstat & SPI_SR_RXNE ) {
// 		spi_data.flag |= 0x10;
// 		spi_data.rx_data = SPI->DR;
// 	}

// }