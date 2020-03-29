;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _mn_register_cb
	.globl _uart_puts
	.globl _uart_init
	.globl _nrf_register_cb
	.globl _nrf_event
	.globl _nrf_rx_enable
	.globl _nrf_reset
	.globl _nrf_init_sw
	.globl _nrf_init_hw
	.globl _mn_exec
	.globl _nrf_recv
	.globl _output_set
	.globl _spi_init
	.globl _sys_event
	.globl _uart_event
	.globl _setup
	.globl _pload
	.globl _system
	.globl _sys_nrf
	.globl _uart_rx_Buff
	.globl _uart_tx_Buff
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_uart_tx_Buff::
	.ds 4
_uart_rx_Buff::
	.ds 4
_sys_nrf::
	.ds 13
_system::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_pload::
	.ds 4
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

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
; interrupt vector 
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
	int 0x000000 ; trap
	int 0x000000 ; int0
	int 0x000000 ; int1
	int 0x000000 ; int2
	int 0x000000 ; int3
	int 0x000000 ; int4
	int _exti2_irq ; int5
	int 0x000000 ; int6
	int 0x000000 ; int7
	int 0x000000 ; int8
	int 0x000000 ; int9
	int 0x000000 ; int10
	int 0x000000 ; int11
	int 0x000000 ; int12
	int 0x000000 ; int13
	int 0x000000 ; int14
	int 0x000000 ; int15
	int 0x000000 ; int16
	int _uart1_tx ; int17
	int _uart1_rx ; int18
	int 0x000000 ; int19
	int 0x000000 ; int20
	int 0x000000 ; int21
	int 0x000000 ; int22
	int _tim4_update ; int23
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
__sdcc_gs_init_startup:
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	src/main.c: 19: int main(void) {
; genLabel
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 20 bytes.
_main:
	sub	sp, #20
;	src/main.c: 24: uart_tx_Buff.buffer = tx_Buff;
; skipping iCode since result will be rematerialized
; genAddrOf
	ldw	x, sp
	incw	x
; genCast
; genAssign
; genPointerSet
	ldw	_uart_tx_Buff+0, x
;	src/main.c: 25: uart_tx_Buff.head = 0;
; skipping iCode since result will be rematerialized
; genPointerSet
	mov	_uart_tx_Buff+2, #0x00
;	src/main.c: 26: uart_tx_Buff.tail = 0;
; skipping iCode since result will be rematerialized
; genPointerSet
	mov	_uart_tx_Buff+3, #0x00
;	src/main.c: 28: uart_rx_Buff.buffer = rx_Buff;
; skipping iCode since result will be rematerialized
; genAddrOf
	ldw	x, sp
	addw	x, #9
; genCast
; genAssign
; genPointerSet
	ldw	_uart_rx_Buff+0, x
;	src/main.c: 29: uart_rx_Buff.head = 0;
; skipping iCode since result will be rematerialized
; genPointerSet
	mov	_uart_rx_Buff+2, #0x00
;	src/main.c: 30: uart_rx_Buff.tail = 0;
; skipping iCode since result will be rematerialized
; genPointerSet
	mov	_uart_rx_Buff+3, #0x00
;	src/main.c: 34: setup();
; genCall
	call	_setup
;	src/main.c: 35: nrf_init_hw();
; genCall
	call	_nrf_init_hw
;	src/main.c: 36: spi_init();
; genCall
	call	_spi_init
;	src/main.c: 37: output_set(R_NRF, 1);
; genIPush
	push	#0x01
; genIPush
	push	#0x00
; genCall
	call	_output_set
	addw	sp, #2
;	src/main.c: 38: uart_init();    
; genCall
	call	_uart_init
;	src/main.c: 41: mn_register_cb( mn_exec );
; genIPush
	push	#<(_mn_exec + 0)
	push	#((_mn_exec + 0) >> 8)
; genCall
	call	_mn_register_cb
	addw	sp, #2
;	src/main.c: 42: nrf_register_cb( nrf_recv );
; genIPush
	push	#<(_nrf_recv + 0)
	push	#((_nrf_recv + 0) >> 8)
; genCall
	call	_nrf_register_cb
	addw	sp, #2
;	src/main.c: 43: nrf_reset();
; genCall
	call	_nrf_reset
;	src/main.c: 44: nrf_init_sw();
; genCall
	call	_nrf_init_sw
;	src/main.c: 45: nrf_rx_enable();
; genCall
	call	_nrf_rx_enable
;	src/main.c: 48: rim();
;	genInline
	rim
;	src/main.c: 50: const uint8_t hello[] = {"STM"};
; skipping iCode since result will be rematerialized
; genPointerSet
	ld	a, #0x53
	ld	(0x11, sp), a
; genPlus
	ldw	x, sp
	addw	x, #18
; genPointerSet
	ld	a, #0x54
	ld	(x), a
; genPlus
	ldw	x, sp
	addw	x, #19
; genPointerSet
	ld	a, #0x4d
	ld	(x), a
; genPlus
	ldw	x, sp
	addw	x, #20
; genPointerSet
	clr	(x)
;	src/main.c: 51: uart_puts(hello);
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genIPush
	ldw	x, sp
	addw	x, #17
	pushw	x
; genCall
	call	_uart_puts
	addw	sp, #2
;	src/main.c: 54: while( 1 ) {
; genLabel
00102$:
;	src/main.c: 55: uart_event();
; genCall
	call	_uart_event
;	src/main.c: 56: sys_event();
; genCall
	call	_sys_event
;	src/main.c: 57: nrf_event();
; genCall
	call	_nrf_event
; genGoto
	jp	00102$
; genLabel
00104$:
;	src/main.c: 68: }
; genEndFunction
	addw	sp, #20
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__pload:
	.db #0x43	; 67	'C'
	.db #0x43	; 67	'C'
	.db #0x43	; 67	'C'
	.db #0x43	; 67	'C'
	.area CABS (ABS)
