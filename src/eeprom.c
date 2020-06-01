#include "stm8s.h"
#include "eeprom.h"


// Reada one byte from EEPROM
// addr: address of EEPROM memory to read
uint8_t eeprom_read(uint8_t addr) {
	uint8_t *eemem = (char *) 0x4000;
	return *(eemem + addr);
}


// Write data tu EEPROM
// addr: address memory to start save data
// *data: poiter to data with will be save
// len: length in bytes to save
void eeprom_write(uint8_t addr, uint8_t *data, uint8_t len) {
	uint8_t *eemem = (char *) 0x4000;

	if( !(FLASH->IAPSR & FLASH_IAPSR_DUL) ) {
	// Write lock
		FLASH->DUKR = 0xAE;
		FLASH->DUKR = 0x56;
		while ( !(FLASH->IAPSR & FLASH_IAPSR_DUL) );
	}

	for( uint8_t i = 0; i<len; i++) {
		*(eemem + addr + i) = data[i];
		while ( !(FLASH->IAPSR & FLASH_IAPSR_EOP) );
	}

	FLASH->IAPSR &= ~FLASH_IAPSR_DUL; 
}