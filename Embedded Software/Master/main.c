/*
 * main.c
 *
 *  Created on: Dec 22, 2020
 *      Author: Trung Duc
 */
#include "include.h"
 //Khoi tao parameter va bien
double w1[7]={-2.35431928,2.36016677,2.35200359,2.30560324,0.00563173,-2.30560001,-2.35201019};
double w2[2] ={-9.09648728,9.07690696};
double b2[2]={3.6192758,3.61944451};
double b1[1]={-0.00577195};
double ZZ[2], AA[2];
double predictionArray[2]={0,0};
double Z, A;
int signal = 1,vel_sta = 60,n=0,hhh=0,i;
uint8_t readSensorE;
uint8_t readSensorD;
uint16_t pwm[2];
uint16_t state[7];
//Chuong trinh con
int normalize(float x, float in_min, float in_max, int out_min, int out_max) // chuong trinh con chuan hoa van toc
{
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

void controller(int signal) // chuong trinh con xuat ra van toc cho 2 banh
{
  if(signal == 1){ // tracking line di thang
      if(predictionArray[0]>0.9 && predictionArray[1]>0.9){
      pwm[0]=115;
      pwm[1]=115;}
      else if(predictionArray[0]<0.9 && predictionArray[1]>0.9){
          pwm[0]=130;
          pwm[1]=65;}
      else {
          pwm[1]=130;
          pwm[0]=65;}
      //pwm[0]=normalize(predictionArray[0],0,1,0,150);
      //pwm[1]=normalize(predictionArray[1],0,1,0,150);
}
  else if(signal == 2){ // Di thang qua nga giao 3 lan 2
      pwm[1]=135;
      pwm[0]=135;}
  else if(signal == 3){ // Re trai qua nga giao 3 lan 3
        pwm[0]=135;
        pwm[1]=90;}
  else if(signal == 4){ // Re phai nga giao 3 line
      pwm[1]=125;
      pwm[0]=85;}
  else if(signal == 0 ){ // Re phai nga giao 3 line
        pwm[0]=1;
        pwm[1]=1;}
}

double sigmoid(double z) // chuong trinh con ham kich hoat sigmoid
{
    return 1/(1+exp(-z));
}
void forward_prediction(void) // chuong trinh con du doan do lech cua xe
  {
    Z=((state[0]*w1[0] + state[1]*w1[1] + state[2]*w1[2] + state[3]*w1[3] + state[4]*w1[4] + state[5]*w1[5] + state[6]*w1[6]) + b1[0]);
    A=tanh(Z);
    ZZ[0]=((w2[0]*A + b2[0]));
    ZZ[1]=((w2[1]*A + b2[1]));
    AA[0]= sigmoid(ZZ[0]);
    AA[1]= sigmoid(ZZ[1]);
    predictionArray[0]=AA[0];
    predictionArray[1]=AA[1];
  }
void Imp_I2C0(uint16_t pwm0_data,uint8_t slave1_addr) // chuong trinh con gui van toc cho Slave bang I2C
{   I2CMasterSlaveAddrSet(I2C0,slave1_addr,false);
    I2CMasterDataPut(I2C0, pwm0_data);
    //I2CMasterControl(I2C0, SINGLE_I2C);
    I2CMasterControl(I2C0, START_I2C);
    //I2CMasterControl(I2C0, CONT_I2C);
    //while(I2CMasterBusy(I2C0));
   // I2CMasterControl(I2C0, FINISH_I2C);
    //SysCtlDelay(10);
}
void Imp_I2C1(uint16_t pwm1_data,uint8_t slave2_addr) // chuong trinh con gui van toc cho Slave bang I2C
{ I2CMasterSlaveAddrSet(I2C0,slave2_addr,false);
    I2CMasterDataPut(I2C0, pwm1_data);
    I2CMasterControl(I2C0, START_I2C);
    //I2CMasterControl(I2C0, CONT_I2C);
    while(I2CMasterBusy(I2C0));
   // I2CMasterControl(I2C0, FINISH_I2C);
    //SysCtlDelay(10);
    }
void ReadSensor(void) //chuong trinh con doc digital Sensor
{
    readSensorE=GPIOPinRead(PORTE,P1|P2|P3|P4);
    readSensorD=GPIOPinRead(PORTD,P1|P2|P3);
    state[1]=(readSensorD&P1)/2; //ss 1, value 2
    state[2]=(readSensorD&P2)/4; //ss 2, value 4
    state[3]=(readSensorD&P3)/8; //ss 3, value 8
    state[4]=(readSensorE&P4)/16; //ss 4, value 16
    state[5]=(readSensorE&P1)/2; //ss 5, value 2
    state[6]=(readSensorE&P2)/4; //ss 6, value 4
    state[0]=(readSensorE&P3)/8; //ss 7, value 8

}
//void spe_state(void)
//{
//    if(state[3]==1&&state[4]==1&&state[5]==1)
//    { controller(4); // gap nga 3 lan 3 hay khong
//    n=1;
//    while (n==1)
//               {
//               ReadSensor();
//               if ((state[0]==1&&state[1]==0&&state[2]==0&&state[3]==0&&state[4]==0&&state[5]==0&&state[6]==0)||(state[0]==0&&state[1]==1&&state[2]==0&&state[3]==0&&state[4]==0&&state[5]==0&&state[6]==0)||(state[0]==0&&state[1]==0&&state[2]==1&&state[3]==0&&state[4]==0&&state[5]==0&&state[6]==0)||(state[0]==0&&state[1]==0&&state[2]==0&&state[3]==1&&state[4]==0&&state[5]==0&&state[6]==0)||(state[0]==0&&state[1]==0&&state[2]==0&&state[3]==0&&state[4]==1&&state[5]==0&&state[6]==0)||(state[0]==0&&state[1]==0&&state[2]==0&&state[3]==0&&state[4]==0&&state[5]==1&&state[6]==0)||(state[0]==0&&state[1]==0&&state[2]==0&&state[3]==0&&state[4]==0&&state[5]==0&&state[6]==1))
//               {n=0;}
//               }
//    }
//    else if(state[1]==1&&state[2]==0&&state[3]==0&&state[4]==1&&state[5]==0&&state[6]==0&&state[0]==0)
//        { controller(2);
//        n=1;
//        while (n==1)
//            {
//            ReadSensor();
//            if ((state[0]==0&&state[1]==0&&state[2]==0&&state[3]==0&&state[4]==1&&state[5]==0&&state[6]==0)||(state[0]==0&&state[1]==0&&state[2]==0&&state[3]==1&&state[4]==1&&state[5]==0&&state[6]==0)||(state[0]==0&&state[1]==0&&state[2]==0&&state[3]==1&&state[4]==0&&state[5]==0&&state[6]==0))
//            {n=0;}
//            }// gap nga 3 lan 3 hay khong
//        }
//  //  else if((state[2]==1&&state[1]==1)||(state[2]==1&&state[1]==1&&state[3]==1)||(state[2]==1&&state[1]==1&&state[3]==3&&state[4]==1))
//  //else if(state[3]==1&&state[4]==1&&state[5]==1&&m==1)
//               // gap nga 3 lan 3 hay khong
// //{ m=2;
//  //       signal = 2;} // gap nga 3 lan 2 hay khong
//    //else if((state[5]==1&&state[6]==1)||(state[4]==1&&state[5]==1)||(state[4]==1&&state[5]==1&&state[6]==1))
//  //   else if(state[3]==1&&state[4]==1&&state[5]==1&&m==2)
// //    { signal = 3; // gap nga giao 3 line hay khong
//   //     m=0;}
//    else signal = 1;
//}

void spe_state(void)
{

    if (state[1]==1&&state[4]==1&&state[0]==1&&state[6]==1&&hhh==0) // nga re thu 1
    {
        do{ hhh=1;

            for(i=0;i<120;i++)
                                    {controller(4);
                                    Imp_I2C1(pwm[0],0x53); // Truyen gia tri van toc cho Slave 2, banh phai
                                    Imp_I2C0(pwm[1],0x55); // Truyen gia tri van toc cho Slave 1, banh trai
                                    ReadSensor();
                                    SysCtlDelay(16666);
                                    }
                            }while((state[5]==0&&state[6]==0&&state[4]==1&&state[3]==0&&state[2]==0&&state[1]==0&&state[0]==0));

    }
    else if (state[4]==1&&state[1]==1&&state[0]==0&&hhh==1) // tram 1 truoc nga re thu 2
        {
                do{ hhh=2;
                    for(i=0;i<100;i++)
                        {controller(1);
                        Imp_I2C1(pwm[0],0x53); // Truyen gia tri van toc cho Slave 2, banh phai
                        Imp_I2C0(pwm[1],0x55); // Truyen gia tri van toc cho Slave 1, banh trai
                        ReadSensor();
                        SysCtlDelay(16666);
                        }
                }while((state[5]==0&&state[6]==0&&state[4]==1&&state[3]==0&&state[2]==0&&state[1]==0&&state[0]==0));
        }
    else if (state[4]==1&&state[1]==1&&state[0]==0&&hhh==2&&n==0) //nga re thu 2
    {
                do{ hhh=3;
                n=1;
                    for(i=0;i<150;i++)
                                    {controller(2);
                                    Imp_I2C1(pwm[0],0x53); // Truyen gia tri van toc cho Slave 2, banh phai
                                    Imp_I2C0(pwm[1],0x55); // Truyen gia tri van toc cho Slave 1, banh trai
                                    ReadSensor();
                                    SysCtlDelay(16666);
                                    }}

                                    while((state[5]==0&&state[6]==0&&state[4]==1&&state[3]==0&&state[2]==0&&state[1]==0&&state[0]==0));


        }
    else if (state[4]==1&&state[1]==0&&state[0]==1&&hhh==3&&n==1) // tram 2 truoc nga re thu 3
            {
                    do{ hhh=3;
                    n=2;
                        for(i=0;i<100;i++)
                            {controller(1);
                            Imp_I2C1(pwm[0],0x53); // Truyen gia tri van toc cho Slave 2, banh phai
                            Imp_I2C0(pwm[1],0x55); // Truyen gia tri van toc cho Slave 1, banh trai
                            ReadSensor();
                            SysCtlDelay(16666);
                            }
                    }while((state[5]==0&&state[6]==0&&state[4]==1&&state[3]==0&&state[2]==0&&state[1]==0&&state[0]==0));
            }
    else if (state[5]==1&&state[4]==1&&state[3]==1&&state[1]==0&&hhh==3&&n==2) // nga re cuoi cung
    {
            do{ hhh=4;
                for(i=0;i<120;i++)
                    {controller(3);
                    Imp_I2C1(pwm[0],0x53); // Truyen gia tri van toc cho Slave 2, banh phai
                    Imp_I2C0(pwm[1],0x55); // Truyen gia tri van toc cho Slave 1, banh trai
                    ReadSensor();
                    SysCtlDelay(16666);
                    }
                signal = 1;
            }while((state[5]==0&&state[6]==0&&state[4]==1&&state[3]==0&&state[2]==0&&state[1]==0&&state[0]==0));
    }
    else if((state[5]==1&&state[6]==1&&state[4]==1&&state[3]==1&&state[2]==1&&state[1]==1&&state[0]==1&&hhh==4)) //stop
    {
        signal = 0;
    }
    else signal = 1;
 }
//    if((state[1]==1&&state[2]==0&&state[3]==0&&state[4]==1&&state[5]==0&&state[6]==0&&state[0]==0)||(state[1]==0&&state[2]==0&&state[3]==1&&state[4]==1&&state[5]==1&&state[6]==0&&state[0]==0))
//    {   if((state[1]==1&&state[2]==0&&state[3]==0&&state[4]==1&&state[5]==0&&state[6]==0&&state[0]==0)||(state[1]==0&&state[2]==0&&state[3]==1&&state[4]==1&&state[5]==0&&state[6]==0&&state[0]==0)||(state[1]==0&&state[2]==0&&state[3]==1&&state[4]==0&&state[5]==0&&state[6]==0&&state[0]==0)){
//        do{ for(i=0;i<100;i++)
//        {controller(2);
//        Imp_I2C1(pwm[0],0x53); // Truyen gia tri van toc cho Slave 2, banh phai
//        Imp_I2C0(pwm[1],0x55); // Truyen gia tri van toc cho Slave 1, banh trai
//        ReadSensor();
//        SysCtlDelay(16666);
//        }}
//
//        while((state[5]==0&&state[6]==0&&state[4]==1&&state[3]==0&&state[2]==0&&state[1]==0&&state[0]==0));
//
//    }
//        else
//            {
//            do{ for(i=0;i<40;i++)
//                    {controller(4);
//                    Imp_I2C1(pwm[0],0x53); // Truyen gia tri van toc cho Slave 2, banh phai
//                    Imp_I2C0(pwm[1],0x55); // Truyen gia tri van toc cho Slave 1, banh trai
//                    ReadSensor();
//                    SysCtlDelay(16666);
//                    }
//            }while((state[5]==0&&state[6]==0&&state[4]==1&&state[3]==0&&state[2]==0&&state[1]==0&&state[0]==0));
//    }
//    }
//    else if ((state[1]==0&&state[2]==0&&state[3]==0&&state[4]==1&&state[5]==0&&state[6]==0&&state[0]==1))
//    {
//        do{ for(i=0;i<100;i++)
//                {controller(3);
//                Imp_I2C1(pwm[0],0x53); // Truyen gia tri van toc cho Slave 2, banh phai
//                Imp_I2C0(pwm[1],0x55); // Truyen gia tri van toc cho Slave 1, banh trai
//                ReadSensor();
//                SysCtlDelay(16666);
//                }
//        }while((state[5]==0&&state[6]==0&&state[4]==1&&state[3]==0&&state[2]==0&&state[1]==0&&state[0]==0));
//}


//Chuong trinh chinh
int main(void)
{
    SysCtlClockSet(SYSCTL_SYSDIV_5|SYSCTL_USE_PLL|SYSCTL_XTAL_16MHZ|SYSCTL_OSC_MAIN); //40Mhz
    Config_readSensor(); // cau hinh GPIO de doc sensor
    Config_I2C0(); // cau hinh I2C
//    Config_Timer(); // cau hinh Timer
//    uint32_t num =SysCtlClockGet()/1000;
//    TimerLoadSet(TIMER0_BASE,TIMER_A,num*4000);
//    IntEnable(INT_TIMER0A);
//    TimerIntEnable(TIMER0_BASE,TIMER_TIMA_TIMEOUT);
//    IntMasterEnable();
//    TimerEnable(TIMER0_BASE,TIMER_A);

    while(1)
    {  // Giai thuat tracking line

       ReadSensor(); // Doc gia tri sensor
       forward_prediction(); // Predict do lech
       spe_state();
       if (signal==0)
       {controller(0); // Dung bo dieu khien xuat ra van toc
       Imp_I2C1(0,0x53); // Truyen gia tri van toc cho Slave 2, banh phai
       Imp_I2C0(0,0x55); // Truyen gia tri van toc cho Slave 1, banh trai
       I2CMasterControl(I2C0, FINISH_I2C);
           break;}
       else
       {
       controller(signal); // Dung bo dieu khien xuat ra van toc
       Imp_I2C1(pwm[0],0x53); // Truyen gia tri van toc cho Slave 2, banh phai
       Imp_I2C0(pwm[1],0x55); // Truyen gia tri van toc cho Slave 1, banh trai
       }
}
}

//void Timer0IntHandler(void){
//    TimerIntClear(TIMER0_BASE,TIMER_TIMA_TIMEOUT);
//    if(state[3]==1&&state[4]==1&&state[5]==1){
//        signal=4;
//    }
//    else signal=1;
//}
