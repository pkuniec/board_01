#include <stdlib.h>
#include "stm8s.h"
#include "stm8s_it.h"

#include "common.h"
#include "nrf24l01.h"
#include "nrf24l01_mem.h"
#include "uart.h"
#include "mnprot.h"

volatile T_circ_buffer uart_tx_Buff;
volatile T_circ_buffer uart_rx_Buff;

nrf_t sys_nrf;
sys_t system;

uint8_t pload[4] = {'C', 'C', 'C', 'C'};

int main(void) {

    uint8_t tx_Buff[TX_BUFF_SIZE];
    uint8_t rx_Buff[RX_BUFF_SIZE];

    uart_tx_Buff.buffer = tx_Buff;
    uart_tx_Buff.head = 0;
    uart_tx_Buff.tail = 0;

    uart_rx_Buff.buffer = rx_Buff;
    uart_rx_Buff.head = 0;
    uart_rx_Buff.tail = 0;

    

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

    rim();

    const uint8_t hello[] = {"STM"};
    uart_puts(hello);

    
    while( 1 ) {
        uart_event();
        sys_event();
        nrf_event();
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
