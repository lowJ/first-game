class Tile{
  float x; 
  float y;
  float w;
  float h;
  PImage img;
  float halfWidth;
  float halfHeight;
  String fileName;
  String type;
  String fn;
  String filenumber;
  Tile(float xVar, float yVar, float wid, float hei, String ty, String fn){
    this.x = xVar;
    this.y = yVar;
    this.w = wid;
    this.h = hei;
    this.type = ty;
    this.filenumber = fn;
    halfWidth = w/2;
    halfHeight = h/2;
    fileName = ty + "slice" + filenumber + ".png";
    img = loadImage(fileName);

  }
  
  
  void drawTile(){
    fill(85, 48, 0);
    //rect(x, y, w, h);
    image(img, x, y);
  }
  
  
}