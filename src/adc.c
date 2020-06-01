#include "stm8s.h"
#include "adc.h"
#include "common.h"

// Get ADC value
// *adc: pointer to word (uint16_t) wher by stored ADC value
void adc_get(uint16_t *adc) {
	// wake up ADC
	SetBit(ADC1->CR1, 0);
	delay(100);

	// Start conversion
	SetBit(ADC1->CR1, 0);
	while(ADC1->CSR & ADC1_CSR_EOC)
	ClrBit(ADC1->CSR, 7);
	*adc = (uint16_t)(ADC1->DRH << 8);
	*adc |= (uint8_t)(ADC1->DRL);

	// Sleep ADC
	ClrBit(ADC1->CR1, 0);
}