/*

Read value from two potentiometer plugged to an arduino micro.
Write on the serial port a formatted string: 000000.
First two digit tell wich potentiometer the value is referring to, next digits are the value (from 0 to 1000).

2014/11/25
Eugenio Vannoni

Made for educational purpose. 
Jumpstar processing Starter 3d 2014, 
Workshop a cura di Officine Arduino


This example is in the public domain.

*/

int pinP1=A0;
int pinP2=A1;
int p1,p2,p1max,p1min,p2max,p2min;
void setup(){
   // open the serial port at 9600 bps:
  Serial.begin(9600);
  p1min=1024;
  p2min=1024;
  p1max=0;
  p2max=0;
}

void loop(){

  p1 = analogRead(pinP1); 
  if(p1>1023)p1=p1max; 
  if(p1<0)p1=p1min;
  if(p1>p1max && p1<1024)p1max=p1;
  if(p1<p1min && p1>0 )p1min=p1;
  p2 = analogRead(pinP2);
  
  if(p2>1023)p2=p2max; 
  if(p2<0)p2=p2min; 
  if(p2>p2max && p2<1024)p2max=p2;
  if(p2<p2min && p2>0 )p2min=p2;
  int tmp=floor((float(p1)-float(p1min))/(float(p1max)-float(p1min))*1000);
  if(tmp>1000)tmp=1000;
  Serial.print("01");
  if(tmp<0)tmp=0;
  if(tmp<10)Serial.print("0");
  if(tmp<100)Serial.print("0");
  if(tmp<1000)Serial.print("0");
  Serial.println(tmp);

  tmp=floor((float(p2)-float(p2min))/(float(p2max)-float(p2min))*1000);
  if(tmp>1000)tmp=1000;
  if(tmp<0)tmp=0; 
  Serial.print("02");
  if(tmp<10)Serial.print("0");
  if(tmp<100)Serial.print("0");
  if(tmp<1000)Serial.print("0");
  Serial.println(tmp);
  
}
