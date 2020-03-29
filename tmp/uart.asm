;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
	.module uart
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _uart_init
	.globl _uart_putc
	.globl _uart_puts
	.globl _uart_recv
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
;	src/uart.c: 7: void uart_init(void) {
; genLabel
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_uart_init:
;	src/uart.c: 9: UART1->BRR2 = 0x00;
; genPointerSet
	mov	0x5233+0, #0x00
;	src/uart.c: 10: UART1->BRR1 = 0x0D;
; genPointerSet
	mov	0x5232+0, #0x0d
;	src/uart.c: 14: UART1->CR2 = UART1_CR2_TEN | UART1_CR2_REN | UART1_CR2_RIEN;
; genPointerSet
	mov	0x5235+0, #0x2c
; genLabel
00101$:
;	src/uart.c: 15: }
; genEndFunction
	ret
;	src/uart.c: 18: int8_t uart_putc(uint8_t c) {
; genLabel
;	-----------------------------------------
;	 function uart_putc
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 2 bytes.
_uart_putc:
	sub	sp, #2
;	src/uart.c: 20: UART1->CR2 &= ~(UART1_CR2_REN);
; genPointerGet
	ld	a, 0x5235
; genAnd
	and	a, #0xfb
; genPointerSet
	ld	0x5235, a
;	src/uart.c: 22: uint8_t head_temp = uart_tx_Buff.head + 1;
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _uart_tx_Buff+2
; genCast
; genAssign
; genPlus
	inc	a
;	src/uart.c: 24: if ( head_temp == TX_BUFF_SIZE ) {
; genCmpEQorNE
	cp	a, #0x08
	jrne	00118$
	jp	00119$
00118$:
	jp	00102$
00119$:
; skipping generated iCode
;	src/uart.c: 25: head_temp = 0;
; genAssign
	clr	a
; genLabel
00102$:
;	src/uart.c: 28: if ( head_temp == uart_tx_Buff.tail ) {
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	x, #(_uart_tx_Buff + 3)
	push	a
	ld	a, (x)
	ld	(0x03, sp), a
	pop	a
; genCmpEQorNE
	cp	a, (0x02, sp)
	jrne	00121$
	jp	00122$
00121$:
	jp	00104$
00122$:
; skipping generated iCode
;	src/uart.c: 30: return -1;
; genReturn
	ld	a, #0xff
	jp	00105$
; genLabel
00104$:
;	src/uart.c: 33: uart_tx_Buff.buffer[head_temp] = c;
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	x, _uart_tx_Buff+0
	ldw	(0x01, sp), x
; genPlus
	clrw	x
	ld	xl, a
	addw	x, (0x01, sp)
; genPointerSet
	push	a
	ld	a, (0x06, sp)
	ld	(x), a
	pop	a
;	src/uart.c: 34: uart_tx_Buff.head = head_temp;
; skipping iCode since result will be rematerialized
; genPointerSet
	ld	_uart_tx_Buff+2, a
;	src/uart.c: 37: UART1->CR2 |= UART1_CR2_TIEN | UART1_CR2_TCIEN;
; genPointerGet
	ld	a, 0x5235
; genOr
	or	a, #0xc0
; genPointerSet
	ld	0x5235, a
;	src/uart.c: 39: return 0;
; genReturn
	clr	a
; genLabel
00105$:
;	src/uart.c: 40: }
; genEndFunction
	addw	sp, #2
	ret
;	src/uart.c: 42: void uart_puts(uint8_t *str) {
; genLabel
;	-----------------------------------------
;	 function uart_puts
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_uart_puts:
;	src/uart.c: 43: while( *str ) {
; genAssign
	ldw	x, (0x03, sp)
; genLabel
00103$:
; genPointerGet
	ld	a, (x)
; genIfx
	tnz	a
	jrne	00124$
	jp	00106$
00124$:
;	src/uart.c: 44: if( !uart_putc( *str ) ) {
; genIPush
	pushw	x
	push	a
; genCall
	call	_uart_putc
	addw	sp, #1
	popw	x
; genIfx
	tnz	a
	jreq	00125$
	jp	00103$
00125$:
;	src/uart.c: 45: *(str++);
; genPlus
	incw	x
; genGoto
	jp	00103$
; genLabel
00106$:
;	src/uart.c: 48: }
; genEndFunction
	ret
;	src/uart.c: 50: int8_t uart_recv(uint8_t *data) {
; genLabel
;	-----------------------------------------
;	 function uart_recv
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 2 bytes.
_uart_recv:
	sub	sp, #2
;	src/uart.c: 52: if ( uart_rx_Buff.head == uart_rx_Buff.tail ) {
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _uart_rx_Buff+2
	ld	(0x02, sp), a
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _uart_rx_Buff+3
; genCmpEQorNE
	cp	a, (0x02, sp)
	jrne	00118$
	jp	00119$
00118$:
	jp	00102$
00119$:
; skipping generated iCode
;	src/uart.c: 53: return -1;
; genReturn
	ld	a, #0xff
	jp	00105$
; genLabel
00102$:
;	src/uart.c: 56: uart_rx_Buff.tail++;
; genAddrOf
	ldw	x, #_uart_rx_Buff+3
; genPointerGet
	ld	a, (x)
; genPlus
	inc	a
; genPointerSet
	ld	(x), a
;	src/uart.c: 58: if ( uart_rx_Buff.tail == RX_BUFF_SIZE ) {
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _uart_rx_Buff+3
; genCmpEQorNE
	cp	a, #0x08
	jrne	00121$
	jp	00122$
00121$:
	jp	00104$
00122$:
; skipping generated iCode
;	src/uart.c: 59: uart_rx_Buff.tail = 0;
; skipping iCode since result will be rematerialized
; genPointerSet
	mov	_uart_rx_Buff+3, #0x00
; genLabel
00104$:
;	src/uart.c: 62: *data = uart_rx_Buff.buffer[uart_rx_Buff.tail];
; genAssign
	ldw	y, (0x05, sp)
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	x, _uart_rx_Buff+0
	ldw	(0x01, sp), x
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _uart_rx_Buff+3
; genPlus
	clrw	x
	ld	xl, a
	addw	x, (0x01, sp)
; genPointerGet
	ld	a, (x)
; genPointerSet
	ld	(y), a
;	src/uart.c: 63: return 0;
; genReturn
	clr	a
; genLabel
00105$:
;	src/uart.c: 64: }
; genEndFunction
	addw	sp, #2
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
