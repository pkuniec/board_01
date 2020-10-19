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


// Timer calc
#define BASE_CLOCK  2000000UL
#define OS_TIM_PRE  4
#define OS_TIM_CNT  50

#define OS_TIM_CLK  BASE_CLOCK / OS_TIM_PRE / OS_TIM_CNT
#define OS_TIM_US   1000000 / OS_TIM_CLK // 100 us

#define OS_TIM_10MS 10000 / OS_TIM_US
#define OS_TIM_1S   1000000 / OS_TIM_10MS / OS_TIM_US

typedef struct {
    uint8_t flags;
} sys_t;


sys_t *GetSysHandler(void);

void setup(void);
void delay(uint16_t time);
void uart_event(void);
void sys_event(void);
void timer_event(void);

void sys_timer_func(void *arg);

uint8_t *GetRegHandler(void);
void reg_transfer(uint8_t data);

void adc_get(uint16_t *adc);
void output_set(uint8_t num, uint8_t mode);

void nrf_recv(void);
void mn_exec(void);

#endif