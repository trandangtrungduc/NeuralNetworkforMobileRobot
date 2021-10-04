#include "../include.h"
#include "I2C.h"
extern void Config_I2C0(void)
{
    SysCtlPeripheralEnable(EN_I2C0);
    SysCtlPeripheralReset(EN_I2C0);
    SysCtlPeripheralEnable(EN_GPIOB);

    //GPIOPadConfigSet(PORTA, P6|P7, GPIO_STRENGTH_4MA, GPIO_PIN_TYPE_STD_WPU);
   // GPIOPadConfigSet(GPIO_PORTA_BASE, P7, GPIO_STRENGTH_2MA, GPIO_PIN_TYPE_OD);
    GPIOPinConfigure(SCL0);
    GPIOPinConfigure(SDA0);
    GPIOPinTypeI2CSCL(PORTB,P2);
    GPIOPinTypeI2C(PORTB,P3);
    while(!SysCtlPeripheralReady(EN_I2C0)){}
    I2CMasterInitExpClk(I2C0, SysCtlClockGet(), true);
   // I2CMasterEnable(I2C0);
}


