#ifndef EEPROM__H
#define EEPROM__H

uint8_t eeprom_read(uint8_t addr);
void eeprom_write(uint8_t addr, uint8_t *data, uint8_t len);

#endif