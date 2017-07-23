class GameTile extends Tile{
  float tileSize = 70;
  float w;
  float h;
  GameTile(float xVar, float yVar, String ty, String fn){
    super(xVar, yVar, 70, 70, ty, fn);
    w = tileSize;
    h = tileSize;
    
  }
}