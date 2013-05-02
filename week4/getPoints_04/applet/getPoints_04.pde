import geomerative.*;
import controlP5.*;
import processing.pdf.*;

ControlP5 controlP5;
RFont font;
ArrayList coords;
Population population;
Button button;
String theValue = "Q";

boolean recording = false;

//----------------SETUP---------------------------------
void setup() {
  size(1100, 500);
  background(255);
  controlP5 = new ControlP5(this);
  noStroke();
  smooth();
  int popmax = 5;
  float mutationRate = 0.05;  // A pretty high mutation rate here, our population is rather small we need to enforce variety
  coords = new ArrayList();
  button = new Button(50, height-70, 160, 20, "evolve new generation");

  RG.init(this); 
  font = new RFont("FreeSans.ttf", 300, CENTER);
  RCommand.setSegmentLength(1);//ASSIGN A VALUE OF 10, SO EVERY 10 PIXELS
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  RGroup myGroup = font.toGroup(theValue); 
  RPoint[] myPoints = myGroup.getPoints();
  coords = new ArrayList();

  population = new Population(mutationRate, popmax);

  controlP5.addTextfield("textA", 220, height - 70, 100, 20);
}

//----------------DRAW---------------------------------

void draw() {
  background(255);
  if (recording) {
    beginRecord(PDF, "frame-####.pdf");
  }

  population.display();
  population.rollover(mouseX, mouseY);

  if (recording) {
    endRecord();
    recording = false;
  }
  textAlign(LEFT);
  text("Generative Type Design", 50, 30);
  text("Generation #:" + population.getGenerations(), 50, height - 20);

  fill(0);
  // Display the button
  button.display();
  button.rollover(mouseX, mouseY);
}

//////////////////////////////////////////////

// If the button is clicked, evolve next generation
void mousePressed() {
  if (button.clicked(mouseX, mouseY)) {
    population.selection();
    population.reproduction();
  }
}

void mouseReleased() {
  button.released();
}

public void textA(String _theValue) {
  theValue = _theValue;
  population.selection();
  population.reproduction();
}

void keyPressed() {
  if (key=='p') {
    recording = true;
  }
}

