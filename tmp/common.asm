;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
	.module common
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _mn_decode_frame
	.globl _nrf_clear_rxbuff
	.globl _uart_recv
	.globl _uart_putc
	.globl _setup
	.globl _delay
	.globl _uart_event
	.globl _sys_event
	.globl _spi_init
	.globl _spi_transmit
	.globl _eeprom_read
	.globl _eeprom_write
	.globl _adc_get
	.globl _reg_transfer
	.globl _output_set
	.globl _nrf_recv
	.globl _mn_exec
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_output_set_reg_data_65536_76:
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
;	src/common.c: 8: void setup(void) {
; genLabel
;	-----------------------------------------
;	 function setup
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_setup:
;	src/common.c: 11: GPIOA->DDR = (1<<LATCH);
; genPointerSet
	mov	0x5002+0, #0x02
;	src/common.c: 12: GPIOA->CR1 = (1<<LATCH);
; genPointerSet
	mov	0x5003+0, #0x02
;	src/common.c: 15: GPIOC->CR2 = PIN_4;
; genPointerSet
	mov	0x500e+0, #0x10
;	src/common.c: 16: EXTI->CR1 |= 0x20; // PORTC faling edge
; genPointerGet
	ld	a, 0x50a0
; genOr
	or	a, #0x20
; genPointerSet
	ld	0x50a0, a
;	src/common.c: 19: ADC1->CSR = 0x03; // Channel 3;
; genPointerSet
	mov	0x5400+0, #0x03
;	src/common.c: 20: ADC1->CR1 = 0x70; // f.master/18
; genPointerSet
	mov	0x5401+0, #0x70
;	src/common.c: 21: ADC1->TDRL = 0x03;
; genPointerSet
	mov	0x5407+0, #0x03
;	src/common.c: 24: ClrBit(GPIOA->ODR, LATCH);
; genPointerGet
	ld	a, 0x5000
; genAnd
	and	a, #0xfd
; genPointerSet
	ld	0x5000, a
;	src/common.c: 27: TIM2->ARRH = 0x03; // 
; genPointerSet
	mov	0x530f+0, #0x03
;	src/common.c: 28: TIM2->ARRL = 0xE7; // ARR = 999
; genPointerSet
	mov	0x5310+0, #0xe7
;	src/common.c: 29: TIM2->PSCR = 0x00; // PSCR = 1
; genPointerSet
	mov	0x530e+0, #0x00
;	src/common.c: 30: TIM2->EGR = TIM2_EGR_UG;
; genPointerSet
	mov	0x5306+0, #0x01
;	src/common.c: 31: TIM2->CCMR1 = 0x78; // PWM mode1
; genPointerSet
	mov	0x5307+0, #0x78
;	src/common.c: 32: TIM2->CCMR2 = 0x78; // PWM mode1
; genPointerSet
	mov	0x5308+0, #0x78
;	src/common.c: 33: TIM2->CCER1 = TIM2_CCER1_CC1E | TIM2_CCER1_CC2E;
; genPointerSet
	mov	0x530a+0, #0x11
;	src/common.c: 34: TIM2->CCR1H = 0x01;
; genPointerSet
	mov	0x5311+0, #0x01
;	src/common.c: 35: TIM2->CCR1L = 0xF4;
; genPointerSet
	mov	0x5312+0, #0xf4
;	src/common.c: 36: TIM2->CCR2H = 0x00;
; genPointerSet
	mov	0x5313+0, #0x00
;	src/common.c: 37: TIM2->CCR2L = 0xFA;
; genPointerSet
	mov	0x5314+0, #0xfa
;	src/common.c: 41: TIM4->PSCR = TIM4_PSCR_PSC; // pre. 128
; genPointerSet
	mov	0x5347+0, #0x07
;	src/common.c: 42: TIM4->ARR = 99;
; genPointerSet
	mov	0x5348+0, #0x63
;	src/common.c: 43: TIM4->IER |= TIM4_IER_UIE;
; genPointerGet
	ld	a, 0x5343
; genOr
	or	a, #0x01
; genPointerSet
	ld	0x5343, a
;	src/common.c: 44: TIM4->CR1 |= TIM4_CR1_CEN;
; genPointerGet
	ld	a, 0x5340
; genOr
	or	a, #0x01
; genPointerSet
	ld	0x5340, a
; genLabel
00101$:
;	src/common.c: 45: }
; genEndFunction
	ret
