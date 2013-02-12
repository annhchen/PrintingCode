//------------------------- properties
PGraphics canvas;

int canvas_width = 3300;
int canvas_height = 3000;

float ratioWidth = 1;
float ratioHeight = 1;
float ratio = 1;

//------------------------- setup
void setup()
{
  size(800, 600);
  background(30);
  canvas = createGraphics(canvas_width, canvas_height);
  calculateResizeRatio();

//------------------------- sharp variables
  float sharpVertices = 20;
  
  int xPos = 0;
  int yPos = 0;

//------------------------- wet variables   
  int circleRadius = 250;
  float numVertices = 16;
  float vertexDegree = 500 / numVertices;

  canvas.beginDraw();
  canvas.background(255);

//------------------------- draw sharp version 1
//  canvas.fill(255);
//  canvas.smooth();
//  canvas.strokeWeight(3);
//  canvas.stroke(0);
//  canvas.beginShape();
//
//  for (int i = 0; i < 10; i++) {
//    canvas.vertex(random(3000), random(3000));
//  }
//
//  canvas.endShape();

//------------------------- draw sharp version 2
  canvas.beginShape();
  canvas.smooth();
  canvas.noStroke();
  canvas.fill(30);
  
    for(int i = 0; i < sharpVertices; i++) {
      canvas.vertex(
    }

//------------------------- draw wet 1
  canvas.fill(30, 100);
  canvas.smooth();
  canvas.noStroke();
  canvas.beginShape();
  canvas.translate(width * 2, height * 3);
    
    for(int i = 0; i < numVertices; i++) {
      float x = cos(radians(i * vertexDegree)) * (circleRadius + random(-50, 50));
      float y = sin(radians(i * vertexDegree)) * (circleRadius + random(-50, 50));
      canvas.curveVertex(x * 5, y + 110);
    }
    
  canvas.endShape();
  
  canvas.endDraw();

  //------------------------- resize canvas
  float resizedWidth = (float) canvas.width * ratio;
  float resizedHeight = (float) canvas.height * ratio;

  image(canvas, (width / 2) - (resizedWidth / 2), (height / 2) - (resizedHeight / 2), resizedWidth, resizedHeight);

//  canvas.save("sketch.tif");
}

//------------------------- fit canvas to screen
void calculateResizeRatio() 
{
  ratioWidth = (float) width / (float) canvas.width;
  ratioHeight = (float) height / (float) canvas.height;

  if (ratioWidth < ratioHeight)  ratio = ratioWidth;
  else                           ratio = ratioHeight;
}

