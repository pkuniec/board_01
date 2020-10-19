#ifdef __SDCC__
  #include "stm8s.h"
#else
  #include <inttypes.h>
  #include "stm8s_sim_def.h"
  #include "stm8s_sim.h"
#endif

#include <stdlib.h>
#include "common.h"
#include "nrf24l01.h"
#include "nrf24l01_mem.h"
#include "mnprot.h"

// Static global
static mn_frame_t mn_frame;


// Register callback function
// func: function addr
void mn_register_cb(mn_execute_cb func) {
	if (func) {
		mn_frame.execute = func;
	} else {
		mn_frame.execute = NULL;
	}
}


// Send frame to module
// data: pointer to payload buffer 
static void mn_send_hw(uint8_t *data) {
	nrf_tx_enable();
	nrf_sendcmd( W_TX_PAYLOAD_NOACK );
	nrf_write_tx(data, PAYLOADSIZE);
	nrf_rx_enable();
}


// Copy data to payload buffer
// *src: poiter to source data
// size: data size
// idx: payload buffer index to put data
static void cp2buff(uint8_t *src, uint8_t size, uint8_t idx) {
	uint8_t i;

	if (idx < PL_BUFF_SIZE) {
		for(i = 0; i <size; i++) {
			mn_frame.frame[idx][i] = *src++;
		}
		mn_frame.frame[idx][PAYLOAD_COUNT] = 1;
	}
}


// Return free index in payload buffer
// *idx: pointer to variable for free index num
// Return: 0 - OK, -1 - no free index
static int8_t get_free_plidx(uint8_t *idx) {

	for (uint8_t i=0; i<PL_BUFF_SIZE; i++) {
	// Search free space in buffer frame
		if ( !mn_frame.frame[i][PAYLOAD_COUNT] ) {
			*idx = i;
			return 0;
		}
	}

	return -1;
}


// Send data to mesh network
// dest: destination addr
// ttl: TTL hop (0-127)
// data: pointer for data to send
// size: data size
// ack: ACK (0 - off, 1 - on)
// return: -1: no space in ack buff, -2: no space in payload buff
int8_t mn_send(uint8_t dst, uint8_t ttl, uint8_t *data, uint8_t size, uint8_t ack) {
	uint8_t i;
	int8_t idx;

	if (get_free_plidx(&idx)) {
		return -2;
	}

	if (ttl > 127) {
		ttl = DEFAULT_TTL;
	}

	mn_frame.frame[idx][DST_ADDR] = dst;
	mn_frame.frame[idx][SRC_ADDR] = MN_ADDR;
	mn_frame.frame[idx][PAYLOAD_COUNT] = 1;
	mn_frame.frame[idx][ACK_TTL] = ttl;
	mn_frame.frame[idx][FRAME_ID] = mn_frame.frame_id++;
	mn_frame.frame[idx][PAYLOAD_TIMESTAMP] = mn_frame.timestamp;

	if ( ack ) {
		ttl |= 0x80;
		mn_frame.frame[idx][PAYLOAD_COUNT]+= ACK_RET_COUNT;
		mn_frame.frame[idx][ACK_TTL] = ttl;
	}	


	// calc frame index to put payload
	size = size + 4;
	if (size > PAYLOADSIZE) {
		size = PAYLOADSIZE;
	}

	for(i = 4; i <size; i++) {
		mn_frame.frame[idx][i] = *data++;
	}

	return 0;
}


// Send frame from buffer to module
void send_to_mesh(void) {
	static uint8_t i;

	if (mn_frame.frame[i][PAYLOAD_COUNT]) {
		if (mn_frame.frame[i][PAYLOAD_TIMESTAMP] < mn_frame.timestamp ) {
			mn_frame.frame[i][PAYLOAD_COUNT]--;
			mn_frame.frame[i][PAYLOAD_TIMESTAMP] = mn_frame.timestamp + 100;
			mn_frame.frame[i][FRAME_ID]--;
			mn_send_hw(mn_frame.frame[i]);
		}
	}

	i++;
	i = (i & PL_BUFF_SIZE-1);
	mn_frame.timestamp++;

	// if (i == PL_BUFF_SIZE) {
	// 	i = 0;
	// 	mn_frame.timestamp++;
	// }
}




