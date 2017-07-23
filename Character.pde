class Character{
  Orb p;
  GameTile c;
  Orb currentP;
  int shootDelay = 15; //1- 59, 1 is fastest
  int shootDelayCounter; 
  int jump2ndDelay;
  int controlSet;
  boolean releasedSemi = false;
  float jumpUpSpeed = 20;
  float jumpFallSpeed = 0.9;
  float defaultJumpFallSpeed;
  float duckSpeed = 2;
  float speed = 5;
  float gravity = 6;
  float x;
  float vx;
  float vy;
  float jumpv;
  float y;
  float w;
  float health;
  float defaultH;
  float duckH;
  float h;
  String collisionSide;
  String pCollisionSide;
  float halfWidth;
  float halfHeight;
  boolean wReleasedInJump = false;
  boolean iReleasedInJump = false;
  boolean shooting = false;
  boolean wReleased = true;
  boolean strafe = false;
  boolean iReleased = true;
  boolean onPlatform = false;
  boolean moveRight = false;
  boolean moveLeft = false;
  boolean facingLeft = false;
  boolean facingRight = true;
  boolean ducking = false;
  String name;
  boolean isDead;
  boolean running = false;
  boolean releasedSpace = false;
  boolean isJumping = false;
  boolean has2ndJump = true;
  Animation rrun, ridle, lidle, lrun, jump, ljump, rduck, lduck, rswim, lswim, dead;
  Character(float xVal, float yVal, float wid, float hei){
    this.x = xVal;
    this.y = yVal;
    this.defaultH = hei;
    this.w = wid;
    this.h = hei;
    duckH = hei/2;
  }
  
   Character(float xVal, float yVal, float wid, float hei, float jumpUpSpeed, float jumpFallSpeed, float duckSpeed, float speed, float gravity, float health, String name){
    this.x = xVal;
    this.y = yVal;
    this.defaultH = hei;
    this.w = wid;
    this.h = hei;
    duckH = hei/2;
    this.jumpUpSpeed = jumpUpSpeed;
    this.jumpFallSpeed = jumpFallSpeed;
    this.duckSpeed = duckSpeed;
    this.speed = speed;
    this.gravity = gravity;
    defaultJumpFallSpeed = jumpFallSpeed;
    halfWidth = w/2;
    halfHeight = h/2;
    this.health = health;
    this.name = name;
  }
  void loadAnimations(){
    dead = new Animation("dead_", 2, 5);
    rswim = new Animation("swim_", 6, 4);
    lswim = new Animation("lswim_", 6, 4);
    lduck = new Animation("lduck_", 1, 5);
    rduck = new Animation("duck_", 1, 5);
    ridle = new Animation("idle_", 4, 5);
    lidle = new Animation("lidle_", 4, 5);
    rrun = new Animation("run_", 6, 5);
    lrun = new Animation("lrun_", 6, 5);
    jump = new Animation("jump_",4, 15);
    ljump = new Animation("ljump_", 4, 15);
  }
  
  void drawRedMark(){
    fill(200, 0, 0);
    triangle(x + (w/2), y - 20, x + (w/2) - 10, y - 30, x + (w/2) + 10, y - 30);
  }
  void drawBlueMark(){
    fill(0, 0, 200);
    triangle(x + (w/2), y - 20, x + (w/2) - 10, y - 30, x + (w/2) + 10, y - 30);
  }
  
  void animatePlayer(){
  if(!isJumping && !running && !ducking && facingRight && !isDead){
    ridle.display(x - xOffset, y - yOffset);
  }
  if(!isJumping && !running && !ducking && facingLeft && !isDead){
    lidle.display(x - xOffset, y - yOffset);
  }
  
  if(isJumping && facingRight && !ducking){
    jump.display(x - xOffset, y - yOffset);
  }
  if(isJumping && facingLeft && !ducking ){
    ljump.display(x - xOffset, y - yOffset);
  }
  
  if(!moveLeft && moveRight && !isJumping && !ducking && !strafe){ 
    rrun.display(x - xOffset, y - yOffset);
  }
  if(moveLeft && !moveRight && !isJumping && !ducking && !strafe){
    lrun.display(x - xOffset, y - yOffset);
  }
  if(strafe && facingLeft && (moveLeft || moveRight) && !ducking){
    lrun.display(x - xOffset, y - yOffset);
    
  }
  if(strafe && facingRight && (moveLeft || moveRight) && !ducking){
    rrun.display(x - xOffset, y - yOffset);
    
  }
  
  if(ducking && facingRight && !running && moveRight == false){
    rduck.display(x - xOffset, y - duckYoffset - yOffset);
  }
  if(ducking && facingLeft && !running && moveLeft == false){
    lduck.display(x - xOffset, y - duckYoffset - yOffset);
  }
  
  if(strafe && facingRight && ducking && (moveLeft || moveRight)){
    rswim.display(x - xOffset, y - yOffset);
    
  }
  
  if(strafe && facingLeft && ducking && (moveLeft || moveRight)){
    lswim.display(x - xOffset, y - yOffset);
    
  }
  if(ducking && facingRight && moveRight && !strafe){
    rswim.display(x - xOffset, y - yOffset);
    //println("sd");
  }
  //System.out.println(moveRight);
  //System.out.println(facingRight);
  if(ducking && facingLeft && moveLeft && !strafe){
    lswim.display(x - xOffset, y - yOffset);
  }
  if(isDead){
    dead.display(x - xOffset, y - yOffset);
  }
}
  void drawChar(){
    //fill(0, 255, 0);
    //rect(x, y, w, h);
    animatePlayer();
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
            println("top");
            y += overlapY;
          }if(dy <= 0){
            collisionSide = "bottom";
            y -= overlapY;
          }
        }else if(dy >0){
          System.out.println("dfsf" + dy);
          if(dx < 0){
            collisionSide = "right";
            x -= overlapX;
          }
          else {//fix important
            collisionSide = "left";
            x += overlapX;
          }
        }
      } else {
        collisionSide = "none";
      }
    }else {
      collisionSide = "none";
    }
  }
  
  void keepUp(){//fix
    for(int i = 0; i < map.size() - 1; i++){
      c = map.get(i);
      rectangleCollisions(c);
      if(collisionSide.equals("bottom")){
        isJumping = false; //fix
        onPlatform = true;
        has2ndJump = true;
      }
    }
    if(!(y <= height + 100  && y> 0 - 100 && x > 0 - 100  && x < width + 100)){
      health --;
    }
  }
     
  void applyGravity(){
    vy += gravity;
  }
  void ifHit(){
    for(int i = 0; i < activeP.size(); i++){
      pCollisions(activeP.get(i));
      if(!pCollisionSide.equals("none") && !(activeP.get(i).shooter.equals(name))){
        health -= activeP.get(i).damage;
        activeP.remove(i);
        if(health <= 0){
          isDead = true;
        }
      }
    }
    if(health <= 0){
      health = 0;
    }
    
  }
  
  void move1(){
    if(aKey){
      if(sKey == true){
        vx = -duckSpeed;
      }
      else{
        running = true;
        vx = -speed;
      }
      if(shift){
        strafe = true;
        moveLeft = true;
        moveRight = false;
      }
      else{
        moveLeft = true;
        facingLeft = true;
        moveRight = false;
        facingRight = false;
        strafe = false;
      }
      
    }
    
    if(dKey){
     if(sKey == true){
       vx = duckSpeed;
     }
     else{
       vx = speed;
       running = true;
     }
     if(shift){
       strafe = true;
       moveLeft = false;
       moveRight = true;
       
     }
     else{
       moveRight = true;
       facingRight = true;
       moveLeft = false;
       facingLeft = false;
       strafe = false;
     }
     
    }
    
    if(aKey == false && dKey == false || aKey && dKey){
      vx = 0;
      moveRight = false;
      moveLeft = false;
      running = false;
    }
    if(wKey){
      if(onPlatform == true && isJumping == false && wReleased){
        jump2ndDelay =0;
        isJumping = true;
        wReleased = false;
        vy = -jumpUpSpeed;
        onPlatform = false;
      }
    }
    if(!wKey && onPlatform) wReleased = true;
    if(!wKey && isJumping == true && has2ndJump){
      wReleasedInJump = true;
    }
    if(!onPlatform && isJumping && has2ndJump && jump2ndDelay > 10 && wKey && wReleasedInJump){
        vy = -jumpUpSpeed;
        has2ndJump = false;
      }
    if(isJumping){
      jump2ndDelay++;
    }
    
    if(!isJumping && onPlatform){
      wReleasedInJump = false;
    }
    
    if(sKey){
      //fix so edits y coord instead of waiting for gravity to bring down
      if(isJumping && !onPlatform){
        jumpFallSpeed = .5; // fix
      }
      h = duckH;
      ducking = true;
      running = false;
    }
    
    if(sKey == false){
      jumpFallSpeed = defaultJumpFallSpeed;
      h = defaultH;
      ducking = false;
    }
    
    if(space){
      if(releasedSpace){
        releasedSpace = false;
        if(facingRight == true){
          Orb p = new Orb(x + w + 1, y + h/2, 10, 10, 8, 10, name);
          activeP.add(p);
          shooting = true;
        }
        if(facingLeft == true){
          Orb p = new Orb(x - 10, y + h/2, 10, 10, -8, 10, name);
          activeP.add(p);
          shooting = true;
        }
      }  
    }
    if(!space){
      releasedSpace = true;
    }
    
    if(onPlatform){
      isJumping = false;
    } // D = v(t) + 1/2a^2 1/60
    vy = vy *jumpFallSpeed;
    //keepUp();
    x +=vx;
    y +=vy;
    if(shootDelayCounter == 60){
      shootDelayCounter = 0;
    }
    shootDelayCounter++;
    drawRedMark();
  }
  void move2(){
    if(jKey){
      if(kKey == true){
        vx = -duckSpeed;
      }
      else{
        running = true;
        vx = -speed;
      }
      if(nKey){
        strafe = true;
        moveLeft = true;
        moveRight = false;
      }
      else{
        moveLeft = true;
        facingLeft = true;
        moveRight = false;
        facingRight = false;
        strafe = false;
      }
      
      
    }
    
    if(lKey){
     if(kKey == true){
       vx = duckSpeed;
     }
     else{
       vx = speed;
       running = true;
     }
     if(nKey){
       strafe = true;
       moveLeft = false;
       moveRight = true;
     }
     else{
       moveRight = true;
       facingRight = true;
       moveLeft = false;
       facingLeft = false;
       strafe = false;
     }
    }
    
    if(jKey == false && lKey == false || jKey && lKey){
      vx = 0;
      moveRight = false;
      moveLeft = false;
      running = false;
    }
    if(iKey){
      if(onPlatform == true && isJumping == false && iReleased){
        jump2ndDelay =0;
        isJumping = true;
        iReleased = false;
        vy = -jumpUpSpeed;
        onPlatform = false;
      }
    }
    if(!iKey && onPlatform) iReleased = true;
    if(!iKey && isJumping == true && has2ndJump){
      iReleasedInJump = true;
    }
    if(!onPlatform && isJumping && has2ndJump && jump2ndDelay > 10 && iKey && iReleasedInJump){
        vy = -jumpUpSpeed;
        has2ndJump = false;
      }
    if(isJumping){
      jump2ndDelay++;
    }
    
    if(!isJumping && onPlatform){
      iReleasedInJump = false;
    }
    
    if(kKey){
      //fix so edits y coord instead of waiting for gravity to bring down
      if(isJumping && !onPlatform){
        jumpFallSpeed = .5; // fix
      }
      h = duckH;
      ducking = true;
      running = false;
    }
    
    if(kKey == false){
      jumpFallSpeed = defaultJumpFallSpeed;
      h = defaultH;
      ducking = false;
    }
    
    if(semiKey){
      if(releasedSemi){
        releasedSemi = false;
        if(facingRight == true){
          //float x, float y, float w, float h, float s, float d, String shooter){
          Orb p = new Orb(x + w + 1, y + h/2, 10, 10, 8, 10, name);
          activeP.add(p);
          shooting = true;
        }
        if(facingLeft == true){
          Orb p = new Orb(x - 10, y + h/2, 10, 10, -8, 10, name);
          activeP.add(p);
          shooting = true;
        }
      }  
    }
    if(!semiKey){
      releasedSemi = true;
    }
    
    if(onPlatform){
      isJumping = false;
    } // D = v(t) + 1/2a^2 1/60
    vy = vy *jumpFallSpeed;
    x +=vx;
    y +=vy;
    drawBlueMark();
  }
  
    void playerCollisions(Character r2){
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
            pCollisionSide = "top";
            y += overlapY;
          }if(dy <= 0){
            pCollisionSide = "bottom";

            y -= overlapY;
          }
        }else{
          if (dx > 0){
            pCollisionSide = "left";
            x += overlapX;
          }else{
            pCollisionSide = "right";
            x -= overlapX;
          }
        }
      } else {
        pCollisionSide = "none";
      }
    }else {
      pCollisionSide = "none";
    }
  }

  
  void pCollisions(Orb r2){
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
            pCollisionSide = "top";
          }if(dy <= 0){
            pCollisionSide = "bottom";
          }
        }else{
          if (dx > 0){
            pCollisionSide = "left";
          }else{
            pCollisionSide = "right";

          }
        }
      } else {
        pCollisionSide = "none";
      }
    }else {
      pCollisionSide = "none";
    }
  }
}