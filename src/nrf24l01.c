#ifdef __SDCC__
  #include "stm8s.h"
#else
  #include <inttypes.h>
  #include "stm8s_sim_def.h"
  #include "stm8s_sim.h"
#endif

#include <stdlib.h>
#include "common.h"
#include "nrf24l01.h"
#include "nrf24l01_mem.h"
#include "uart.h"
#include "spi.h"

// Static global
static nrf_t nrf;

// Return Handler static global
nrf_t *GetNrfHandler(void) {
    return &nrf;
}

// Init hardware
void nrf_init_hw(void) {
	// GPIO
	GPIOA->DDR |= SPI_CE | SPI_CSN;
	GPIOA->CR1 |= SPI_CE | SPI_CSN;
	GPIOA->CR2 |= SPI_CE | SPI_CSN;
	GPIOA->ODR |= SPI_CSN;

	GPIOC->CR2 |= NRF_IRQ;

	// EXTI
	EXTI->CR1 |= 0x20; // PORTC faling edge
}

// Power on/off NRF24L01 module
void nrf_power(uint8_t power) {
	if (power) {
		output_set(R_NRF, 0);
		delay(65000);
	} else {
		output_set(R_NRF, 1);
		delay(65000);
	}
}

// Software init for module
void nrf_init_sw(void) {
	uint8_t addr[5] = {0xA5, 0xE7, 0xE7, 0xE7, 0xA7};

	nrf_writereg( SETUP_AW, AW_5 );
	nrf_writereg_many( 0, TX_ADDR, addr, 5);
	nrf_writereg( EN_RXADDR, ERX_P0 | ERX_P1 );
	nrf_writereg_many( 0, RX_ADDR_P0, addr, 5);
	nrf_writereg( RX_PW_P0, PAYLOADSIZE);
	nrf_writereg( RX_PW_P1, PAYLOADSIZE);
	nrf_writereg( EN_AA, 0x00);
	nrf_writereg( RF_CH, 11);
	nrf_writereg( RF_SETUP, TRANS_SPEED_1MB | RF_PWR_0dB );
	nrf_writereg( SETUP_RETR, 0x40);
	nrf_writereg( FEATURE, EN_DYN_ACK);
	nrf_writereg( CONFIG, EN_CRC | CRC0 | MASK_MAX_RT | MASK_TX_DS);
}


void nrf_reset(void) {
	nrf_power(0);
	nrf_power(1);

	nrf_writereg( CONFIG, 0x08 );
	nrf_writereg( RX_PW_P0, 0x00);
	nrf_writereg( EN_AA, 0x00 );
	nrf_writereg( EN_RXADDR, 0x00 );
	nrf_writereg( RF_CH, 0x00 );
	nrf_writereg( RF_SETUP, 0x00 );
	nrf_writereg( STATUS, 0xe0 );
	nrf_sendcmd( FLUSH_TX );
	nrf_sendcmd( FLUSH_RX );
}


void nrf_powerdown(void) {
	uint8_t config;
	nrf_ce_low();

	config = nrf_readreg( CONFIG );
	config &= ~(PWR_UP | PRIM_RX);
	nrf_writereg( CONFIG, config );
}


void nrf_rx_enable(void) {
	uint8_t config = 0;
	nrf_ce_low();

	config = nrf_readreg( CONFIG );
	nrf_writereg( CONFIG, config | PRIM_RX | PWR_UP );
	while( !(config & (PWR_UP | PRIM_RX)) ) {
		config = nrf_readreg( CONFIG );
	}

	nrf_ce_high();
	nrf_sendcmd( FLUSH_RX );
}


void nrf_tx_enable(void) {
	uint8_t config;
	nrf_ce_low();

	config = nrf_readreg( CONFIG );
	config &= ~(PRIM_RX);
	nrf_writereg( CONFIG, config | PWR_UP );
	while( !(config & PWR_UP) ) {
		config = nrf_readreg( CONFIG );
	}
	nrf_sendcmd( FLUSH_TX );
}


void nrf_read_rx(uint8_t *data, uint8_t len) {
	nrf_csn_enable();
	spi_transmit( R_RX_PAYLOAD );
	while(len--) {
		*data++ = spi_transmit( NOP );
	}
	nrf_csn_disable();
}


void nrf_write_tx(uint8_t *data, uint8_t len) {
	nrf_writereg_many(1, W_TX_PAYLOAD, data, len);
	nrf_ce_high();
	delay(100);
	nrf_ce_low();
}


void nrf_register_cb(nrf_cb_f func) {
	nrf.func = func;
}


void nrf_event(void) {
    sys_t *sys = GetSysHandler();
	uint8_t nstatus;
	nrf.status = nstatus = 0;

	if( sys->flags & (1<<N_IRQ) ) {
		// NRF24L01 interrupt notify
		nrf.status = nrf_readreg( STATUS );
		nrf.pipe_no = (nrf.status >> 1) & 0x07;

		if( (nrf.status & RX_DR) ) {
			// data receive
			nstatus |= RX_DR;
			nrf_read_rx(nrf.data_rx, PAYLOADSIZE);
		}

		if( (nrf.status & TX_DS) ) {
			// data send
			nstatus |= TX_DS;
		}

		if( (nrf.status & MAX_RT) ) {
			// max. retry reached
			nstatus |= MAX_RT;
		}

		if( (nrf.status & TX_FULL) ) {
			// tx buffor full
		}

		if( nrf.func ) {
			nrf.func();
		}

		nrf_writereg( STATUS, nstatus );
		ClrBit(sys->flags, N_IRQ);
	}	
}


void nrf_clear_rxbuff(void) {
	for(uint8_t x=0; x<PAYLOADSIZE; x++) {
		nrf.data_rx[x] = 0;
	}
}


void nrf_csn_enable(void) {
	ClrBit(GPIOA->ODR, 3);
}


void nrf_csn_disable(void) {
	while( (SPI->SR & SPI_SR_BSY) );
	SetBit(GPIOA->ODR, 3);
}


void nrf_ce_low(void) {
	ClrBit(GPIOA->ODR, 2);
}


void nrf_ce_high(void) {
	SetBit(GPIOA->ODR, 2);
}


uint8_t nrf_sendcmd(uint8_t cmd) {
	uint8_t status;
	nrf_csn_enable();
	status = spi_transmit( cmd );
	nrf_csn_disable();
	return status;
}


uint8_t nrf_readreg(uint8_t reg) {
	uint8_t data;
	nrf_csn_enable();
	spi_transmit(R_REGISTER | (REGISTER_MASK & reg) );
	data = spi_transmit(NOP);
	nrf_csn_disable();
	return data;
}


void nrf_writereg(uint8_t reg, uint8_t data) {
	nrf_csn_enable();
	spi_transmit(W_REGISTER | (REGISTER_MASK & reg) );
	spi_transmit(data);
	nrf_csn_disable();
}


void nrf_writereg_many(uint8_t cmd, uint8_t reg, uint8_t *data, uint8_t len) {
	nrf_csn_enable();

	if( cmd ) {
		spi_transmit( reg );
	} else {
		spi_transmit(W_REGISTER | (REGISTER_MASK & reg) );
	}

	while(len--) {
		spi_transmit(*data++);
	}
	nrf_csn_disable();
}