#ifndef QUEUE__H
#define QUEUE__H

#define Q_SIZE   16

typedef struct {
    volatile uint8_t idx;
    volatile uint8_t cnt;
    uint8_t queue[Q_SIZE];
} queue_t;

void init_queue(queue_t *q);
int8_t add_queue(queue_t *q, uint8_t value);
int8_t get_queue(queue_t *q, uint8_t *value);
//uint8_t size_queue(queue_t *q);

#endif