// Retransmit frame to mesh network
static void mn_retransmit(void) {
    nrf_t *nrf = GetNrfHandler();
	uint8_t ack = (nrf->data_rx[ACK_TTL] & 0x80); // get ACK
	uint8_t x = (nrf->data_rx[ACK_TTL] & 0x7F);	 // x = TTL
	int8_t send = 1;

	// Decrement TTL
	if( x-- ) {
		nrf->data_rx[ACK_TTL] = x | ack;

		// Check if frame was retransmit
		for(x=0; x<RET_BUFF_SIZE; x++) {
			if( (mn_frame.retframe[0][x] == nrf->data_rx[DST_ADDR]) && (mn_frame.retframe[1][x] == nrf->data_rx[SRC_ADDR]) && (mn_frame.retframe[2][x] == nrf->data_rx[FRAME_ID]) ) {
				send = 0;
				break;
			}
		}

		if( send ) {
			mn_frame.rframe_idx = (++mn_frame.rframe_idx & (RET_BUFF_SIZE-1) );
			mn_frame.retframe[0][mn_frame.rframe_idx] = nrf->data_rx[DST_ADDR];
			mn_frame.retframe[1][mn_frame.rframe_idx] = nrf->data_rx[SRC_ADDR];
			mn_frame.retframe[2][mn_frame.rframe_idx] = nrf->data_rx[FRAME_ID];

			// Get free index in buffer
			if (!get_free_plidx(&send)) {
				cp2buff(nrf->data_rx, PAYLOADSIZE, send);
			}
		}
	}
}


// Execute frame
// ack: 0 - never send ACK
//      1 - send ACK if is set in frame
static void mn_execute(uint8_t ack) {
    nrf_t *nrf = GetNrfHandler();
	uint8_t x;
	uint8_t e = 1;
	uint8_t ack_replay[2];

	// Check if frame already have been executed
	for( x = 0; x < CMP_BUFF_SIZE; x++) {
		if ( (mn_frame.cmpframe[0][x] == nrf->data_rx[SRC_ADDR]) && (mn_frame.cmpframe[1][x] == nrf->data_rx[FRAME_ID]) ) {
			e = 0;
			break;
		}
	}

    if( e ) {
        // Save execute frame info in frame buff
        mn_frame.cframe_idx = (++mn_frame.cframe_idx & (CMP_BUFF_SIZE-1) );
        mn_frame.cmpframe[0][mn_frame.cframe_idx] = nrf->data_rx[SRC_ADDR]; // source addr.
        mn_frame.cmpframe[1][mn_frame.cframe_idx] = nrf->data_rx[FRAME_ID]; // frame ID

		// If is set ACK, send it
		if ( (nrf->data_rx[ACK_TTL] & 0x80) && ack) {
			ack_replay[0] = 0xFF; // ACK patern (func 0xFF)
			ack_replay[1] = nrf->data_rx[FRAME_ID];
			mn_send( nrf->data_rx[SRC_ADDR], DEFAULT_TTL, ack_replay, 2, 0);
		}

	    // Execute
        if ( mn_frame.execute ) {
            mn_frame.execute();
        }
	}
}


// Decode frame from mesh network
// This function tak action for recived frame (exec, retransmit, mark ACK response)
void mn_decode_frame(void) {
    nrf_t *nrf = GetNrfHandler();
	uint8_t x;

	if( (nrf->status & RX_DR) ) {

		// Frame have own SRC addr
		if( nrf->data_rx[DST_ADDR] == MN_ADDR ) {

			// Check if it's ACK (func no. is 0xFF)
			if(0xFF == nrf->data_rx[FRAME_1] ) {
				// check and mark frame in payload buffer as send
				for( x = 0; x < PL_BUFF_SIZE; x++) {
					if (mn_frame.frame[x][DST_ADDR] == nrf->data_rx[SRC_ADDR]) { // check if SRC addr == dst in ACK buffer
						if (mn_frame.frame[x][FRAME_ID] == nrf->data_rx[FRAME_2]) { // check if Frame ID is correct
							mn_frame.frame[x][PAYLOAD_COUNT] = 0;
							break;
						}
					}
				}

			} else {
			// Execute
				mn_execute(1);
			}
		} else 	if (255 == nrf->data_rx[DST_ADDR] && nrf->data_rx[SRC_ADDR] != MN_ADDR) {
			// Retransmit + execute
			mn_retransmit();
			mn_execute(0);
		} else if ( nrf->data_rx[SRC_ADDR] != MN_ADDR ) {
			// Retransmit
			mn_retransmit();
		}
	}
}