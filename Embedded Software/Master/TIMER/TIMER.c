#include "../include.h"
#include "TIMER.h"
extern void Config_Timer(void)
{
    SysCtlPeripheralEnable(SYSCTL_PERIPH_TIMER0); //timer 32bit, co 2 timer nho hon la A va B moi timer 16bit
    TimerConfigure(TIMER0_BASE,TIMER_CFG_PERIODIC);// cau hinh timer tuan hoan

}