;	src/common.c: 48: void delay(uint16_t time) {
; genLabel
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_delay:
;	src/common.c: 49: while( time ) {
; genAssign
	ldw	x, (0x03, sp)
; genLabel
00101$:
; genIfx
	tnzw	x
	jrne	00117$
	jp	00104$
00117$:
;	src/common.c: 50: time--;
; genMinus
	decw	x
;	src/common.c: 51: nop();
;	genInline
	nop
; genGoto
	jp	00101$
; genLabel
00104$:
;	src/common.c: 53: }
; genEndFunction
	ret
;	src/common.c: 56: void uart_event(void) {
; genLabel
;	-----------------------------------------
;	 function uart_event
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 1 bytes.
_uart_event:
	push	a
;	src/common.c: 57: uint8_t data = 0;
; genAssign
	clr	(0x01, sp)
;	src/common.c: 59: if( !uart_recv( &data ) ) {
; skipping iCode since result will be rematerialized
; skipping iCode since result will be rematerialized
; genIPush
	ldw	x, sp
	incw	x
	pushw	x
; genCall
	call	_uart_recv
	addw	sp, #2
; genIfx
	tnz	a
	jreq	00117$
	jp	00105$
00117$:
;	src/common.c: 61: if ( data == 'a' ) {
; genCmpEQorNE
	ld	a, (0x01, sp)
	cp	a, #0x61
	jrne	00119$
	jp	00120$
00119$:
	jp	00105$
00120$:
; skipping generated iCode
;	src/common.c: 62: uart_putc('0' + uart_rx_Buff.head);
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _uart_rx_Buff+2
; genCast
; genAssign
; genPlus
	add	a, #0x30
; genIPush
	push	a
; genCall
	call	_uart_putc
	pop	a
; genLabel
00105$:
;	src/common.c: 65: }
; genEndFunction
	pop	a
	ret
;	src/common.c: 68: void sys_event(void) {
; genLabel
;	-----------------------------------------
;	 function sys_event
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_sys_event:
;	src/common.c: 69: if ( system.flags ) {
; genAddrOf
	ldw	x, #_system+0
; genPointerGet
	ld	a, (x)
; genIfx
	tnz	a
	jrne	00117$
	jp	00105$
00117$:
;	src/common.c: 71: if ( system.flags & (1<<E_IRQ) ) {
; genAnd
	bcp	a, #0x01
	jrne	00118$
	jp	00105$
00118$:
; skipping generated iCode
;	src/common.c: 72: ClrBit(system.flags, E_IRQ);
; genAnd
	and	a, #0xfe
; genPointerSet
	ld	(x), a
;	src/common.c: 73: uart_putc('E');
; genIPush
	push	#0x45
; genCall
	call	_uart_putc
	pop	a
; genLabel
00105$:
;	src/common.c: 76: }
; genEndFunction
	ret
;	src/common.c: 80: void spi_init(void) {
; genLabel
;	-----------------------------------------
;	 function spi_init
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_spi_init:
;	src/common.c: 82: SPI->CR2 = SPI_CR2_SSM | SPI_CR2_SSI;
; genPointerSet
	mov	0x5201+0, #0x03
;	src/common.c: 83: SPI->CR1 = SPI_CR1_MSTR | SPI_CR1_SPE;// | (SPI_CR1_BR & 0x08);
; genPointerSet
	mov	0x5200+0, #0x44
; genLabel
00101$:
;	src/common.c: 84: }
; genEndFunction
	ret
;	src/common.c: 90: uint8_t spi_transmit(uint8_t data) {
; genLabel
;	-----------------------------------------
;	 function spi_transmit
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_spi_transmit:
;	src/common.c: 91: SPI->DR = data;
; genPointerSet
	ldw	x, #0x5204
	ld	a, (0x03, sp)
	ld	(x), a
;	src/common.c: 92: while( !(SPI->SR & SPI_SR_TXE) );
; genLabel
00101$:
; genPointerGet
	ld	a, 0x5203
; genAnd
	bcp	a, #0x02
	jrne	00124$
	jp	00101$
00124$:
; skipping generated iCode
;	src/common.c: 93: while( !(SPI->SR & SPI_SR_RXNE) );
; genLabel
00104$:
; genPointerGet
	ld	a, 0x5203
; genAnd
	srl	a
	jrc	00125$
	jp	00104$
00125$:
; skipping generated iCode
;	src/common.c: 94: return SPI->DR;
; genPointerGet
	ld	a, 0x5204
; genReturn
; genLabel
00107$:
;	src/common.c: 95: }
; genEndFunction
	ret
;	src/common.c: 100: uint8_t eeprom_read(uint8_t addr) {
; genLabel
;	-----------------------------------------
;	 function eeprom_read
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_eeprom_read:
;	src/common.c: 102: return *(eemem + addr);
; genPlus
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	addw	x, #0x4000
; genPointerGet
	ld	a, (x)
; genReturn
; genLabel
00101$:
;	src/common.c: 103: }
; genEndFunction
	ret
;	src/common.c: 110: void eeprom_write(uint8_t addr, uint8_t *data, uint8_t len) {
; genLabel
;	-----------------------------------------
;	 function eeprom_write
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 3 bytes.
_eeprom_write:
	sub	sp, #3
;	src/common.c: 113: if( !(FLASH->IAPSR & FLASH_IAPSR_DUL) ) {
; genPointerGet
	ld	a, 0x505f
; genAnd
	bcp	a, #0x08
	jreq	00146$
	jp	00120$
00146$:
; skipping generated iCode
;	src/common.c: 115: FLASH->DUKR = 0xAE;
; genPointerSet
	mov	0x5064+0, #0xae
;	src/common.c: 116: FLASH->DUKR = 0x56;
; genPointerSet
	mov	0x5064+0, #0x56
;	src/common.c: 117: while ( !(FLASH->IAPSR & FLASH_IAPSR_DUL) );
; genLabel
00101$:
; genPointerGet
	ld	a, 0x505f
; genAnd
	bcp	a, #0x08
	jrne	00147$
	jp	00101$
00147$:
; skipping generated iCode
;	src/common.c: 120: for( uint8_t i = 0; i<len; i++) {
; genLabel
00120$:
; genPlus
	clrw	x
	ld	a, (0x06, sp)
	ld	xl, a
	addw	x, #0x4000
	ldw	(0x01, sp), x
; genAssign
	clr	(0x03, sp)
; genLabel
00111$:
; genCmp
; genCmpTop
	ld	a, (0x03, sp)
	cp	a, (0x09, sp)
	jrc	00148$
	jp	00109$
00148$:
; skipping generated iCode
;	src/common.c: 121: *(eemem + addr + i) = data[i];
; genPlus
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	addw	x, (0x01, sp)
; genPlus
	clrw	y
	ld	a, (0x03, sp)
	ld	yl, a
	addw	y, (0x07, sp)
; genPointerGet
	ld	a, (y)
; genPointerSet
	ld	(x), a
;	src/common.c: 122: while ( !(FLASH->IAPSR & FLASH_IAPSR_EOP) );
; genLabel
00106$:
; genPointerGet
	ld	a, 0x505f
; genAnd
	bcp	a, #0x04
	jrne	00149$
	jp	00106$
00149$:
; skipping generated iCode
;	src/common.c: 120: for( uint8_t i = 0; i<len; i++) {
; genPlus
	inc	(0x03, sp)
; genGoto
	jp	00111$
; genLabel
00109$:
;	src/common.c: 125: FLASH->IAPSR &= ~FLASH_IAPSR_DUL; 
; genPointerGet
	ld	a, 0x505f
; genAnd
	and	a, #0xf7
; genPointerSet
	ld	0x505f, a
; genLabel
00113$:
;	src/common.c: 126: }
; genEndFunction
	addw	sp, #3
	ret
;	src/common.c: 131: void adc_get(uint16_t *adc) {
; genLabel
;	-----------------------------------------
;	 function adc_get
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 2 bytes.
_adc_get:
	sub	sp, #2
;	src/common.c: 133: SetBit(ADC1->CR1, 0);
; genPointerGet
	ld	a, 0x5401
; genOr
	or	a, #0x01
; genPointerSet
	ld	0x5401, a
;	src/common.c: 134: delay(100);
; genIPush
	push	#0x64
	push	#0x00
; genCall
	call	_delay
	addw	sp, #2
;	src/common.c: 136: SetBit(ADC1->CR1, 0);
; genPointerGet
	ld	a, 0x5401
; genOr
	or	a, #0x01
; genPointerSet
	ld	0x5401, a
;	src/common.c: 137: while(ADC1->CSR & ADC1_CSR_EOC)
; genLabel
00101$:
; genPointerGet
	ld	a, 0x5400
; genAnd
	tnz	a
	jrmi	00116$
	jp	00103$
00116$:
; skipping generated iCode
;	src/common.c: 138: ClrBit(ADC1->CSR, 7);
; genPointerGet
	ld	a, 0x5400
; genAnd
	and	a, #0x7f
; genPointerSet
	ld	0x5400, a
; genGoto
	jp	00101$
; genLabel
00103$:
;	src/common.c: 139: *adc = (uint16_t)(ADC1->DRH << 8);
; genAssign
	ldw	y, (0x05, sp)
; genPointerGet
	ld	a, 0x5404
; genCast
; genAssign
	clrw	x
; genLeftShiftLiteral
	ld	xh, a
	clr	a
; genCast
; genAssign
	ld	xl, a
; genPointerSet
	ldw	(y), x
;	src/common.c: 140: *adc |= (uint8_t)(ADC1->DRL);
; genPointerGet
	ld	a, 0x5405
; genCast
; genAssign
	clr	(0x01, sp)
; genOr
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	xl, a
	ld	a, xh
	or	a, (0x01, sp)
	ld	xh, a
; genPointerSet
	ldw	(y), x
;	src/common.c: 142: ClrBit(ADC1->CR1, 0);
; genPointerGet
	ld	a, 0x5401
; genAnd
	and	a, #0xfe
; genPointerSet
	ld	0x5401, a
; genLabel
00104$:
;	src/common.c: 143: }
; genEndFunction
	addw	sp, #2
	ret
;	src/common.c: 148: void reg_transfer(uint8_t data) {
; genLabel
;	-----------------------------------------
;	 function reg_transfer
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_reg_transfer:
;	src/common.c: 149: spi_transmit(data);
; genIPush
	ld	a, (0x03, sp)
	push	a
; genCall
	call	_spi_transmit
	pop	a
;	src/common.c: 150: SetBit(GPIOA->ODR, LATCH);
; genPointerGet
	ld	a, 0x5000
; genOr
	or	a, #0x02
; genPointerSet
	ld	0x5000, a
;	src/common.c: 151: delay(10);
; genIPush
	push	#0x0a
	push	#0x00
; genCall
	call	_delay
	addw	sp, #2
;	src/common.c: 152: ClrBit(GPIOA->ODR, LATCH);
; genPointerGet
	ld	a, 0x5000
; genAnd
	and	a, #0xfd
; genPointerSet
	ld	0x5000, a
; genLabel
00101$:
;	src/common.c: 153: }
; genEndFunction
	ret
;	src/common.c: 161: void output_set(uint8_t num, uint8_t mode) {
; genLabel
;	-----------------------------------------
;	 function output_set
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_output_set:
;	src/common.c: 165: SetBit(reg_data, num);
; genLeftShift
	ld	a, #0x01
	push	a
	ld	a, (0x04, sp)
	jreq	00112$
00111$:
	sll	(1, sp)
	dec	a
	jrne	00111$
00112$:
	pop	a
;	src/common.c: 164: if ( mode ) {
; genIfx
	tnz	(0x04, sp)
	jrne	00113$
	jp	00102$
00113$:
;	src/common.c: 165: SetBit(reg_data, num);
; genOr
	or	a, _output_set_reg_data_65536_76+0
	ld	_output_set_reg_data_65536_76+0, a
; genGoto
	jp	00103$
; genLabel
00102$:
;	src/common.c: 167: ClrBit(reg_data, num);
; genXor
	cpl	a
; genAnd
	and	a, _output_set_reg_data_65536_76+0
	ld	_output_set_reg_data_65536_76+0, a
; genLabel
00103$:
;	src/common.c: 170: reg_transfer(reg_data);
; genIPush
	push	_output_set_reg_data_65536_76+0
; genCall
	call	_reg_transfer
	pop	a
; genLabel
00104$:
;	src/common.c: 171: }
; genEndFunction
	ret
;	src/common.c: 175: void nrf_recv(void) {
; genLabel
;	-----------------------------------------
;	 function nrf_recv
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_nrf_recv:
;	src/common.c: 176: if ( sys_nrf.status & RX_DR ) {
; genAddrOf
	ldw	x, #_sys_nrf+0
; genPointerGet
	ld	a, (x)
; genAnd
	bcp	a, #0x40
	jrne	00110$
	jp	00103$
00110$:
; skipping generated iCode
;	src/common.c: 177: mn_decode_frame();
; genCall
	pushw	x
	call	_mn_decode_frame
	popw	x
;	src/common.c: 178: sys_nrf.status &=~ RX_DR;
; genPointerGet
	ld	a, (x)
; genAnd
	and	a, #0xbf
; genPointerSet
	ld	(x), a
; genLabel
00103$:
;	src/common.c: 180: }
; genEndFunction
	ret
;	src/common.c: 183: void mn_exec(void) {
; genLabel
;	-----------------------------------------
;	 function mn_exec
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 3 bytes.
_mn_exec:
	sub	sp, #3
;	src/common.c: 185: for (uint8_t x=4; x<8; x++) {
; skipping iCode since result will be rematerialized
; genPlus
	ldw	x, #(_sys_nrf + 0)+2
	ldw	(0x01, sp), x
; genAssign
	ld	a, #0x04
	ld	(0x03, sp), a
; genLabel
00107$:
; genCmp
; genCmpTop
	ld	a, (0x03, sp)
	cp	a, #0x08
	jrc	00132$
	jp	00101$
00132$:
; skipping generated iCode
;	src/common.c: 186: uart_putc(sys_nrf.data_rx[x]);
; genPlus
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	addw	x, (0x01, sp)
; genPointerGet
	ld	a, (x)
; genIPush
	push	a
; genCall
	call	_uart_putc
	pop	a
;	src/common.c: 185: for (uint8_t x=4; x<8; x++) {
; genPlus
	inc	(0x03, sp)
; genGoto
	jp	00107$
; genLabel
00101$:
;	src/common.c: 189: if ( sys_nrf.data_rx[4] == 'C' ) {
; genPlus
	ldw	x, #(_sys_nrf + 0)+6
; genPointerGet
	ld	a, (x)
; genCmpEQorNE
	cp	a, #0x43
	jrne	00134$
	jp	00135$
00134$:
	jp	00103$
00135$:
; skipping generated iCode
;	src/common.c: 190: output_set(3 ,1);
; genIPush
	pushw	x
	push	#0x01
; genIPush
	push	#0x03
; genCall
	call	_output_set
	addw	sp, #2
	popw	x
; genLabel
00103$:
;	src/common.c: 193: if ( sys_nrf.data_rx[4] == 'O' ) {
; genPointerGet
	ld	a, (x)
; genCmpEQorNE
	cp	a, #0x4f
	jrne	00137$
	jp	00138$
00137$:
	jp	00105$
00138$:
; skipping generated iCode
;	src/common.c: 194: output_set(3, 0);
; genIPush
	push	#0x00
; genIPush
	push	#0x03
; genCall
	call	_output_set
	addw	sp, #2
; genLabel
00105$:
;	src/common.c: 197: nrf_clear_rxbuff();
; genCall
	addw	sp, #3
	jp	_nrf_clear_rxbuff
; genLabel
00109$:
;	src/common.c: 198: }
; genEndFunction
	addw	sp, #3
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
