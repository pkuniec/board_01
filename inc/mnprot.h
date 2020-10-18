#ifndef MNPROT_H
#define MNPROT_H

#define MN_ADDR		9 //3 - odbiorca, 9 - nadawca

#define CMP_BUFF_SIZE	4
#define RET_BUFF_SIZE	4
#define ACK_BUFF_SIZE	4
#define ACK_RET_COUNT	4
#define DEFAULT_TTL		6

/* Frame structure */
/* | Addr. dest (8 bit) | Addr. src. (8 bit) | ACK (1 bit) | TTL (7 bit) | FRAME ID (8 bit) | PAYLOAD (max. 28 bajt) |*/

#define DST_ADDR	0
#define SRC_ADDR	1
#define ACK_TTL		2
#define FRAME_ID	3


typedef void (*mn_execute_cb)(void);

typedef struct {
	uint8_t cmpframe[2][CMP_BUFF_SIZE]; // 0 - src | 1 - frame ID
	uint8_t cframe_idx;
	uint8_t retframe[3][RET_BUFF_SIZE]; // 0 - dst | 1 - src | 2 - frame ID
	uint8_t rframe_idx;
	uint8_t ackframe[4][ACK_BUFF_SIZE]; // 0 - dst | 1 - frame ID | 2 - ACK retransmit count | 3 - data size
	uint8_t ackframe_idx;
	uint8_t rsend_buff[ACK_BUFF_SIZE][PAYLOADSIZE-4];
	uint8_t ack_free;
	mn_execute_cb execute;
} mn_frame_t;


void mn_register_cb(mn_execute_cb func);
void mn_send(uint8_t dest, uint8_t ttl, uint8_t *data, uint8_t size, uint8_t ack);
void check_ack(void);
void mn_decode_frame(void);
void mn_execute(void);
void mn_retransmit(void);

#endif