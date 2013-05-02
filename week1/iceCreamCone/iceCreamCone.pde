import processing.pdf.*;

boolean record;

void setup() {
  
  size(800, 800);
  background(255);
  smooth();
  
}

void draw() {
  if (record) {
   beginRecord(PDF, "iceCreamCone####.pdf"); 
  }
    
  drawCircle(width/2, height/2, width);
  
  if (record) {
    endRecord();
    record = false;
  }
//  
//  float n = noise(t);
//  println(n);
//  t += 0.01;
//  
//  ellipse(400 * n, 200 + n, 100, 100);
  
}

void drawCircle(int x, int y, float r) {
  ellipse(x, y, r, r);
  
  //Exit condition, stop when radius is too small
  if (r > 2) {
    r *=0.75f;
    
    //Call the function inside the function (this is the recursive part)
    drawCircle(x, y-45, r);
  }
}

void keyPressed() {
  if (key == 'p') {
  record = true;
  }
}



