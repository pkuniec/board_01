#ifndef SPI__H
#define SPI__H

#define IT_SPI				10


void spi_init(void);
uint8_t spi_transmit(uint8_t data);

#endif