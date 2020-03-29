;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
	.module nrf24l01
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _output_set
	.globl _spi_transmit
	.globl _delay
	.globl _nrf_init_hw
	.globl _nrf_power
	.globl _nrf_init_sw
	.globl _nrf_reset
	.globl _nrf_powerdown
	.globl _nrf_rx_enable
	.globl _nrf_tx_enable
	.globl _nrf_read_rx
	.globl _nrf_write_tx
	.globl _nrf_register_cb
	.globl _nrf_event
	.globl _nrf_clear_rxbuff
	.globl _nrf_csn_enable
	.globl _nrf_csn_disable
	.globl _nrf_ce_low
	.globl _nrf_ce_high
	.globl _nrf_sendcmd
	.globl _nrf_readreg
	.globl _nrf_writereg
	.globl _nrf_writereg_many
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
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
;	src/nrf24l01.c: 8: void nrf_init_hw(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_init_hw
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_init_hw:
;	src/nrf24l01.c: 10: GPIOA->DDR |= SPI_CE | SPI_CSN;
; genPointerGet
	ld	a, 0x5002
; genOr
	or	a, #0x0c
; genPointerSet
	ld	0x5002, a
;	src/nrf24l01.c: 11: GPIOA->CR1 |= SPI_CE | SPI_CSN;
; genPointerGet
	ld	a, 0x5003
; genOr
	or	a, #0x0c
; genPointerSet
	ld	0x5003, a
;	src/nrf24l01.c: 12: GPIOA->CR2 |= SPI_CE | SPI_CSN;
; genPointerGet
	ld	a, 0x5004
; genOr
	or	a, #0x0c
; genPointerSet
	ld	0x5004, a
;	src/nrf24l01.c: 13: GPIOA->ODR |= SPI_CSN;
; genPointerGet
	ld	a, 0x5000
; genOr
	or	a, #0x08
; genPointerSet
	ld	0x5000, a
;	src/nrf24l01.c: 15: GPIOC->CR2 |= NRF_IRQ;
; genPointerGet
	ld	a, 0x500e
; genOr
	or	a, #0x08
; genPointerSet
	ld	0x500e, a
;	src/nrf24l01.c: 18: EXTI->CR1 |= 0x20; // PORTC faling edge
; genPointerGet
	ld	a, 0x50a0
; genOr
	or	a, #0x20
; genPointerSet
	ld	0x50a0, a
; genLabel
00101$:
;	src/nrf24l01.c: 19: }
; genEndFunction
	ret
