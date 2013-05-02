import processing.core.*; 

import geomerative.*; 
import controlP5.*; 
import processing.pdf.*; 
import java.awt.Rectangle; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class getPoints_04 extends PApplet {





ControlP5 controlP5;
RFont font;
ArrayList coords;
Population population;
Button button;
String theValue = "Q";

boolean recording = false;

//----------------SETUP---------------------------------
public void setup() {
  size(1100, 500);
  background(255);
  controlP5 = new ControlP5(this);
  noStroke();
  smooth();
  int popmax = 5;
  float mutationRate = 0.05f;  // A pretty high mutation rate here, our population is rather small we need to enforce variety
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

public void draw() {
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
public void mousePressed() {
  if (button.clicked(mouseX, mouseY)) {
    population.selection();
    population.reproduction();
  }
}

public void mouseReleased() {
  button.released();
}

public void textA(String _theValue) {
  theValue = _theValue;
  population.selection();
  population.reproduction();
}

public void keyPressed() {
  if (key=='p') {
    recording = true;
  }
}

// Interactive Selection
// http://www.genarts.com/karl/papers/siggraph91.html
// Daniel Shiffman <http://www.shiffman.net>



class Button {
  Rectangle r;  // Button's rectangle
  String txt;   // Button's text
  boolean clicked;  // Did i click on it?
  boolean rollover; // Did i rollover it?

  Button(int x, int y, int w, int h, String s) {
    r = new Rectangle(x ,y , w, h);
    txt = s;
  }

  public void display() {
    // Draw rectangle and text based on whether rollover or clicked
    rectMode(CORNER);
    stroke(0); noFill();
    if (rollover) fill(0.5f);
    if (clicked) fill(0);
    rect(r.x,r.y,r.width,r.height);
    float b = 0.0f;
    if (clicked) b = 1;
    else if (rollover) b = 0.2f;
    else b = 0;
    fill(b);
    textAlign(LEFT);
    text(txt,r.x+10,r.y+14);

  }
  
  
  // Methods to check rollover, clicked, or released (must be called from appropriate
  // Places in draw, mousePressed, mouseReleased
  public boolean rollover(int mx, int my) {
    if (r.contains(mx,my)) rollover = true;
    else rollover = false;
    return rollover;
  }

  public boolean clicked(int mx, int my) {
    if (r.contains(mx,my)) clicked = true;
    return clicked;
  }

  public void released() {
    clicked = false;
  }

}
// Interactive Selection
// http://www.genarts.com/karl/papers/siggraph91.html
// Daniel Shiffman <http://www.shiffman.net>

class DNA {

  // The genetic sequence
  float[] genes;
  int len = 20;  // Arbitrary length
  
  //Constructor (makes a random DNA)
  DNA() {
    // DNA is random floating point values between 0 and 1 (!!)
    genes = new float[len];
    for (int i = 0; i < genes.length; i++) {
      genes[i] = random(0,1);
    }
  }
  
  DNA(float[] newgenes) {
    genes = newgenes;
  }
  

  // Crossover
  // Creates new DNA sequence from two (this & 
  public DNA crossover(DNA partner) {
    float[] child = new float[genes.length];
    int crossover = PApplet.parseInt(random(genes.length));
    for (int i = 0; i < genes.length; i++) {
      if (i > crossover) child[i] = genes[i];
      else               child[i] = partner.genes[i];
    }
    DNA newgenes = new DNA(child);
    return newgenes;
  }
  
  // Based on a mutation probability, picks a new random character in array spots
  public void mutate(float m) {
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < m) {
         genes[i] = random(0,1);
      }
    }
  }
}
class LetterPoints {
  DNA dna;          // LetterPoints DNA
  float fitness;    // How good is this Letter?
  float x, y;       // Position on screen
  int wh = 180;      // Size of square enclosing face
  boolean rollover; // Are we rolling over this face?

  Rectangle r;

  RGroup myGroup = font.toGroup(theValue); 
  RPoint[] myPoints = myGroup.getPoints();

  int seed = 0;

  LetterPoints(DNA dna_, float x_, float y_) {
    dna = dna_;
    x = x_;
    y = y_;
    fitness = 1;
    seed = PApplet.parseInt(random(100000));

    r = new Rectangle(PApplet.parseInt(x), PApplet.parseInt(y), PApplet.parseInt(wh), PApplet.parseInt(wh));
  }

  public void display() {
    randomSeed(seed);
    float letterWidth = map(dna.genes[0], 0, 1, 0, 3);
    float letterHeight = map(dna.genes[1], 0, 1, 0, 2);
    float letterR = map(dna.genes[2], 0, 1, 0, 250);
    float letterG = map(dna.genes[3], 0, 1, 0, 250);
    float letterB = map(dna.genes[4], 0, 1, 0, 250);
    float letterAlpha = map(dna.genes[5], 0, 1, 50, 100);
    float letterRandomXHigh = map(dna.genes[6], 0, 1, 1, 1.5f);
    float letterRandomYHigh = map(dna.genes[7], 0, 1, 1, 1.5f);
    float letterRandomXLow = map(dna.genes[8], 0, 1, 0.5f, 1);
    float letterRandomYLow = map(dna.genes[9], 0, 1, 0.5f, 1);
    float letterStrokeWeight = map(dna.genes[10], 0, 1, 0.5f, 15);


    pushMatrix();
    translate(x + (wh/2), y + (wh - 10));

    noStroke();
    /*beginShape();
    for (int i=0; i<myPoints.length; i++) {
      fill(letterR, letterG, letterB, letterAlpha);
      // slight change: adjusting width & height
      //vertex(myPoints[i].x * letterWidth, myPoints[i].y * letterHeight);
      
      //extreme change: randomizing vertex points
      vertex(myPoints[i].x * random(letterRandomXLow, letterRandomXHigh), myPoints[i].y * random(letterRandomYLow, letterRandomYHigh));
    }
    endShape();*/

// Divide points into sections
    beginShape();
    for (int i=0; i<myPoints.length/2; i++) {
      strokeWeight(1);
      stroke(letterR, letterG, letterB, letterAlpha);
      fill(letterR, letterG, letterB, letterAlpha);
      vertex(myPoints[i].x * random(letterRandomXLow, letterRandomXHigh), myPoints[i].y * random(letterRandomYLow, letterRandomYHigh));
    }
    endShape();

    beginShape();
    smooth();
    for (int i=myPoints.length/2; i<myPoints.length; i++) {
      strokeWeight(1);
      stroke(letterR, letterG, letterB, letterAlpha);
      fill(letterR, letterG, letterB, letterAlpha);
      vertex(myPoints[i].x * letterWidth, myPoints[i].y * letterHeight);
    }
    endShape();

    beginShape();
    smooth();
    for (int i=(myPoints.length/3)*2; i<myPoints.length; i++) {
      strokeWeight(1);
      stroke(letterR, letterG, letterB, letterAlpha);
      vertex(myPoints[i].x * letterWidth, myPoints[i].y * letterHeight);
    }
    endShape();

    pushMatrix();
    noStroke();
    strokeWeight(0.25f);
    if (rollover) fill(0, 0.25f);
    else noFill();
    rectMode(CORNER);
    rect(-wh/2, -wh+10, wh, wh);
    popMatrix();

    // Display fitness value
    textAlign(CENTER);
    if (rollover) fill(0);
    else fill(0.25f);
    text(PApplet.parseInt(fitness), 0, 35);

    popMatrix();

    noStroke();
    noFill();
    rect(r.x, r.y, r.width, r.height);
  }

  public float getFitness() {
    return fitness;
  }

  public DNA getDNA() {
    return dna;
  }

  // Increment fitness if mouse is rolling over face
  public void rollover(int mx, int my) {
    if (r.contains(mx, my)) {
      rollover = true;
      fitness += 0.25f;
    } 
    else {
      rollover = false;
    }
  }
}

class Population {
  float mutationRate;           // Mutation rate
  LetterPoints[] population;
  ArrayList<LetterPoints> matingPool;   // ArrayList which we will use for our "mating pool"
  int generations;              // Number of generations

  Population(float m, int num) {
    mutationRate = m;
    population = new LetterPoints[num];
    matingPool = new ArrayList<LetterPoints>();
    generations = 0;
    for (int i = 0; i < population.length; i++) {
      population[i] = new LetterPoints(new DNA(), 200*i + 50, 175);
    }
  }

  public void display() {
    for (int i = 0; i < population.length; i++) {
      //translate(200, 0);
      population[i].display();
    }
  }

  // Are we rolling over any of the faces?
  public void rollover(int mx, int my) {
    for (int i = 0; i < population.length; i++) {
      population[i].rollover(mx, my);
    }
  }

  // Generate a mating pool
  public void selection() {
    // Clear the ArrayList
    matingPool.clear();

    // Calculate total fitness of whole population
    float maxFitness = getMaxFitness();

    // Calculate fitness for each member of the population (scaled to value between 0 and 1)
    // Based on fitness, each member will get added to the mating pool a certain number of times
    // A higher fitness = more entries to mating pool = more likely to be picked as a parent
    // A lower fitness = fewer entries to mating pool = less likely to be picked as a parent
    for (int i = 0; i < population.length; i++) {
      float fitnessNormal = map(population[i].getFitness(), 0, maxFitness, 0, 1);
      int n = (int) (fitnessNormal * 100);  // Arbitrary multiplier
      for (int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
    }
  }  

  // Making the next generation
  public void reproduction() {
    // Refill the population with children from the mating pool
    for (int i = 0; i < population.length; i++) {
      // Sping the wheel of fortune to pick two parents
      int m = PApplet.parseInt(random(matingPool.size()));
      int d = PApplet.parseInt(random(matingPool.size()));
      // Pick two parents
      LetterPoints mom = matingPool.get(m);
      LetterPoints dad = matingPool.get(d);
      // Get their genes
      DNA momgenes = mom.getDNA();
      DNA dadgenes = dad.getDNA();
      // Mate their genes
      DNA child = momgenes.crossover(dadgenes);
      // Mutate their genes
      child.mutate(mutationRate);
      // Fill the new population with the new child
      population[i] = new LetterPoints(child, 200*i + 50, 175);
    }
    generations++;
  }

  public int getGenerations() {
    return generations;
  }

  // Find highest fintess for the population
  public float getMaxFitness() {
    float record = 0;
    for (int i = 0; i < population.length; i++) {
      if (population[i].getFitness() > record) {
        record = population[i].getFitness();
      }
    }
    return record;
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "getPoints_04" });
  }
}
