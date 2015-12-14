void drawPlayer() {
  pushMatrix();
  translate(xPlayer, yPlayer);
  rotate(radians(angle));
  fill(255, 180, 10);
  image(img1[0], 0, 0, 30, 30);
  popMatrix();
  xPlayer +=vx;
  yPlayer +=vy;
  if (w) {
    angle = 0;
    vx = 0;
    vy = -3;
    if (dash) {
      vy = -6;
      c1 = false;
    }
  }
  if (a) {
    angle = 270;
    vx = -3;
    vy = 0;
    if (dash) {
      vx = -6;
      c1 = false;
    }
  }
  if (s) {
    angle = 180;
    vx = 0;
    vy = 3;
    if (dash) {
      vy = 6;
      c1 = false;
    }
  }
  if (d) {
    angle = 90;
    vx = 3;
    vy = 0;
    if (dash) {
      vx = 6;
      c1 = false;
    }
  }

  if (c1) {      
      switch(angle){
        case 0:        //上方向を向いているならば      
  
        break;
        
        case 270:
        
        break;
        
        case 180:
        
        break;
        
        case 90:
        
        break;
      }
  }
    xPlayer = constrain(xPlayer, 10, width-10);
    yPlayer = constrain(yPlayer, 10, height-10);
}

