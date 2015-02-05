import processing.serial.*;

Serial myPort;             // The serial port
color[] palette = {
                    #000000, 
                    #2AC4C0, 
                    #FD9173, 
                    #F4F4F4
                  };
int margin = 50; 

int xPos = margin; // initial position on horizontal axis
int yPos = margin; // initial position on vertical axis

color colour;
int numberRows = 20;
float rowHeight;

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

    stroke(#000000, 60);
    line(xPos, yPos-random(0, 5), xPos, yPos + random(0, 5));

    // trim off any whitespace:
    inString = trim(inString);

    // Separate inString into string values
    String[] vals = split(inString, ';');

    // Change color based on potentiometer value
    float potVal = map(float(vals[0]), 0, 1023, 0, 85);

    // Change color to accent color when button is pressed
    int btnVal = parseInt(vals[2]);
    if (btnVal == 1) {
      colour = palette[2];
    } else {
      colour = palette[0];
    }

    noStroke();
    fill(colour, potVal);
    float diameter = 10 + random(1, 10);
    // float diameter = 15;
    ellipse(xPos, yPos, diameter, diameter);

    xPos += 20;

    // at the edge of the screen, go back to the beginning:
    if (xPos >= width-margin) {
      xPos = margin;
      yPos += rowHeight;
    }
  } else if (yPos >= (height-margin)) {
    save("sketch.png");
  }
  
}
