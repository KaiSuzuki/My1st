void drawPlayer() {
  if (buki == 1) {
    CharacterWeapon.Shooter();
  }
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
    switch(buki) {
    case 1:      //上方向を向いているならば
      switch(angle){
        case 0:        //シューターならば
        if (yPlayer/20 >=FiringRange) {                                  //fはとりあえず射程距離を表す
          flippedF[yPlayer/20-FiringRange][xPlayer/20] = true;
          aaa[yPlayer/20-FiringRange][xPlayer/20]=1;
        }
        break;
        
        case 270:
        if (FiringRange <= xPlayer/20 ) {                                  //fはとりあえず射程距離を表す
          flippedF[yPlayer/20][xPlayer/20-FiringRange] = true;
          aaa[yPlayer/20][xPlayer/20-FiringRange]=1;
        }
        break;
        
        case 180:
        if (height-FiringRange >= yPlayer/20 ) {                                  //fはとりあえず射程距離を表す
          flippedF[yPlayer/20+FiringRange][xPlayer/20] = true;
          aaa[yPlayer/20+FiringRange][xPlayer/20]=1;
        }
        break;
        
        case 90:
        if (width-FiringRange >= xPlayer/20 ) {                                  //fはとりあえず射程距離を表す
          flippedF[yPlayer/20][xPlayer/20+FiringRange] = true;
          aaa[yPlayer/20][xPlayer/20+FiringRange]=1;
        }
        break;
      }
      break;
    }
    xPlayer = constrain(xPlayer, 10, width-10);
    yPlayer = constrain(yPlayer, 10, height-10);
  }
}

