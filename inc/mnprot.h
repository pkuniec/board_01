#ifndef MNPROT_H
#define MNPROT_H

#define MN_ADDR		3 //3 - odbiorca, 9 - nadawca

// !Buffers size must be pow. 2 ex: 2, 4, 8, 16 ...
#define PL_BUFF_SIZE	4
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
	uint8_t frame[PL_BUFF_SIZE][PAYLOADSIZE+1]; // Frame buffer
	uint8_t cmpframe[2][CMP_BUFF_SIZE]; // 0 - src | 1 - frame ID
	uint8_t cframe_idx;
	uint8_t retframe[3][RET_BUFF_SIZE]; // 0 - dst | 1 - src | 2 - frame ID
	uint8_t rframe_idx;
	mn_execute_cb execute;
} mn_frame_t;

void mn_init(void);
void mn_register_cb(mn_execute_cb func);
int8_t mn_send(uint8_t dest, uint8_t ttl, uint8_t *data, uint8_t size, uint8_t ack);
void send_to_mesh(void);
void mn_decode_frame(void);

#endif