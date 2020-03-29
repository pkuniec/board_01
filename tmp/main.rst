                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.0.0 #11528 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _mn_register_cb
                                     13 	.globl _uart_puts
                                     14 	.globl _uart_init
                                     15 	.globl _nrf_register_cb
                                     16 	.globl _nrf_event
                                     17 	.globl _nrf_rx_enable
                                     18 	.globl _nrf_reset
                                     19 	.globl _nrf_init_sw
                                     20 	.globl _nrf_init_hw
                                     21 	.globl _mn_exec
                                     22 	.globl _nrf_recv
                                     23 	.globl _output_set
                                     24 	.globl _spi_init
                                     25 	.globl _sys_event
                                     26 	.globl _uart_event
                                     27 	.globl _setup
                                     28 	.globl _pload
                                     29 	.globl _system
                                     30 	.globl _sys_nrf
                                     31 	.globl _uart_rx_Buff
                                     32 	.globl _uart_tx_Buff
                                     33 ;--------------------------------------------------------
                                     34 ; ram data
                                     35 ;--------------------------------------------------------
                                     36 	.area DATA
      00001B                         37 _uart_tx_Buff::
      00001B                         38 	.ds 4
      00001F                         39 _uart_rx_Buff::
      00001F                         40 	.ds 4
      000023                         41 _sys_nrf::
      000023                         42 	.ds 13
      000030                         43 _system::
      000030                         44 	.ds 1
                                     45 ;--------------------------------------------------------
                                     46 ; ram data
                                     47 ;--------------------------------------------------------
                                     48 	.area INITIALIZED
      000032                         49 _pload::
      000032                         50 	.ds 4
                                     51 ;--------------------------------------------------------
                                     52 ; Stack segment in internal ram 
                                     53 ;--------------------------------------------------------
                                     54 	.area	SSEG
      FFFFFF                         55 __start__stack:
      FFFFFF                         56 	.ds	1
                                     57 
                                     58 ;--------------------------------------------------------
                                     59 ; absolute external ram data
                                     60 ;--------------------------------------------------------
                                     61 	.area DABS (ABS)
                                     62 
                                     63 ; default segment ordering for linker
                                     64 	.area HOME
                                     65 	.area GSINIT
                                     66 	.area GSFINAL
                                     67 	.area CONST
                                     68 	.area INITIALIZER
                                     69 	.area CODE
                                     70 
                                     71 ;--------------------------------------------------------
                                     72 ; interrupt vector 
                                     73 ;--------------------------------------------------------
                                     74 	.area HOME
      008000                         75 __interrupt_vect:
      008000 82 00 80 6B             76 	int s_GSINIT ; reset
      008004 82 00 00 00             77 	int 0x000000 ; trap
      008008 82 00 00 00             78 	int 0x000000 ; int0
      00800C 82 00 00 00             79 	int 0x000000 ; int1
      008010 82 00 00 00             80 	int 0x000000 ; int2
      008014 82 00 00 00             81 	int 0x000000 ; int3
      008018 82 00 00 00             82 	int 0x000000 ; int4
      00801C 82 00 87 20             83 	int _exti2_irq ; int5
      008020 82 00 00 00             84 	int 0x000000 ; int6
      008024 82 00 00 00             85 	int 0x000000 ; int7
      008028 82 00 00 00             86 	int 0x000000 ; int8
      00802C 82 00 00 00             87 	int 0x000000 ; int9
      008030 82 00 00 00             88 	int 0x000000 ; int10
      008034 82 00 00 00             89 	int 0x000000 ; int11
      008038 82 00 00 00             90 	int 0x000000 ; int12
      00803C 82 00 00 00             91 	int 0x000000 ; int13
      008040 82 00 00 00             92 	int 0x000000 ; int14
      008044 82 00 00 00             93 	int 0x000000 ; int15
      008048 82 00 00 00             94 	int 0x000000 ; int16
      00804C 82 00 86 63             95 	int _uart1_tx ; int17
      008050 82 00 86 D2             96 	int _uart1_rx ; int18
      008054 82 00 00 00             97 	int 0x000000 ; int19
      008058 82 00 00 00             98 	int 0x000000 ; int20
      00805C 82 00 00 00             99 	int 0x000000 ; int21
      008060 82 00 00 00            100 	int 0x000000 ; int22
      008064 82 00 86 49            101 	int _tim4_update ; int23
                                    102 ;--------------------------------------------------------
                                    103 ; global & static initialisations
                                    104 ;--------------------------------------------------------
                                    105 	.area HOME
                                    106 	.area GSINIT
                                    107 	.area GSFINAL
                                    108 	.area GSINIT
      00806B                        109 __sdcc_gs_init_startup:
      00806B                        110 __sdcc_init_data:
                                    111 ; stm8_genXINIT() start
      00806B AE 00 30         [ 2]  112 	ldw x, #l_DATA
      00806E 27 07            [ 1]  113 	jreq	00002$
      008070                        114 00001$:
      008070 72 4F 00 00      [ 1]  115 	clr (s_DATA - 1, x)
      008074 5A               [ 2]  116 	decw x
      008075 26 F9            [ 1]  117 	jrne	00001$
      008077                        118 00002$:
      008077 AE 00 05         [ 2]  119 	ldw	x, #l_INITIALIZER
      00807A 27 09            [ 1]  120 	jreq	00004$
      00807C                        121 00003$:
      00807C D6 80 87         [ 1]  122 	ld	a, (s_INITIALIZER - 1, x)
      00807F D7 00 30         [ 1]  123 	ld	(s_INITIALIZED - 1, x), a
      008082 5A               [ 2]  124 	decw	x
      008083 26 F7            [ 1]  125 	jrne	00003$
      008085                        126 00004$:
                                    127 ; stm8_genXINIT() end
                                    128 	.area GSFINAL
      008085 CC 80 68         [ 2]  129 	jp	__sdcc_program_startup
                                    130 ;--------------------------------------------------------
                                    131 ; Home
                                    132 ;--------------------------------------------------------
                                    133 	.area HOME
                                    134 	.area HOME
      008068                        135 __sdcc_program_startup:
      008068 CC 87 43         [ 2]  136 	jp	_main
                                    137 ;	return from main will return to caller
                                    138 ;--------------------------------------------------------
                                    139 ; code
                                    140 ;--------------------------------------------------------
                                    141 	.area CODE
                                    142 ;	src/main.c: 19: int main(void) {
                                    143 ; genLabel
                                    144 ;	-----------------------------------------
                                    145 ;	 function main
                                    146 ;	-----------------------------------------
                                    147 ;	Register assignment might be sub-optimal.
                                    148 ;	Stack space usage: 20 bytes.
      008743                        149 _main:
      008743 52 14            [ 2]  150 	sub	sp, #20
                                    151 ;	src/main.c: 24: uart_tx_Buff.buffer = tx_Buff;
                                    152 ; skipping iCode since result will be rematerialized
                                    153 ; genAddrOf
      008745 96               [ 1]  154 	ldw	x, sp
      008746 5C               [ 1]  155 	incw	x
                                    156 ; genCast
                                    157 ; genAssign
                                    158 ; genPointerSet
      008747 CF 00 1B         [ 2]  159 	ldw	_uart_tx_Buff+0, x
                                    160 ;	src/main.c: 25: uart_tx_Buff.head = 0;
                                    161 ; skipping iCode since result will be rematerialized
                                    162 ; genPointerSet
      00874A 35 00 00 1D      [ 1]  163 	mov	_uart_tx_Buff+2, #0x00
                                    164 ;	src/main.c: 26: uart_tx_Buff.tail = 0;
                                    165 ; skipping iCode since result will be rematerialized
                                    166 ; genPointerSet
      00874E 35 00 00 1E      [ 1]  167 	mov	_uart_tx_Buff+3, #0x00
                                    168 ;	src/main.c: 28: uart_rx_Buff.buffer = rx_Buff;
                                    169 ; skipping iCode since result will be rematerialized
                                    170 ; genAddrOf
      008752 96               [ 1]  171 	ldw	x, sp
      008753 1C 00 09         [ 2]  172 	addw	x, #9
                                    173 ; genCast
                                    174 ; genAssign
                                    175 ; genPointerSet
      008756 CF 00 1F         [ 2]  176 	ldw	_uart_rx_Buff+0, x
                                    177 ;	src/main.c: 29: uart_rx_Buff.head = 0;
                                    178 ; skipping iCode since result will be rematerialized
                                    179 ; genPointerSet
      008759 35 00 00 21      [ 1]  180 	mov	_uart_rx_Buff+2, #0x00
                                    181 ;	src/main.c: 30: uart_rx_Buff.tail = 0;
                                    182 ; skipping iCode since result will be rematerialized
                                    183 ; genPointerSet
      00875D 35 00 00 22      [ 1]  184 	mov	_uart_rx_Buff+3, #0x00
                                    185 ;	src/main.c: 34: setup();
                                    186 ; genCall
      008761 CD 83 2D         [ 4]  187 	call	_setup
                                    188 ;	src/main.c: 35: nrf_init_hw();
                                    189 ; genCall
      008764 CD 87 C2         [ 4]  190 	call	_nrf_init_hw
                                    191 ;	src/main.c: 36: spi_init();
                                    192 ; genCall
      008767 CD 83 EC         [ 4]  193 	call	_spi_init
                                    194 ;	src/main.c: 37: output_set(R_NRF, 1);
                                    195 ; genIPush
      00876A 4B 01            [ 1]  196 	push	#0x01
                                    197 ; genIPush
      00876C 4B 00            [ 1]  198 	push	#0x00
                                    199 ; genCall
      00876E CD 84 F0         [ 4]  200 	call	_output_set
      008771 5B 02            [ 2]  201 	addw	sp, #2
                                    202 ;	src/main.c: 38: uart_init();    
                                    203 ; genCall
      008773 CD 85 8C         [ 4]  204 	call	_uart_init
                                    205 ;	src/main.c: 41: mn_register_cb( mn_exec );
                                    206 ; genIPush
      008776 4B 31            [ 1]  207 	push	#<(_mn_exec + 0)
      008778 4B 85            [ 1]  208 	push	#((_mn_exec + 0) >> 8)
                                    209 ; genCall
      00877A CD 80 8D         [ 4]  210 	call	_mn_register_cb
      00877D 5B 02            [ 2]  211 	addw	sp, #2
                                    212 ;	src/main.c: 42: nrf_register_cb( nrf_recv );
                                    213 ; genIPush
      00877F 4B 1C            [ 1]  214 	push	#<(_nrf_recv + 0)
      008781 4B 85            [ 1]  215 	push	#((_nrf_recv + 0) >> 8)
                                    216 ; genCall
      008783 CD 89 E4         [ 4]  217 	call	_nrf_register_cb
      008786 5B 02            [ 2]  218 	addw	sp, #2
                                    219 ;	src/main.c: 43: nrf_reset();
                                    220 ; genCall
      008788 CD 88 BF         [ 4]  221 	call	_nrf_reset
                                    222 ;	src/main.c: 44: nrf_init_sw();
                                    223 ; genCall
      00878B CD 88 22         [ 4]  224 	call	_nrf_init_sw
                                    225 ;	src/main.c: 45: nrf_rx_enable();
                                    226 ; genCall
      00878E CD 89 2C         [ 4]  227 	call	_nrf_rx_enable
                                    228 ;	src/main.c: 48: rim();
                                    229 ;	genInline
      008791 9A               [ 1]  230 	rim
                                    231 ;	src/main.c: 50: const uint8_t hello[] = {"STM"};
                                    232 ; skipping iCode since result will be rematerialized
                                    233 ; genPointerSet
      008792 A6 53            [ 1]  234 	ld	a, #0x53
      008794 6B 11            [ 1]  235 	ld	(0x11, sp), a
                                    236 ; genPlus
      008796 96               [ 1]  237 	ldw	x, sp
      008797 1C 00 12         [ 2]  238 	addw	x, #18
                                    239 ; genPointerSet
      00879A A6 54            [ 1]  240 	ld	a, #0x54
      00879C F7               [ 1]  241 	ld	(x), a
                                    242 ; genPlus
      00879D 96               [ 1]  243 	ldw	x, sp
      00879E 1C 00 13         [ 2]  244 	addw	x, #19
                                    245 ; genPointerSet
      0087A1 A6 4D            [ 1]  246 	ld	a, #0x4d
      0087A3 F7               [ 1]  247 	ld	(x), a
                                    248 ; genPlus
      0087A4 96               [ 1]  249 	ldw	x, sp
      0087A5 1C 00 14         [ 2]  250 	addw	x, #20
                                    251 ; genPointerSet
      0087A8 7F               [ 1]  252 	clr	(x)
                                    253 ;	src/main.c: 51: uart_puts(hello);
                                    254 ; skipping iCode since result will be rematerialized
                                    255 ; skipping iCode since result will be rematerialized
                                    256 ; genIPush
      0087A9 96               [ 1]  257 	ldw	x, sp
      0087AA 1C 00 11         [ 2]  258 	addw	x, #17
      0087AD 89               [ 2]  259 	pushw	x
                                    260 ; genCall
      0087AE CD 85 E7         [ 4]  261 	call	_uart_puts
      0087B1 5B 02            [ 2]  262 	addw	sp, #2
                                    263 ;	src/main.c: 54: while( 1 ) {
                                    264 ; genLabel
      0087B3                        265 00102$:
                                    266 ;	src/main.c: 55: uart_event();
                                    267 ; genCall
      0087B3 CD 83 A8         [ 4]  268 	call	_uart_event
                                    269 ;	src/main.c: 56: sys_event();
                                    270 ; genCall
      0087B6 CD 83 D1         [ 4]  271 	call	_sys_event
                                    272 ;	src/main.c: 57: nrf_event();
                                    273 ; genCall
      0087B9 CD 89 EB         [ 4]  274 	call	_nrf_event
                                    275 ; genGoto
      0087BC CC 87 B3         [ 2]  276 	jp	00102$
                                    277 ; genLabel
      0087BF                        278 00104$:
                                    279 ;	src/main.c: 68: }
                                    280 ; genEndFunction
      0087BF 5B 14            [ 2]  281 	addw	sp, #20
      0087C1 81               [ 4]  282 	ret
                                    283 	.area CODE
                                    284 	.area CONST
                                    285 	.area INITIALIZER
      008089                        286 __xinit__pload:
      008089 43                     287 	.db #0x43	; 67	'C'
      00808A 43                     288 	.db #0x43	; 67	'C'
      00808B 43                     289 	.db #0x43	; 67	'C'
      00808C 43                     290 	.db #0x43	; 67	'C'
                                    291 	.area CABS (ABS)
