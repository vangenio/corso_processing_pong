/*
  Esplora Accelerometer 
 
 This  sketch shows you how to read the values from the accelerometer.
 To see it in action, open the serial monitor and tilt the board. You'll see
 the accelerometer values for each axis change when you tilt the board 
 on that axis.
  
 Created on 22 Dec 2012
 by Tom Igoe
 
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
if(xAxis>xmax)xAxis=xmax;
if(xAxis<xmin)xAxis=xmin;

int tmp=floor( (float(xAxis)-float(xmin))/(float(xmax)-float(xmin))*1000);
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


