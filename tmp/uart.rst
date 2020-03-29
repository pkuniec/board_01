                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.0.0 #11528 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module uart
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _uart_init
                                     12 	.globl _uart_putc
                                     13 	.globl _uart_puts
                                     14 	.globl _uart_recv
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
                                     23 ;--------------------------------------------------------
                                     24 ; absolute external ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DABS (ABS)
                                     27 
                                     28 ; default segment ordering for linker
                                     29 	.area HOME
                                     30 	.area GSINIT
                                     31 	.area GSFINAL
                                     32 	.area CONST
                                     33 	.area INITIALIZER
                                     34 	.area CODE
                                     35 
                                     36 ;--------------------------------------------------------
                                     37 ; global & static initialisations
                                     38 ;--------------------------------------------------------
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area GSINIT
                                     43 ;--------------------------------------------------------
                                     44 ; Home
                                     45 ;--------------------------------------------------------
                                     46 	.area HOME
                                     47 	.area HOME
                                     48 ;--------------------------------------------------------
                                     49 ; code
                                     50 ;--------------------------------------------------------
                                     51 	.area CODE
                                     52 ;	src/uart.c: 7: void uart_init(void) {
                                     53 ; genLabel
                                     54 ;	-----------------------------------------
                                     55 ;	 function uart_init
                                     56 ;	-----------------------------------------
                                     57 ;	Register assignment is optimal.
                                     58 ;	Stack space usage: 0 bytes.
      00858C                         59 _uart_init:
                                     60 ;	src/uart.c: 9: UART1->BRR2 = 0x00;
                                     61 ; genPointerSet
      00858C 35 00 52 33      [ 1]   62 	mov	0x5233+0, #0x00
                                     63 ;	src/uart.c: 10: UART1->BRR1 = 0x0D;
                                     64 ; genPointerSet
      008590 35 0D 52 32      [ 1]   65 	mov	0x5232+0, #0x0d
                                     66 ;	src/uart.c: 14: UART1->CR2 = UART1_CR2_TEN | UART1_CR2_REN | UART1_CR2_RIEN;
                                     67 ; genPointerSet
      008594 35 2C 52 35      [ 1]   68 	mov	0x5235+0, #0x2c
                                     69 ; genLabel
      008598                         70 00101$:
                                     71 ;	src/uart.c: 15: }
                                     72 ; genEndFunction
      008598 81               [ 4]   73 	ret
                                     74 ;	src/uart.c: 18: int8_t uart_putc(uint8_t c) {
                                     75 ; genLabel
                                     76 ;	-----------------------------------------
                                     77 ;	 function uart_putc
                                     78 ;	-----------------------------------------
                                     79 ;	Register assignment might be sub-optimal.
                                     80 ;	Stack space usage: 2 bytes.
      008599                         81 _uart_putc:
      008599 52 02            [ 2]   82 	sub	sp, #2
                                     83 ;	src/uart.c: 20: UART1->CR2 &= ~(UART1_CR2_REN);
                                     84 ; genPointerGet
      00859B C6 52 35         [ 1]   85 	ld	a, 0x5235
                                     86 ; genAnd
      00859E A4 FB            [ 1]   87 	and	a, #0xfb
                                     88 ; genPointerSet
      0085A0 C7 52 35         [ 1]   89 	ld	0x5235, a
                                     90 ;	src/uart.c: 22: uint8_t head_temp = uart_tx_Buff.head + 1;
                                     91 ; skipping iCode since result will be rematerialized
                                     92 ; genPointerGet
      0085A3 C6 00 1D         [ 1]   93 	ld	a, _uart_tx_Buff+2
                                     94 ; genCast
                                     95 ; genAssign
                                     96 ; genPlus
      0085A6 4C               [ 1]   97 	inc	a
                                     98 ;	src/uart.c: 24: if ( head_temp == TX_BUFF_SIZE ) {
                                     99 ; genCmpEQorNE
      0085A7 A1 08            [ 1]  100 	cp	a, #0x08
      0085A9 26 03            [ 1]  101 	jrne	00118$
      0085AB CC 85 B1         [ 2]  102 	jp	00119$
      0085AE                        103 00118$:
      0085AE CC 85 B2         [ 2]  104 	jp	00102$
      0085B1                        105 00119$:
                                    106 ; skipping generated iCode
                                    107 ;	src/uart.c: 25: head_temp = 0;
                                    108 ; genAssign
      0085B1 4F               [ 1]  109 	clr	a
                                    110 ; genLabel
      0085B2                        111 00102$:
                                    112 ;	src/uart.c: 28: if ( head_temp == uart_tx_Buff.tail ) {
                                    113 ; skipping iCode since result will be rematerialized
                                    114 ; genPointerGet
      0085B2 AE 00 1E         [ 2]  115 	ldw	x, #(_uart_tx_Buff + 3)
      0085B5 88               [ 1]  116 	push	a
      0085B6 F6               [ 1]  117 	ld	a, (x)
      0085B7 6B 03            [ 1]  118 	ld	(0x03, sp), a
      0085B9 84               [ 1]  119 	pop	a
                                    120 ; genCmpEQorNE
      0085BA 11 02            [ 1]  121 	cp	a, (0x02, sp)
      0085BC 26 03            [ 1]  122 	jrne	00121$
      0085BE CC 85 C4         [ 2]  123 	jp	00122$
      0085C1                        124 00121$:
      0085C1 CC 85 C9         [ 2]  125 	jp	00104$
      0085C4                        126 00122$:
                                    127 ; skipping generated iCode
                                    128 ;	src/uart.c: 30: return -1;
                                    129 ; genReturn
      0085C4 A6 FF            [ 1]  130 	ld	a, #0xff
      0085C6 CC 85 E4         [ 2]  131 	jp	00105$
                                    132 ; genLabel
      0085C9                        133 00104$:
                                    134 ;	src/uart.c: 33: uart_tx_Buff.buffer[head_temp] = c;
                                    135 ; skipping iCode since result will be rematerialized
                                    136 ; genPointerGet
      0085C9 CE 00 1B         [ 2]  137 	ldw	x, _uart_tx_Buff+0
      0085CC 1F 01            [ 2]  138 	ldw	(0x01, sp), x
                                    139 ; genPlus
      0085CE 5F               [ 1]  140 	clrw	x
      0085CF 97               [ 1]  141 	ld	xl, a
      0085D0 72 FB 01         [ 2]  142 	addw	x, (0x01, sp)
                                    143 ; genPointerSet
      0085D3 88               [ 1]  144 	push	a
      0085D4 7B 06            [ 1]  145 	ld	a, (0x06, sp)
      0085D6 F7               [ 1]  146 	ld	(x), a
      0085D7 84               [ 1]  147 	pop	a
                                    148 ;	src/uart.c: 34: uart_tx_Buff.head = head_temp;
                                    149 ; skipping iCode since result will be rematerialized
                                    150 ; genPointerSet
      0085D8 C7 00 1D         [ 1]  151 	ld	_uart_tx_Buff+2, a
                                    152 ;	src/uart.c: 37: UART1->CR2 |= UART1_CR2_TIEN | UART1_CR2_TCIEN;
                                    153 ; genPointerGet
      0085DB C6 52 35         [ 1]  154 	ld	a, 0x5235
                                    155 ; genOr
      0085DE AA C0            [ 1]  156 	or	a, #0xc0
                                    157 ; genPointerSet
      0085E0 C7 52 35         [ 1]  158 	ld	0x5235, a
                                    159 ;	src/uart.c: 39: return 0;
                                    160 ; genReturn
      0085E3 4F               [ 1]  161 	clr	a
                                    162 ; genLabel
      0085E4                        163 00105$:
                                    164 ;	src/uart.c: 40: }
                                    165 ; genEndFunction
      0085E4 5B 02            [ 2]  166 	addw	sp, #2
      0085E6 81               [ 4]  167 	ret
                                    168 ;	src/uart.c: 42: void uart_puts(uint8_t *str) {
                                    169 ; genLabel
                                    170 ;	-----------------------------------------
                                    171 ;	 function uart_puts
                                    172 ;	-----------------------------------------
                                    173 ;	Register assignment is optimal.
                                    174 ;	Stack space usage: 0 bytes.
      0085E7                        175 _uart_puts:
                                    176 ;	src/uart.c: 43: while( *str ) {
                                    177 ; genAssign
      0085E7 1E 03            [ 2]  178 	ldw	x, (0x03, sp)
                                    179 ; genLabel
      0085E9                        180 00103$:
                                    181 ; genPointerGet
      0085E9 F6               [ 1]  182 	ld	a, (x)
                                    183 ; genIfx
      0085EA 4D               [ 1]  184 	tnz	a
      0085EB 26 03            [ 1]  185 	jrne	00124$
      0085ED CC 86 02         [ 2]  186 	jp	00106$
      0085F0                        187 00124$:
                                    188 ;	src/uart.c: 44: if( !uart_putc( *str ) ) {
                                    189 ; genIPush
      0085F0 89               [ 2]  190 	pushw	x
      0085F1 88               [ 1]  191 	push	a
                                    192 ; genCall
      0085F2 CD 85 99         [ 4]  193 	call	_uart_putc
      0085F5 5B 01            [ 2]  194 	addw	sp, #1
      0085F7 85               [ 2]  195 	popw	x
                                    196 ; genIfx
      0085F8 4D               [ 1]  197 	tnz	a
      0085F9 27 03            [ 1]  198 	jreq	00125$
      0085FB CC 85 E9         [ 2]  199 	jp	00103$
      0085FE                        200 00125$:
                                    201 ;	src/uart.c: 45: *(str++);
                                    202 ; genPlus
      0085FE 5C               [ 1]  203 	incw	x
                                    204 ; genGoto
      0085FF CC 85 E9         [ 2]  205 	jp	00103$
                                    206 ; genLabel
      008602                        207 00106$:
                                    208 ;	src/uart.c: 48: }
                                    209 ; genEndFunction
      008602 81               [ 4]  210 	ret
                                    211 ;	src/uart.c: 50: int8_t uart_recv(uint8_t *data) {
                                    212 ; genLabel
                                    213 ;	-----------------------------------------
                                    214 ;	 function uart_recv
                                    215 ;	-----------------------------------------
                                    216 ;	Register assignment might be sub-optimal.
                                    217 ;	Stack space usage: 2 bytes.
      008603                        218 _uart_recv:
      008603 52 02            [ 2]  219 	sub	sp, #2
                                    220 ;	src/uart.c: 52: if ( uart_rx_Buff.head == uart_rx_Buff.tail ) {
                                    221 ; skipping iCode since result will be rematerialized
                                    222 ; genPointerGet
      008605 C6 00 21         [ 1]  223 	ld	a, _uart_rx_Buff+2
      008608 6B 02            [ 1]  224 	ld	(0x02, sp), a
                                    225 ; skipping iCode since result will be rematerialized
                                    226 ; genPointerGet
      00860A C6 00 22         [ 1]  227 	ld	a, _uart_rx_Buff+3
                                    228 ; genCmpEQorNE
      00860D 11 02            [ 1]  229 	cp	a, (0x02, sp)
      00860F 26 03            [ 1]  230 	jrne	00118$
      008611 CC 86 17         [ 2]  231 	jp	00119$
      008614                        232 00118$:
      008614 CC 86 1C         [ 2]  233 	jp	00102$
      008617                        234 00119$:
                                    235 ; skipping generated iCode
                                    236 ;	src/uart.c: 53: return -1;
                                    237 ; genReturn
      008617 A6 FF            [ 1]  238 	ld	a, #0xff
      008619 CC 86 46         [ 2]  239 	jp	00105$
                                    240 ; genLabel
      00861C                        241 00102$:
                                    242 ;	src/uart.c: 56: uart_rx_Buff.tail++;
                                    243 ; genAddrOf
      00861C AE 00 22         [ 2]  244 	ldw	x, #_uart_rx_Buff+3
                                    245 ; genPointerGet
      00861F F6               [ 1]  246 	ld	a, (x)
                                    247 ; genPlus
      008620 4C               [ 1]  248 	inc	a
                                    249 ; genPointerSet
      008621 F7               [ 1]  250 	ld	(x), a
                                    251 ;	src/uart.c: 58: if ( uart_rx_Buff.tail == RX_BUFF_SIZE ) {
                                    252 ; skipping iCode since result will be rematerialized
                                    253 ; genPointerGet
      008622 C6 00 22         [ 1]  254 	ld	a, _uart_rx_Buff+3
                                    255 ; genCmpEQorNE
      008625 A1 08            [ 1]  256 	cp	a, #0x08
      008627 26 03            [ 1]  257 	jrne	00121$
      008629 CC 86 2F         [ 2]  258 	jp	00122$
      00862C                        259 00121$:
      00862C CC 86 33         [ 2]  260 	jp	00104$
      00862F                        261 00122$:
                                    262 ; skipping generated iCode
                                    263 ;	src/uart.c: 59: uart_rx_Buff.tail = 0;
                                    264 ; skipping iCode since result will be rematerialized
                                    265 ; genPointerSet
      00862F 35 00 00 22      [ 1]  266 	mov	_uart_rx_Buff+3, #0x00
                                    267 ; genLabel
      008633                        268 00104$:
                                    269 ;	src/uart.c: 62: *data = uart_rx_Buff.buffer[uart_rx_Buff.tail];
                                    270 ; genAssign
      008633 16 05            [ 2]  271 	ldw	y, (0x05, sp)
                                    272 ; skipping iCode since result will be rematerialized
                                    273 ; genPointerGet
      008635 CE 00 1F         [ 2]  274 	ldw	x, _uart_rx_Buff+0
      008638 1F 01            [ 2]  275 	ldw	(0x01, sp), x
                                    276 ; skipping iCode since result will be rematerialized
                                    277 ; genPointerGet
      00863A C6 00 22         [ 1]  278 	ld	a, _uart_rx_Buff+3
                                    279 ; genPlus
      00863D 5F               [ 1]  280 	clrw	x
      00863E 97               [ 1]  281 	ld	xl, a
      00863F 72 FB 01         [ 2]  282 	addw	x, (0x01, sp)
                                    283 ; genPointerGet
      008642 F6               [ 1]  284 	ld	a, (x)
                                    285 ; genPointerSet
      008643 90 F7            [ 1]  286 	ld	(y), a
                                    287 ;	src/uart.c: 63: return 0;
                                    288 ; genReturn
      008645 4F               [ 1]  289 	clr	a
                                    290 ; genLabel
      008646                        291 00105$:
                                    292 ;	src/uart.c: 64: }
                                    293 ; genEndFunction
      008646 5B 02            [ 2]  294 	addw	sp, #2
      008648 81               [ 4]  295 	ret
                                    296 	.area CODE
                                    297 	.area CONST
                                    298 	.area INITIALIZER
                                    299 	.area CABS (ABS)
