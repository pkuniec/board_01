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


// Init structure
void mn_init(void) {
	mn_frame.ack_free = ACK_BUFF_SIZE;
}


// Send frame to module
static void mn_send_hw(void) {
	nrf_tx_enable();
	nrf_sendcmd( W_TX_PAYLOAD_NOACK );
	nrf_write_tx(mn_frame.frame, PAYLOADSIZE);
	nrf_rx_enable();
}


// Send data to mesh network
// dest: destination addr
// ttl: TTL hop (0-127)
// data: pointer for data to send
// size: data size
// ack: ACK (0 - off, 1 - on)
int8_t mn_send(uint8_t dst, uint8_t ttl, uint8_t *data, uint8_t size, uint8_t ack) {

	uint8_t i;
	//uint8_t frame[PAYLOADSIZE] = {0};
	static uint8_t frame_id;


	if ( ttl > 127 ) {
		ttl = DEFAULT_TTL;
	}

	if ( ack ) {
		ttl |= 0x80;
		
		if (mn_frame.ack_free) {

			mn_frame.ack_free--;
			mn_frame.ackframe_idx = (++mn_frame.ackframe_idx & (ACK_BUFF_SIZE-1) );
			mn_frame.ackframe[0][mn_frame.ackframe_idx] = dst;
			mn_frame.ackframe[1][mn_frame.ackframe_idx] = frame_id;
			mn_frame.ackframe[2][mn_frame.ackframe_idx] = ACK_RET_COUNT;
			mn_frame.ackframe[3][mn_frame.ackframe_idx] = size;
		

			for(i=0; i<size; i++) {
				mn_frame.rsend_buff[mn_frame.ackframe_idx][i] = data[i];
			}
		} else {
			return -1;
		}
	}

	mn_frame.frame[0] = dst;
	mn_frame.frame[1] = MN_ADDR;
	mn_frame.frame[2] = ttl;
	mn_frame.frame[3] = frame_id++;

	size = size + 4;
	if (size > PAYLOADSIZE) {
		size = PAYLOADSIZE;
	}

	for(i = 4; i <size; i++) {
		mn_frame.frame[i] = *data++;
	}

	mn_send_hw();
	return 0;
}


// Check & resend ACK
void check_ack(void) {
	static uint8_t x;

	// Check if recived ACK
	if ( mn_frame.ackframe[2][x] ) {
		//resend frame
		mn_frame.ackframe[2][x]--; // decrement resend frame count
		mn_frame.frame[0] = mn_frame.ackframe[0][x]; // DST
		mn_frame.frame[1] = MN_ADDR; // SRC
		mn_frame.frame[2] = DEFAULT_TTL; // TTL
		mn_frame.frame[3] = mn_frame.ackframe[1][x]; // Frame ID

		for(uint8_t i = 0; i <mn_frame.ackframe[3][x]; i++) {
			mn_frame.frame[i+4] = mn_frame.rsend_buff[x][i];
		}

		mn_send_hw();
	}

	x = ++x & (ACK_BUFF_SIZE-1);
}


// Decode frame from mesh network
void mn_decode_frame(void) {
    nrf_t *nrf = GetNrfHandler();
	uint8_t x;

	if( (nrf->status & RX_DR) ) {
		if( nrf->data_rx[DST_ADDR] == MN_ADDR ) {

			// Check if it's ACK (func no. 0xFF)
			if(0xFF == nrf->data_rx[4] ) {
				for( x = 0; x < ACK_BUFF_SIZE; x++) {
					if (mn_frame.ackframe[0][x] == nrf->data_rx[SRC_ADDR]) { // check if SRC addr == dst in ACK buffer
						if (mn_frame.ackframe[1][x] == nrf->data_rx[5]) { // check if Frame ID is correct
							mn_frame.ack_free++;
							mn_frame.ackframe[2][x] = 0;
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


// Execute frame
void mn_execute(uint8_t ack) {
    nrf_t *nrf = GetNrfHandler();
	uint8_t x;
	uint8_t e = 1;
	uint8_t ack_r[2];

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
				ack_r[0] = 0xFF; // ACK patern (func 0xFF)
				ack_r[1] = nrf->data_rx[FRAME_ID];
				nrf_tx_enable();
				delay(10+MN_ADDR);
				mn_send( nrf->data_rx[SRC_ADDR], 6, ack_r, 2, 0);
				nrf_rx_enable();
			}

	    // Execute
        if ( mn_frame.execute ) {
            mn_frame.execute();
        }
	}
}


// Retransmit frame to mesh network
void mn_retransmit(void) {
    nrf_t *nrf = GetNrfHandler();
	uint8_t ack = (nrf->data_rx[ACK_TTL] & 0x80); // get ACK
	uint8_t x = (nrf->data_rx[ACK_TTL] & 0x7F);	 // x = TTL
	uint8_t send = 1;

	// Decrement TTL
	if( --x ) {
		nrf->data_rx[2] = x | ack;

		// Check if frame was retransmit
		for(x=0; x<RET_BUFF_SIZE; x++) {
			if( (mn_frame.retframe[0][x] == nrf->data_rx[DST_ADDR]) && (mn_frame.retframe[1][x] == nrf->data_rx[SRC_ADDR]) && (mn_frame.retframe[2][x] == nrf->data_rx[FRAME_ID]) ) {
				send = 0;
				break;
			}
		}

		if( send ) {
			nrf_tx_enable();
			mn_frame.rframe_idx = (++mn_frame.rframe_idx & (RET_BUFF_SIZE-1) );
			mn_frame.retframe[0][mn_frame.rframe_idx] = nrf->data_rx[DST_ADDR];
			mn_frame.retframe[1][mn_frame.rframe_idx] = nrf->data_rx[SRC_ADDR];
			mn_frame.retframe[2][mn_frame.rframe_idx] = nrf->data_rx[FRAME_ID];
			nrf_sendcmd( W_TX_PAYLOAD_NOACK );
            // Pararandom delay send time
			delay(50*MN_ADDR);
			nrf_write_tx(nrf->data_rx, PAYLOADSIZE);
			nrf_rx_enable();
		}
	}
}