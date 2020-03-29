                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.0.0 #11528 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module mnprot
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _nrf_sendcmd
                                     12 	.globl _nrf_write_tx
                                     13 	.globl _nrf_tx_enable
                                     14 	.globl _nrf_rx_enable
                                     15 	.globl _delay
                                     16 	.globl _mn_frame
                                     17 	.globl _mn_register_cb
                                     18 	.globl _mn_send
                                     19 	.globl _mn_decode_frame
                                     20 	.globl _mn_execute
                                     21 	.globl _mn_retransmit
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area DATA
      000001                         26 _mn_frame::
      000001                         27 	.ds 24
      000019                         28 _mn_send_frame_id_65536_73:
      000019                         29 	.ds 1
                                     30 ;--------------------------------------------------------
                                     31 ; ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area INITIALIZED
                                     34 ;--------------------------------------------------------
                                     35 ; absolute external ram data
                                     36 ;--------------------------------------------------------
                                     37 	.area DABS (ABS)
                                     38 
                                     39 ; default segment ordering for linker
                                     40 	.area HOME
                                     41 	.area GSINIT
                                     42 	.area GSFINAL
                                     43 	.area CONST
                                     44 	.area INITIALIZER
                                     45 	.area CODE
                                     46 
                                     47 ;--------------------------------------------------------
                                     48 ; global & static initialisations
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
                                     51 	.area GSINIT
                                     52 	.area GSFINAL
                                     53 	.area GSINIT
                                     54 ;--------------------------------------------------------
                                     55 ; Home
                                     56 ;--------------------------------------------------------
                                     57 	.area HOME
                                     58 	.area HOME
                                     59 ;--------------------------------------------------------
                                     60 ; code
                                     61 ;--------------------------------------------------------
                                     62 	.area CODE
                                     63 ;	src/mnprot.c: 10: void mn_register_cb(mn_execute_cb func) {
                                     64 ; genLabel
                                     65 ;	-----------------------------------------
                                     66 ;	 function mn_register_cb
                                     67 ;	-----------------------------------------
                                     68 ;	Register assignment is optimal.
                                     69 ;	Stack space usage: 0 bytes.
      00808D                         70 _mn_register_cb:
                                     71 ;	src/mnprot.c: 11: if (func) {
                                     72 ; genIfx
      00808D 1E 03            [ 2]   73 	ldw	x, (0x03, sp)
      00808F 26 03            [ 1]   74 	jrne	00111$
      008091 CC 80 9D         [ 2]   75 	jp	00102$
      008094                         76 00111$:
                                     77 ;	src/mnprot.c: 12: mn_frame.execute = func;
                                     78 ; skipping iCode since result will be rematerialized
                                     79 ; genPointerSet
      008094 AE 00 17         [ 2]   80 	ldw	x, #(_mn_frame + 22)
      008097 16 03            [ 2]   81 	ldw	y, (0x03, sp)
      008099 FF               [ 2]   82 	ldw	(x), y
                                     83 ; genGoto
      00809A CC 80 A3         [ 2]   84 	jp	00104$
                                     85 ; genLabel
      00809D                         86 00102$:
                                     87 ;	src/mnprot.c: 14: mn_frame.execute = NULL;
                                     88 ; skipping iCode since result will be rematerialized
                                     89 ; genPointerSet
      00809D AE 00 17         [ 2]   90 	ldw	x, #(_mn_frame + 22)
      0080A0 6F 01            [ 1]   91 	clr	(0x1, x)
      0080A2 7F               [ 1]   92 	clr	(x)
                                     93 ; genLabel
      0080A3                         94 00104$:
                                     95 ;	src/mnprot.c: 16: }
                                     96 ; genEndFunction
      0080A3 81               [ 4]   97 	ret
                                     98 ;	src/mnprot.c: 19: void mn_send(uint8_t dest, uint8_t ttl, uint8_t *data, uint8_t ack) {
                                     99 ; genLabel
                                    100 ;	-----------------------------------------
                                    101 ;	 function mn_send
                                    102 ;	-----------------------------------------
                                    103 ;	Register assignment might be sub-optimal.
                                    104 ;	Stack space usage: 13 bytes.
      0080A4                        105 _mn_send:
      0080A4 52 0D            [ 2]  106 	sub	sp, #13
                                    107 ;	src/mnprot.c: 21: uint8_t frame[PAYLOADSIZE] = {0};
                                    108 ; skipping iCode since result will be rematerialized
                                    109 ; genPointerSet
      0080A6 0F 05            [ 1]  110 	clr	(0x05, sp)
                                    111 ; genPlus
      0080A8 96               [ 1]  112 	ldw	x, sp
      0080A9 1C 00 06         [ 2]  113 	addw	x, #6
      0080AC 1F 01            [ 2]  114 	ldw	(0x01, sp), x
                                    115 ; genPointerSet
      0080AE 1E 01            [ 2]  116 	ldw	x, (0x01, sp)
      0080B0 7F               [ 1]  117 	clr	(x)
                                    118 ; genPlus
      0080B1 96               [ 1]  119 	ldw	x, sp
      0080B2 1C 00 07         [ 2]  120 	addw	x, #7
      0080B5 1F 03            [ 2]  121 	ldw	(0x03, sp), x
                                    122 ; genPointerSet
      0080B7 1E 03            [ 2]  123 	ldw	x, (0x03, sp)
      0080B9 7F               [ 1]  124 	clr	(x)
                                    125 ; genPlus
      0080BA 90 96            [ 1]  126 	ldw	y, sp
      0080BC 72 A9 00 08      [ 2]  127 	addw	y, #8
                                    128 ; genPointerSet
      0080C0 90 7F            [ 1]  129 	clr	(y)
                                    130 ; genPlus
      0080C2 96               [ 1]  131 	ldw	x, sp
      0080C3 1C 00 09         [ 2]  132 	addw	x, #9
                                    133 ; genPointerSet
      0080C6 7F               [ 1]  134 	clr	(x)
                                    135 ; genPlus
      0080C7 96               [ 1]  136 	ldw	x, sp
      0080C8 1C 00 0A         [ 2]  137 	addw	x, #10
                                    138 ; genPointerSet
      0080CB 7F               [ 1]  139 	clr	(x)
                                    140 ; genPlus
      0080CC 96               [ 1]  141 	ldw	x, sp
      0080CD 1C 00 0B         [ 2]  142 	addw	x, #11
                                    143 ; genPointerSet
      0080D0 7F               [ 1]  144 	clr	(x)
                                    145 ; genPlus
      0080D1 96               [ 1]  146 	ldw	x, sp
      0080D2 1C 00 0C         [ 2]  147 	addw	x, #12
                                    148 ; genPointerSet
      0080D5 7F               [ 1]  149 	clr	(x)
                                    150 ;	src/mnprot.c: 25: if( ttl > 127 ) {
                                    151 ; genCmp
                                    152 ; genCmpTop
      0080D6 7B 11            [ 1]  153 	ld	a, (0x11, sp)
      0080D8 A1 7F            [ 1]  154 	cp	a, #0x7f
      0080DA 22 03            [ 1]  155 	jrugt	00131$
      0080DC CC 80 E3         [ 2]  156 	jp	00102$
      0080DF                        157 00131$:
                                    158 ; skipping generated iCode
                                    159 ;	src/mnprot.c: 26: ttl = 127;
                                    160 ; genAssign
      0080DF A6 7F            [ 1]  161 	ld	a, #0x7f
      0080E1 6B 11            [ 1]  162 	ld	(0x11, sp), a
                                    163 ; genLabel
      0080E3                        164 00102$:
                                    165 ;	src/mnprot.c: 29: if( ack ) {
                                    166 ; genIfx
      0080E3 0D 14            [ 1]  167 	tnz	(0x14, sp)
      0080E5 26 03            [ 1]  168 	jrne	00132$
      0080E7 CC 80 F0         [ 2]  169 	jp	00104$
      0080EA                        170 00132$:
                                    171 ;	src/mnprot.c: 30: ttl |= 0x80;
                                    172 ; genAssign
      0080EA 7B 11            [ 1]  173 	ld	a, (0x11, sp)
                                    174 ; genOr
      0080EC AA 80            [ 1]  175 	or	a, #0x80
      0080EE 6B 11            [ 1]  176 	ld	(0x11, sp), a
                                    177 ; genLabel
      0080F0                        178 00104$:
                                    179 ;	src/mnprot.c: 33: frame[0] = dest;
                                    180 ; genPointerSet
      0080F0 7B 10            [ 1]  181 	ld	a, (0x10, sp)
      0080F2 6B 05            [ 1]  182 	ld	(0x05, sp), a
                                    183 ;	src/mnprot.c: 34: frame[1] = MN_ADDR;
                                    184 ; genPointerSet
      0080F4 1E 01            [ 2]  185 	ldw	x, (0x01, sp)
      0080F6 A6 03            [ 1]  186 	ld	a, #0x03
      0080F8 F7               [ 1]  187 	ld	(x), a
                                    188 ;	src/mnprot.c: 35: frame[2] = ttl;
                                    189 ; genPointerSet
      0080F9 1E 03            [ 2]  190 	ldw	x, (0x03, sp)
      0080FB 7B 11            [ 1]  191 	ld	a, (0x11, sp)
      0080FD F7               [ 1]  192 	ld	(x), a
                                    193 ;	src/mnprot.c: 36: frame[3] = frame_id++;
                                    194 ; genAssign
      0080FE C6 00 19         [ 1]  195 	ld	a, _mn_send_frame_id_65536_73+0
                                    196 ; genPlus
      008101 72 5C 00 19      [ 1]  197 	inc	_mn_send_frame_id_65536_73+0
                                    198 ; genPointerSet
      008105 90 F7            [ 1]  199 	ld	(y), a
                                    200 ;	src/mnprot.c: 38: for(i = 4; i <PAYLOADSIZE; i++) {
                                    201 ; genAssign
      008107 16 12            [ 2]  202 	ldw	y, (0x12, sp)
                                    203 ; genAssign
      008109 A6 04            [ 1]  204 	ld	a, #0x04
      00810B 6B 0D            [ 1]  205 	ld	(0x0d, sp), a
                                    206 ; genLabel
      00810D                        207 00106$:
                                    208 ;	src/mnprot.c: 39: frame[i] = *data++;
                                    209 ; genPlus
      00810D 5F               [ 1]  210 	clrw	x
      00810E 7B 0D            [ 1]  211 	ld	a, (0x0d, sp)
      008110 97               [ 1]  212 	ld	xl, a
      008111 89               [ 2]  213 	pushw	x
      008112 96               [ 1]  214 	ldw	x, sp
      008113 1C 00 07         [ 2]  215 	addw	x, #7
      008116 72 FB 01         [ 2]  216 	addw	x, (1, sp)
      008119 5B 02            [ 2]  217 	addw	sp, #2
                                    218 ; genPointerGet
      00811B 90 F6            [ 1]  219 	ld	a, (y)
                                    220 ; genPlus
      00811D 90 5C            [ 1]  221 	incw	y
                                    222 ; genPointerSet
      00811F F7               [ 1]  223 	ld	(x), a
                                    224 ;	src/mnprot.c: 38: for(i = 4; i <PAYLOADSIZE; i++) {
                                    225 ; genPlus
      008120 0C 0D            [ 1]  226 	inc	(0x0d, sp)
                                    227 ; genCmp
                                    228 ; genCmpTop
      008122 7B 0D            [ 1]  229 	ld	a, (0x0d, sp)
      008124 A1 08            [ 1]  230 	cp	a, #0x08
      008126 24 03            [ 1]  231 	jrnc	00133$
      008128 CC 81 0D         [ 2]  232 	jp	00106$
      00812B                        233 00133$:
                                    234 ; skipping generated iCode
                                    235 ;	src/mnprot.c: 42: nrf_sendcmd( W_TX_PAYLOAD_NOACK );
                                    236 ; genIPush
      00812B 4B B0            [ 1]  237 	push	#0xb0
                                    238 ; genCall
      00812D CD 8A A6         [ 4]  239 	call	_nrf_sendcmd
      008130 84               [ 1]  240 	pop	a
                                    241 ;	src/mnprot.c: 43: nrf_write_tx(frame, PAYLOADSIZE);
                                    242 ; skipping iCode since result will be rematerialized
                                    243 ; skipping iCode since result will be rematerialized
                                    244 ; genIPush
      008131 4B 08            [ 1]  245 	push	#0x08
                                    246 ; genIPush
      008133 96               [ 1]  247 	ldw	x, sp
      008134 1C 00 06         [ 2]  248 	addw	x, #6
      008137 89               [ 2]  249 	pushw	x
                                    250 ; genCall
      008138 CD 89 C5         [ 4]  251 	call	_nrf_write_tx
      00813B 5B 03            [ 2]  252 	addw	sp, #3
                                    253 ; genLabel
      00813D                        254 00108$:
                                    255 ;	src/mnprot.c: 44: }
                                    256 ; genEndFunction
      00813D 5B 0D            [ 2]  257 	addw	sp, #13
      00813F 81               [ 4]  258 	ret
                                    259 ;	src/mnprot.c: 47: void mn_decode_frame(void) {
                                    260 ; genLabel
                                    261 ;	-----------------------------------------
                                    262 ;	 function mn_decode_frame
                                    263 ;	-----------------------------------------
                                    264 ;	Register assignment might be sub-optimal.
                                    265 ;	Stack space usage: 0 bytes.
      008140                        266 _mn_decode_frame:
                                    267 ;	src/mnprot.c: 48: if( (sys_nrf.status & RX_DR) ) {
                                    268 ; skipping iCode since result will be rematerialized
                                    269 ; genPointerGet
      008140 C6 00 23         [ 1]  270 	ld	a, _sys_nrf+0
                                    271 ; genAnd
      008143 A5 40            [ 1]  272 	bcp	a, #0x40
      008145 26 03            [ 1]  273 	jrne	00139$
      008147 CC 81 98         [ 2]  274 	jp	00112$
      00814A                        275 00139$:
                                    276 ; skipping generated iCode
                                    277 ;	src/mnprot.c: 49: if( sys_nrf.data_rx[0] == MN_ADDR ) {
                                    278 ; skipping iCode since result will be rematerialized
                                    279 ; skipping iCode since result will be rematerialized
                                    280 ; genPointerGet
      00814A C6 00 25         [ 1]  281 	ld	a, _sys_nrf+2
      00814D 97               [ 1]  282 	ld	xl, a
                                    283 ; genCmpEQorNE
      00814E 9F               [ 1]  284 	ld	a, xl
      00814F A1 03            [ 1]  285 	cp	a, #0x03
      008151 26 03            [ 1]  286 	jrne	00141$
      008153 CC 81 59         [ 2]  287 	jp	00142$
      008156                        288 00141$:
      008156 CC 81 5F         [ 2]  289 	jp	00108$
      008159                        290 00142$:
                                    291 ; skipping generated iCode
                                    292 ;	src/mnprot.c: 51: mn_execute();
                                    293 ; genCall
      008159 CD 81 99         [ 4]  294 	call	_mn_execute
                                    295 ; genGoto
      00815C CC 81 90         [ 2]  296 	jp	00109$
                                    297 ; genLabel
      00815F                        298 00108$:
                                    299 ;	src/mnprot.c: 52: } else 	if (sys_nrf.data_rx[0] == 255 && sys_nrf.data_rx[1] != MN_ADDR) {
                                    300 ; skipping iCode since result will be rematerialized
                                    301 ; genPointerGet
      00815F C6 00 26         [ 1]  302 	ld	a, _sys_nrf+3
                                    303 ; genCmpEQorNE
      008162 A1 03            [ 1]  304 	cp	a, #0x03
      008164 26 05            [ 1]  305 	jrne	00144$
      008166 A6 01            [ 1]  306 	ld	a, #0x01
      008168 CC 81 6C         [ 2]  307 	jp	00145$
      00816B                        308 00144$:
      00816B 4F               [ 1]  309 	clr	a
      00816C                        310 00145$:
                                    311 ; genCmpEQorNE
      00816C 88               [ 1]  312 	push	a
      00816D 9F               [ 1]  313 	ld	a, xl
      00816E 4C               [ 1]  314 	inc	a
      00816F 84               [ 1]  315 	pop	a
      008170 26 03            [ 1]  316 	jrne	00147$
      008172 CC 81 78         [ 2]  317 	jp	00148$
      008175                        318 00147$:
      008175 CC 81 87         [ 2]  319 	jp	00104$
      008178                        320 00148$:
                                    321 ; skipping generated iCode
                                    322 ; genIfx
      008178 4D               [ 1]  323 	tnz	a
      008179 27 03            [ 1]  324 	jreq	00149$
      00817B CC 81 87         [ 2]  325 	jp	00104$
      00817E                        326 00149$:
                                    327 ;	src/mnprot.c: 54: mn_retransmit();
                                    328 ; genCall
      00817E CD 82 2C         [ 4]  329 	call	_mn_retransmit
                                    330 ;	src/mnprot.c: 55: mn_execute();
                                    331 ; genCall
      008181 CD 81 99         [ 4]  332 	call	_mn_execute
                                    333 ; genGoto
      008184 CC 81 90         [ 2]  334 	jp	00109$
                                    335 ; genLabel
      008187                        336 00104$:
                                    337 ;	src/mnprot.c: 56: } else if ( sys_nrf.data_rx[1] != MN_ADDR ) {
                                    338 ; genIfx
      008187 4D               [ 1]  339 	tnz	a
      008188 27 03            [ 1]  340 	jreq	00150$
      00818A CC 81 90         [ 2]  341 	jp	00109$
      00818D                        342 00150$:
                                    343 ;	src/mnprot.c: 58: mn_retransmit();
                                    344 ; genCall
      00818D CD 82 2C         [ 4]  345 	call	_mn_retransmit
                                    346 ; genLabel
      008190                        347 00109$:
                                    348 ;	src/mnprot.c: 62: sys_nrf.status &= ~RX_DR;
                                    349 ; genPointerGet
      008190 C6 00 23         [ 1]  350 	ld	a, _sys_nrf+0
                                    351 ; genAnd
      008193 A4 BF            [ 1]  352 	and	a, #0xbf
                                    353 ; genPointerSet
      008195 C7 00 23         [ 1]  354 	ld	_sys_nrf+0, a
                                    355 ; genLabel
      008198                        356 00112$:
                                    357 ;	src/mnprot.c: 64: }
                                    358 ; genEndFunction
      008198 81               [ 4]  359 	ret
                                    360 ;	src/mnprot.c: 67: void mn_execute(void) {
                                    361 ; genLabel
                                    362 ;	-----------------------------------------
                                    363 ;	 function mn_execute
                                    364 ;	-----------------------------------------
                                    365 ;	Register assignment might be sub-optimal.
                                    366 ;	Stack space usage: 7 bytes.
      008199                        367 _mn_execute:
      008199 52 07            [ 2]  368 	sub	sp, #7
                                    369 ;	src/mnprot.c: 69: uint8_t e = 1;
                                    370 ; genAssign
      00819B A6 01            [ 1]  371 	ld	a, #0x01
      00819D 6B 01            [ 1]  372 	ld	(0x01, sp), a
                                    373 ;	src/mnprot.c: 72: for( x = 0; x < CMP_BUFF_SIZE; x++) {
                                    374 ; skipping iCode since result will be rematerialized
                                    375 ; skipping iCode since result will be rematerialized
                                    376 ; genPlus
      00819F AE 00 26         [ 2]  377 	ldw	x, #(_sys_nrf + 0)+3
      0081A2 1F 02            [ 2]  378 	ldw	(0x02, sp), x
                                    379 ; genAssign
      0081A4 0F 07            [ 1]  380 	clr	(0x07, sp)
                                    381 ; genLabel
      0081A6                        382 00109$:
                                    383 ;	src/mnprot.c: 73: if( (mn_frame.cmpframe[0][x] == sys_nrf.data_rx[SRC_ADDR]) && (mn_frame.cmpframe[1][x] == sys_nrf.data_rx[FRAME_ID]) ) {
                                    384 ; genPlus
      0081A6 5F               [ 1]  385 	clrw	x
      0081A7 7B 07            [ 1]  386 	ld	a, (0x07, sp)
      0081A9 97               [ 1]  387 	ld	xl, a
      0081AA 1C 00 01         [ 2]  388 	addw	x, #(_mn_frame + 0)
                                    389 ; genPointerGet
      0081AD F6               [ 1]  390 	ld	a, (x)
      0081AE 6B 06            [ 1]  391 	ld	(0x06, sp), a
                                    392 ; genPointerGet
      0081B0 1E 02            [ 2]  393 	ldw	x, (0x02, sp)
      0081B2 F6               [ 1]  394 	ld	a, (x)
                                    395 ; genPlus
      0081B3 AE 00 28         [ 2]  396 	ldw	x, #(_sys_nrf + 0)+5
      0081B6 1F 04            [ 2]  397 	ldw	(0x04, sp), x
                                    398 ; genCmpEQorNE
      0081B8 11 06            [ 1]  399 	cp	a, (0x06, sp)
      0081BA 26 03            [ 1]  400 	jrne	00139$
      0081BC CC 81 C2         [ 2]  401 	jp	00140$
      0081BF                        402 00139$:
      0081BF CC 81 E2         [ 2]  403 	jp	00110$
      0081C2                        404 00140$:
                                    405 ; skipping generated iCode
                                    406 ; genPlus
      0081C2 AE 00 05         [ 2]  407 	ldw	x, #(_mn_frame + 0)+4
                                    408 ; genPlus
      0081C5 9F               [ 1]  409 	ld	a, xl
      0081C6 1B 07            [ 1]  410 	add	a, (0x07, sp)
      0081C8 97               [ 1]  411 	ld	xl, a
      0081C9 9E               [ 1]  412 	ld	a, xh
      0081CA A9 00            [ 1]  413 	adc	a, #0x00
                                    414 ; genPointerGet
      0081CC 95               [ 1]  415 	ld	xh, a
      0081CD F6               [ 1]  416 	ld	a, (x)
      0081CE 6B 06            [ 1]  417 	ld	(0x06, sp), a
                                    418 ; genPointerGet
      0081D0 1E 04            [ 2]  419 	ldw	x, (0x04, sp)
      0081D2 F6               [ 1]  420 	ld	a, (x)
                                    421 ; genCmpEQorNE
      0081D3 11 06            [ 1]  422 	cp	a, (0x06, sp)
      0081D5 26 03            [ 1]  423 	jrne	00142$
      0081D7 CC 81 DD         [ 2]  424 	jp	00143$
      0081DA                        425 00142$:
      0081DA CC 81 E2         [ 2]  426 	jp	00110$
      0081DD                        427 00143$:
                                    428 ; skipping generated iCode
                                    429 ;	src/mnprot.c: 74: e = 0;
                                    430 ; genAssign
      0081DD 0F 01            [ 1]  431 	clr	(0x01, sp)
                                    432 ;	src/mnprot.c: 75: break;
                                    433 ; genGoto
      0081DF CC 81 ED         [ 2]  434 	jp	00104$
                                    435 ; genLabel
      0081E2                        436 00110$:
                                    437 ;	src/mnprot.c: 72: for( x = 0; x < CMP_BUFF_SIZE; x++) {
                                    438 ; genPlus
      0081E2 0C 07            [ 1]  439 	inc	(0x07, sp)
                                    440 ; genCmp
                                    441 ; genCmpTop
      0081E4 7B 07            [ 1]  442 	ld	a, (0x07, sp)
      0081E6 A1 04            [ 1]  443 	cp	a, #0x04
      0081E8 24 03            [ 1]  444 	jrnc	00144$
      0081EA CC 81 A6         [ 2]  445 	jp	00109$
      0081ED                        446 00144$:
                                    447 ; skipping generated iCode
                                    448 ; genLabel
      0081ED                        449 00104$:
                                    450 ;	src/mnprot.c: 79: if( e ) {
                                    451 ; genIfx
      0081ED 0D 01            [ 1]  452 	tnz	(0x01, sp)
      0081EF 26 03            [ 1]  453 	jrne	00145$
      0081F1 CC 82 29         [ 2]  454 	jp	00111$
      0081F4                        455 00145$:
                                    456 ;	src/mnprot.c: 81: mn_frame.cframe_idx = (++mn_frame.cframe_idx & (CMP_BUFF_SIZE-1) );
                                    457 ; skipping iCode since result will be rematerialized
                                    458 ; genPlus
      0081F4 AE 00 09         [ 2]  459 	ldw	x, #(_mn_frame + 0)+8
                                    460 ; genPointerGet
      0081F7 F6               [ 1]  461 	ld	a, (x)
                                    462 ; genPlus
      0081F8 4C               [ 1]  463 	inc	a
                                    464 ; genPointerSet
      0081F9 F7               [ 1]  465 	ld	(x), a
                                    466 ; genAnd
      0081FA A4 03            [ 1]  467 	and	a, #0x03
      0081FC 6B 07            [ 1]  468 	ld	(0x07, sp), a
                                    469 ; genPointerSet
      0081FE 7B 07            [ 1]  470 	ld	a, (0x07, sp)
      008200 F7               [ 1]  471 	ld	(x), a
                                    472 ;	src/mnprot.c: 82: mn_frame.cmpframe[0][mn_frame.cframe_idx] = sys_nrf.data_rx[SRC_ADDR]; // source addr.
                                    473 ; genPlus
      008201 5F               [ 1]  474 	clrw	x
      008202 7B 07            [ 1]  475 	ld	a, (0x07, sp)
      008204 97               [ 1]  476 	ld	xl, a
      008205 1C 00 01         [ 2]  477 	addw	x, #(_mn_frame + 0)
                                    478 ; genPointerGet
      008208 16 02            [ 2]  479 	ldw	y, (0x02, sp)
      00820A 90 F6            [ 1]  480 	ld	a, (y)
                                    481 ; genPointerSet
      00820C F7               [ 1]  482 	ld	(x), a
                                    483 ;	src/mnprot.c: 83: mn_frame.cmpframe[1][mn_frame.cframe_idx] = sys_nrf.data_rx[FRAME_ID]; // frame ID
                                    484 ; genPlus
      00820D AE 00 05         [ 2]  485 	ldw	x, #(_mn_frame + 0)+4
                                    486 ; genPlus
      008210 9F               [ 1]  487 	ld	a, xl
      008211 1B 07            [ 1]  488 	add	a, (0x07, sp)
      008213 97               [ 1]  489 	ld	xl, a
      008214 9E               [ 1]  490 	ld	a, xh
      008215 A9 00            [ 1]  491 	adc	a, #0x00
      008217 95               [ 1]  492 	ld	xh, a
                                    493 ; genPointerGet
      008218 16 04            [ 2]  494 	ldw	y, (0x04, sp)
      00821A 90 F6            [ 1]  495 	ld	a, (y)
                                    496 ; genPointerSet
      00821C F7               [ 1]  497 	ld	(x), a
                                    498 ;	src/mnprot.c: 86: if ( mn_frame.execute ) {
                                    499 ; skipping iCode since result will be rematerialized
                                    500 ; genPointerGet
      00821D CE 00 17         [ 2]  501 	ldw	x, _mn_frame+22
                                    502 ; genIfx
      008220 5D               [ 2]  503 	tnzw	x
      008221 26 03            [ 1]  504 	jrne	00146$
      008223 CC 82 29         [ 2]  505 	jp	00111$
      008226                        506 00146$:
                                    507 ;	src/mnprot.c: 87: mn_frame.execute();
                                    508 ; genCall
      008226 5B 07            [ 2]  509 	addw	sp, #7
      008228 FC               [ 2]  510 	jp	(x)
                                    511 ; genLabel
      008229                        512 00111$:
                                    513 ;	src/mnprot.c: 99: }
                                    514 ; genEndFunction
      008229 5B 07            [ 2]  515 	addw	sp, #7
      00822B 81               [ 4]  516 	ret
                                    517 ;	src/mnprot.c: 102: void mn_retransmit(void) {
                                    518 ; genLabel
                                    519 ;	-----------------------------------------
                                    520 ;	 function mn_retransmit
                                    521 ;	-----------------------------------------
                                    522 ;	Register assignment might be sub-optimal.
                                    523 ;	Stack space usage: 17 bytes.
      00822C                        524 _mn_retransmit:
      00822C 52 11            [ 2]  525 	sub	sp, #17
                                    526 ;	src/mnprot.c: 103: uint8_t ack = (sys_nrf.data_rx[ACK_TTL] & 0x80); // get ACK
                                    527 ; skipping iCode since result will be rematerialized
                                    528 ; genPlus
      00822E AE 00 25         [ 2]  529 	ldw	x, #(_sys_nrf + 0)+2
      008231 1F 01            [ 2]  530 	ldw	(0x01, sp), x
                                    531 ; genAssign
      008233 16 01            [ 2]  532 	ldw	y, (0x01, sp)
      008235 17 03            [ 2]  533 	ldw	(0x03, sp), y
                                    534 ; genPlus
      008237 AE 00 27         [ 2]  535 	ldw	x, #(_sys_nrf + 0)+4
      00823A 1F 0D            [ 2]  536 	ldw	(0x0d, sp), x
                                    537 ; genPointerGet
      00823C 1E 0D            [ 2]  538 	ldw	x, (0x0d, sp)
      00823E F6               [ 1]  539 	ld	a, (x)
      00823F 95               [ 1]  540 	ld	xh, a
                                    541 ; genAnd
      008240 9E               [ 1]  542 	ld	a, xh
      008241 A4 80            [ 1]  543 	and	a, #0x80
      008243 6B 0F            [ 1]  544 	ld	(0x0f, sp), a
                                    545 ;	src/mnprot.c: 104: uint8_t x = (sys_nrf.data_rx[ACK_TTL] & 0x7F);	 // x = TTL
                                    546 ; genAnd
      008245 58               [ 2]  547 	sllw	x
      008246 54               [ 2]  548 	srlw	x
                                    549 ;	src/mnprot.c: 105: uint8_t send = 1;
                                    550 ; genAssign
      008247 A6 01            [ 1]  551 	ld	a, #0x01
      008249 6B 05            [ 1]  552 	ld	(0x05, sp), a
                                    553 ;	src/mnprot.c: 108: if( --x ) {
                                    554 ; genMinus
      00824B 9E               [ 1]  555 	ld	a, xh
      00824C 4A               [ 1]  556 	dec	a
      00824D 6B 11            [ 1]  557 	ld	(0x11, sp), a
                                    558 ; genIfx
      00824F 0D 11            [ 1]  559 	tnz	(0x11, sp)
      008251 26 03            [ 1]  560 	jrne	00144$
      008253 CC 83 2A         [ 2]  561 	jp	00112$
      008256                        562 00144$:
                                    563 ;	src/mnprot.c: 109: sys_nrf.data_rx[2] = x | ack;
                                    564 ; genOr
      008256 7B 11            [ 1]  565 	ld	a, (0x11, sp)
      008258 1A 0F            [ 1]  566 	or	a, (0x0f, sp)
      00825A 6B 11            [ 1]  567 	ld	(0x11, sp), a
                                    568 ; genPointerSet
      00825C 1E 0D            [ 2]  569 	ldw	x, (0x0d, sp)
      00825E 7B 11            [ 1]  570 	ld	a, (0x11, sp)
      008260 F7               [ 1]  571 	ld	(x), a
                                    572 ;	src/mnprot.c: 112: for(x=0; x<RET_BUFF_SIZE; x++) {
                                    573 ; genPlus
      008261 AE 00 28         [ 2]  574 	ldw	x, #(_sys_nrf + 0)+5
      008264 1F 06            [ 2]  575 	ldw	(0x06, sp), x
                                    576 ; genPlus
      008266 AE 00 26         [ 2]  577 	ldw	x, #(_sys_nrf + 0)+3
      008269 1F 08            [ 2]  578 	ldw	(0x08, sp), x
                                    579 ; skipping iCode since result will be rematerialized
                                    580 ; genPlus
      00826B AE 00 0A         [ 2]  581 	ldw	x, #(_mn_frame + 0)+9
      00826E 1F 0A            [ 2]  582 	ldw	(0x0a, sp), x
                                    583 ; genAssign
      008270 0F 11            [ 1]  584 	clr	(0x11, sp)
                                    585 ; genLabel
      008272                        586 00110$:
                                    587 ;	src/mnprot.c: 113: if( (mn_frame.retframe[0][x] == sys_nrf.data_rx[DST_ADDR]) && (mn_frame.retframe[1][x] == sys_nrf.data_rx[SRC_ADDR]) && (mn_frame.retframe[2][x] == sys_nrf.data_rx[FRAME_ID]) ) {
                                    588 ; genPlus
      008272 5F               [ 1]  589 	clrw	x
      008273 7B 11            [ 1]  590 	ld	a, (0x11, sp)
      008275 97               [ 1]  591 	ld	xl, a
      008276 72 FB 0A         [ 2]  592 	addw	x, (0x0a, sp)
                                    593 ; genPointerGet
      008279 F6               [ 1]  594 	ld	a, (x)
      00827A 6B 10            [ 1]  595 	ld	(0x10, sp), a
                                    596 ; genPointerGet
      00827C 1E 03            [ 2]  597 	ldw	x, (0x03, sp)
      00827E F6               [ 1]  598 	ld	a, (x)
                                    599 ; genPlus
      00827F AE 00 0E         [ 2]  600 	ldw	x, #(_mn_frame + 0)+13
      008282 1F 0C            [ 2]  601 	ldw	(0x0c, sp), x
                                    602 ; genPlus
      008284 AE 00 12         [ 2]  603 	ldw	x, #(_mn_frame + 0)+17
      008287 1F 0E            [ 2]  604 	ldw	(0x0e, sp), x
                                    605 ; genCmpEQorNE
      008289 11 10            [ 1]  606 	cp	a, (0x10, sp)
      00828B 26 03            [ 1]  607 	jrne	00146$
      00828D CC 82 93         [ 2]  608 	jp	00147$
      008290                        609 00146$:
      008290 CC 82 C6         [ 2]  610 	jp	00111$
      008293                        611 00147$:
                                    612 ; skipping generated iCode
                                    613 ; genPlus
      008293 5F               [ 1]  614 	clrw	x
      008294 7B 11            [ 1]  615 	ld	a, (0x11, sp)
      008296 97               [ 1]  616 	ld	xl, a
      008297 72 FB 0C         [ 2]  617 	addw	x, (0x0c, sp)
                                    618 ; genPointerGet
      00829A F6               [ 1]  619 	ld	a, (x)
      00829B 6B 10            [ 1]  620 	ld	(0x10, sp), a
                                    621 ; genPointerGet
      00829D 1E 08            [ 2]  622 	ldw	x, (0x08, sp)
      00829F F6               [ 1]  623 	ld	a, (x)
                                    624 ; genCmpEQorNE
      0082A0 11 10            [ 1]  625 	cp	a, (0x10, sp)
      0082A2 26 03            [ 1]  626 	jrne	00149$
      0082A4 CC 82 AA         [ 2]  627 	jp	00150$
      0082A7                        628 00149$:
      0082A7 CC 82 C6         [ 2]  629 	jp	00111$
      0082AA                        630 00150$:
                                    631 ; skipping generated iCode
                                    632 ; genPlus
      0082AA 5F               [ 1]  633 	clrw	x
      0082AB 7B 11            [ 1]  634 	ld	a, (0x11, sp)
      0082AD 97               [ 1]  635 	ld	xl, a
      0082AE 72 FB 0E         [ 2]  636 	addw	x, (0x0e, sp)
                                    637 ; genPointerGet
      0082B1 F6               [ 1]  638 	ld	a, (x)
      0082B2 6B 10            [ 1]  639 	ld	(0x10, sp), a
                                    640 ; genPointerGet
      0082B4 1E 06            [ 2]  641 	ldw	x, (0x06, sp)
      0082B6 F6               [ 1]  642 	ld	a, (x)
                                    643 ; genCmpEQorNE
      0082B7 11 10            [ 1]  644 	cp	a, (0x10, sp)
      0082B9 26 03            [ 1]  645 	jrne	00152$
      0082BB CC 82 C1         [ 2]  646 	jp	00153$
      0082BE                        647 00152$:
      0082BE CC 82 C6         [ 2]  648 	jp	00111$
      0082C1                        649 00153$:
                                    650 ; skipping generated iCode
                                    651 ;	src/mnprot.c: 114: send = 0;
                                    652 ; genAssign
      0082C1 0F 05            [ 1]  653 	clr	(0x05, sp)
                                    654 ;	src/mnprot.c: 115: break;
                                    655 ; genGoto
      0082C3 CC 82 D1         [ 2]  656 	jp	00105$
                                    657 ; genLabel
      0082C6                        658 00111$:
                                    659 ;	src/mnprot.c: 112: for(x=0; x<RET_BUFF_SIZE; x++) {
                                    660 ; genPlus
      0082C6 0C 11            [ 1]  661 	inc	(0x11, sp)
                                    662 ; genCmp
                                    663 ; genCmpTop
      0082C8 7B 11            [ 1]  664 	ld	a, (0x11, sp)
      0082CA A1 04            [ 1]  665 	cp	a, #0x04
      0082CC 24 03            [ 1]  666 	jrnc	00154$
      0082CE CC 82 72         [ 2]  667 	jp	00110$
      0082D1                        668 00154$:
                                    669 ; skipping generated iCode
                                    670 ; genLabel
      0082D1                        671 00105$:
                                    672 ;	src/mnprot.c: 119: if( send ) {
                                    673 ; genIfx
      0082D1 0D 05            [ 1]  674 	tnz	(0x05, sp)
      0082D3 26 03            [ 1]  675 	jrne	00155$
      0082D5 CC 83 2A         [ 2]  676 	jp	00112$
      0082D8                        677 00155$:
                                    678 ;	src/mnprot.c: 120: nrf_tx_enable();
                                    679 ; genCall
      0082D8 CD 89 62         [ 4]  680 	call	_nrf_tx_enable
                                    681 ;	src/mnprot.c: 121: mn_frame.rframe_idx = (++mn_frame.rframe_idx & (RET_BUFF_SIZE-1) );
                                    682 ; genPlus
      0082DB AE 00 16         [ 2]  683 	ldw	x, #(_mn_frame + 0)+21
                                    684 ; genPointerGet
      0082DE F6               [ 1]  685 	ld	a, (x)
                                    686 ; genPlus
      0082DF 4C               [ 1]  687 	inc	a
                                    688 ; genPointerSet
      0082E0 F7               [ 1]  689 	ld	(x), a
                                    690 ; genAnd
      0082E1 A4 03            [ 1]  691 	and	a, #0x03
      0082E3 6B 11            [ 1]  692 	ld	(0x11, sp), a
                                    693 ; genPointerSet
      0082E5 7B 11            [ 1]  694 	ld	a, (0x11, sp)
      0082E7 F7               [ 1]  695 	ld	(x), a
                                    696 ;	src/mnprot.c: 122: mn_frame.retframe[0][mn_frame.rframe_idx] = sys_nrf.data_rx[DST_ADDR];
                                    697 ; genPlus
      0082E8 5F               [ 1]  698 	clrw	x
      0082E9 7B 11            [ 1]  699 	ld	a, (0x11, sp)
      0082EB 97               [ 1]  700 	ld	xl, a
      0082EC 72 FB 0A         [ 2]  701 	addw	x, (0x0a, sp)
                                    702 ; genPointerGet
      0082EF 16 03            [ 2]  703 	ldw	y, (0x03, sp)
      0082F1 90 F6            [ 1]  704 	ld	a, (y)
                                    705 ; genPointerSet
      0082F3 F7               [ 1]  706 	ld	(x), a
                                    707 ;	src/mnprot.c: 123: mn_frame.retframe[1][mn_frame.rframe_idx] = sys_nrf.data_rx[SRC_ADDR];
                                    708 ; genPlus
      0082F4 5F               [ 1]  709 	clrw	x
      0082F5 7B 11            [ 1]  710 	ld	a, (0x11, sp)
      0082F7 97               [ 1]  711 	ld	xl, a
      0082F8 72 FB 0C         [ 2]  712 	addw	x, (0x0c, sp)
                                    713 ; genPointerGet
      0082FB 16 08            [ 2]  714 	ldw	y, (0x08, sp)
      0082FD 90 F6            [ 1]  715 	ld	a, (y)
                                    716 ; genPointerSet
      0082FF F7               [ 1]  717 	ld	(x), a
                                    718 ;	src/mnprot.c: 124: mn_frame.retframe[2][mn_frame.rframe_idx] = sys_nrf.data_rx[FRAME_ID];
                                    719 ; genPlus
      008300 5F               [ 1]  720 	clrw	x
      008301 7B 11            [ 1]  721 	ld	a, (0x11, sp)
      008303 97               [ 1]  722 	ld	xl, a
      008304 72 FB 0E         [ 2]  723 	addw	x, (0x0e, sp)
                                    724 ; genPointerGet
      008307 16 06            [ 2]  725 	ldw	y, (0x06, sp)
      008309 90 F6            [ 1]  726 	ld	a, (y)
                                    727 ; genPointerSet
      00830B F7               [ 1]  728 	ld	(x), a
                                    729 ;	src/mnprot.c: 125: nrf_sendcmd( W_TX_PAYLOAD_NOACK );
                                    730 ; genIPush
      00830C 4B B0            [ 1]  731 	push	#0xb0
                                    732 ; genCall
      00830E CD 8A A6         [ 4]  733 	call	_nrf_sendcmd
      008311 84               [ 1]  734 	pop	a
                                    735 ;	src/mnprot.c: 126: delay(55*MN_ADDR);
                                    736 ; genIPush
      008312 4B A5            [ 1]  737 	push	#0xa5
      008314 4B 00            [ 1]  738 	push	#0x00
                                    739 ; genCall
      008316 CD 83 9A         [ 4]  740 	call	_delay
      008319 5B 02            [ 2]  741 	addw	sp, #2
                                    742 ;	src/mnprot.c: 127: nrf_write_tx(sys_nrf.data_rx, PAYLOADSIZE);
                                    743 ; genCast
                                    744 ; genAssign
      00831B 1E 01            [ 2]  745 	ldw	x, (0x01, sp)
                                    746 ; genIPush
      00831D 4B 08            [ 1]  747 	push	#0x08
                                    748 ; genIPush
      00831F 89               [ 2]  749 	pushw	x
                                    750 ; genCall
      008320 CD 89 C5         [ 4]  751 	call	_nrf_write_tx
      008323 5B 03            [ 2]  752 	addw	sp, #3
                                    753 ;	src/mnprot.c: 128: nrf_rx_enable();
                                    754 ; genCall
      008325 5B 11            [ 2]  755 	addw	sp, #17
      008327 CC 89 2C         [ 2]  756 	jp	_nrf_rx_enable
                                    757 ; genLabel
      00832A                        758 00112$:
                                    759 ;	src/mnprot.c: 131: }
                                    760 ; genEndFunction
      00832A 5B 11            [ 2]  761 	addw	sp, #17
      00832C 81               [ 4]  762 	ret
                                    763 	.area CODE
                                    764 	.area CONST
                                    765 	.area INITIALIZER
                                    766 	.area CABS (ABS)
