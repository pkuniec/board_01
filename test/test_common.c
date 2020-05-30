#include <stdio.h>
#include <inttypes.h>
#include "stm8s_sim.h"
#include "stm8s_sim_def.h"
#include "unity.h"
#include "uart.h"
#include "queue.h"
#include "common.h"
#include "spi.h"
#include "nrf24l01.h"
#include "nrf24l01_mem.h"
#include "mnprot.h"


void setUp(void) { }

void tearDown(void) { }

void test_common_UartEvent(void) {
    uint8_t test_value = 'a';

    sim_isr_rx(test_value);
    uart_event();
    sim_isr_tx();
    TEST_ASSERT_EQUAL('0', UART1->DR);
}
