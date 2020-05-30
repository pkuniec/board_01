#include "stm8s.h"

#include "common.h"
#include "uart.h"
#include "modbus.h"

static T_modbus modbus;


void modbusSendException(uint8_t exceptionCode) {
	uint16_t crc;
	modbus.buff[1] |= 0x80;
	modbus.buff[2] = exceptionCode;
	crc = modbusCRC(3);
	modbus.buff[3] = (uint8_t)(crc & 0xFF);
	modbus.buff[4] = (uint8_t)(crc >> 8);
	modbus.idx = 5;

	modbusResponse();
}


uint8_t modbusGetBusState(void) {
	return modbus.BusState;
}


void modbusInit(void) {
	modbus.Addres = 0;
	uint8_t *ptr = (uint8_t*)modbus.funcs;
	uint8_t len = sizeof( T_modbusfunc )*mbFuncCount;

	while(len--) {
		*ptr++ = 0;
	}
}

void modbusSetAddres(uint8_t addr) {
	modbus.Addres = addr;
}


int8_t modbus_putdata(uint8_t data) {

    modbus.BusState |= mbReceiving;
    modbus.timer = 0;

    if ( modbus.idx < buff_size ) {
        modbus.buff[modbus.idx++] = data;
        return 0;
    } else {
        return -1;
    }
}


uint16_t crc16_update(uint16_t crc, uint8_t a) {
	crc ^= (uint16_t)a;
	for (uint8_t i = 0; i < 8; ++i) {
		if (crc & 1)
			crc = (crc >> 1) ^ 0xA001;
		else
			crc = (crc >> 1);
	}

	return crc;
}


uint16_t modbusCRC(uint8_t len) {
	uint16_t crc = 0xFFFF;

	// wyliczenie i sprawdzenie CRC
	for(uint8_t i=0; i<len; i++) {
		crc = crc16_update( crc, modbus.buff[i] );
	}

	return crc;
}


void modbusReset(void) {
	modbus.idx = 0;
	modbus.timer = 0;
	modbus.BusState = 0;
}


void modbusTickTimer(void) {
	if ( modbus.BusState & mbReceiving ) {
		modbus.timer++;

		// Gap detect
		if ( modbus.timer > mbT15 ) {
			modbus.BusState |= mbGap;
		}

		// Frame end parse (clear reciving)
		if ( modbus.timer > mbT35 ) {
			modbus.BusState = mbParseFrame;
		}
	}

	// Liczenie czasu do wyslania odpowiedzi
	if ( modbus.BusState & mbPrepareReq ) {
		modbus.timer--;

		if ( !modbus.timer ) {
			modbus.BusState = mbSendRequest;
		}
	}
}


void modbus_event(void) {
	uint16_t crc;
	uint8_t error = 0;

	// Parsing rcived data frame
	if ( modbus.BusState & mbParseFrame ) {
		
		// frame to short
		if (modbus.idx < 5) {
			modbus.BusState = mbReset;
			return;
		}

		// frame not for us
		if ( modbus.buff[0] != modbus.Addres ) {
			modbus.BusState = mbReset;
			return;
		}

		// check CRC
		crc = (uint16_t) ((modbus.buff[modbus.idx-1] << 8) | modbus.buff[modbus.idx-2]);
		if ( modbusCRC(modbus.idx-2) != crc ) {
			modbus.BusState = mbReset;
			return;
		}

		// Frame OK
		// crc - value do counting down from numbers of registered functions
		crc = mbFuncCount;
		while( crc-- ) {
			if ( modbus.funcs[crc].func_num == modbus.buff[1] ) {
				modbus.funcs[crc].func_name();
				error = 1;
				break;
			}
		}

		if ( !error ) {
			modbusSendException( mbIllegalFunction );
		}

		modbus.BusState &= ~mbParseFrame;
	}

	// Sending rensponse
	if ( modbus.BusState & mbSendRequest ) {
		for(uint8_t i=0; i<modbus.idx; i++) {
            uart_putc(modbus.buff[i]);
        }
        modbus.idx = 0;
        modbus.BusState &= ~mbSendRequest;
	}

	// Reset Bus
	if ( modbus.BusState & mbReset ) {
		modbusReset();
	}

}


void modbusResponse(void) {
	modbus.BusState |= mbPrepareReq;
	modbus.timer = mbT35;
}


int8_t mbRegisterFunc(uint8_t num, void (*func_name)(void) ) {
	for(uint8_t i=0; i<mbFuncCount; i++) {
		if ( !modbus.funcs[i].func_num ) {
			modbus.funcs[i].func_num = num;
			modbus.funcs[i].func_name = func_name;
			return 0;
		}
	}
	return -1;
}


int8_t mbUnregisterFunc(uint8_t num) {
	for(uint8_t i=0; i<mbFuncCount; i++) {
		if ( modbus.funcs[i].func_num == num ) {
			modbus.funcs[i].func_num = 0;
			modbus.funcs[i].func_name = 0;
			return 0;
		}
	}
	return -1;
}


// Modbus Funcion implrmrntation


// Function 0x05 - Write Single Coil
// Coil 0 - LED-s ON/OFF
// Coli 1 - motor ON/OFF
// Coli 2 - software reset
void modbusFunc05(void) {
	uint8_t coil = modbus.buff[3];

	if (coil > 2 ) {
		modbusSendException( mbIllegal_data_addr );
	}
	
	if ( !coil ) {
		if ( modbus.buff[4] == 0xFF ) {
            output_set(3, 1);
        } else {
            output_set(3, 0);
        }
	}

	if ( coil == 1 ) {
        if ( modbus.buff[4] == 0xFF ) {
            output_set(4, 1);
        } else {
            output_set(4, 0);
        }
	}

	if ( coil == 2 && modbus.buff[4] == 0xFF ) {
		// software reset
		WWDG->CR = 0xFF;
	}

	modbusResponse();
}


// Function 0x03 - Read Holding Registers
// Reg 0,1 - Motor time (0 - motor0, 1 - motor1)
void modbusFunc03(void) {
	uint8_t reg_num = modbus.buff[3];
	uint8_t reg_cnt = modbus.buff[5];
	uint8_t err_l = 0;
	uint16_t crc = 0;

	modbus.buff[2] = reg_cnt * 2;

	if ( reg_num > 1 ) {
		err_l = 1;
		modbusSendException( mbIllegal_data_addr );
	}

	if ( reg_num + reg_cnt > 2 ) {
		err_l = 2;
		modbusSendException( mbIllegal_data_val );
	}

	if ( !err_l ) {
		modbusResponse();
	}
}


// Func 0x06 - Write Single Register
// Reg 0 - Write time for motor0 (0x??XX) and motor1 (0xXX??)
void modbusFunc06(void) {
	uint8_t reg_num = modbus.buff[3];
	uint8_t reg0_val = modbus.buff[4];
	uint8_t reg1_val = modbus.buff[5];

	modbus.buff[2] = 0x00;

	if ( reg_num > 0 ) {
		modbusSendException( mbIllegal_data_addr );
	}

	modbusResponse();
}