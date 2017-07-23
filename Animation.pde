class Animation {
  float everyFrame; //determines when to change to next frame. for example 1 would play the frames at 60fps
  PImage[] images;
  int imageCount;
  int frame;
  int frameCounter;
  
  Animation(String imagePrefix, int count, int ef) {
    everyFrame = ef;
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 1) + ".png";

      images[i] = loadImage(filename);
    }
  }

  void display(float xpos, float ypos) {
    if(frameCounter % everyFrame == 0){
      frame = (frame+1) % imageCount;
      
    }
    image(images[frame], xpos, ypos);
    frameCounter++;
    if(frameCounter >= 60) frameCounter = 1;
  }
  
  int getWidth() {
    return images[0].width;
  }
}