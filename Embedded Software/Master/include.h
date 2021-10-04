#ifndef INCLUDE_H_
#define INCLUDE_H_
//thu vien ho tro ve bool, int, string va toan hoc math
#include <stdbool.h>
#include <stdint.h>
#include <math.h>
#include <stdio.h>
//thu vien driver API
#include "driverlib/gpio.h"
#include "driverlib/i2c.h"
#include "driverlib/sysctl.h"
#include "driverlib/pin_map.h"
#include "driverlib/timer.h"
#include "driverlib/interrupt.h"
#include "driverlib/rom.h"
//thu vien ho tro phan cung
#include "inc/hw_ints.h"
#include "inc/hw_gpio.h"
#include "inc/hw_memmap.h"
#include "inc/hw_types.h"
//#include "inc/tm4c123gh6pm.h"
//thu vien khai bao them (dua vao cac module minh tao ra)
#include "GPIO/GPIO.h"
#include "TIMER/TIMER.h"
#include "I2C/I2C.h"
#endif
