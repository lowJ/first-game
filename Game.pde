//change the theme of the map 
// you can choose, castle, choco, dirt,grass, purple, and sand
String mapType = "grass";

//edit the map
// you can edit the map by changing the values 
//any value that is greater than 0 will be the same block but may just look different
// 0 = empty space
// 1 = ground block
// 2 = underground block
//3  = left edge block
// 4 = right edge block
/////////////////////////////////////////////////////////
//you can uncommet and recommet some of these premade maps
//map "baisc"

//int[][] tiles =    {{1,0,0,0,0,0,0,0,0,0,0,0,0,1},
//                    {2,0,0,0,0,0,0,0,0,0,0,0,0,2},
//                    {2,0,0,3,1,1,1,1,1,1,4,0,0,2},
//                    {2,0,0,0,0,0,0,0,0,0,0,0,0,2},
//                    {2,0,0,0,0,0,0,0,0,0,0,0,0,2},
//                    {2,1,1,1,1,4,0,0,3,1,1,1,1,2},
//                    {2,2,2,2,2,0,0,0,0,2,2,2,2,2}}; 
                    
//map "tunnels"

int[][] tiles =     {{1,0,3,1,1,1,1,1,1,1,1,4,0,1},
                     {2,0,0,2,2,0,2,2,0,2,2,0,0,2},
                     {2,0,0,0,0,0,0,0,0,0,0,0,0,2},
                     {2,0,3,1,1,0,1,1,0,1,1,4,0,2},
                     {2,0,0,2,2,0,2,2,0,2,2,0,0,2},
                     {2,0,0,0,0,0,0,0,0,0,0,0,0,2},
                     {2,1,1,1,1,1,1,1,1,1,1,1,1,2}};
//map "platform"
//int[][] tiles =     {{1,0,0,0,0,0,0,0,0,0,0,0,0,1},
//                     {2,0,0,0,0,0,0,0,0,0,0,0,0,2},
//                     {2,0,3,4,0,0,0,0,0,0,3,4,0,2},
//                     {2,0,0,0,0,0,0,0,0,0,0,0,0,2},
//                     {2,0,0,0,0,0,3,4,0,0,0,0,0,2},
//                     {2,0,0,0,0,0,0,0,0,0,0,0,0,2},
//                     {2,0,1,1,0,0,0,0,0,0,1,1,0,2}};

//map "pit"

//int[][] tiles =      {{1,0,0,0,0,0,0,0,0,0,0,0,0,1},
//                     {2,0,0,0,0,0,3,4,0,0,0,0,0,2},
//                     {2,0,0,0,0,0,0,0,0,0,0,0,0,2},
//                     {2,3,4,0,0,0,0,0,0,0,0,3,4,2},
//                     {2,0,0,0,0,0,3,4,0,0,0,0,0,2},
//                     {2,0,0,0,0,0,0,0,0,0,0,0,0,2},
//                     {2,1,1,1,1,0,0,0,0,1,1,1,1,2}}; 

             

