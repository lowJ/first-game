abstract class Projectile {
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
  String shooter;
  String collisionSide  = "none";
  boolean removeIt = false;
  GameTile c;

  abstract void animate();

  void pDraw() {
    //move to different method
    for (int i = 0; i < map.size() - 1; i++) {
      c = map.get(i);
      rectangleCollisions(c);
    }
    fill(0, 0, 255);
    animate();
  }
  void rectangleCollisions(GameTile r2) {
    float dx = (x+w/2) - (r2.x+r2.w/2);
    float dy = (y+h/2) - (r2.y+r2.h/2);

    float combinedHalfWidths = halfWidth + r2.halfWidth;
    float combinedHalfHeights = halfHeight + r2.halfHeight;

    if (abs(dx) < combinedHalfWidths) {
      if (abs(dy) < combinedHalfHeights) {
        float overlapX = combinedHalfWidths - abs(dx);
        float overlapY = combinedHalfHeights - abs(dy);
        if (overlapX >= overlapY) {
          if (dy > 0) {
            collisionSide = "top";
            y += overlapY;
            removeIt = true;
          }
          if (dy <= 0) {
            collisionSide = "bottom";
            y -= overlapY;
            removeIt = true;
          }
        } else {
          if (dx > 0) {
            collisionSide = "left";
            x += overlapX;
            System.out.println("left");
            removeIt = true;
          } else {
            collisionSide = "right";
            x -= overlapX;
            System.out.println("right");
            removeIt = true;
          }
        }
      } else {
        collisionSide = "none";
      }
    } else {
      collisionSide = "none";
    }
  }

  void pMove() {
    x+= speed;
  }; //move the projectile
}