/*

Based on the Esplora Accelerometer example by Tom Igoe created on 22 Dec 2012

Write on the serial port the normalized value of the tilt angle for the x axis in the format 000000.
First two digit tell wich player is the value for.
Next 4 digit have a from 0 to 1000 value. 500 stay for 0 degree angle.

2014/11/25
Eugenio Vannoni

Made for educational purpose. 
Jumpstar processing Starter 3d 2014, 
Workshop a cura di Officine Arduino


This example is in the public domain.

*/

#include <Esplora.h>

void setup()
{
  Serial.begin(9600);        // initialize serial communications with your computer
} 

void loop()
{
  int xAxis = Esplora.readAccelerometer(X_AXIS);    // read the X axis
  int yAxis = Esplora.readAccelerometer(Y_AXIS);    // read the Y axis
  int zAxis = Esplora.readAccelerometer(Z_AXIS);    // read the Z axis
/*
  Serial.print("x: ");      // print the label for X 
  Serial.print(xAxis);      // print the value for the X axis
  Serial.print("\ty: ");    // print a tab character, then the label for Y 
  Serial.print(yAxis);      // print the value for the Y axis
  Serial.print("\tz: ");    // print a tab character, then the label for Z
  Serial.println(zAxis);    // print the value for the Z axis

  delay(500);              // wait half a second (500 milliseconds)
*/
int xmin=-85;
int xmax=140;
if(xAxis>xmax)xAxis=xmax; // the higher value returned
if(xAxis<xmin)xAxis=xmin; // the lower value returned

int tmp=floor( (float(xAxis)-float(xmin))/(float(xmax)-float(xmin))*1000); //normalize the value from 0 to 1000

if(tmp<10)Serial.print(0);
if(tmp<100)Serial.print(0);
if(tmp<1000)Serial.print(0);
Serial.print(tmp);
if(tmp<10)Serial.print(0);
if(tmp<100)Serial.print(0);
if(tmp<1000)Serial.print(0);
Serial.println(tmp);   
delay(10);
}


