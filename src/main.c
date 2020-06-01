#include <stdlib.h>
#include "stm8s.h"
#include "stm8s_it.h"

#include "common.h"
#include "nrf24l01.h"
#include "nrf24l01_mem.h"
#include "uart.h"
#include "spi.h"
#include "mnprot.h"
#include "modbus.h"

//uint8_t pload[4] = {'C', 'C', 'C', 'C'};

int main(void) {

    setup();
    nrf_init_hw();
    spi_init();
    output_set(R_NRF, 1);
    uart_init();

    // NRF24L01 setup
    mn_register_cb( mn_exec );
    nrf_register_cb( nrf_recv );
    nrf_reset();
    nrf_init_sw();
    nrf_rx_enable();
    //nrf_tx_enable();

    // Modbus
    modbusInit();
    modbusReset();
    modbusSetAddres(0x01);

    mbRegisterFunc(0x05, modbusFunc05);
    mbRegisterFunc(0x03, modbusFunc03);
    mbRegisterFunc(0x06, modbusFunc06);

    rim();

    while(1) {
        uart_event();
        sys_event();
        nrf_event();
        timer_event();
        modbus_event();
        // delay(65000);
        // delay(65000);
        // delay(65000);
        // delay(65000);
        // mn_send(3, 2, pload, 0);
        // if (pload[0] == 'C')
        //     pload[0] = 'O';
        // else
        //     pload[0] = 'C';
    }
}