;	src/nrf24l01.c: 22: void nrf_power(uint8_t power) {
; genLabel
;	-----------------------------------------
;	 function nrf_power
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_power:
;	src/nrf24l01.c: 23: if (power) {
; genIfx
	tnz	(0x03, sp)
	jrne	00111$
	jp	00102$
00111$:
;	src/nrf24l01.c: 24: output_set(R_NRF, 0);
; genIPush
	push	#0x00
; genIPush
	push	#0x00
; genCall
	call	_output_set
	addw	sp, #2
;	src/nrf24l01.c: 25: delay(65000);
; genIPush
	push	#0xe8
	push	#0xfd
; genCall
	call	_delay
	addw	sp, #2
; genGoto
	jp	00104$
; genLabel
00102$:
;	src/nrf24l01.c: 27: output_set(R_NRF, 1);
; genIPush
	push	#0x01
; genIPush
	push	#0x00
; genCall
	call	_output_set
	addw	sp, #2
;	src/nrf24l01.c: 28: delay(65000);
; genIPush
	push	#0xe8
	push	#0xfd
; genCall
	call	_delay
	addw	sp, #2
; genLabel
00104$:
;	src/nrf24l01.c: 30: }
; genEndFunction
	ret
;	src/nrf24l01.c: 33: void nrf_init_sw(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_init_sw
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 5 bytes.
_nrf_init_sw:
	sub	sp, #5
;	src/nrf24l01.c: 34: uint8_t addr[5] = {0xA5, 0xE7, 0xE7, 0xE7, 0xA7};
; skipping iCode since result will be rematerialized
; genPointerSet
	ld	a, #0xa5
	ld	(0x01, sp), a
; genPlus
	ldw	x, sp
	addw	x, #2
; genPointerSet
	ld	a, #0xe7
	ld	(x), a
; genPlus
	ldw	x, sp
	addw	x, #3
; genPointerSet
	ld	a, #0xe7
	ld	(x), a
; genPlus
	ldw	x, sp
	addw	x, #4
; genPointerSet
	ld	a, #0xe7
	ld	(x), a
; genPlus
	ldw	x, sp
	addw	x, #5
; genPointerSet
	ld	a, #0xa7
	ld	(x), a
;	src/nrf24l01.c: 36: nrf_writereg( SETUP_AW, AW_5 );
; genIPush
	push	#0x03
; genIPush
	push	#0x03
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 37: nrf_writereg_many( 0, TX_ADDR, addr, 5);
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genIPush
	push	#0x05
; genIPush
	ldw	x, sp
	incw	x
	incw	x
	pushw	x
; genIPush
	push	#0x10
; genIPush
	push	#0x00
; genCall
	call	_nrf_writereg_many
	addw	sp, #5
;	src/nrf24l01.c: 38: nrf_writereg( EN_RXADDR, ERX_P0 | ERX_P1 );
; genIPush
	push	#0x03
; genIPush
	push	#0x02
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 39: nrf_writereg_many( 0, RX_ADDR_P0, addr, 5);
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genIPush
	push	#0x05
; genIPush
	ldw	x, sp
	incw	x
	incw	x
	pushw	x
; genIPush
	push	#0x0a
; genIPush
	push	#0x00
; genCall
	call	_nrf_writereg_many
	addw	sp, #5
;	src/nrf24l01.c: 40: nrf_writereg( RX_PW_P0, PAYLOADSIZE);
; genIPush
	push	#0x08
; genIPush
	push	#0x11
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 41: nrf_writereg( RX_PW_P1, PAYLOADSIZE);
; genIPush
	push	#0x08
; genIPush
	push	#0x12
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 42: nrf_writereg( EN_AA, 0x00);
; genIPush
	push	#0x00
; genIPush
	push	#0x01
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 43: nrf_writereg( RF_CH, 11);
; genIPush
	push	#0x0b
; genIPush
	push	#0x05
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 44: nrf_writereg( RF_SETUP, TRANS_SPEED_1MB );
; genIPush
	push	#0x00
; genIPush
	push	#0x06
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 45: nrf_writereg( SETUP_RETR, 0x40);
; genIPush
	push	#0x40
; genIPush
	push	#0x04
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 46: nrf_writereg( FEATURE, EN_DYN_ACK);
; genIPush
	push	#0x00
; genIPush
	push	#0x1d
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 47: nrf_writereg( CONFIG, EN_CRC | CRC0 | MASK_MAX_RT | MASK_TX_DS);
; genIPush
	push	#0x3c
; genIPush
	push	#0x00
; genCall
	call	_nrf_writereg
	addw	sp, #2
; genLabel
00101$:
;	src/nrf24l01.c: 48: }
; genEndFunction
	addw	sp, #5
	ret
;	src/nrf24l01.c: 51: void nrf_reset(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_reset
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_reset:
;	src/nrf24l01.c: 52: nrf_power(0);
; genIPush
	push	#0x00
; genCall
	call	_nrf_power
	pop	a
;	src/nrf24l01.c: 53: nrf_power(1);
; genIPush
	push	#0x01
; genCall
	call	_nrf_power
	pop	a
;	src/nrf24l01.c: 55: nrf_writereg( CONFIG, 0x08 );
; genIPush
	push	#0x08
; genIPush
	push	#0x00
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 56: nrf_writereg( RX_PW_P0, 0x00);
; genIPush
	push	#0x00
; genIPush
	push	#0x11
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 57: nrf_writereg( EN_AA, 0x00 );
; genIPush
	push	#0x00
; genIPush
	push	#0x01
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 58: nrf_writereg( EN_RXADDR, 0x00 );
; genIPush
	push	#0x00
; genIPush
	push	#0x02
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 59: nrf_writereg( RF_CH, 0x00 );
; genIPush
	push	#0x00
; genIPush
	push	#0x05
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 60: nrf_writereg( RF_SETUP, 0x00 );
; genIPush
	push	#0x00
; genIPush
	push	#0x06
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 61: nrf_writereg( STATUS, 0xe0 );
; genIPush
	push	#0xe0
; genIPush
	push	#0x07
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 62: nrf_sendcmd( FLUSH_TX );
; genIPush
	push	#0xe1
; genCall
	call	_nrf_sendcmd
	pop	a
;	src/nrf24l01.c: 63: nrf_sendcmd( FLUSH_RX );
; genIPush
	push	#0xe2
; genCall
	call	_nrf_sendcmd
	pop	a
; genLabel
00101$:
;	src/nrf24l01.c: 64: }
; genEndFunction
	ret
;	src/nrf24l01.c: 67: void nrf_powerdown(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_powerdown
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_powerdown:
;	src/nrf24l01.c: 69: nrf_ce_low();
; genCall
	call	_nrf_ce_low
;	src/nrf24l01.c: 71: config = nrf_readreg( CONFIG );
; genIPush
	push	#0x00
; genCall
	call	_nrf_readreg
	addw	sp, #1
; genAssign
;	src/nrf24l01.c: 72: config &= ~(PWR_UP | PRIM_RX);
; genAnd
	and	a, #0xfc
;	src/nrf24l01.c: 73: nrf_writereg( CONFIG, config );
; genIPush
	push	a
; genIPush
	push	#0x00
; genCall
	call	_nrf_writereg
	addw	sp, #2
; genLabel
00101$:
;	src/nrf24l01.c: 74: }
; genEndFunction
	ret
;	src/nrf24l01.c: 77: void nrf_rx_enable(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_rx_enable
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_rx_enable:
;	src/nrf24l01.c: 79: nrf_ce_low();
; genCall
	call	_nrf_ce_low
;	src/nrf24l01.c: 81: config = nrf_readreg( CONFIG );
; genIPush
	push	#0x00
; genCall
	call	_nrf_readreg
	addw	sp, #1
; genAssign
;	src/nrf24l01.c: 82: nrf_writereg( CONFIG, config | PRIM_RX | PWR_UP );
; genOr
	push	a
	or	a, #0x03
	ld	xl, a
	pop	a
; genIPush
	push	a
	pushw	x
	addw	sp, #1
; genIPush
	push	#0x00
; genCall
	call	_nrf_writereg
	addw	sp, #2
	pop	a
;	src/nrf24l01.c: 83: while( !(config & (PWR_UP | PRIM_RX)) ) {
; genLabel
00101$:
; genAnd
	bcp	a, #0x03
	jreq	00116$
	jp	00103$
00116$:
; skipping generated iCode
;	src/nrf24l01.c: 84: config = nrf_readreg( CONFIG );
; genIPush
	push	#0x00
; genCall
	call	_nrf_readreg
	addw	sp, #1
; genAssign
; genGoto
	jp	00101$
; genLabel
00103$:
;	src/nrf24l01.c: 87: nrf_ce_high();
; genCall
	call	_nrf_ce_high
;	src/nrf24l01.c: 88: nrf_sendcmd( FLUSH_RX );
; genIPush
	push	#0xe2
; genCall
	call	_nrf_sendcmd
	pop	a
; genLabel
00104$:
;	src/nrf24l01.c: 89: }
; genEndFunction
	ret
;	src/nrf24l01.c: 92: void nrf_tx_enable(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_tx_enable
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_tx_enable:
;	src/nrf24l01.c: 94: nrf_ce_low();
; genCall
	call	_nrf_ce_low
;	src/nrf24l01.c: 96: config = nrf_readreg( CONFIG );
; genIPush
	push	#0x00
; genCall
	call	_nrf_readreg
	addw	sp, #1
; genAssign
;	src/nrf24l01.c: 97: config &= ~(PRIM_RX);
; genAnd
	and	a, #0xfe
;	src/nrf24l01.c: 98: nrf_writereg( CONFIG, config | PWR_UP );
; genOr
	push	a
	or	a, #0x02
	ld	xl, a
	pop	a
; genIPush
	push	a
	pushw	x
	addw	sp, #1
; genIPush
	push	#0x00
; genCall
	call	_nrf_writereg
	addw	sp, #2
	pop	a
;	src/nrf24l01.c: 99: while( !(config & PWR_UP) ) {
; genLabel
00101$:
; genAnd
	bcp	a, #0x02
	jreq	00116$
	jp	00103$
00116$:
; skipping generated iCode
;	src/nrf24l01.c: 100: config = nrf_readreg( CONFIG );
; genIPush
	push	#0x00
; genCall
	call	_nrf_readreg
	addw	sp, #1
; genAssign
; genGoto
	jp	00101$
; genLabel
00103$:
;	src/nrf24l01.c: 102: nrf_sendcmd( FLUSH_TX );
; genIPush
	push	#0xe1
; genCall
	call	_nrf_sendcmd
	pop	a
; genLabel
00104$:
;	src/nrf24l01.c: 103: }
; genEndFunction
	ret
;	src/nrf24l01.c: 106: void nrf_read_rx(uint8_t *data, uint8_t len) {
; genLabel
;	-----------------------------------------
;	 function nrf_read_rx
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 1 bytes.
_nrf_read_rx:
	push	a
;	src/nrf24l01.c: 107: nrf_csn_enable();
; genCall
	call	_nrf_csn_enable
;	src/nrf24l01.c: 108: spi_transmit( R_RX_PAYLOAD );
; genIPush
	push	#0x61
; genCall
	call	_spi_transmit
	pop	a
;	src/nrf24l01.c: 109: while(len--) {
; genAssign
	ldw	x, (0x04, sp)
; genAssign
	ld	a, (0x06, sp)
	ld	(0x01, sp), a
; genLabel
00101$:
; genAssign
	ld	a, (0x01, sp)
; genMinus
	dec	(0x01, sp)
; genIfx
	tnz	a
	jrne	00117$
	jp	00103$
00117$:
;	src/nrf24l01.c: 110: *data++ = spi_transmit( NOP );
; genIPush
	pushw	x
	push	#0xff
; genCall
	call	_spi_transmit
	addw	sp, #1
	popw	x
; genPointerSet
	ld	(x), a
; genPlus
	incw	x
; genGoto
	jp	00101$
; genLabel
00103$:
;	src/nrf24l01.c: 112: nrf_csn_disable();
; genCall
	pop	a
	jp	_nrf_csn_disable
; genLabel
00104$:
;	src/nrf24l01.c: 113: }
; genEndFunction
	pop	a
	ret
;	src/nrf24l01.c: 116: void nrf_write_tx(uint8_t *data, uint8_t len) {
; genLabel
;	-----------------------------------------
;	 function nrf_write_tx
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_write_tx:
;	src/nrf24l01.c: 117: nrf_writereg_many(1, W_TX_PAYLOAD, data, len);
; genIPush
	ld	a, (0x05, sp)
	push	a
; genIPush
	ldw	x, (0x04, sp)
	pushw	x
; genIPush
	push	#0xa0
; genIPush
	push	#0x01
; genCall
	call	_nrf_writereg_many
	addw	sp, #5
;	src/nrf24l01.c: 118: nrf_ce_high();
; genCall
	call	_nrf_ce_high
;	src/nrf24l01.c: 119: delay(100);
; genIPush
	push	#0x64
	push	#0x00
; genCall
	call	_delay
	addw	sp, #2
;	src/nrf24l01.c: 120: nrf_ce_low();
; genCall
	jp	_nrf_ce_low
; genLabel
00101$:
;	src/nrf24l01.c: 121: }
; genEndFunction
	ret
;	src/nrf24l01.c: 124: void nrf_register_cb(nrf_cb_f func) {
; genLabel
;	-----------------------------------------
;	 function nrf_register_cb
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_register_cb:
;	src/nrf24l01.c: 125: sys_nrf.func = func;
; skipping iCode since result will be rematerialized
; genPointerSet
	ldw	x, #(_sys_nrf + 11)
	ldw	y, (0x03, sp)
	ldw	(x), y
; genLabel
00101$:
;	src/nrf24l01.c: 126: }
; genEndFunction
	ret
;	src/nrf24l01.c: 129: void nrf_event(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_event
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 1 bytes.
_nrf_event:
	push	a
;	src/nrf24l01.c: 130: uint8_t nstatus = 0;
; genAssign
	clr	(0x01, sp)
;	src/nrf24l01.c: 131: sys_nrf.status = nstatus;
; skipping iCode since result will be rematerialized
; genPointerSet
	mov	_sys_nrf+0, #0x00
;	src/nrf24l01.c: 133: if( system.flags & (1<<N_IRQ) ) {
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _system+0
; genAnd
	bcp	a, #0x02
	jrne	00138$
	jp	00111$
00138$:
; skipping generated iCode
;	src/nrf24l01.c: 135: sys_nrf.status = nrf_readreg( STATUS );
; genIPush
	push	#0x07
; genCall
	call	_nrf_readreg
	addw	sp, #1
; genPointerSet
	ld	_sys_nrf+0, a
;	src/nrf24l01.c: 136: sys_nrf.pipe_no = (sys_nrf.status >> 1) & 0x07;
; skipping iCode since result will be rematerialized
; genPlus
	ldw	x, #(_sys_nrf + 0)+1
; genPointerGet
	ld	a, _sys_nrf+0
; genRightShiftLiteral
	srl	a
; genAnd
	and	a, #0x07
; genPointerSet
	ld	(x), a
;	src/nrf24l01.c: 138: if( (sys_nrf.status & RX_DR) ) {
; genPointerGet
	ld	a, _sys_nrf+0
; genAnd
	bcp	a, #0x40
	jrne	00139$
	jp	00102$
00139$:
; skipping generated iCode
;	src/nrf24l01.c: 140: nstatus |= RX_DR;
; genAssign
	ld	a, #0x40
	ld	(0x01, sp), a
;	src/nrf24l01.c: 141: nrf_read_rx(sys_nrf.data_rx, PAYLOADSIZE);
; genPlus
	ldw	x, #(_sys_nrf + 0)+2
; genCast
; genAssign
; genIPush
	push	#0x08
; genIPush
	pushw	x
; genCall
	call	_nrf_read_rx
	addw	sp, #3
; genLabel
00102$:
;	src/nrf24l01.c: 144: if( (sys_nrf.status & TX_DS) ) {
; genPointerGet
	ld	a, _sys_nrf+0
; genAnd
	bcp	a, #0x20
	jrne	00140$
	jp	00104$
00140$:
; skipping generated iCode
;	src/nrf24l01.c: 146: nstatus |= TX_DS;
; genOr
	push	a
	ld	a, (0x02, sp)
	or	a, #0x20
	ld	(0x02, sp), a
	pop	a
; genLabel
00104$:
;	src/nrf24l01.c: 149: if( (sys_nrf.status & MAX_RT) ) {
; genAnd
	bcp	a, #0x10
	jrne	00141$
	jp	00106$
00141$:
; skipping generated iCode
;	src/nrf24l01.c: 151: nstatus |= MAX_RT;
; genOr
	ld	a, (0x01, sp)
	or	a, #0x10
	ld	(0x01, sp), a
; genLabel
00106$:
;	src/nrf24l01.c: 159: if( sys_nrf.func ) {
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	x, _sys_nrf+11
; genIfx
	tnzw	x
	jrne	00142$
	jp	00108$
00142$:
;	src/nrf24l01.c: 160: sys_nrf.func();
; genCall
	call	(x)
; genLabel
00108$:
;	src/nrf24l01.c: 163: nrf_writereg( STATUS, nstatus );
; genIPush
	ld	a, (0x01, sp)
	push	a
; genIPush
	push	#0x07
; genCall
	call	_nrf_writereg
	addw	sp, #2
;	src/nrf24l01.c: 164: ClrBit(system.flags, N_IRQ);
; genPointerGet
	ld	a, _system+0
; genAnd
	and	a, #0xfd
; genPointerSet
	ld	_system+0, a
; genLabel
00111$:
;	src/nrf24l01.c: 166: }
; genEndFunction
	pop	a
	ret
;	src/nrf24l01.c: 169: void nrf_clear_rxbuff(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_clear_rxbuff
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_clear_rxbuff:
;	src/nrf24l01.c: 170: for(uint8_t x=0; x<PAYLOADSIZE; x++) {
; skipping iCode since result will be rematerialized
; genAssign
	clr	a
; genLabel
00103$:
; genCmp
; genCmpTop
	cp	a, #0x08
	jrc	00118$
	jp	00105$
00118$:
; skipping generated iCode
;	src/nrf24l01.c: 171: sys_nrf.data_rx[x] = 0;
; genPlus
	clrw	x
	ld	xl, a
	addw	x, #(_sys_nrf + 2)
; genPointerSet
	clr	(x)
;	src/nrf24l01.c: 170: for(uint8_t x=0; x<PAYLOADSIZE; x++) {
; genPlus
	inc	a
; genGoto
	jp	00103$
; genLabel
00105$:
;	src/nrf24l01.c: 173: }
; genEndFunction
	ret
;	src/nrf24l01.c: 176: void nrf_csn_enable(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_csn_enable
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_csn_enable:
;	src/nrf24l01.c: 177: ClrBit(GPIOA->ODR, 3);
; genPointerGet
	ld	a, 0x5000
; genAnd
	and	a, #0xf7
; genPointerSet
	ld	0x5000, a
; genLabel
00101$:
;	src/nrf24l01.c: 178: }
; genEndFunction
	ret
;	src/nrf24l01.c: 181: void nrf_csn_disable(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_csn_disable
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_csn_disable:
;	src/nrf24l01.c: 182: while( (SPI->SR & SPI_SR_BSY) );
; genLabel
00101$:
; genPointerGet
	ld	a, 0x5203
; genAnd
	tnz	a
	jrpl	00116$
	jp	00101$
00116$:
; skipping generated iCode
;	src/nrf24l01.c: 183: SetBit(GPIOA->ODR, 3);
; genPointerGet
	ld	a, 0x5000
; genOr
	or	a, #0x08
; genPointerSet
	ld	0x5000, a
; genLabel
00104$:
;	src/nrf24l01.c: 184: }
; genEndFunction
	ret
;	src/nrf24l01.c: 187: void nrf_ce_low(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_ce_low
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_ce_low:
;	src/nrf24l01.c: 188: ClrBit(GPIOA->ODR, 2);
; genPointerGet
	ld	a, 0x5000
; genAnd
	and	a, #0xfb
; genPointerSet
	ld	0x5000, a
; genLabel
00101$:
;	src/nrf24l01.c: 189: }
; genEndFunction
	ret
;	src/nrf24l01.c: 192: void nrf_ce_high(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_ce_high
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_ce_high:
;	src/nrf24l01.c: 193: SetBit(GPIOA->ODR, 2);
; genPointerGet
	ld	a, 0x5000
; genOr
	or	a, #0x04
; genPointerSet
	ld	0x5000, a
; genLabel
00101$:
;	src/nrf24l01.c: 194: }
; genEndFunction
	ret
;	src/nrf24l01.c: 197: uint8_t nrf_sendcmd(uint8_t cmd) {
; genLabel
;	-----------------------------------------
;	 function nrf_sendcmd
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_sendcmd:
;	src/nrf24l01.c: 199: nrf_csn_enable();
; genCall
	call	_nrf_csn_enable
;	src/nrf24l01.c: 200: status = spi_transmit( cmd );
; genIPush
	ld	a, (0x03, sp)
	push	a
; genCall
	call	_spi_transmit
	addw	sp, #1
; genAssign
;	src/nrf24l01.c: 201: nrf_csn_disable();
; genCall
	push	a
	call	_nrf_csn_disable
	pop	a
;	src/nrf24l01.c: 202: return status;
; genReturn
; genLabel
00101$:
;	src/nrf24l01.c: 203: }
; genEndFunction
	ret
;	src/nrf24l01.c: 206: uint8_t nrf_readreg(uint8_t reg) {
; genLabel
;	-----------------------------------------
;	 function nrf_readreg
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_readreg:
;	src/nrf24l01.c: 208: nrf_csn_enable();
; genCall
	call	_nrf_csn_enable
;	src/nrf24l01.c: 209: spi_transmit(R_REGISTER | (REGISTER_MASK & reg) );
; genAssign
	ld	a, (0x03, sp)
; genAnd
	and	a, #0x1f
; genIPush
	push	a
; genCall
	call	_spi_transmit
	pop	a
;	src/nrf24l01.c: 210: data = spi_transmit(NOP);
; genIPush
	push	#0xff
; genCall
	call	_spi_transmit
	addw	sp, #1
; genAssign
;	src/nrf24l01.c: 211: nrf_csn_disable();
; genCall
	push	a
	call	_nrf_csn_disable
	pop	a
;	src/nrf24l01.c: 212: return data;
; genReturn
; genLabel
00101$:
;	src/nrf24l01.c: 213: }
; genEndFunction
	ret
;	src/nrf24l01.c: 216: void nrf_writereg(uint8_t reg, uint8_t data) {
; genLabel
;	-----------------------------------------
;	 function nrf_writereg
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_writereg:
;	src/nrf24l01.c: 217: nrf_csn_enable();
; genCall
	call	_nrf_csn_enable
;	src/nrf24l01.c: 218: spi_transmit(W_REGISTER | (REGISTER_MASK & reg) );
; genAssign
	ld	a, (0x03, sp)
; genAnd
	and	a, #0x1f
; genOr
	or	a, #0x20
; genIPush
	push	a
; genCall
	call	_spi_transmit
	pop	a
;	src/nrf24l01.c: 219: spi_transmit(data);
; genIPush
	ld	a, (0x04, sp)
	push	a
; genCall
	call	_spi_transmit
	pop	a
;	src/nrf24l01.c: 220: nrf_csn_disable();
; genCall
	jp	_nrf_csn_disable
; genLabel
00101$:
;	src/nrf24l01.c: 221: }
; genEndFunction
	ret
;	src/nrf24l01.c: 224: void nrf_writereg_many(uint8_t cmd, uint8_t reg, uint8_t *data, uint8_t len) {
; genLabel
;	-----------------------------------------
;	 function nrf_writereg_many
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 1 bytes.
_nrf_writereg_many:
	push	a
;	src/nrf24l01.c: 225: nrf_csn_enable();
; genCall
	call	_nrf_csn_enable
;	src/nrf24l01.c: 227: if( cmd ) {
; genIfx
	tnz	(0x04, sp)
	jrne	00125$
	jp	00102$
00125$:
;	src/nrf24l01.c: 228: spi_transmit( reg );
; genIPush
	ld	a, (0x05, sp)
	push	a
; genCall
	call	_spi_transmit
	pop	a
; genGoto
	jp	00111$
; genLabel
00102$:
;	src/nrf24l01.c: 230: spi_transmit(W_REGISTER | (REGISTER_MASK & reg) );
; genAssign
	ld	a, (0x05, sp)
; genAnd
	and	a, #0x1f
; genOr
	or	a, #0x20
; genIPush
	push	a
; genCall
	call	_spi_transmit
	pop	a
;	src/nrf24l01.c: 233: while(len--) {
; genLabel
00111$:
; genAssign
	ldw	x, (0x06, sp)
; genAssign
	ld	a, (0x08, sp)
	ld	(0x01, sp), a
; genLabel
00104$:
; genAssign
	ld	a, (0x01, sp)
; genMinus
	dec	(0x01, sp)
; genIfx
	tnz	a
	jrne	00126$
	jp	00106$
00126$:
;	src/nrf24l01.c: 234: spi_transmit(*data++);
; genPointerGet
	ld	a, (x)
; genPlus
	incw	x
; genAssign
	ldw	(0x06, sp), x
; genIPush
	pushw	x
	push	a
; genCall
	call	_spi_transmit
	pop	a
	popw	x
; genGoto
	jp	00104$
; genLabel
00106$:
;	src/nrf24l01.c: 236: nrf_csn_disable();
; genCall
	pop	a
	jp	_nrf_csn_disable
; genLabel
00107$:
;	src/nrf24l01.c: 237: }
; genEndFunction
	pop	a
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
