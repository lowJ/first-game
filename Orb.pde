class Orb extends Projectile{
  float speed;
  float x;
  float y;
  float w;
  float h;
  float damage;
  float maxDist;
  float startX;
  float halfHeight;
  float halfWidth;
  float imageW = 60;
  float startY;
  String shooter;
  String collisionSide  = "none";
  boolean removeIt = false;
  Animation rshot, lshot;
  GameTile c;
  Orb (float x, float y, float w, float h, float s, float d, String shooter){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speed = s;
    this.damage = d;
    halfWidth = w/2;
    halfHeight = h/2;
    this.shooter = shooter;
    rshot = new Animation("rshot_", 6, 3);
    lshot = new Animation("lshot_", 6 , 3);
  }
  boolean ifRemove(){
    if(!collisionSide.equals("none")) return true;
    return false;
  }
  void pDraw(){
    //move to different method
    for(int i = 0; i < map.size() - 1; i++){
      c = map.get(i);
      rectangleCollisions(c);
    }
    fill(0,0,255);
    //rect(x, y, w, h);
    animate();
  }
  void animate(){
    if(speed < 0){
      lshot.display(x - (imageW/2) + w/2, y - (imageW/2) + (w/2));
    }
    if(speed > 0){
      rshot.display(x - (imageW/2) + w/2, y - (imageW/2) + (w/2));
    }
  }
  
  void rectangleCollisions(GameTile r2){
    float dx = (x+w/2) - (r2.x+r2.w/2);
    float dy = (y+h/2) - (r2.y+r2.h/2);
  
    float combinedHalfWidths = halfWidth + r2.halfWidth;
    float combinedHalfHeights = halfHeight + r2.halfHeight;
  
    if (abs(dx) < combinedHalfWidths){
      if (abs(dy) < combinedHalfHeights){
        float overlapX = combinedHalfWidths - abs(dx);
        float overlapY = combinedHalfHeights - abs(dy);
        if (overlapX >= overlapY){
          if (dy > 0){
            collisionSide = "top";
            y += overlapY;
            removeIt = true;
          }if(dy <= 0){
            collisionSide = "bottom";
            y -= overlapY;
            removeIt = true;
          }
        }else{
          if (dx > 0){
            collisionSide = "left";
            x += overlapX;
            System.out.println("left");
            removeIt = true;
          }else{
            collisionSide = "right";
            x -= overlapX;
            System.out.println("right");
            removeIt = true;
          }
        }
      } else {
        collisionSide = "none";
      }
    }else {
      collisionSide = "none";
    }
  }
  
  boolean ifOut(){
    if(x > width || x < 0 || y > height || y < 0){
      return true;
    }
    else{
      return false;
    }
  }
  
  void pMove(){
    x+= speed;
  }
}