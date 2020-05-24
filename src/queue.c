#include "stm8s.h"
#include "queue.h"

int8_t add_queue(queue_t *q, uint8_t value) {
    if (q->cnt < Q_SIZE ) {
        q->queue[( (q->idx + q->cnt) & Q_SIZE-1)] = value;
        q->cnt++;
        return 0;
    } else {
        return -1;
    }
}

int8_t get_queue(queue_t *q, uint8_t *value) {
    if (q->cnt) {
        q->cnt--;
        *value =  q->queue[q->idx++];
        q->idx = (q->idx & Q_SIZE-1);
        return 0;
    } else {
        return -1;
    }
}

uint8_t size_queue(queue_t *q) {
    return q->cnt;
}