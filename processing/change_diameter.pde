import processing.serial.*;
 
 Serial myPort;             // The serial port
 color[] palette = {#CAC2B3,
                    #2AC4C0,
                    #FD9173,
                    #F4F4F4};
 int margin = 50; 
 
 int xPos = margin; // initial position on horizontal axis
 int yPos = margin; // initial position on vertical axis
 
 color colour;
 int numberRows = 20;
 float rowHeight;
 int colourIndex = 0;

 void setup () {
   size(600, 800);
   smooth();
   myPort = new Serial(this, Serial.list()[5], 9600);
   myPort.bufferUntil('\n');
   background(244, 244, 244);
   rowHeight = (height-2*margin)/numberRows;
 }
 
 void draw () {
 // everything happens in the serialEvent()
 }
 
 void serialEvent (Serial myPort) {
   
   // get the ASCII string:
   String inString = myPort.readStringUntil('\n');
   
   if (inString != null && yPos <= (height-margin)) {
     
     // trim off any whitespace:
     inString = trim(inString);
     
     // Separate inString into string values
     String[] vals = split(inString, ';');
     
     // Change color based on potentiometer value
     int potVal = int(map(float(vals[0]), 0, 1023, 0, 10));
     
     // Change color to accent color when button is pressed
     int btnVal = parseInt(vals[2]);
     if (btnVal == 1) {
       colourIndex = ( ++colourIndex > 3) ? 0 : colourIndex++;
     }
     
     // Change speed based on LDR value
     float LDRVal = map(float(vals[1]), 0, 1023, 0, 2); 
     
     noStroke();
     fill(palette[colourIndex], 90);
     float diameter = 10 + potVal;
     ellipse(xPos, yPos, diameter, diameter);
     
     xPos += 20;
     // at the edge of the screen, go back to the beginning:
     if (xPos >= width-margin) {
       xPos = margin;
       yPos += rowHeight;
     }
   }
   
 }
