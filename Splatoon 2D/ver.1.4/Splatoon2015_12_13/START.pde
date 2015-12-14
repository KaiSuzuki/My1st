void drawStart(){
  background(255);
  textAlign(CENTER, CENTER);
  image(start,width/2,height/2);
  pushMatrix();
  translate(width/3,2*height/3);
  rotate(radians(30));
  fill(0);
  textSize(80);
  text(splatoooon,0,0);
  popMatrix();
  fill(0,0,255);
  textSize(20);
  text(startButton,2*width/3,height-50);
}
