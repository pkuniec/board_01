;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
	.module stm8s_it
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sec
	.globl _tim4_update
	.globl _uart1_tx
	.globl _uart1_rx
	.globl _exti2_irq
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_sec::
	.ds 1
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
;	src/stm8s_it.c: 10: void tim4_update(void) __interrupt (IT_TIM4_OVR_UIF) {
; genLabel
;	-----------------------------------------
;	 function tim4_update
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_tim4_update:
;	src/stm8s_it.c: 13: TIM4->SR1 &= ~TIM4_SR1_UIF;
; genPointerGet
	ld	a, 0x5344
; genAnd
	and	a, #0xfe
; genPointerSet
	ld	0x5344, a
;	src/stm8s_it.c: 15: if ( !sec-- ) {
; genAssign
	ld	a, _sec+0
; genMinus
	dec	_sec+0
; genIfx
	tnz	a
	jreq	00110$
	jp	00103$
00110$:
;	src/stm8s_it.c: 16: sec = 100;
; genAssign
	mov	_sec+0, #0x64
; genLabel
00103$:
;	src/stm8s_it.c: 18: }
; genEndFunction
	iret
;	src/stm8s_it.c: 21: void uart1_tx(void) __interrupt (IT_UART1_TX) {
; genLabel
;	-----------------------------------------
;	 function uart1_tx
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 3 bytes.
_uart1_tx:
	sub	sp, #3
;	src/stm8s_it.c: 22: uint8_t sr_reg = UART1->SR;
; genPointerGet
	ld	a, 0x5230
	ld	(0x01, sp), a
;	src/stm8s_it.c: 24: if ( uart_tx_Buff.head == uart_tx_Buff.tail ) {
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _uart_tx_Buff+2
	ld	(0x03, sp), a
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _uart_tx_Buff+3
; genCmpEQorNE
	cp	a, (0x03, sp)
	jrne	00133$
	jp	00134$
00133$:
	jp	00106$
00134$:
; skipping generated iCode
;	src/stm8s_it.c: 26: UART1->CR2 |= UART1_CR2_REN;
; genPointerGet
	ld	a, 0x5235
; genOr
	or	a, #0x04
; genPointerSet
	ld	0x5235, a
;	src/stm8s_it.c: 28: UART1->CR2 &= ~(UART1_CR2_TIEN | UART1_CR2_TCIEN);
; genPointerGet
	ld	a, 0x5235
; genAnd
	and	a, #0x3f
; genPointerSet
	ld	0x5235, a
; genGoto
	jp	00107$
; genLabel
00106$:
;	src/stm8s_it.c: 31: if ( sr_reg & UART1_SR_TXE ) {
; genAnd
	tnz	(0x01, sp)
	jrmi	00135$
	jp	00107$
00135$:
; skipping generated iCode
;	src/stm8s_it.c: 33: uart_tx_Buff.tail++;
; genAddrOf
	ldw	x, #_uart_tx_Buff+3
; genPointerGet
	ld	a, (x)
; genPlus
	inc	a
; genPointerSet
	ld	(x), a
;	src/stm8s_it.c: 34: if (uart_tx_Buff.tail == TX_BUFF_SIZE) {
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _uart_tx_Buff+3
; genCmpEQorNE
	cp	a, #0x08
	jrne	00137$
	jp	00138$
00137$:
	jp	00102$
00138$:
; skipping generated iCode
;	src/stm8s_it.c: 35: uart_tx_Buff.tail = 0;
; skipping iCode since result will be rematerialized
; genPointerSet
	mov	_uart_tx_Buff+3, #0x00
; genLabel
00102$:
;	src/stm8s_it.c: 38: UART1->DR = uart_tx_Buff.buffer[uart_tx_Buff.tail];
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	x, _uart_tx_Buff+0
	ldw	(0x02, sp), x
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _uart_tx_Buff+3
; genPlus
	clrw	x
	ld	xl, a
	addw	x, (0x02, sp)
; genPointerGet
	ld	a, (x)
; genPointerSet
	ld	0x5231, a
; genLabel
00107$:
;	src/stm8s_it.c: 42: if ( sr_reg & UART1_SR_TC ) {
; genAnd
	ld	a, (0x01, sp)
	bcp	a, #0x40
	jrne	00139$
	jp	00110$
00139$:
; skipping generated iCode
;	src/stm8s_it.c: 44: UART1->SR &= ~(UART1_SR_TC);
; genPointerGet
	ld	a, 0x5230
; genAnd
	and	a, #0xbf
; genPointerSet
	ld	0x5230, a
; genLabel
00110$:
;	src/stm8s_it.c: 46: }
; genEndFunction
	addw	sp, #3
	iret
;	src/stm8s_it.c: 49: void uart1_rx(void) __interrupt (IT_UART1_RX) {
; genLabel
;	-----------------------------------------
;	 function uart1_rx
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 1 bytes.
_uart1_rx:
	push	a
;	src/stm8s_it.c: 50: if ( UART1->SR & UART1_SR_RXNE ) {
; genPointerGet
	ld	a, 0x5230
; genAnd
	bcp	a, #0x20
	jrne	00125$
	jp	00108$
00125$:
; skipping generated iCode
;	src/stm8s_it.c: 51: uint8_t head_temp = uart_rx_Buff.head + 1;
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _uart_rx_Buff+2
; genCast
; genAssign
; genPlus
	inc	a
	ld	(0x01, sp), a
;	src/stm8s_it.c: 53: if ( head_temp == RX_BUFF_SIZE ) {
; genCmpEQorNE
	ld	a, (0x01, sp)
	cp	a, #0x08
	jrne	00127$
	jp	00128$
00127$:
	jp	00102$
00128$:
; skipping generated iCode
;	src/stm8s_it.c: 54: head_temp = 0;
; genAssign
	clr	(0x01, sp)
; genLabel
00102$:
;	src/stm8s_it.c: 57: if ( head_temp == uart_rx_Buff.tail ) {
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _uart_rx_Buff+3
; genCmpEQorNE
	cp	a, (0x01, sp)
	jrne	00130$
	jp	00131$
00130$:
	jp	00104$
00131$:
; skipping generated iCode
;	src/stm8s_it.c: 59: UART1->SR &= ~UART1_SR_RXNE;
; genPointerGet
	ld	a, 0x5230
; genAnd
	and	a, #0xdf
; genPointerSet
	ld	0x5230, a
; genGoto
	jp	00108$
; genLabel
00104$:
;	src/stm8s_it.c: 61: uart_rx_Buff.buffer[head_temp] = UART1->DR;
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	x, _uart_rx_Buff+0
; genPlus
	ld	a, xl
	add	a, (0x01, sp)
	ld	xl, a
	ld	a, xh
	adc	a, #0x00
	ld	xh, a
; genPointerGet
	ld	a, 0x5231
; genPointerSet
	ld	(x), a
;	src/stm8s_it.c: 62: uart_rx_Buff.head = head_temp;
; skipping iCode since result will be rematerialized
; genPointerSet
	ldw	x, #(_uart_rx_Buff + 2)
	ld	a, (0x01, sp)
	ld	(x), a
; genLabel
00108$:
;	src/stm8s_it.c: 65: }
; genEndFunction
	pop	a
	iret
;	src/stm8s_it.c: 68: void exti2_irq(void) __interrupt (IT_EXTI2) {
; genLabel
;	-----------------------------------------
;	 function exti2_irq
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_exti2_irq:
;	src/stm8s_it.c: 69: if( !(GPIOC->IDR & (PIN_3)) ) {
; genPointerGet
	ld	a, 0x500b
; genAnd
	bcp	a, #0x08
	jreq	00117$
	jp	00102$
00117$:
; skipping generated iCode
;	src/stm8s_it.c: 71: SetBit(system.flags, N_IRQ);
; genAddrOf
	ldw	x, #_system+0
; genPointerGet
	ld	a, (x)
; genOr
	or	a, #0x02
; genPointerSet
	ld	(x), a
; genLabel
00102$:
;	src/stm8s_it.c: 74: if( !(GPIOC->IDR & (PIN_4)) ) {
; genPointerGet
	ld	a, 0x500b
; genAnd
	bcp	a, #0x10
	jreq	00118$
	jp	00105$
00118$:
; skipping generated iCode
;	src/stm8s_it.c: 76: SetBit(system.flags, E_IRQ);
; genAddrOf
	ldw	x, #_system+0
; genPointerGet
	ld	a, (x)
; genOr
	or	a, #0x01
; genPointerSet
	ld	(x), a
; genLabel
00105$:
;	src/stm8s_it.c: 78: }
; genEndFunction
	iret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__sec:
	.db #0x64	; 100	'd'
	.area CABS (ABS)
