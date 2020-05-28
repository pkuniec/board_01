#include <stdio.h>
#include <inttypes.h>
#include "stm8s_sim.h"
#include "unity.h"
#include "uart.h"
#include "queue.h"

void setUp(void) { }

void tearDown(void) { }

void test_uart_InitAndTest(void) {
	// Init test
    uart_init();
    TEST_ASSERT_EQUAL(0x00, UART1->BRR2);
    TEST_ASSERT_EQUAL(0x0D, UART1->BRR1);
}

void test_uart_Tx(void) {
	uint8_t test_value = 'A';

    TEST_ASSERT_EQUAL(0, uart_putc(test_value));
    sim_isr_tx();
    TEST_ASSERT_EQUAL(test_value, UART1->DR);
}

void test_uart_Rx(void) {
	uint8_t test_value = 'B';
	uint8_t data;
	int8_t ret;

	ret = uart_recv(&data);
	TEST_ASSERT_EQUAL(-1, ret);

    sim_isr_rx(test_value);
 
 	ret = uart_recv(&data);
 	TEST_ASSERT_EQUAL(0, ret);
    TEST_ASSERT_EQUAL(test_value, data);
}
