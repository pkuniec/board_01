#ifndef COMMON__H
#define COMMON__H

// GPIOA
#define LATCH   1

/*
- Register -
0 - NRF
1 - AC1 (triac)
2 - AC2 (triac)
3 - Relay1
4 - Relay2
5 - Out_1
6 - Out_2
7 - Out_3
*/

#define R_NRF   0
#define R_AC1   1
#define R_AC2   2
#define R_REL1  3
#define R_REL2  4
#define R_OUT1  5
#define R_OUT2  6
#define R_OUT3  7


// System Flags
#define E_IRQ   0   // External IRQ
#define N_IRQ   1   // NRF24L01 IRQ

typedef struct {
    uint8_t flags;
} sys_t;


sys_t *GetSysHeader(void);

void setup(void);
void delay(uint16_t time);
void uart_event(void);
void sys_event(void);

void reg_transfer(uint8_t data);

uint8_t eeprom_read(uint8_t addr);
void eeprom_write(uint8_t addr, uint8_t *data, uint8_t len);

void adc_get(uint16_t *adc);
void output_set(uint8_t num, uint8_t mode);

void nrf_recv(void);
void mn_exec(void);

#endif