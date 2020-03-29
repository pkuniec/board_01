                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.0.0 #11528 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module common
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _mn_decode_frame
                                     12 	.globl _nrf_clear_rxbuff
                                     13 	.globl _uart_recv
                                     14 	.globl _uart_putc
                                     15 	.globl _setup
                                     16 	.globl _delay
                                     17 	.globl _uart_event
                                     18 	.globl _sys_event
                                     19 	.globl _spi_init
                                     20 	.globl _spi_transmit
                                     21 	.globl _eeprom_read
                                     22 	.globl _eeprom_write
                                     23 	.globl _adc_get
                                     24 	.globl _reg_transfer
                                     25 	.globl _output_set
                                     26 	.globl _nrf_recv
                                     27 	.globl _mn_exec
                                     28 ;--------------------------------------------------------
                                     29 ; ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DATA
      00001A                         32 _output_set_reg_data_65536_76:
      00001A                         33 	.ds 1
                                     34 ;--------------------------------------------------------
                                     35 ; ram data
                                     36 ;--------------------------------------------------------
                                     37 	.area INITIALIZED
                                     38 ;--------------------------------------------------------
                                     39 ; absolute external ram data
                                     40 ;--------------------------------------------------------
                                     41 	.area DABS (ABS)
                                     42 
                                     43 ; default segment ordering for linker
                                     44 	.area HOME
                                     45 	.area GSINIT
                                     46 	.area GSFINAL
                                     47 	.area CONST
                                     48 	.area INITIALIZER
                                     49 	.area CODE
                                     50 
                                     51 ;--------------------------------------------------------
                                     52 ; global & static initialisations
                                     53 ;--------------------------------------------------------
                                     54 	.area HOME
                                     55 	.area GSINIT
                                     56 	.area GSFINAL
                                     57 	.area GSINIT
                                     58 ;--------------------------------------------------------
                                     59 ; Home
                                     60 ;--------------------------------------------------------
                                     61 	.area HOME
                                     62 	.area HOME
                                     63 ;--------------------------------------------------------
                                     64 ; code
                                     65 ;--------------------------------------------------------
                                     66 	.area CODE
                                     67 ;	src/common.c: 8: void setup(void) {
                                     68 ; genLabel
                                     69 ;	-----------------------------------------
                                     70 ;	 function setup
                                     71 ;	-----------------------------------------
                                     72 ;	Register assignment is optimal.
                                     73 ;	Stack space usage: 0 bytes.
      00832D                         74 _setup:
                                     75 ;	src/common.c: 11: GPIOA->DDR = (1<<LATCH);
                                     76 ; genPointerSet
      00832D 35 02 50 02      [ 1]   77 	mov	0x5002+0, #0x02
                                     78 ;	src/common.c: 12: GPIOA->CR1 = (1<<LATCH);
                                     79 ; genPointerSet
      008331 35 02 50 03      [ 1]   80 	mov	0x5003+0, #0x02
                                     81 ;	src/common.c: 15: GPIOC->CR2 = PIN_4;
                                     82 ; genPointerSet
      008335 35 10 50 0E      [ 1]   83 	mov	0x500e+0, #0x10
                                     84 ;	src/common.c: 16: EXTI->CR1 |= 0x20; // PORTC faling edge
                                     85 ; genPointerGet
      008339 C6 50 A0         [ 1]   86 	ld	a, 0x50a0
                                     87 ; genOr
      00833C AA 20            [ 1]   88 	or	a, #0x20
                                     89 ; genPointerSet
      00833E C7 50 A0         [ 1]   90 	ld	0x50a0, a
                                     91 ;	src/common.c: 19: ADC1->CSR = 0x03; // Channel 3;
                                     92 ; genPointerSet
      008341 35 03 54 00      [ 1]   93 	mov	0x5400+0, #0x03
                                     94 ;	src/common.c: 20: ADC1->CR1 = 0x70; // f.master/18
                                     95 ; genPointerSet
      008345 35 70 54 01      [ 1]   96 	mov	0x5401+0, #0x70
                                     97 ;	src/common.c: 21: ADC1->TDRL = 0x03;
                                     98 ; genPointerSet
      008349 35 03 54 07      [ 1]   99 	mov	0x5407+0, #0x03
                                    100 ;	src/common.c: 24: ClrBit(GPIOA->ODR, LATCH);
                                    101 ; genPointerGet
      00834D C6 50 00         [ 1]  102 	ld	a, 0x5000
                                    103 ; genAnd
      008350 A4 FD            [ 1]  104 	and	a, #0xfd
                                    105 ; genPointerSet
      008352 C7 50 00         [ 1]  106 	ld	0x5000, a
                                    107 ;	src/common.c: 27: TIM2->ARRH = 0x03; // 
                                    108 ; genPointerSet
      008355 35 03 53 0F      [ 1]  109 	mov	0x530f+0, #0x03
                                    110 ;	src/common.c: 28: TIM2->ARRL = 0xE7; // ARR = 999
                                    111 ; genPointerSet
      008359 35 E7 53 10      [ 1]  112 	mov	0x5310+0, #0xe7
                                    113 ;	src/common.c: 29: TIM2->PSCR = 0x00; // PSCR = 1
                                    114 ; genPointerSet
      00835D 35 00 53 0E      [ 1]  115 	mov	0x530e+0, #0x00
                                    116 ;	src/common.c: 30: TIM2->EGR = TIM2_EGR_UG;
                                    117 ; genPointerSet
      008361 35 01 53 06      [ 1]  118 	mov	0x5306+0, #0x01
                                    119 ;	src/common.c: 31: TIM2->CCMR1 = 0x78; // PWM mode1
                                    120 ; genPointerSet
      008365 35 78 53 07      [ 1]  121 	mov	0x5307+0, #0x78
                                    122 ;	src/common.c: 32: TIM2->CCMR2 = 0x78; // PWM mode1
                                    123 ; genPointerSet
      008369 35 78 53 08      [ 1]  124 	mov	0x5308+0, #0x78
                                    125 ;	src/common.c: 33: TIM2->CCER1 = TIM2_CCER1_CC1E | TIM2_CCER1_CC2E;
                                    126 ; genPointerSet
      00836D 35 11 53 0A      [ 1]  127 	mov	0x530a+0, #0x11
                                    128 ;	src/common.c: 34: TIM2->CCR1H = 0x01;
                                    129 ; genPointerSet
      008371 35 01 53 11      [ 1]  130 	mov	0x5311+0, #0x01
                                    131 ;	src/common.c: 35: TIM2->CCR1L = 0xF4;
                                    132 ; genPointerSet
      008375 35 F4 53 12      [ 1]  133 	mov	0x5312+0, #0xf4
                                    134 ;	src/common.c: 36: TIM2->CCR2H = 0x00;
                                    135 ; genPointerSet
      008379 35 00 53 13      [ 1]  136 	mov	0x5313+0, #0x00
                                    137 ;	src/common.c: 37: TIM2->CCR2L = 0xFA;
                                    138 ; genPointerSet
      00837D 35 FA 53 14      [ 1]  139 	mov	0x5314+0, #0xfa
                                    140 ;	src/common.c: 41: TIM4->PSCR = TIM4_PSCR_PSC; // pre. 128
                                    141 ; genPointerSet
      008381 35 07 53 47      [ 1]  142 	mov	0x5347+0, #0x07
                                    143 ;	src/common.c: 42: TIM4->ARR = 99;
                                    144 ; genPointerSet
      008385 35 63 53 48      [ 1]  145 	mov	0x5348+0, #0x63
                                    146 ;	src/common.c: 43: TIM4->IER |= TIM4_IER_UIE;
                                    147 ; genPointerGet
      008389 C6 53 43         [ 1]  148 	ld	a, 0x5343
                                    149 ; genOr
      00838C AA 01            [ 1]  150 	or	a, #0x01
                                    151 ; genPointerSet
      00838E C7 53 43         [ 1]  152 	ld	0x5343, a
                                    153 ;	src/common.c: 44: TIM4->CR1 |= TIM4_CR1_CEN;
                                    154 ; genPointerGet
      008391 C6 53 40         [ 1]  155 	ld	a, 0x5340
                                    156 ; genOr
      008394 AA 01            [ 1]  157 	or	a, #0x01
                                    158 ; genPointerSet
      008396 C7 53 40         [ 1]  159 	ld	0x5340, a
                                    160 ; genLabel
      008399                        161 00101$:
                                    162 ;	src/common.c: 45: }
                                    163 ; genEndFunction
      008399 81               [ 4]  164 	ret
                                    165 ;	src/common.c: 48: void delay(uint16_t time) {
                                    166 ; genLabel
                                    167 ;	-----------------------------------------
                                    168 ;	 function delay
                                    169 ;	-----------------------------------------
                                    170 ;	Register assignment is optimal.
                                    171 ;	Stack space usage: 0 bytes.
      00839A                        172 _delay:
                                    173 ;	src/common.c: 49: while( time ) {
                                    174 ; genAssign
      00839A 1E 03            [ 2]  175 	ldw	x, (0x03, sp)
                                    176 ; genLabel
      00839C                        177 00101$:
                                    178 ; genIfx
      00839C 5D               [ 2]  179 	tnzw	x
      00839D 26 03            [ 1]  180 	jrne	00117$
      00839F CC 83 A7         [ 2]  181 	jp	00104$
      0083A2                        182 00117$:
                                    183 ;	src/common.c: 50: time--;
                                    184 ; genMinus
      0083A2 5A               [ 2]  185 	decw	x
                                    186 ;	src/common.c: 51: nop();
                                    187 ;	genInline
      0083A3 9D               [ 1]  188 	nop
                                    189 ; genGoto
      0083A4 CC 83 9C         [ 2]  190 	jp	00101$
                                    191 ; genLabel
      0083A7                        192 00104$:
                                    193 ;	src/common.c: 53: }
                                    194 ; genEndFunction
      0083A7 81               [ 4]  195 	ret
                                    196 ;	src/common.c: 56: void uart_event(void) {
                                    197 ; genLabel
                                    198 ;	-----------------------------------------
                                    199 ;	 function uart_event
                                    200 ;	-----------------------------------------
                                    201 ;	Register assignment might be sub-optimal.
                                    202 ;	Stack space usage: 1 bytes.
      0083A8                        203 _uart_event:
      0083A8 88               [ 1]  204 	push	a
                                    205 ;	src/common.c: 57: uint8_t data = 0;
                                    206 ; genAssign
      0083A9 0F 01            [ 1]  207 	clr	(0x01, sp)
                                    208 ;	src/common.c: 59: if( !uart_recv( &data ) ) {
                                    209 ; skipping iCode since result will be rematerialized
                                    210 ; skipping iCode since result will be rematerialized
                                    211 ; genIPush
      0083AB 96               [ 1]  212 	ldw	x, sp
      0083AC 5C               [ 1]  213 	incw	x
      0083AD 89               [ 2]  214 	pushw	x
                                    215 ; genCall
      0083AE CD 86 03         [ 4]  216 	call	_uart_recv
      0083B1 5B 02            [ 2]  217 	addw	sp, #2
                                    218 ; genIfx
      0083B3 4D               [ 1]  219 	tnz	a
      0083B4 27 03            [ 1]  220 	jreq	00117$
      0083B6 CC 83 CF         [ 2]  221 	jp	00105$
      0083B9                        222 00117$:
                                    223 ;	src/common.c: 61: if ( data == 'a' ) {
                                    224 ; genCmpEQorNE
      0083B9 7B 01            [ 1]  225 	ld	a, (0x01, sp)
      0083BB A1 61            [ 1]  226 	cp	a, #0x61
      0083BD 26 03            [ 1]  227 	jrne	00119$
      0083BF CC 83 C5         [ 2]  228 	jp	00120$
      0083C2                        229 00119$:
      0083C2 CC 83 CF         [ 2]  230 	jp	00105$
      0083C5                        231 00120$:
                                    232 ; skipping generated iCode
                                    233 ;	src/common.c: 62: uart_putc('0' + uart_rx_Buff.head);
                                    234 ; skipping iCode since result will be rematerialized
                                    235 ; genPointerGet
      0083C5 C6 00 21         [ 1]  236 	ld	a, _uart_rx_Buff+2
                                    237 ; genCast
                                    238 ; genAssign
                                    239 ; genPlus
      0083C8 AB 30            [ 1]  240 	add	a, #0x30
                                    241 ; genIPush
      0083CA 88               [ 1]  242 	push	a
                                    243 ; genCall
      0083CB CD 85 99         [ 4]  244 	call	_uart_putc
      0083CE 84               [ 1]  245 	pop	a
                                    246 ; genLabel
      0083CF                        247 00105$:
                                    248 ;	src/common.c: 65: }
                                    249 ; genEndFunction
      0083CF 84               [ 1]  250 	pop	a
      0083D0 81               [ 4]  251 	ret
                                    252 ;	src/common.c: 68: void sys_event(void) {
                                    253 ; genLabel
                                    254 ;	-----------------------------------------
                                    255 ;	 function sys_event
                                    256 ;	-----------------------------------------
                                    257 ;	Register assignment is optimal.
                                    258 ;	Stack space usage: 0 bytes.
      0083D1                        259 _sys_event:
                                    260 ;	src/common.c: 69: if ( system.flags ) {
                                    261 ; genAddrOf
      0083D1 AE 00 30         [ 2]  262 	ldw	x, #_system+0
                                    263 ; genPointerGet
      0083D4 F6               [ 1]  264 	ld	a, (x)
                                    265 ; genIfx
      0083D5 4D               [ 1]  266 	tnz	a
      0083D6 26 03            [ 1]  267 	jrne	00117$
      0083D8 CC 83 EB         [ 2]  268 	jp	00105$
      0083DB                        269 00117$:
                                    270 ;	src/common.c: 71: if ( system.flags & (1<<E_IRQ) ) {
                                    271 ; genAnd
      0083DB A5 01            [ 1]  272 	bcp	a, #0x01
      0083DD 26 03            [ 1]  273 	jrne	00118$
      0083DF CC 83 EB         [ 2]  274 	jp	00105$
      0083E2                        275 00118$:
                                    276 ; skipping generated iCode
                                    277 ;	src/common.c: 72: ClrBit(system.flags, E_IRQ);
                                    278 ; genAnd
      0083E2 A4 FE            [ 1]  279 	and	a, #0xfe
                                    280 ; genPointerSet
      0083E4 F7               [ 1]  281 	ld	(x), a
                                    282 ;	src/common.c: 73: uart_putc('E');
                                    283 ; genIPush
      0083E5 4B 45            [ 1]  284 	push	#0x45
                                    285 ; genCall
      0083E7 CD 85 99         [ 4]  286 	call	_uart_putc
      0083EA 84               [ 1]  287 	pop	a
                                    288 ; genLabel
      0083EB                        289 00105$:
                                    290 ;	src/common.c: 76: }
                                    291 ; genEndFunction
      0083EB 81               [ 4]  292 	ret
                                    293 ;	src/common.c: 80: void spi_init(void) {
                                    294 ; genLabel
                                    295 ;	-----------------------------------------
                                    296 ;	 function spi_init
                                    297 ;	-----------------------------------------
                                    298 ;	Register assignment is optimal.
                                    299 ;	Stack space usage: 0 bytes.
      0083EC                        300 _spi_init:
                                    301 ;	src/common.c: 82: SPI->CR2 = SPI_CR2_SSM | SPI_CR2_SSI;
                                    302 ; genPointerSet
      0083EC 35 03 52 01      [ 1]  303 	mov	0x5201+0, #0x03
                                    304 ;	src/common.c: 83: SPI->CR1 = SPI_CR1_MSTR | SPI_CR1_SPE;// | (SPI_CR1_BR & 0x08);
                                    305 ; genPointerSet
      0083F0 35 44 52 00      [ 1]  306 	mov	0x5200+0, #0x44
                                    307 ; genLabel
      0083F4                        308 00101$:
                                    309 ;	src/common.c: 84: }
                                    310 ; genEndFunction
      0083F4 81               [ 4]  311 	ret
                                    312 ;	src/common.c: 90: uint8_t spi_transmit(uint8_t data) {
                                    313 ; genLabel
                                    314 ;	-----------------------------------------
                                    315 ;	 function spi_transmit
                                    316 ;	-----------------------------------------
                                    317 ;	Register assignment is optimal.
                                    318 ;	Stack space usage: 0 bytes.
      0083F5                        319 _spi_transmit:
                                    320 ;	src/common.c: 91: SPI->DR = data;
                                    321 ; genPointerSet
      0083F5 AE 52 04         [ 2]  322 	ldw	x, #0x5204
      0083F8 7B 03            [ 1]  323 	ld	a, (0x03, sp)
      0083FA F7               [ 1]  324 	ld	(x), a
                                    325 ;	src/common.c: 92: while( !(SPI->SR & SPI_SR_TXE) );
                                    326 ; genLabel
      0083FB                        327 00101$:
                                    328 ; genPointerGet
      0083FB C6 52 03         [ 1]  329 	ld	a, 0x5203
                                    330 ; genAnd
      0083FE A5 02            [ 1]  331 	bcp	a, #0x02
      008400 26 03            [ 1]  332 	jrne	00124$
      008402 CC 83 FB         [ 2]  333 	jp	00101$
      008405                        334 00124$:
                                    335 ; skipping generated iCode
                                    336 ;	src/common.c: 93: while( !(SPI->SR & SPI_SR_RXNE) );
                                    337 ; genLabel
      008405                        338 00104$:
                                    339 ; genPointerGet
      008405 C6 52 03         [ 1]  340 	ld	a, 0x5203
                                    341 ; genAnd
      008408 44               [ 1]  342 	srl	a
      008409 25 03            [ 1]  343 	jrc	00125$
      00840B CC 84 05         [ 2]  344 	jp	00104$
      00840E                        345 00125$:
                                    346 ; skipping generated iCode
                                    347 ;	src/common.c: 94: return SPI->DR;
                                    348 ; genPointerGet
      00840E C6 52 04         [ 1]  349 	ld	a, 0x5204
                                    350 ; genReturn
                                    351 ; genLabel
      008411                        352 00107$:
                                    353 ;	src/common.c: 95: }
                                    354 ; genEndFunction
      008411 81               [ 4]  355 	ret
                                    356 ;	src/common.c: 100: uint8_t eeprom_read(uint8_t addr) {
                                    357 ; genLabel
                                    358 ;	-----------------------------------------
                                    359 ;	 function eeprom_read
                                    360 ;	-----------------------------------------
                                    361 ;	Register assignment is optimal.
                                    362 ;	Stack space usage: 0 bytes.
      008412                        363 _eeprom_read:
                                    364 ;	src/common.c: 102: return *(eemem + addr);
                                    365 ; genPlus
      008412 5F               [ 1]  366 	clrw	x
      008413 7B 03            [ 1]  367 	ld	a, (0x03, sp)
      008415 97               [ 1]  368 	ld	xl, a
      008416 1C 40 00         [ 2]  369 	addw	x, #0x4000
                                    370 ; genPointerGet
      008419 F6               [ 1]  371 	ld	a, (x)
                                    372 ; genReturn
                                    373 ; genLabel
      00841A                        374 00101$:
                                    375 ;	src/common.c: 103: }
                                    376 ; genEndFunction
      00841A 81               [ 4]  377 	ret
                                    378 ;	src/common.c: 110: void eeprom_write(uint8_t addr, uint8_t *data, uint8_t len) {
                                    379 ; genLabel
                                    380 ;	-----------------------------------------
                                    381 ;	 function eeprom_write
                                    382 ;	-----------------------------------------
                                    383 ;	Register assignment might be sub-optimal.
                                    384 ;	Stack space usage: 3 bytes.
      00841B                        385 _eeprom_write:
      00841B 52 03            [ 2]  386 	sub	sp, #3
                                    387 ;	src/common.c: 113: if( !(FLASH->IAPSR & FLASH_IAPSR_DUL) ) {
                                    388 ; genPointerGet
      00841D C6 50 5F         [ 1]  389 	ld	a, 0x505f
                                    390 ; genAnd
      008420 A5 08            [ 1]  391 	bcp	a, #0x08
      008422 27 03            [ 1]  392 	jreq	00146$
      008424 CC 84 39         [ 2]  393 	jp	00120$
      008427                        394 00146$:
                                    395 ; skipping generated iCode
                                    396 ;	src/common.c: 115: FLASH->DUKR = 0xAE;
                                    397 ; genPointerSet
      008427 35 AE 50 64      [ 1]  398 	mov	0x5064+0, #0xae
                                    399 ;	src/common.c: 116: FLASH->DUKR = 0x56;
                                    400 ; genPointerSet
      00842B 35 56 50 64      [ 1]  401 	mov	0x5064+0, #0x56
                                    402 ;	src/common.c: 117: while ( !(FLASH->IAPSR & FLASH_IAPSR_DUL) );
                                    403 ; genLabel
      00842F                        404 00101$:
                                    405 ; genPointerGet
      00842F C6 50 5F         [ 1]  406 	ld	a, 0x505f
                                    407 ; genAnd
      008432 A5 08            [ 1]  408 	bcp	a, #0x08
      008434 26 03            [ 1]  409 	jrne	00147$
      008436 CC 84 2F         [ 2]  410 	jp	00101$
      008439                        411 00147$:
                                    412 ; skipping generated iCode
                                    413 ;	src/common.c: 120: for( uint8_t i = 0; i<len; i++) {
                                    414 ; genLabel
      008439                        415 00120$:
                                    416 ; genPlus
      008439 5F               [ 1]  417 	clrw	x
      00843A 7B 06            [ 1]  418 	ld	a, (0x06, sp)
      00843C 97               [ 1]  419 	ld	xl, a
      00843D 1C 40 00         [ 2]  420 	addw	x, #0x4000
      008440 1F 01            [ 2]  421 	ldw	(0x01, sp), x
                                    422 ; genAssign
      008442 0F 03            [ 1]  423 	clr	(0x03, sp)
                                    424 ; genLabel
      008444                        425 00111$:
                                    426 ; genCmp
                                    427 ; genCmpTop
      008444 7B 03            [ 1]  428 	ld	a, (0x03, sp)
      008446 11 09            [ 1]  429 	cp	a, (0x09, sp)
      008448 25 03            [ 1]  430 	jrc	00148$
      00844A CC 84 6F         [ 2]  431 	jp	00109$
      00844D                        432 00148$:
                                    433 ; skipping generated iCode
                                    434 ;	src/common.c: 121: *(eemem + addr + i) = data[i];
                                    435 ; genPlus
      00844D 5F               [ 1]  436 	clrw	x
      00844E 7B 03            [ 1]  437 	ld	a, (0x03, sp)
      008450 97               [ 1]  438 	ld	xl, a
      008451 72 FB 01         [ 2]  439 	addw	x, (0x01, sp)
                                    440 ; genPlus
      008454 90 5F            [ 1]  441 	clrw	y
      008456 7B 03            [ 1]  442 	ld	a, (0x03, sp)
      008458 90 97            [ 1]  443 	ld	yl, a
      00845A 72 F9 07         [ 2]  444 	addw	y, (0x07, sp)
                                    445 ; genPointerGet
      00845D 90 F6            [ 1]  446 	ld	a, (y)
                                    447 ; genPointerSet
      00845F F7               [ 1]  448 	ld	(x), a
                                    449 ;	src/common.c: 122: while ( !(FLASH->IAPSR & FLASH_IAPSR_EOP) );
                                    450 ; genLabel
      008460                        451 00106$:
                                    452 ; genPointerGet
      008460 C6 50 5F         [ 1]  453 	ld	a, 0x505f
                                    454 ; genAnd
      008463 A5 04            [ 1]  455 	bcp	a, #0x04
      008465 26 03            [ 1]  456 	jrne	00149$
      008467 CC 84 60         [ 2]  457 	jp	00106$
      00846A                        458 00149$:
                                    459 ; skipping generated iCode
                                    460 ;	src/common.c: 120: for( uint8_t i = 0; i<len; i++) {
                                    461 ; genPlus
      00846A 0C 03            [ 1]  462 	inc	(0x03, sp)
                                    463 ; genGoto
      00846C CC 84 44         [ 2]  464 	jp	00111$
                                    465 ; genLabel
      00846F                        466 00109$:
                                    467 ;	src/common.c: 125: FLASH->IAPSR &= ~FLASH_IAPSR_DUL; 
                                    468 ; genPointerGet
      00846F C6 50 5F         [ 1]  469 	ld	a, 0x505f
                                    470 ; genAnd
      008472 A4 F7            [ 1]  471 	and	a, #0xf7
                                    472 ; genPointerSet
      008474 C7 50 5F         [ 1]  473 	ld	0x505f, a
                                    474 ; genLabel
      008477                        475 00113$:
                                    476 ;	src/common.c: 126: }
                                    477 ; genEndFunction
      008477 5B 03            [ 2]  478 	addw	sp, #3
      008479 81               [ 4]  479 	ret
                                    480 ;	src/common.c: 131: void adc_get(uint16_t *adc) {
                                    481 ; genLabel
                                    482 ;	-----------------------------------------
                                    483 ;	 function adc_get
                                    484 ;	-----------------------------------------
                                    485 ;	Register assignment might be sub-optimal.
                                    486 ;	Stack space usage: 2 bytes.
      00847A                        487 _adc_get:
      00847A 52 02            [ 2]  488 	sub	sp, #2
                                    489 ;	src/common.c: 133: SetBit(ADC1->CR1, 0);
                                    490 ; genPointerGet
      00847C C6 54 01         [ 1]  491 	ld	a, 0x5401
                                    492 ; genOr
      00847F AA 01            [ 1]  493 	or	a, #0x01
                                    494 ; genPointerSet
      008481 C7 54 01         [ 1]  495 	ld	0x5401, a
                                    496 ;	src/common.c: 134: delay(100);
                                    497 ; genIPush
      008484 4B 64            [ 1]  498 	push	#0x64
      008486 4B 00            [ 1]  499 	push	#0x00
                                    500 ; genCall
      008488 CD 83 9A         [ 4]  501 	call	_delay
      00848B 5B 02            [ 2]  502 	addw	sp, #2
                                    503 ;	src/common.c: 136: SetBit(ADC1->CR1, 0);
                                    504 ; genPointerGet
      00848D C6 54 01         [ 1]  505 	ld	a, 0x5401
                                    506 ; genOr
      008490 AA 01            [ 1]  507 	or	a, #0x01
                                    508 ; genPointerSet
      008492 C7 54 01         [ 1]  509 	ld	0x5401, a
                                    510 ;	src/common.c: 137: while(ADC1->CSR & ADC1_CSR_EOC)
                                    511 ; genLabel
      008495                        512 00101$:
                                    513 ; genPointerGet
      008495 C6 54 00         [ 1]  514 	ld	a, 0x5400
                                    515 ; genAnd
      008498 4D               [ 1]  516 	tnz	a
      008499 2B 03            [ 1]  517 	jrmi	00116$
      00849B CC 84 A9         [ 2]  518 	jp	00103$
      00849E                        519 00116$:
                                    520 ; skipping generated iCode
                                    521 ;	src/common.c: 138: ClrBit(ADC1->CSR, 7);
                                    522 ; genPointerGet
      00849E C6 54 00         [ 1]  523 	ld	a, 0x5400
                                    524 ; genAnd
      0084A1 A4 7F            [ 1]  525 	and	a, #0x7f
                                    526 ; genPointerSet
      0084A3 C7 54 00         [ 1]  527 	ld	0x5400, a
                                    528 ; genGoto
      0084A6 CC 84 95         [ 2]  529 	jp	00101$
                                    530 ; genLabel
      0084A9                        531 00103$:
                                    532 ;	src/common.c: 139: *adc = (uint16_t)(ADC1->DRH << 8);
                                    533 ; genAssign
      0084A9 16 05            [ 2]  534 	ldw	y, (0x05, sp)
                                    535 ; genPointerGet
      0084AB C6 54 04         [ 1]  536 	ld	a, 0x5404
                                    537 ; genCast
                                    538 ; genAssign
      0084AE 5F               [ 1]  539 	clrw	x
                                    540 ; genLeftShiftLiteral
      0084AF 95               [ 1]  541 	ld	xh, a
      0084B0 4F               [ 1]  542 	clr	a
                                    543 ; genCast
                                    544 ; genAssign
      0084B1 97               [ 1]  545 	ld	xl, a
                                    546 ; genPointerSet
      0084B2 90 FF            [ 2]  547 	ldw	(y), x
                                    548 ;	src/common.c: 140: *adc |= (uint8_t)(ADC1->DRL);
                                    549 ; genPointerGet
      0084B4 C6 54 05         [ 1]  550 	ld	a, 0x5405
                                    551 ; genCast
                                    552 ; genAssign
      0084B7 0F 01            [ 1]  553 	clr	(0x01, sp)
                                    554 ; genOr
      0084B9 89               [ 2]  555 	pushw	x
      0084BA 1A 02            [ 1]  556 	or	a, (2, sp)
      0084BC 85               [ 2]  557 	popw	x
      0084BD 97               [ 1]  558 	ld	xl, a
      0084BE 9E               [ 1]  559 	ld	a, xh
      0084BF 1A 01            [ 1]  560 	or	a, (0x01, sp)
      0084C1 95               [ 1]  561 	ld	xh, a
                                    562 ; genPointerSet
      0084C2 90 FF            [ 2]  563 	ldw	(y), x
                                    564 ;	src/common.c: 142: ClrBit(ADC1->CR1, 0);
                                    565 ; genPointerGet
      0084C4 C6 54 01         [ 1]  566 	ld	a, 0x5401
                                    567 ; genAnd
      0084C7 A4 FE            [ 1]  568 	and	a, #0xfe
                                    569 ; genPointerSet
      0084C9 C7 54 01         [ 1]  570 	ld	0x5401, a
                                    571 ; genLabel
      0084CC                        572 00104$:
                                    573 ;	src/common.c: 143: }
                                    574 ; genEndFunction
      0084CC 5B 02            [ 2]  575 	addw	sp, #2
      0084CE 81               [ 4]  576 	ret
                                    577 ;	src/common.c: 148: void reg_transfer(uint8_t data) {
                                    578 ; genLabel
                                    579 ;	-----------------------------------------
                                    580 ;	 function reg_transfer
                                    581 ;	-----------------------------------------
                                    582 ;	Register assignment is optimal.
                                    583 ;	Stack space usage: 0 bytes.
      0084CF                        584 _reg_transfer:
                                    585 ;	src/common.c: 149: spi_transmit(data);
                                    586 ; genIPush
      0084CF 7B 03            [ 1]  587 	ld	a, (0x03, sp)
      0084D1 88               [ 1]  588 	push	a
                                    589 ; genCall
      0084D2 CD 83 F5         [ 4]  590 	call	_spi_transmit
      0084D5 84               [ 1]  591 	pop	a
                                    592 ;	src/common.c: 150: SetBit(GPIOA->ODR, LATCH);
                                    593 ; genPointerGet
      0084D6 C6 50 00         [ 1]  594 	ld	a, 0x5000
                                    595 ; genOr
      0084D9 AA 02            [ 1]  596 	or	a, #0x02
                                    597 ; genPointerSet
      0084DB C7 50 00         [ 1]  598 	ld	0x5000, a
                                    599 ;	src/common.c: 151: delay(10);
                                    600 ; genIPush
      0084DE 4B 0A            [ 1]  601 	push	#0x0a
      0084E0 4B 00            [ 1]  602 	push	#0x00
                                    603 ; genCall
      0084E2 CD 83 9A         [ 4]  604 	call	_delay
      0084E5 5B 02            [ 2]  605 	addw	sp, #2
                                    606 ;	src/common.c: 152: ClrBit(GPIOA->ODR, LATCH);
                                    607 ; genPointerGet
      0084E7 C6 50 00         [ 1]  608 	ld	a, 0x5000
                                    609 ; genAnd
      0084EA A4 FD            [ 1]  610 	and	a, #0xfd
                                    611 ; genPointerSet
      0084EC C7 50 00         [ 1]  612 	ld	0x5000, a
                                    613 ; genLabel
      0084EF                        614 00101$:
                                    615 ;	src/common.c: 153: }
                                    616 ; genEndFunction
      0084EF 81               [ 4]  617 	ret
                                    618 ;	src/common.c: 161: void output_set(uint8_t num, uint8_t mode) {
                                    619 ; genLabel
                                    620 ;	-----------------------------------------
                                    621 ;	 function output_set
                                    622 ;	-----------------------------------------
                                    623 ;	Register assignment is optimal.
                                    624 ;	Stack space usage: 0 bytes.
      0084F0                        625 _output_set:
                                    626 ;	src/common.c: 165: SetBit(reg_data, num);
                                    627 ; genLeftShift
      0084F0 A6 01            [ 1]  628 	ld	a, #0x01
      0084F2 88               [ 1]  629 	push	a
      0084F3 7B 04            [ 1]  630 	ld	a, (0x04, sp)
      0084F5 27 05            [ 1]  631 	jreq	00112$
      0084F7                        632 00111$:
      0084F7 08 01            [ 1]  633 	sll	(1, sp)
      0084F9 4A               [ 1]  634 	dec	a
      0084FA 26 FB            [ 1]  635 	jrne	00111$
      0084FC                        636 00112$:
      0084FC 84               [ 1]  637 	pop	a
                                    638 ;	src/common.c: 164: if ( mode ) {
                                    639 ; genIfx
      0084FD 0D 04            [ 1]  640 	tnz	(0x04, sp)
      0084FF 26 03            [ 1]  641 	jrne	00113$
      008501 CC 85 0D         [ 2]  642 	jp	00102$
      008504                        643 00113$:
                                    644 ;	src/common.c: 165: SetBit(reg_data, num);
                                    645 ; genOr
      008504 CA 00 1A         [ 1]  646 	or	a, _output_set_reg_data_65536_76+0
      008507 C7 00 1A         [ 1]  647 	ld	_output_set_reg_data_65536_76+0, a
                                    648 ; genGoto
      00850A CC 85 14         [ 2]  649 	jp	00103$
                                    650 ; genLabel
      00850D                        651 00102$:
                                    652 ;	src/common.c: 167: ClrBit(reg_data, num);
                                    653 ; genXor
      00850D 43               [ 1]  654 	cpl	a
                                    655 ; genAnd
      00850E C4 00 1A         [ 1]  656 	and	a, _output_set_reg_data_65536_76+0
      008511 C7 00 1A         [ 1]  657 	ld	_output_set_reg_data_65536_76+0, a
                                    658 ; genLabel
      008514                        659 00103$:
                                    660 ;	src/common.c: 170: reg_transfer(reg_data);
                                    661 ; genIPush
      008514 3B 00 1A         [ 1]  662 	push	_output_set_reg_data_65536_76+0
                                    663 ; genCall
      008517 CD 84 CF         [ 4]  664 	call	_reg_transfer
      00851A 84               [ 1]  665 	pop	a
                                    666 ; genLabel
      00851B                        667 00104$:
                                    668 ;	src/common.c: 171: }
                                    669 ; genEndFunction
      00851B 81               [ 4]  670 	ret
                                    671 ;	src/common.c: 175: void nrf_recv(void) {
                                    672 ; genLabel
                                    673 ;	-----------------------------------------
                                    674 ;	 function nrf_recv
                                    675 ;	-----------------------------------------
                                    676 ;	Register assignment is optimal.
                                    677 ;	Stack space usage: 0 bytes.
      00851C                        678 _nrf_recv:
                                    679 ;	src/common.c: 176: if ( sys_nrf.status & RX_DR ) {
                                    680 ; genAddrOf
      00851C AE 00 23         [ 2]  681 	ldw	x, #_sys_nrf+0
                                    682 ; genPointerGet
      00851F F6               [ 1]  683 	ld	a, (x)
                                    684 ; genAnd
      008520 A5 40            [ 1]  685 	bcp	a, #0x40
      008522 26 03            [ 1]  686 	jrne	00110$
      008524 CC 85 30         [ 2]  687 	jp	00103$
      008527                        688 00110$:
                                    689 ; skipping generated iCode
                                    690 ;	src/common.c: 177: mn_decode_frame();
                                    691 ; genCall
      008527 89               [ 2]  692 	pushw	x
      008528 CD 81 40         [ 4]  693 	call	_mn_decode_frame
      00852B 85               [ 2]  694 	popw	x
                                    695 ;	src/common.c: 178: sys_nrf.status &=~ RX_DR;
                                    696 ; genPointerGet
      00852C F6               [ 1]  697 	ld	a, (x)
                                    698 ; genAnd
      00852D A4 BF            [ 1]  699 	and	a, #0xbf
                                    700 ; genPointerSet
      00852F F7               [ 1]  701 	ld	(x), a
                                    702 ; genLabel
      008530                        703 00103$:
                                    704 ;	src/common.c: 180: }
                                    705 ; genEndFunction
      008530 81               [ 4]  706 	ret
                                    707 ;	src/common.c: 183: void mn_exec(void) {
                                    708 ; genLabel
                                    709 ;	-----------------------------------------
                                    710 ;	 function mn_exec
                                    711 ;	-----------------------------------------
                                    712 ;	Register assignment might be sub-optimal.
                                    713 ;	Stack space usage: 3 bytes.
      008531                        714 _mn_exec:
      008531 52 03            [ 2]  715 	sub	sp, #3
                                    716 ;	src/common.c: 185: for (uint8_t x=4; x<8; x++) {
                                    717 ; skipping iCode since result will be rematerialized
                                    718 ; genPlus
      008533 AE 00 25         [ 2]  719 	ldw	x, #(_sys_nrf + 0)+2
      008536 1F 01            [ 2]  720 	ldw	(0x01, sp), x
                                    721 ; genAssign
      008538 A6 04            [ 1]  722 	ld	a, #0x04
      00853A 6B 03            [ 1]  723 	ld	(0x03, sp), a
                                    724 ; genLabel
      00853C                        725 00107$:
                                    726 ; genCmp
                                    727 ; genCmpTop
      00853C 7B 03            [ 1]  728 	ld	a, (0x03, sp)
      00853E A1 08            [ 1]  729 	cp	a, #0x08
      008540 25 03            [ 1]  730 	jrc	00132$
      008542 CC 85 57         [ 2]  731 	jp	00101$
      008545                        732 00132$:
                                    733 ; skipping generated iCode
                                    734 ;	src/common.c: 186: uart_putc(sys_nrf.data_rx[x]);
                                    735 ; genPlus
      008545 5F               [ 1]  736 	clrw	x
      008546 7B 03            [ 1]  737 	ld	a, (0x03, sp)
      008548 97               [ 1]  738 	ld	xl, a
      008549 72 FB 01         [ 2]  739 	addw	x, (0x01, sp)
                                    740 ; genPointerGet
      00854C F6               [ 1]  741 	ld	a, (x)
                                    742 ; genIPush
      00854D 88               [ 1]  743 	push	a
                                    744 ; genCall
      00854E CD 85 99         [ 4]  745 	call	_uart_putc
      008551 84               [ 1]  746 	pop	a
                                    747 ;	src/common.c: 185: for (uint8_t x=4; x<8; x++) {
                                    748 ; genPlus
      008552 0C 03            [ 1]  749 	inc	(0x03, sp)
                                    750 ; genGoto
      008554 CC 85 3C         [ 2]  751 	jp	00107$
                                    752 ; genLabel
      008557                        753 00101$:
                                    754 ;	src/common.c: 189: if ( sys_nrf.data_rx[4] == 'C' ) {
                                    755 ; genPlus
      008557 AE 00 29         [ 2]  756 	ldw	x, #(_sys_nrf + 0)+6
                                    757 ; genPointerGet
      00855A F6               [ 1]  758 	ld	a, (x)
                                    759 ; genCmpEQorNE
      00855B A1 43            [ 1]  760 	cp	a, #0x43
      00855D 26 03            [ 1]  761 	jrne	00134$
      00855F CC 85 65         [ 2]  762 	jp	00135$
      008562                        763 00134$:
      008562 CC 85 70         [ 2]  764 	jp	00103$
      008565                        765 00135$:
                                    766 ; skipping generated iCode
                                    767 ;	src/common.c: 190: output_set(3 ,1);
                                    768 ; genIPush
      008565 89               [ 2]  769 	pushw	x
      008566 4B 01            [ 1]  770 	push	#0x01
                                    771 ; genIPush
      008568 4B 03            [ 1]  772 	push	#0x03
                                    773 ; genCall
      00856A CD 84 F0         [ 4]  774 	call	_output_set
      00856D 5B 02            [ 2]  775 	addw	sp, #2
      00856F 85               [ 2]  776 	popw	x
                                    777 ; genLabel
      008570                        778 00103$:
                                    779 ;	src/common.c: 193: if ( sys_nrf.data_rx[4] == 'O' ) {
                                    780 ; genPointerGet
      008570 F6               [ 1]  781 	ld	a, (x)
                                    782 ; genCmpEQorNE
      008571 A1 4F            [ 1]  783 	cp	a, #0x4f
      008573 26 03            [ 1]  784 	jrne	00137$
      008575 CC 85 7B         [ 2]  785 	jp	00138$
      008578                        786 00137$:
      008578 CC 85 84         [ 2]  787 	jp	00105$
      00857B                        788 00138$:
                                    789 ; skipping generated iCode
                                    790 ;	src/common.c: 194: output_set(3, 0);
                                    791 ; genIPush
      00857B 4B 00            [ 1]  792 	push	#0x00
                                    793 ; genIPush
      00857D 4B 03            [ 1]  794 	push	#0x03
                                    795 ; genCall
      00857F CD 84 F0         [ 4]  796 	call	_output_set
      008582 5B 02            [ 2]  797 	addw	sp, #2
                                    798 ; genLabel
      008584                        799 00105$:
                                    800 ;	src/common.c: 197: nrf_clear_rxbuff();
                                    801 ; genCall
      008584 5B 03            [ 2]  802 	addw	sp, #3
      008586 CC 8A 66         [ 2]  803 	jp	_nrf_clear_rxbuff
                                    804 ; genLabel
      008589                        805 00109$:
                                    806 ;	src/common.c: 198: }
                                    807 ; genEndFunction
      008589 5B 03            [ 2]  808 	addw	sp, #3
      00858B 81               [ 4]  809 	ret
                                    810 	.area CODE
                                    811 	.area CONST
                                    812 	.area INITIALIZER
                                    813 	.area CABS (ABS)
