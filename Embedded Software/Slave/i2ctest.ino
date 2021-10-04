#include <Wire.h>

int vel;
void setup(){
  pinMode(2,INPUT_PULLUP);// Chan interup cua PHASE A
  pinMode(3,INPUT_PULLUP);// Chan doc tin hieu tu ecoder
  pinMode(6,OUTPUT);  // Chan xuat xung PWM dieu khien dong co
  pinMode(7,OUTPUT);// Chan IN3 TB6612
  pinMode(8,OUTPUT);// Chan IN4 TB6612
  digitalWrite(7,HIGH);
  digitalWrite(8,LOW);
  Serial.begin(9600);
  Wire.begin(0x55);
  Wire.onReceive(receiveEvent);
}
void loop() 
{
//delay(100); 
analogWrite(6,vel);
}
void receiveEvent(int howMany){
  while(Wire.available())
  {
    vel = Wire.read(); 
    Serial.println(vel);
  }
}
