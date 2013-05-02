import processing.pdf.*;

import toxi.color.*;
import toxi.color.theory.*;
import toxi.util.datatypes.*;

int rectSize = 10;
float spacing = 5;

void setup()
{
  size(1280, 600);

  beginRecord(PDF, "pdfs/" + getClass().getName() + "_" + year() + "_" + month() + "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + ".pdf");

  background(255);
  noStroke();
  smooth();
  colorMode(HSB, 1, 1, 1);

  // ---------------------- create your color theme
  ColorTheme t = new ColorTheme("anns theme");

  // ---------------------- add pre-defined colorrange objects
  t.addRange("saddlebrown", 0.05);  // change to red, orange, yellow, green
  t.addRange("dark teal", 0.05);
  t.addRange("fresh yellow", 0.05);

  // ---------------------- add color range object ranges of hue, saturation and brightness
  FloatRange h = new FloatRange(0.9, 0.93);
  FloatRange s = new FloatRange(0.01, 0.11);
  FloatRange b = new FloatRange(0.99, 1);
  ColorRange range = new ColorRange(h, s, b, "anns range");
  t.addRange(range, null, 0.08);

  // ---------------------- get 4 random colors from the theme
  ColorList randomList = t.getColors(50);

  // ---------------------- draw
  translate(30, 30);
  int xPos = 0;

  for (Iterator i = randomList.iterator(); i.hasNext();) {
    TColor c = (TColor) i.next();
    fill(c.hue(), c.saturation(), c.brightness());

    rect(xPos, 0, rectSize/2, rectSize);
    ellipse(xPos, 30, rectSize, rectSize);
    rect(xPos, 60, rectSize/2, rectSize);
    rect(xPos, 70, rectSize, rectSize);

    rect(xPos, 100, rectSize/2, rectSize);
    ellipse(xPos, 130, rectSize, rectSize);
    rect(xPos, 160, rectSize/2, rectSize);
    rect(xPos, 170, rectSize, rectSize);

    rect(xPos, 200, rectSize/2, rectSize);
    ellipse(xPos, 230, rectSize, rectSize);
    rect(xPos, 260, rectSize/2, rectSize);
    rect(xPos, 270, rectSize, rectSize);

    rect(xPos, 300, rectSize/2, rectSize);
    ellipse(xPos, 330, rectSize, rectSize);
    rect(xPos, 360, rectSize/2, rectSize);
    rect(xPos, 370, rectSize, rectSize);



    xPos += rectSize + spacing;
  }
  endRecord();
}

