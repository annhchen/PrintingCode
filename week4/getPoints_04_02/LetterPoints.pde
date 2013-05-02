class LetterPoints {
  DNA dna;          // LetterPoints DNA
  float fitness;    // How good is this Letter?
  float x, y;       // Position on screen
  int wh = 180;      // Size of square enclosing face
  boolean rollover; // Are we rolling over this face?

  Rectangle r;

  RGroup myGroup01 = font01.toGroup(theValue); 
  RPoint[] myPoints01 = myGroup01.getPoints();
  RGroup myGroup02 = font02.toGroup(theValue); 
  RPoint[] myPoints02 = myGroup02.getPoints();

  int seed = 0;

  LetterPoints(DNA dna_, float x_, float y_) {
    dna = dna_;
    x = x_;
    y = y_;
    fitness = 1;
    seed = int(random(100000));

    r = new Rectangle(int(x), int(y), int(wh), int(wh));
  }

  void display() {
    randomSeed(seed);
    float letterWidth = map(dna.genes[0], 0, 1, 0, 1.75);
    float letterHeight = map(dna.genes[1], 0, 1, 0, 1.5);
    float letterR = map(dna.genes[2], 0, 1, 0, 250);
    float letterG = map(dna.genes[3], 0, 1, 0, 250);
    float letterB = map(dna.genes[4], 0, 1, 0, 250);
//    float letterAlpha = map(dna.genes[5], 0, 1, 50, 100);
    float letterRandomXHigh = map(dna.genes[6], 0, 1, 1, 1.5);
    float letterRandomYHigh = map(dna.genes[7], 0, 1, 1, 1.5);
    float letterRandomXLow = map(dna.genes[8], 0, 1, 0.5, 1);
    float letterRandomYLow = map(dna.genes[9], 0, 1, 0.5, 1);
    float letterStrokeWeight = map(dna.genes[10], 0, 1, 0.5, 15);


    pushMatrix();
    translate(x + (wh/2), y + (wh - 10));

    noStroke();
    beginShape();
    for (int i=0; i<myPoints02.length; i++) {
      fill(letterR, letterG, letterB);
      // slight change: adjusting width & height
      vertex(myPoints02[i].x * letterWidth, myPoints02[i].y * letterHeight);

      //extreme change: randomizing vertex points
      //vertex(myPoints02[i].x * random(letterRandomXLow, letterRandomXHigh), myPoints02[i].y * random(letterRandomYLow, letterRandomYHigh));
    }
    endShape();

    beginShape();
    for (int i=0; i<myPoints01.length; i++) {
      fill(letterR/2, letterG/2, letterB/2 );
      // slight change: adjusting width & height
      vertex(myPoints01[i].x * letterWidth, myPoints01[i].y * letterHeight);
      //extreme change: randomizing vertex points
      //vertex(myPoints02[i].x * random(letterRandomXLow, letterRandomXHigh), myPoints02[i].y * random(letterRandomYLow, letterRandomYHigh));
    }
    endShape();

    /*
    // Divide points into sections
     beginShape();
     for (int i=0; i<myPoints01.length/2; i++) {
     strokeWeight(1);
     stroke(letterR, letterG, letterB, letterAlpha);
     fill(letterR, letterG, letterB, letterAlpha);
     vertex(myPoints01[i].x * random(letterRandomXLow, letterRandomXHigh), myPoints01[i].y * random(letterRandomYLow, letterRandomYHigh));
     }
     endShape();
     
     beginShape();
     smooth();
     for (int i = myPoints01.length/3; i<myPoints01.length; i++) {
     strokeWeight(1);
     stroke(letterR, letterG, letterB, letterAlpha);
     fill(letterR, letterG, letterB, letterAlpha);
     vertex(myPoints01[i].x * letterWidth, myPoints01[i].y * letterHeight);
     }
     endShape();
     
     beginShape();
     smooth();
     for (int i=(myPoints01.length/3)*2; i<myPoints01.length; i++) {
     strokeWeight(1);
     stroke(letterR, letterG, letterB, letterAlpha);
     vertex(myPoints01[i].x * letterWidth, myPoints01[i].y * letterHeight);
     }
     endShape();*/

    pushMatrix();
    noStroke();
    strokeWeight(0.25);
    if (rollover) fill(0, 0.25);
    else noFill();
    rectMode(CORNER);
    rect(-wh/2, -wh+10, wh, wh);
    popMatrix();

    // Display fitness value
    textAlign(CENTER);
    if (rollover) fill(0);
    else fill(0.25);
    text(int(fitness), 0, 35);

    popMatrix();

    noStroke();
    noFill();
    rect(r.x, r.y, r.width, r.height);
  }

  float getFitness() {
    return fitness;
  }

  DNA getDNA() {
    return dna;
  }

  // Increment fitness if mouse is rolling over face
  void rollover(int mx, int my) {
    if (r.contains(mx, my)) {
      rollover = true;
      fitness += 0.25;
    } 
    else {
      rollover = false;
    }
  }
}

