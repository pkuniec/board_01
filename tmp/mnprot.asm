;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
	.module mnprot
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _nrf_sendcmd
	.globl _nrf_write_tx
	.globl _nrf_tx_enable
	.globl _nrf_rx_enable
	.globl _delay
	.globl _mn_frame
	.globl _mn_register_cb
	.globl _mn_send
	.globl _mn_decode_frame
	.globl _mn_execute
	.globl _mn_retransmit
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_mn_frame::
	.ds 24
_mn_send_frame_id_65536_73:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	src/mnprot.c: 10: void mn_register_cb(mn_execute_cb func) {
; genLabel
;	-----------------------------------------
;	 function mn_register_cb
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_mn_register_cb:
;	src/mnprot.c: 11: if (func) {
; genIfx
	ldw	x, (0x03, sp)
	jrne	00111$
	jp	00102$
00111$:
;	src/mnprot.c: 12: mn_frame.execute = func;
; skipping iCode since result will be rematerialized
; genPointerSet
	ldw	x, #(_mn_frame + 22)
	ldw	y, (0x03, sp)
	ldw	(x), y
; genGoto
	jp	00104$
; genLabel
00102$:
;	src/mnprot.c: 14: mn_frame.execute = NULL;
; skipping iCode since result will be rematerialized
; genPointerSet
	ldw	x, #(_mn_frame + 22)
	clr	(0x1, x)
	clr	(x)
; genLabel
00104$:
;	src/mnprot.c: 16: }
; genEndFunction
	ret
;	src/mnprot.c: 19: void mn_send(uint8_t dest, uint8_t ttl, uint8_t *data, uint8_t ack) {
; genLabel
;	-----------------------------------------
;	 function mn_send
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 13 bytes.
_mn_send:
	sub	sp, #13
;	src/mnprot.c: 21: uint8_t frame[PAYLOADSIZE] = {0};
; skipping iCode since result will be rematerialized
; genPointerSet
	clr	(0x05, sp)
; genPlus
	ldw	x, sp
	addw	x, #6
	ldw	(0x01, sp), x
; genPointerSet
	ldw	x, (0x01, sp)
	clr	(x)
; genPlus
	ldw	x, sp
	addw	x, #7
	ldw	(0x03, sp), x
; genPointerSet
	ldw	x, (0x03, sp)
	clr	(x)
; genPlus
	ldw	y, sp
	addw	y, #8
; genPointerSet
	clr	(y)
; genPlus
	ldw	x, sp
	addw	x, #9
; genPointerSet
	clr	(x)
; genPlus
	ldw	x, sp
	addw	x, #10
; genPointerSet
	clr	(x)
; genPlus
	ldw	x, sp
	addw	x, #11
; genPointerSet
	clr	(x)
; genPlus
	ldw	x, sp
	addw	x, #12
; genPointerSet
	clr	(x)
;	src/mnprot.c: 25: if( ttl > 127 ) {
; genCmp
; genCmpTop
	ld	a, (0x11, sp)
	cp	a, #0x7f
	jrugt	00131$
	jp	00102$
00131$:
; skipping generated iCode
;	src/mnprot.c: 26: ttl = 127;
; genAssign
	ld	a, #0x7f
	ld	(0x11, sp), a
; genLabel
00102$:
;	src/mnprot.c: 29: if( ack ) {
; genIfx
	tnz	(0x14, sp)
	jrne	00132$
	jp	00104$
00132$:
;	src/mnprot.c: 30: ttl |= 0x80;
; genAssign
	ld	a, (0x11, sp)
; genOr
	or	a, #0x80
	ld	(0x11, sp), a
; genLabel
00104$:
;	src/mnprot.c: 33: frame[0] = dest;
; genPointerSet
	ld	a, (0x10, sp)
	ld	(0x05, sp), a
;	src/mnprot.c: 34: frame[1] = MN_ADDR;
; genPointerSet
	ldw	x, (0x01, sp)
	ld	a, #0x03
	ld	(x), a
;	src/mnprot.c: 35: frame[2] = ttl;
; genPointerSet
	ldw	x, (0x03, sp)
	ld	a, (0x11, sp)
	ld	(x), a
;	src/mnprot.c: 36: frame[3] = frame_id++;
; genAssign
	ld	a, _mn_send_frame_id_65536_73+0
; genPlus
	inc	_mn_send_frame_id_65536_73+0
; genPointerSet
	ld	(y), a
;	src/mnprot.c: 38: for(i = 4; i <PAYLOADSIZE; i++) {
; genAssign
	ldw	y, (0x12, sp)
; genAssign
	ld	a, #0x04
	ld	(0x0d, sp), a
; genLabel
00106$:
;	src/mnprot.c: 39: frame[i] = *data++;
; genPlus
	clrw	x
	ld	a, (0x0d, sp)
	ld	xl, a
	pushw	x
	ldw	x, sp
	addw	x, #7
	addw	x, (1, sp)
	addw	sp, #2
; genPointerGet
	ld	a, (y)
; genPlus
	incw	y
; genPointerSet
	ld	(x), a
;	src/mnprot.c: 38: for(i = 4; i <PAYLOADSIZE; i++) {
; genPlus
	inc	(0x0d, sp)
; genCmp
; genCmpTop
	ld	a, (0x0d, sp)
	cp	a, #0x08
	jrnc	00133$
	jp	00106$
00133$:
; skipping generated iCode
;	src/mnprot.c: 42: nrf_sendcmd( W_TX_PAYLOAD_NOACK );
; genIPush
	push	#0xb0
; genCall
	call	_nrf_sendcmd
	pop	a
;	src/mnprot.c: 43: nrf_write_tx(frame, PAYLOADSIZE);
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genIPush
	push	#0x08
; genIPush
	ldw	x, sp
	addw	x, #6
	pushw	x
; genCall
	call	_nrf_write_tx
	addw	sp, #3
; genLabel
00108$:
;	src/mnprot.c: 44: }
; genEndFunction
	addw	sp, #13
	ret
;	src/mnprot.c: 47: void mn_decode_frame(void) {
; genLabel
;	-----------------------------------------
;	 function mn_decode_frame
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 0 bytes.
_mn_decode_frame:
;	src/mnprot.c: 48: if( (sys_nrf.status & RX_DR) ) {
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _sys_nrf+0
; genAnd
	bcp	a, #0x40
	jrne	00139$
	jp	00112$
00139$:
; skipping generated iCode
;	src/mnprot.c: 49: if( sys_nrf.data_rx[0] == MN_ADDR ) {
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _sys_nrf+2
	ld	xl, a
; genCmpEQorNE
	ld	a, xl
	cp	a, #0x03
	jrne	00141$
	jp	00142$
00141$:
	jp	00108$
00142$:
; skipping generated iCode
;	src/mnprot.c: 51: mn_execute();
; genCall
	call	_mn_execute
; genGoto
	jp	00109$
; genLabel
00108$:
;	src/mnprot.c: 52: } else 	if (sys_nrf.data_rx[0] == 255 && sys_nrf.data_rx[1] != MN_ADDR) {
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _sys_nrf+3
; genCmpEQorNE
	cp	a, #0x03
	jrne	00144$
	ld	a, #0x01
	jp	00145$
00144$:
	clr	a
00145$:
; genCmpEQorNE
	push	a
	ld	a, xl
	inc	a
	pop	a
	jrne	00147$
	jp	00148$
00147$:
	jp	00104$
00148$:
; skipping generated iCode
; genIfx
	tnz	a
	jreq	00149$
	jp	00104$
00149$:
;	src/mnprot.c: 54: mn_retransmit();
; genCall
	call	_mn_retransmit
;	src/mnprot.c: 55: mn_execute();
; genCall
	call	_mn_execute
; genGoto
	jp	00109$
; genLabel
00104$:
;	src/mnprot.c: 56: } else if ( sys_nrf.data_rx[1] != MN_ADDR ) {
; genIfx
	tnz	a
	jreq	00150$
	jp	00109$
00150$:
;	src/mnprot.c: 58: mn_retransmit();
; genCall
	call	_mn_retransmit
; genLabel
00109$:
;	src/mnprot.c: 62: sys_nrf.status &= ~RX_DR;
; genPointerGet
	ld	a, _sys_nrf+0
; genAnd
	and	a, #0xbf
; genPointerSet
	ld	_sys_nrf+0, a
; genLabel
00112$:
;	src/mnprot.c: 64: }
; genEndFunction
	ret
;	src/mnprot.c: 67: void mn_execute(void) {
; genLabel
;	-----------------------------------------
;	 function mn_execute
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 7 bytes.
_mn_execute:
	sub	sp, #7
;	src/mnprot.c: 69: uint8_t e = 1;
; genAssign
	ld	a, #0x01
	ld	(0x01, sp), a
;	src/mnprot.c: 72: for( x = 0; x < CMP_BUFF_SIZE; x++) {
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genPlus
	ldw	x, #(_sys_nrf + 0)+3
	ldw	(0x02, sp), x
; genAssign
	clr	(0x07, sp)
; genLabel
00109$:
;	src/mnprot.c: 73: if( (mn_frame.cmpframe[0][x] == sys_nrf.data_rx[SRC_ADDR]) && (mn_frame.cmpframe[1][x] == sys_nrf.data_rx[FRAME_ID]) ) {
; genPlus
	clrw	x
	ld	a, (0x07, sp)
	ld	xl, a
	addw	x, #(_mn_frame + 0)
; genPointerGet
	ld	a, (x)
	ld	(0x06, sp), a
; genPointerGet
	ldw	x, (0x02, sp)
	ld	a, (x)
; genPlus
	ldw	x, #(_sys_nrf + 0)+5
	ldw	(0x04, sp), x
; genCmpEQorNE
	cp	a, (0x06, sp)
	jrne	00139$
	jp	00140$
00139$:
	jp	00110$
00140$:
; skipping generated iCode
; genPlus
	ldw	x, #(_mn_frame + 0)+4
; genPlus
	ld	a, xl
	add	a, (0x07, sp)
	ld	xl, a
	ld	a, xh
	adc	a, #0x00
; genPointerGet
	ld	xh, a
	ld	a, (x)
	ld	(0x06, sp), a
; genPointerGet
	ldw	x, (0x04, sp)
	ld	a, (x)
; genCmpEQorNE
	cp	a, (0x06, sp)
	jrne	00142$
	jp	00143$
00142$:
	jp	00110$
00143$:
; skipping generated iCode
;	src/mnprot.c: 74: e = 0;
; genAssign
	clr	(0x01, sp)
;	src/mnprot.c: 75: break;
; genGoto
	jp	00104$
; genLabel
00110$:
;	src/mnprot.c: 72: for( x = 0; x < CMP_BUFF_SIZE; x++) {
; genPlus
	inc	(0x07, sp)
; genCmp
; genCmpTop
	ld	a, (0x07, sp)
	cp	a, #0x04
	jrnc	00144$
	jp	00109$
00144$:
; skipping generated iCode
; genLabel
00104$:
;	src/mnprot.c: 79: if( e ) {
; genIfx
	tnz	(0x01, sp)
	jrne	00145$
	jp	00111$
00145$:
;	src/mnprot.c: 81: mn_frame.cframe_idx = (++mn_frame.cframe_idx & (CMP_BUFF_SIZE-1) );
; skipping iCode since result will be rematerialized
; genPlus
	ldw	x, #(_mn_frame + 0)+8
; genPointerGet
	ld	a, (x)
; genPlus
	inc	a
; genPointerSet
	ld	(x), a
; genAnd
	and	a, #0x03
	ld	(0x07, sp), a
; genPointerSet
	ld	a, (0x07, sp)
	ld	(x), a
;	src/mnprot.c: 82: mn_frame.cmpframe[0][mn_frame.cframe_idx] = sys_nrf.data_rx[SRC_ADDR]; // source addr.
; genPlus
	clrw	x
	ld	a, (0x07, sp)
	ld	xl, a
	addw	x, #(_mn_frame + 0)
; genPointerGet
	ldw	y, (0x02, sp)
	ld	a, (y)
; genPointerSet
	ld	(x), a
;	src/mnprot.c: 83: mn_frame.cmpframe[1][mn_frame.cframe_idx] = sys_nrf.data_rx[FRAME_ID]; // frame ID
; genPlus
	ldw	x, #(_mn_frame + 0)+4
; genPlus
	ld	a, xl
	add	a, (0x07, sp)
	ld	xl, a
	ld	a, xh
	adc	a, #0x00
	ld	xh, a
; genPointerGet
	ldw	y, (0x04, sp)
	ld	a, (y)
; genPointerSet
	ld	(x), a
;	src/mnprot.c: 86: if ( mn_frame.execute ) {
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	x, _mn_frame+22
; genIfx
	tnzw	x
	jrne	00146$
	jp	00111$
00146$:
;	src/mnprot.c: 87: mn_frame.execute();
; genCall
	addw	sp, #7
	jp	(x)
; genLabel
00111$:
;	src/mnprot.c: 99: }
; genEndFunction
	addw	sp, #7
	ret
;	src/mnprot.c: 102: void mn_retransmit(void) {
; genLabel
;	-----------------------------------------
;	 function mn_retransmit
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 17 bytes.
_mn_retransmit:
	sub	sp, #17
;	src/mnprot.c: 103: uint8_t ack = (sys_nrf.data_rx[ACK_TTL] & 0x80); // get ACK
; skipping iCode since result will be rematerialized
; genPlus
	ldw	x, #(_sys_nrf + 0)+2
	ldw	(0x01, sp), x
; genAssign
	ldw	y, (0x01, sp)
	ldw	(0x03, sp), y
; genPlus
	ldw	x, #(_sys_nrf + 0)+4
	ldw	(0x0d, sp), x
; genPointerGet
	ldw	x, (0x0d, sp)
	ld	a, (x)
	ld	xh, a
; genAnd
	ld	a, xh
	and	a, #0x80
	ld	(0x0f, sp), a
;	src/mnprot.c: 104: uint8_t x = (sys_nrf.data_rx[ACK_TTL] & 0x7F);	 // x = TTL
; genAnd
	sllw	x
	srlw	x
;	src/mnprot.c: 105: uint8_t send = 1;
; genAssign
	ld	a, #0x01
	ld	(0x05, sp), a
;	src/mnprot.c: 108: if( --x ) {
; genMinus
	ld	a, xh
	dec	a
	ld	(0x11, sp), a
; genIfx
	tnz	(0x11, sp)
	jrne	00144$
	jp	00112$
00144$:
;	src/mnprot.c: 109: sys_nrf.data_rx[2] = x | ack;
; genOr
	ld	a, (0x11, sp)
	or	a, (0x0f, sp)
	ld	(0x11, sp), a
; genPointerSet
	ldw	x, (0x0d, sp)
	ld	a, (0x11, sp)
	ld	(x), a
;	src/mnprot.c: 112: for(x=0; x<RET_BUFF_SIZE; x++) {
; genPlus
	ldw	x, #(_sys_nrf + 0)+5
	ldw	(0x06, sp), x
; genPlus
	ldw	x, #(_sys_nrf + 0)+3
	ldw	(0x08, sp), x
; skipping iCode since result will be rematerialized
; genPlus
	ldw	x, #(_mn_frame + 0)+9
	ldw	(0x0a, sp), x
; genAssign
	clr	(0x11, sp)
; genLabel
00110$:
;	src/mnprot.c: 113: if( (mn_frame.retframe[0][x] == sys_nrf.data_rx[DST_ADDR]) && (mn_frame.retframe[1][x] == sys_nrf.data_rx[SRC_ADDR]) && (mn_frame.retframe[2][x] == sys_nrf.data_rx[FRAME_ID]) ) {
; genPlus
	clrw	x
	ld	a, (0x11, sp)
	ld	xl, a
	addw	x, (0x0a, sp)
; genPointerGet
	ld	a, (x)
	ld	(0x10, sp), a
; genPointerGet
	ldw	x, (0x03, sp)
	ld	a, (x)
; genPlus
	ldw	x, #(_mn_frame + 0)+13
	ldw	(0x0c, sp), x
; genPlus
	ldw	x, #(_mn_frame + 0)+17
	ldw	(0x0e, sp), x
; genCmpEQorNE
	cp	a, (0x10, sp)
	jrne	00146$
	jp	00147$
00146$:
	jp	00111$
00147$:
; skipping generated iCode
; genPlus
	clrw	x
	ld	a, (0x11, sp)
	ld	xl, a
	addw	x, (0x0c, sp)
; genPointerGet
	ld	a, (x)
	ld	(0x10, sp), a
; genPointerGet
	ldw	x, (0x08, sp)
	ld	a, (x)
; genCmpEQorNE
	cp	a, (0x10, sp)
	jrne	00149$
	jp	00150$
00149$:
	jp	00111$
00150$:
; skipping generated iCode
; genPlus
	clrw	x
	ld	a, (0x11, sp)
	ld	xl, a
	addw	x, (0x0e, sp)
; genPointerGet
	ld	a, (x)
	ld	(0x10, sp), a
; genPointerGet
	ldw	x, (0x06, sp)
	ld	a, (x)
; genCmpEQorNE
	cp	a, (0x10, sp)
	jrne	00152$
	jp	00153$
00152$:
	jp	00111$
00153$:
; skipping generated iCode
;	src/mnprot.c: 114: send = 0;
; genAssign
	clr	(0x05, sp)
;	src/mnprot.c: 115: break;
; genGoto
	jp	00105$
; genLabel
00111$:
;	src/mnprot.c: 112: for(x=0; x<RET_BUFF_SIZE; x++) {
; genPlus
	inc	(0x11, sp)
; genCmp
; genCmpTop
	ld	a, (0x11, sp)
	cp	a, #0x04
	jrnc	00154$
	jp	00110$
00154$:
; skipping generated iCode
; genLabel
00105$:
;	src/mnprot.c: 119: if( send ) {
; genIfx
	tnz	(0x05, sp)
	jrne	00155$
	jp	00112$
00155$:
;	src/mnprot.c: 120: nrf_tx_enable();
; genCall
	call	_nrf_tx_enable
;	src/mnprot.c: 121: mn_frame.rframe_idx = (++mn_frame.rframe_idx & (RET_BUFF_SIZE-1) );
; genPlus
	ldw	x, #(_mn_frame + 0)+21
; genPointerGet
	ld	a, (x)
; genPlus
	inc	a
; genPointerSet
	ld	(x), a
; genAnd
	and	a, #0x03
	ld	(0x11, sp), a
; genPointerSet
	ld	a, (0x11, sp)
	ld	(x), a
;	src/mnprot.c: 122: mn_frame.retframe[0][mn_frame.rframe_idx] = sys_nrf.data_rx[DST_ADDR];
; genPlus
	clrw	x
	ld	a, (0x11, sp)
	ld	xl, a
	addw	x, (0x0a, sp)
; genPointerGet
	ldw	y, (0x03, sp)
	ld	a, (y)
; genPointerSet
	ld	(x), a
;	src/mnprot.c: 123: mn_frame.retframe[1][mn_frame.rframe_idx] = sys_nrf.data_rx[SRC_ADDR];
; genPlus
	clrw	x
	ld	a, (0x11, sp)
	ld	xl, a
	addw	x, (0x0c, sp)
; genPointerGet
	ldw	y, (0x08, sp)
	ld	a, (y)
; genPointerSet
	ld	(x), a
;	src/mnprot.c: 124: mn_frame.retframe[2][mn_frame.rframe_idx] = sys_nrf.data_rx[FRAME_ID];
; genPlus
	clrw	x
	ld	a, (0x11, sp)
	ld	xl, a
	addw	x, (0x0e, sp)
; genPointerGet
	ldw	y, (0x06, sp)
	ld	a, (y)
; genPointerSet
	ld	(x), a
;	src/mnprot.c: 125: nrf_sendcmd( W_TX_PAYLOAD_NOACK );
; genIPush
	push	#0xb0
; genCall
	call	_nrf_sendcmd
	pop	a
;	src/mnprot.c: 126: delay(55*MN_ADDR);
; genIPush
	push	#0xa5
	push	#0x00
; genCall
	call	_delay
	addw	sp, #2
;	src/mnprot.c: 127: nrf_write_tx(sys_nrf.data_rx, PAYLOADSIZE);
; genCast
; genAssign
	ldw	x, (0x01, sp)
; genIPush
	push	#0x08
; genIPush
	pushw	x
; genCall
	call	_nrf_write_tx
	addw	sp, #3
;	src/mnprot.c: 128: nrf_rx_enable();
; genCall
	addw	sp, #17
	jp	_nrf_rx_enable
; genLabel
00112$:
;	src/mnprot.c: 131: }
; genEndFunction
	addw	sp, #17
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
