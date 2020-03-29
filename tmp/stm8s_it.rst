                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.0.0 #11528 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8s_it
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _sec
                                     12 	.globl _tim4_update
                                     13 	.globl _uart1_tx
                                     14 	.globl _uart1_rx
                                     15 	.globl _exti2_irq
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area DATA
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area INITIALIZED
      000031                         24 _sec::
      000031                         25 	.ds 1
                                     26 ;--------------------------------------------------------
                                     27 ; absolute external ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DABS (ABS)
                                     30 
                                     31 ; default segment ordering for linker
                                     32 	.area HOME
                                     33 	.area GSINIT
                                     34 	.area GSFINAL
                                     35 	.area CONST
                                     36 	.area INITIALIZER
                                     37 	.area CODE
                                     38 
                                     39 ;--------------------------------------------------------
                                     40 ; global & static initialisations
                                     41 ;--------------------------------------------------------
                                     42 	.area HOME
                                     43 	.area GSINIT
                                     44 	.area GSFINAL
                                     45 	.area GSINIT
                                     46 ;--------------------------------------------------------
                                     47 ; Home
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
                                     50 	.area HOME
                                     51 ;--------------------------------------------------------
                                     52 ; code
                                     53 ;--------------------------------------------------------
                                     54 	.area CODE
                                     55 ;	src/stm8s_it.c: 10: void tim4_update(void) __interrupt (IT_TIM4_OVR_UIF) {
                                     56 ; genLabel
                                     57 ;	-----------------------------------------
                                     58 ;	 function tim4_update
                                     59 ;	-----------------------------------------
                                     60 ;	Register assignment is optimal.
                                     61 ;	Stack space usage: 0 bytes.
      008649                         62 _tim4_update:
                                     63 ;	src/stm8s_it.c: 13: TIM4->SR1 &= ~TIM4_SR1_UIF;
                                     64 ; genPointerGet
      008649 C6 53 44         [ 1]   65 	ld	a, 0x5344
                                     66 ; genAnd
      00864C A4 FE            [ 1]   67 	and	a, #0xfe
                                     68 ; genPointerSet
      00864E C7 53 44         [ 1]   69 	ld	0x5344, a
                                     70 ;	src/stm8s_it.c: 15: if ( !sec-- ) {
                                     71 ; genAssign
      008651 C6 00 31         [ 1]   72 	ld	a, _sec+0
                                     73 ; genMinus
      008654 72 5A 00 31      [ 1]   74 	dec	_sec+0
                                     75 ; genIfx
      008658 4D               [ 1]   76 	tnz	a
      008659 27 03            [ 1]   77 	jreq	00110$
      00865B CC 86 62         [ 2]   78 	jp	00103$
      00865E                         79 00110$:
                                     80 ;	src/stm8s_it.c: 16: sec = 100;
                                     81 ; genAssign
      00865E 35 64 00 31      [ 1]   82 	mov	_sec+0, #0x64
                                     83 ; genLabel
      008662                         84 00103$:
                                     85 ;	src/stm8s_it.c: 18: }
                                     86 ; genEndFunction
      008662 80               [11]   87 	iret
                                     88 ;	src/stm8s_it.c: 21: void uart1_tx(void) __interrupt (IT_UART1_TX) {
                                     89 ; genLabel
                                     90 ;	-----------------------------------------
                                     91 ;	 function uart1_tx
                                     92 ;	-----------------------------------------
                                     93 ;	Register assignment might be sub-optimal.
                                     94 ;	Stack space usage: 3 bytes.
      008663                         95 _uart1_tx:
      008663 52 03            [ 2]   96 	sub	sp, #3
                                     97 ;	src/stm8s_it.c: 22: uint8_t sr_reg = UART1->SR;
                                     98 ; genPointerGet
      008665 C6 52 30         [ 1]   99 	ld	a, 0x5230
      008668 6B 01            [ 1]  100 	ld	(0x01, sp), a
                                    101 ;	src/stm8s_it.c: 24: if ( uart_tx_Buff.head == uart_tx_Buff.tail ) {
                                    102 ; skipping iCode since result will be rematerialized
                                    103 ; genPointerGet
      00866A C6 00 1D         [ 1]  104 	ld	a, _uart_tx_Buff+2
      00866D 6B 03            [ 1]  105 	ld	(0x03, sp), a
                                    106 ; skipping iCode since result will be rematerialized
                                    107 ; genPointerGet
      00866F C6 00 1E         [ 1]  108 	ld	a, _uart_tx_Buff+3
                                    109 ; genCmpEQorNE
      008672 11 03            [ 1]  110 	cp	a, (0x03, sp)
      008674 26 03            [ 1]  111 	jrne	00133$
      008676 CC 86 7C         [ 2]  112 	jp	00134$
      008679                        113 00133$:
      008679 CC 86 8F         [ 2]  114 	jp	00106$
      00867C                        115 00134$:
                                    116 ; skipping generated iCode
                                    117 ;	src/stm8s_it.c: 26: UART1->CR2 |= UART1_CR2_REN;
                                    118 ; genPointerGet
      00867C C6 52 35         [ 1]  119 	ld	a, 0x5235
                                    120 ; genOr
      00867F AA 04            [ 1]  121 	or	a, #0x04
                                    122 ; genPointerSet
      008681 C7 52 35         [ 1]  123 	ld	0x5235, a
                                    124 ;	src/stm8s_it.c: 28: UART1->CR2 &= ~(UART1_CR2_TIEN | UART1_CR2_TCIEN);
                                    125 ; genPointerGet
      008684 C6 52 35         [ 1]  126 	ld	a, 0x5235
                                    127 ; genAnd
      008687 A4 3F            [ 1]  128 	and	a, #0x3f
                                    129 ; genPointerSet
      008689 C7 52 35         [ 1]  130 	ld	0x5235, a
                                    131 ; genGoto
      00868C CC 86 BE         [ 2]  132 	jp	00107$
                                    133 ; genLabel
      00868F                        134 00106$:
                                    135 ;	src/stm8s_it.c: 31: if ( sr_reg & UART1_SR_TXE ) {
                                    136 ; genAnd
      00868F 0D 01            [ 1]  137 	tnz	(0x01, sp)
      008691 2B 03            [ 1]  138 	jrmi	00135$
      008693 CC 86 BE         [ 2]  139 	jp	00107$
      008696                        140 00135$:
                                    141 ; skipping generated iCode
                                    142 ;	src/stm8s_it.c: 33: uart_tx_Buff.tail++;
                                    143 ; genAddrOf
      008696 AE 00 1E         [ 2]  144 	ldw	x, #_uart_tx_Buff+3
                                    145 ; genPointerGet
      008699 F6               [ 1]  146 	ld	a, (x)
                                    147 ; genPlus
      00869A 4C               [ 1]  148 	inc	a
                                    149 ; genPointerSet
      00869B F7               [ 1]  150 	ld	(x), a
                                    151 ;	src/stm8s_it.c: 34: if (uart_tx_Buff.tail == TX_BUFF_SIZE) {
                                    152 ; skipping iCode since result will be rematerialized
                                    153 ; genPointerGet
      00869C C6 00 1E         [ 1]  154 	ld	a, _uart_tx_Buff+3
                                    155 ; genCmpEQorNE
      00869F A1 08            [ 1]  156 	cp	a, #0x08
      0086A1 26 03            [ 1]  157 	jrne	00137$
      0086A3 CC 86 A9         [ 2]  158 	jp	00138$
      0086A6                        159 00137$:
      0086A6 CC 86 AD         [ 2]  160 	jp	00102$
      0086A9                        161 00138$:
                                    162 ; skipping generated iCode
                                    163 ;	src/stm8s_it.c: 35: uart_tx_Buff.tail = 0;
                                    164 ; skipping iCode since result will be rematerialized
                                    165 ; genPointerSet
      0086A9 35 00 00 1E      [ 1]  166 	mov	_uart_tx_Buff+3, #0x00
                                    167 ; genLabel
      0086AD                        168 00102$:
                                    169 ;	src/stm8s_it.c: 38: UART1->DR = uart_tx_Buff.buffer[uart_tx_Buff.tail];
                                    170 ; skipping iCode since result will be rematerialized
                                    171 ; genPointerGet
      0086AD CE 00 1B         [ 2]  172 	ldw	x, _uart_tx_Buff+0
      0086B0 1F 02            [ 2]  173 	ldw	(0x02, sp), x
                                    174 ; skipping iCode since result will be rematerialized
                                    175 ; genPointerGet
      0086B2 C6 00 1E         [ 1]  176 	ld	a, _uart_tx_Buff+3
                                    177 ; genPlus
      0086B5 5F               [ 1]  178 	clrw	x
      0086B6 97               [ 1]  179 	ld	xl, a
      0086B7 72 FB 02         [ 2]  180 	addw	x, (0x02, sp)
                                    181 ; genPointerGet
      0086BA F6               [ 1]  182 	ld	a, (x)
                                    183 ; genPointerSet
      0086BB C7 52 31         [ 1]  184 	ld	0x5231, a
                                    185 ; genLabel
      0086BE                        186 00107$:
                                    187 ;	src/stm8s_it.c: 42: if ( sr_reg & UART1_SR_TC ) {
                                    188 ; genAnd
      0086BE 7B 01            [ 1]  189 	ld	a, (0x01, sp)
      0086C0 A5 40            [ 1]  190 	bcp	a, #0x40
      0086C2 26 03            [ 1]  191 	jrne	00139$
      0086C4 CC 86 CF         [ 2]  192 	jp	00110$
      0086C7                        193 00139$:
                                    194 ; skipping generated iCode
                                    195 ;	src/stm8s_it.c: 44: UART1->SR &= ~(UART1_SR_TC);
                                    196 ; genPointerGet
      0086C7 C6 52 30         [ 1]  197 	ld	a, 0x5230
                                    198 ; genAnd
      0086CA A4 BF            [ 1]  199 	and	a, #0xbf
                                    200 ; genPointerSet
      0086CC C7 52 30         [ 1]  201 	ld	0x5230, a
                                    202 ; genLabel
      0086CF                        203 00110$:
                                    204 ;	src/stm8s_it.c: 46: }
                                    205 ; genEndFunction
      0086CF 5B 03            [ 2]  206 	addw	sp, #3
      0086D1 80               [11]  207 	iret
                                    208 ;	src/stm8s_it.c: 49: void uart1_rx(void) __interrupt (IT_UART1_RX) {
                                    209 ; genLabel
                                    210 ;	-----------------------------------------
                                    211 ;	 function uart1_rx
                                    212 ;	-----------------------------------------
                                    213 ;	Register assignment might be sub-optimal.
                                    214 ;	Stack space usage: 1 bytes.
      0086D2                        215 _uart1_rx:
      0086D2 88               [ 1]  216 	push	a
                                    217 ;	src/stm8s_it.c: 50: if ( UART1->SR & UART1_SR_RXNE ) {
                                    218 ; genPointerGet
      0086D3 C6 52 30         [ 1]  219 	ld	a, 0x5230
                                    220 ; genAnd
      0086D6 A5 20            [ 1]  221 	bcp	a, #0x20
      0086D8 26 03            [ 1]  222 	jrne	00125$
      0086DA CC 87 1E         [ 2]  223 	jp	00108$
      0086DD                        224 00125$:
                                    225 ; skipping generated iCode
                                    226 ;	src/stm8s_it.c: 51: uint8_t head_temp = uart_rx_Buff.head + 1;
                                    227 ; skipping iCode since result will be rematerialized
                                    228 ; genPointerGet
      0086DD C6 00 21         [ 1]  229 	ld	a, _uart_rx_Buff+2
                                    230 ; genCast
                                    231 ; genAssign
                                    232 ; genPlus
      0086E0 4C               [ 1]  233 	inc	a
      0086E1 6B 01            [ 1]  234 	ld	(0x01, sp), a
                                    235 ;	src/stm8s_it.c: 53: if ( head_temp == RX_BUFF_SIZE ) {
                                    236 ; genCmpEQorNE
      0086E3 7B 01            [ 1]  237 	ld	a, (0x01, sp)
      0086E5 A1 08            [ 1]  238 	cp	a, #0x08
      0086E7 26 03            [ 1]  239 	jrne	00127$
      0086E9 CC 86 EF         [ 2]  240 	jp	00128$
      0086EC                        241 00127$:
      0086EC CC 86 F1         [ 2]  242 	jp	00102$
      0086EF                        243 00128$:
                                    244 ; skipping generated iCode
                                    245 ;	src/stm8s_it.c: 54: head_temp = 0;
                                    246 ; genAssign
      0086EF 0F 01            [ 1]  247 	clr	(0x01, sp)
                                    248 ; genLabel
      0086F1                        249 00102$:
                                    250 ;	src/stm8s_it.c: 57: if ( head_temp == uart_rx_Buff.tail ) {
                                    251 ; skipping iCode since result will be rematerialized
                                    252 ; genPointerGet
      0086F1 C6 00 22         [ 1]  253 	ld	a, _uart_rx_Buff+3
                                    254 ; genCmpEQorNE
      0086F4 11 01            [ 1]  255 	cp	a, (0x01, sp)
      0086F6 26 03            [ 1]  256 	jrne	00130$
      0086F8 CC 86 FE         [ 2]  257 	jp	00131$
      0086FB                        258 00130$:
      0086FB CC 87 09         [ 2]  259 	jp	00104$
      0086FE                        260 00131$:
                                    261 ; skipping generated iCode
                                    262 ;	src/stm8s_it.c: 59: UART1->SR &= ~UART1_SR_RXNE;
                                    263 ; genPointerGet
      0086FE C6 52 30         [ 1]  264 	ld	a, 0x5230
                                    265 ; genAnd
      008701 A4 DF            [ 1]  266 	and	a, #0xdf
                                    267 ; genPointerSet
      008703 C7 52 30         [ 1]  268 	ld	0x5230, a
                                    269 ; genGoto
      008706 CC 87 1E         [ 2]  270 	jp	00108$
                                    271 ; genLabel
      008709                        272 00104$:
                                    273 ;	src/stm8s_it.c: 61: uart_rx_Buff.buffer[head_temp] = UART1->DR;
                                    274 ; skipping iCode since result will be rematerialized
                                    275 ; genPointerGet
      008709 CE 00 1F         [ 2]  276 	ldw	x, _uart_rx_Buff+0
                                    277 ; genPlus
      00870C 9F               [ 1]  278 	ld	a, xl
      00870D 1B 01            [ 1]  279 	add	a, (0x01, sp)
      00870F 97               [ 1]  280 	ld	xl, a
      008710 9E               [ 1]  281 	ld	a, xh
      008711 A9 00            [ 1]  282 	adc	a, #0x00
      008713 95               [ 1]  283 	ld	xh, a
                                    284 ; genPointerGet
      008714 C6 52 31         [ 1]  285 	ld	a, 0x5231
                                    286 ; genPointerSet
      008717 F7               [ 1]  287 	ld	(x), a
                                    288 ;	src/stm8s_it.c: 62: uart_rx_Buff.head = head_temp;
                                    289 ; skipping iCode since result will be rematerialized
                                    290 ; genPointerSet
      008718 AE 00 21         [ 2]  291 	ldw	x, #(_uart_rx_Buff + 2)
      00871B 7B 01            [ 1]  292 	ld	a, (0x01, sp)
      00871D F7               [ 1]  293 	ld	(x), a
                                    294 ; genLabel
      00871E                        295 00108$:
                                    296 ;	src/stm8s_it.c: 65: }
                                    297 ; genEndFunction
      00871E 84               [ 1]  298 	pop	a
      00871F 80               [11]  299 	iret
                                    300 ;	src/stm8s_it.c: 68: void exti2_irq(void) __interrupt (IT_EXTI2) {
                                    301 ; genLabel
                                    302 ;	-----------------------------------------
                                    303 ;	 function exti2_irq
                                    304 ;	-----------------------------------------
                                    305 ;	Register assignment is optimal.
                                    306 ;	Stack space usage: 0 bytes.
      008720                        307 _exti2_irq:
                                    308 ;	src/stm8s_it.c: 69: if( !(GPIOC->IDR & (PIN_3)) ) {
                                    309 ; genPointerGet
      008720 C6 50 0B         [ 1]  310 	ld	a, 0x500b
                                    311 ; genAnd
      008723 A5 08            [ 1]  312 	bcp	a, #0x08
      008725 27 03            [ 1]  313 	jreq	00117$
      008727 CC 87 31         [ 2]  314 	jp	00102$
      00872A                        315 00117$:
                                    316 ; skipping generated iCode
                                    317 ;	src/stm8s_it.c: 71: SetBit(system.flags, N_IRQ);
                                    318 ; genAddrOf
      00872A AE 00 30         [ 2]  319 	ldw	x, #_system+0
                                    320 ; genPointerGet
      00872D F6               [ 1]  321 	ld	a, (x)
                                    322 ; genOr
      00872E AA 02            [ 1]  323 	or	a, #0x02
                                    324 ; genPointerSet
      008730 F7               [ 1]  325 	ld	(x), a
                                    326 ; genLabel
      008731                        327 00102$:
                                    328 ;	src/stm8s_it.c: 74: if( !(GPIOC->IDR & (PIN_4)) ) {
                                    329 ; genPointerGet
      008731 C6 50 0B         [ 1]  330 	ld	a, 0x500b
                                    331 ; genAnd
      008734 A5 10            [ 1]  332 	bcp	a, #0x10
      008736 27 03            [ 1]  333 	jreq	00118$
      008738 CC 87 42         [ 2]  334 	jp	00105$
      00873B                        335 00118$:
                                    336 ; skipping generated iCode
                                    337 ;	src/stm8s_it.c: 76: SetBit(system.flags, E_IRQ);
                                    338 ; genAddrOf
      00873B AE 00 30         [ 2]  339 	ldw	x, #_system+0
                                    340 ; genPointerGet
      00873E F6               [ 1]  341 	ld	a, (x)
                                    342 ; genOr
      00873F AA 01            [ 1]  343 	or	a, #0x01
                                    344 ; genPointerSet
      008741 F7               [ 1]  345 	ld	(x), a
                                    346 ; genLabel
      008742                        347 00105$:
                                    348 ;	src/stm8s_it.c: 78: }
                                    349 ; genEndFunction
      008742 80               [11]  350 	iret
                                    351 	.area CODE
                                    352 	.area CONST
                                    353 	.area INITIALIZER
      008088                        354 __xinit__sec:
      008088 64                     355 	.db #0x64	; 100	'd'
                                    356 	.area CABS (ABS)
