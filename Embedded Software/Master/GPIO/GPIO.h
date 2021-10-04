#ifndef GPIO_GPIO_H_
#define GPIO_GPIO_H_
//define Pin
#define P0 GPIO_PIN_0
#define P1 GPIO_PIN_1
#define P2 GPIO_PIN_2
#define P3 GPIO_PIN_3
#define P4 GPIO_PIN_4
#define P6 GPIO_PIN_6
#define P7 GPIO_PIN_7
#define PORTE GPIO_PORTE_BASE
#define PORTD GPIO_PORTD_BASE
#define PORTB GPIO_PORTB_BASE
#define EN_GPIOE SYSCTL_PERIPH_GPIOE
#define EN_GPIOD SYSCTL_PERIPH_GPIOD
#define EN_GPIOB SYSCTL_PERIPH_GPIOB
// extern ham
extern void Config_readSensor(void);
#endif
