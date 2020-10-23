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

    // Modbus
    modbusInit();
    modbusReset();
    modbusSetAddres(MN_ADDR);

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
    }
}