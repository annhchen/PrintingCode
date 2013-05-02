
import toxi.color.*;
import toxi.color.theory.*;
import toxi.util.datatypes.*;


// ---------------------- canvas properties
PGraphics canvas;

int canvas_width = 3000; //10 x 10 inches
int canvas_height = 3000;

float ratioWidth = 1;
float ratioHeight = 1;
float ratio = 1;

// ---------------------- setup
void setup() 
{
  size(700, 700);
  background(255);
  noStroke();
  smooth();

  canvas = createGraphics(canvas_width, canvas_height);
  calculateResizeRatio();

  // ---------------------- begin canvas
  canvas.beginDraw();

  canvas.background(0);
  canvas.noStroke();
  canvas.smooth();
  canvas.colorMode(HSB, 1, 1, 1);
  canvas.translate(0, 0);
  
  // ---------------------- create color theme
  ColorTheme t = new ColorTheme("annchens theme");
  
  // ---------------------- add pre-defined colorrange objects
  t.addRange("saddlebrown", 0.15);
  t.addRange("dark teal", 0.05);
  t.addRange("fresh yellow", 0.05);

  // ---------------------- create color range object
  FloatRange h = new FloatRange(0.1, 0.8);
  FloatRange s = new FloatRange(0.3, 0.8);
  FloatRange b = new FloatRange(0.3, 1);
  ColorRange range = new ColorRange(h, s, b, "annchen range");
  t.addRange(range, null, 0.05);
  
  //

    canvas.endDraw();

  // ---------------------- resize canvas
  float resizedWidth = (float) canvas.width * ratio;
  float resizedHeight = (float) canvas.height * ratio;

  image(canvas, (width / 2) - (resizedWidth / 2), (height / 2) - (resizedHeight / 2), resizedWidth, resizedHeight);

  // canvas.save("colorSelfPortrait"+year()+day()+hour()+minute()+second()+".tif");
}

// ---------------------- fit canvas to screen
void calculateResizeRatio() 
{
  ratioWidth = (float) width / (float) canvas.width;
  ratioHeight = (float) height / (float) canvas.height;

  if (ratioWidth < ratioHeight) ratio = ratioWidth;
  else                          ratio = ratioHeight;
}

void keyPressed() 
{
  if (key == 'p') saveImage();
}

void saveImage() {
  println("Saving Image");
  canvas.save("colorSelfPortrait_" + year() + month() + day() + hour() + minute() + second() + ".tiff");
  println("Saved Image");
}

