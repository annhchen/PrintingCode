//------------------Import libraries
import processing.pdf.*;

//------------------Global variables
PFont myFont;

//------------------Setup
void setup()
{
  size(640, 728);
  background(255);
  colorMode(HSB, 360, 100, 100);
  smooth();

  // create a grid object as a container for grid variables
  ModularGrid grid = new ModularGrid(14, 16, 2, 10);

  beginRecord(PDF, "frame-####.pdf");

  //draw background
  Module first = grid.modules[0][0];
  fill(67, 67, 81, 150);
  noStroke();
  rect(first.x, first.y, (first.w * 14) + (grid.gutterSize * 13), (first.h * 16) + (grid.gutterSize * 15));

  // draw some text in the modular grid
  String t = "Flatland";

  Module second = grid.modules[7][10];
  //fill in text 
  myFont = createFont("DIN", 34.5);
  textFont(myFont);
  fill(84, 0, 15);
  text(t, second.x, second.y, (second.w * 4) + (grid.gutterSize * 3), second.h * 2 + grid.gutterSize);

  // draw subtitle
  String subt = "a romance of many dimensions";

  Module third = grid.modules[7][11];
  //fill in subtitle text
  myFont = createFont("DIN-Light", 20);
  textFont(myFont);
  //textAlign(LEFT, TOP);
  fill(84, 0, 15);
  text(subt, third.x, third.y, (third.w * 8) + (grid.gutterSize * 7), third.h * 2 + grid.gutterSize);

  //draw white square
  Module fourth = grid.modules[4][3];
  fill(84, 0, 99, 360);
  rect(fourth.x, fourth.y, (fourth.w * 6) + (grid.gutterSize * 5), (fourth.w *6) + (grid.gutterSize*5));

  //draw small green square
  Module fifth = grid.modules[5][4];
  fill(67, 67, 81, 150);
  rect(fifth.x, fifth.y, (fifth.w * 4) + (grid.gutterSize * 3), (fifth.w *4) + (grid.gutterSize*3));

  //fill in author byline
  String author = "by a";

  Module sixth = grid.modules[7][12];
  myFont = createFont("DIN-Light", 15);
  textFont(myFont);
  fill(84, 0, 15);
  text(author, sixth.x, sixth.y, (sixth.w * 2), sixth.h * 2 + grid.gutterSize);

  //draw small square
  Module seventh = grid.modules [8][12];
  noFill();
  stroke(84, 0, 99, 360);
  strokeWeight(1);
  rect(seventh.x, seventh.y, seventh.w/2 + grid.gutterSize, seventh.w/2 + (grid.gutterSize));

  //draw author name
  String Edwin = "Edwin A. Abbott";

  Module eigth = grid.modules[5][15];
  String[] fontList = PFont.list();
  println(fontList);
  myFont = createFont("DIN-Light", 25.43);
  textFont(myFont);
  fill(84, 0, 15);
  text(Edwin, eigth.x, eigth.y, (eigth.w * 5) + (grid.gutterSize*4), eigth.h * 2 + grid.gutterSize);

  //draw the 3 rows of lines
  strokeWeight(2);
  Module ninth = grid.modules[6][5];
  stroke(84,0,99,360);
  line(ninth.x, ninth.y, ninth.x + (ninth.w * 2), ninth.y);
  
  Module tenth = grid.modules[5][6];
  stroke(84, 0, 99, 360);
  line(tenth.x, tenth.y, tenth.x + (tenth.w * 4) + (grid.gutterSize * 3), tenth.y);
  
  Module eleventh = grid.modules[3][7];
  stroke(84, 0, 99, 360);
  line(eleventh.x, eleventh.y, eleventh.x + (eleventh.w * 8) + (grid.gutterSize * 7), eleventh.y);
  
  endRecord();
  
//  for (int i = 0; i < 3; i++) {
//    for (int j = 1; j < 8; j*=2) {
//  
//  Module ninth = grid.modules[6-i][5+i];
//  stroke(84,0,99,360);
//  
//  line(ninth.x, ninth.y, ninth.x + (ninth.w), ninth.y);
//  }
//}




  // draw grid
  strokeWeight(1);
  grid.display();
  
//      save("cover.tif");
}

void keyPressed()
{
  if (key == 'p') {
    endRecord();

    exit();
    
  }
}


