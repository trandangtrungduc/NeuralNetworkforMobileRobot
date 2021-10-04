#include "../include.h"
#include "GPIO.h"
extern void Config_readSensor(void)
{
    SysCtlPeripheralEnable(EN_GPIOE);
    SysCtlDelay(1);
    SysCtlPeripheralEnable(EN_GPIOD);
    SysCtlDelay(1);
    GPIOPinTypeGPIOInput(PORTE,P1|P2|P3|P4);
    GPIOPinTypeGPIOInput(PORTD,P1|P2|P3);
}
