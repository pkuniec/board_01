#include <stdlib.h>
#include "stm8s.h"
#include "common.h"
#include "nrf24l01.h"
#include "nrf24l01_mem.h"
#include "mnprot.h"

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


// Send data to mesh network
// dest: destination addr
// ttl: TTL hop (0-127)
// data: pointer for data to send
// ack: ACK (0 - off, 1 - on)
void mn_send(uint8_t dest, uint8_t ttl, uint8_t *data, uint8_t ack) {

	uint8_t frame[PAYLOADSIZE] = {0};
	uint8_t i;
	static uint8_t frame_id;

	if( ttl > 127 ) {
		ttl = 127;
	}

	if( ack ) {
		ttl |= 0x80;
	}

	frame[0] = dest;
	frame[1] = MN_ADDR;
	frame[2] = ttl;
	frame[3] = frame_id++;

	for(i = 4; i <PAYLOADSIZE; i++) {
		frame[i] = *data++;
	}

	nrf_sendcmd( W_TX_PAYLOAD_NOACK );
	nrf_write_tx(frame, PAYLOADSIZE);
}


// Decode frame from mesh network
void mn_decode_frame(void) {
    nrf_t *nrf = GetNrfHandler();

	if( (nrf->status & RX_DR) ) {
		if( nrf->data_rx[0] == MN_ADDR ) {
			// execute
			mn_execute();
		} else 	if (nrf->data_rx[0] == 255 && nrf->data_rx[1] != MN_ADDR) {
			// retransmit + execute
			mn_retransmit();
			mn_execute();
		} else if ( nrf->data_rx[1] != MN_ADDR ) {
			// retransmit
			mn_retransmit();
		}

		// Clean RX flag
		nrf->status &= ~RX_DR;
	}
}


// Execute frame
void mn_execute(void) {
    nrf_t *nrf = GetNrfHandler();
	uint8_t x;
	uint8_t e = 1;

	// Check if frame already have been executed
	for( x = 0; x < CMP_BUFF_SIZE; x++) {
		if( (mn_frame.cmpframe[0][x] == nrf->data_rx[SRC_ADDR]) && (mn_frame.cmpframe[1][x] == nrf->data_rx[FRAME_ID]) ) {
			e = 0;
			break;
		}
	}

	if( e ) {
		// save execute frame info in frame buff
		mn_frame.cframe_idx = (++mn_frame.cframe_idx & (CMP_BUFF_SIZE-1) );
		mn_frame.cmpframe[0][mn_frame.cframe_idx] = nrf->data_rx[SRC_ADDR]; // source addr.
		mn_frame.cmpframe[1][mn_frame.cframe_idx] = nrf->data_rx[FRAME_ID]; // frame ID

		// execute
		if ( mn_frame.execute ) {
			mn_frame.execute();
		}

		// if ACK
		// if( nrf->data_rx[ACK_TTL] & 0x80 ) {
		// 	e = 0xff;
		// 	nrf_tx_enable();
		// 	mn_send( nrf->data_rx[DST_ADDR], 5, &e, 0);
		// 	delay(500);
		// 	nrf_rx_enable();
		// }
	}
}


// Retransmit frame to mesh network
void mn_retransmit(void) {
    nrf_t *nrf = GetNrfHandler();
	uint8_t ack = (nrf->data_rx[ACK_TTL] & 0x80); // get ACK
	uint8_t x = (nrf->data_rx[ACK_TTL] & 0x7F);	 // x = TTL
	uint8_t send = 1;

	// decrement TTL
	if( --x ) {
		nrf->data_rx[2] = x | ack;

		// check if frame was retransmit
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
			delay(55*MN_ADDR);
			nrf_write_tx(nrf->data_rx, PAYLOADSIZE);
			nrf_rx_enable();
		}
	}
}