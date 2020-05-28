#include <inttypes.h>
#include "unity.h"
#include "queue.h"

static queue_t q;
static int8_t val;


void setUp(void) { }
void tearDown(void) { }


void test_queue_InitQueue(void) {
	init_queue(&q);
	TEST_ASSERT_EQUAL(0, q.idx);
	TEST_ASSERT_EQUAL(0, q.cnt);
}

void test_queue_StressQueue(void) {
	// Wypelnienie kolejki
	for(uint8_t i=0; i<Q_SIZE; i++) {
		TEST_ASSERT_EQUAL(0, add_queue(&q, i));
	}

	// Test przepelnienia kolejki
	TEST_ASSERT_EQUAL(-1, add_queue(&q, 'A'));
	TEST_ASSERT_EQUAL(-1, add_queue(&q, 'B'));

	// Pobieranie z kolejki
	for(uint8_t i=0; i<Q_SIZE; i++) {
		TEST_ASSERT_EQUAL(0, get_queue(&q, &val));
		TEST_ASSERT_EQUAL(i, val);
	}

	// Test czy bufor pusty
	TEST_ASSERT_EQUAL(-1, get_queue(&q, &val));
	TEST_ASSERT_EQUAL(-1, get_queue(&q, &val));

	// Test wartosci queue->cnt
	TEST_ASSERT_EQUAL(0, q.cnt);
}
