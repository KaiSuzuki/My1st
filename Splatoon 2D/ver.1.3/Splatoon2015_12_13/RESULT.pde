void drawResult() {
  player.pause();
  noLoop();
  redraw();
  if (countF>count) {
    winBGM.loop();
  } else if (countF<count) {
    loseBGM.loop();
  }
  textAlign(CENTER, CENTER);
  font = loadFont("AgencyFB-Reg-48.vlw");
  textFont(font, 36);
  result = loadImage("result.png");
  int dimension = result.width * result.height;
  result.loadPixels();
  for (int i = 0; i < dimension; i ++) { 
    if (result.pixels[i] == friendOFcol) {
      countF++;
    } else if (result.pixels[i] == enemyOFcol) {
      count++;
    }
  }
  background(255);
  drawJudge();
}

void drawJudge(){
  fill(friendOFcol);
  text(countF,width/3,height/2);
  image(imgResult1,width/3,height/3);
  fill(enemyOFcol);
  text(count,2*width/3,height/2);
  image(imgResult2,2*width/3,height/3);
  if(countF>count){
    fill(255,80,205);
    text(win,width/3,2*height/3);
    fill(0,0,255);
    text(lose,2*width/3,2*height/3);
    winBGM.play();
  }else if(countF<count){ 
    fill(255,80,205);
    text(win,2*width/3,2*height/3);
    fill(0,0,255);
    text(lose,width/3,2*height/3);
    loseBGM.play();
  }
}

