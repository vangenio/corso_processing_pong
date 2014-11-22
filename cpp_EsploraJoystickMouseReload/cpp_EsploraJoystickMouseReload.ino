/*
  Esplora Joystick Mouse

 This  sketch shows you how to read the joystick and use it to control the movement
 of the cursor on your computer.  You're making your Esplora into a mouse!

 WARNING: this sketch will take over your mouse movement. If you lose control
 of your mouse do the following:
 1) unplug the Esplora.
 2) open the EsploraBlink sketch
 3) hold the reset button down while plugging your Esplora back in
 4) while holding reset, click "Upload"
 5) when you see the message "Done compiling", release the reset button.

 This will stop your Esplora from controlling your mouse while you upload a sketch
 that doesn't take control of the mouse.

 Created on 22 Dec 2012
 by Tom Igoe

 This example is in the public domain.
 */

#include <Esplora.h>

void setup()
{
  Serial.begin(9600);       // initialize serial communication with your computer
  Mouse.begin();            // take control of the mouse
  delay (100);
}

void loop()
{
 int xDrift = map(Esplora.readJoystickX(), -512, 512, 10, -10);  // finds the drift value for x and maps it
 int yDrift = map(Esplora.readJoystickY(), -512, 512, -10, 10);  // finds the drift value for y and maps it
 do
  {
   int xValue = Esplora.readJoystickX();        // read the joystick's X position
    int yValue = Esplora.readJoystickY();        // read the joystick's Y position
    int button = Esplora.readJoystickSwitch();   // read the joystick pushbutton
    Serial.print("\nJoystick X: ");                // print a label for the X value
    Serial.print(xValue);                        // print the X value
    Serial.print("\tY: ");                       // print a tab character and a label for the Y value
    Serial.print(yValue);                        // print the Y value
    Serial.print("\tButton: ");                  // print a tab character and a label for the button
    Serial.print(button);                        // print the button value
    Serial.print("\txDrift: ");
    Serial.print(xDrift);
    Serial.print("\tyDrift: ");
    Serial.print(yDrift);
    int mouseX = map( xValue,-512, 512, 10, -10);  // map the X value to a range of movement for the mouse X
    int mouseY = map( yValue,-512, 512, -10, 10);  // map the Y value to a range of movement for the mouse Y
    Mouse.move(mouseX-xDrift, mouseY-yDrift, 0);   // move the mouse
    
    if (button == 0) {                           // if the joystick button is pressed
    Mouse.press();                             // send a mouse click
  } else {
    Mouse.release();                           // if it's not pressed, release the mouse button
  }
    delay(10);       // a short delay before moving again
  } while(xDrift != 0 || yDrift != 0); // checks for drift
}