float yOffset = 56;
float xOffset = 55;
float duckYoffset = 20;
boolean isWon = false;
boolean sKey = false;
boolean dKey = false;
boolean space = false;
boolean shift = false;
boolean wKey = false;
boolean aKey = false;
boolean jKey = false;
boolean kKey = false;
boolean nKey = false;
float healthBarW = 100;
float redW = 100;
float blueW = 100;
boolean lKey = false;
boolean iKey = false;
boolean semiKey = false;
float xpos;
float ypos;
boolean click1 = false;
boolean click2 = false;
boolean ifWon = false;
ArrayList<Orb> activeP = new ArrayList<Orb>();
Character player2 = new Character(1000-200, 300, 50, 69, 100, 0.7, 4, 6, 6, 100, "p2");
Character player1 = new Character(200, 300, 50, 69, 100, 0.7, 4, 6, 6, 100, "p1");
ArrayList<GameTile> map = new ArrayList<GameTile>();
void setup() {
  
  pixelDensity(displayDensity());
  size(980, 490, OPENGL);
  player2.loadAnimations();
  player1.loadAnimations();
  Map map1 = new Map(tiles, mapType);
  
  background(255);
  
}
void draw() {
  background(255);
  fill(255, 0, 0);
  for(int i = 0; i < map.size(); i++){
    map.get(i).drawTile();
  }
  player2.ifHit(); // checks if any players are hit by Orbs
  player1.ifHit();
  if(ifWon == false){
    player2.move2();//blue
    player1.move1();//red
  }
  
  player2.applyGravity(); // applies gravity
  player1.applyGravity();
  
  player2.keepUp(); // makes players stand and not go through tiles
  player1.keepUp();
  
  //showLines();
  
  player2.drawChar(); // draws the character and animations
  player1.drawChar();
  
  pCollision(); //checks if a Orb hits a tile, if so it gets removed
  
  drawP(); // draws and animates all the active Orbs
  
  //showCoords();
  displayHealth();
  drawHealthBars();
  checkIfWon();
  
}

void checkIfWon(){
  if(player2.health <= 0){
    ifWon = true;
    fill(200, 0, 0);
    textSize(50);
    text("red wins", width/2, height/2);
  }
  if(player1.health <= 0){
    textSize(50);
    ifWon = true;
    fill(0,0,200);
    text("blue wins", width/2, height/2);
  }
}

void showCoords() {
  textSize(12);
  fill(0, 102, 153);
  text(mouseX, 5, 10);
  text(mouseY, 30, 10);
}

void showLines(){
  for(int i = height; i > 0; i-= 70){
    line(0, i, width,i);
  }
  
  for(int i = 0; i < width; i += 70){
    line(i, 0, i, height);
  }
}
void drawHealthBars(){

  fill(200, 0, 0);
  rect(200, 25, 100, 10);
  rect((1000 - 200), 25, 100, 10);
  fill(0, 200, 0);
  rect(200, 25, player1.health, 10);
  rect((1000-200), 25, player2.health, 10);
  
}

void platformHelper(){
  if(mousePressed){
    click1 = true;
  }
  if(mousePressed){
    click2 = true;
  }
}

void pCollision(){
  for(int i = 0; i < activeP.size(); i++){
    if(activeP.get(i).removeIt){
      
      activeP.remove(i);
    }
  }
}

void drawP(){
  for(int i = 0; i < activeP.size(); i++){
        activeP.get(i).pDraw();
        activeP.get(i).pMove();
      }
}

void displayHealth(){
  fill(0,0,200);
  text(player2.health, 800, 10);
  fill(200,0,0);
  text(player1.health, 200, 10);
}
  void keyPressed() {
  switch (keyCode) {
  case 59://left
    semiKey = true;
    break;
  case 76://right
    lKey = true;
    break;
  case 75://up
    kKey = true;
    break;
  case 74://down
    jKey = true;
    break;
  case 73: //space
    iKey = true;
    break;
  case 78: //nKey
    nKey = true;
  }
  switch (keyCode) {
  case 65://left
    aKey = true;
    break;
  case 68://right
    dKey = true;
    break;
  case 87://up
    wKey = true;
    break;
  case 83://down
    sKey = true;
    break;
  case 32: //space
    space = true;
    break;
  case 16: //shift
    shift = true;
  }
}
void keyReleased() {
  switch (keyCode) {

  case 59://left
    semiKey = false;
    break;
  case 76://right
    lKey = false;
    break;
  case 75://up
    kKey = false;
    break;
  case 74://down
    jKey = false;
    break;
  case 73: //space
    iKey = false;
    break;
  case 78:
    nKey = false;
  }
  switch (keyCode) {
  case 65://left
    aKey = false;
    break;
  case 68://right
    dKey = false;
    break;
  case 87://up
    wKey = false;
    break;
  case 83://down
    sKey = false;
    break;
  case 32: //space
    space = false;
    break;
  case 16: //shift
    shift = false;
  }
}