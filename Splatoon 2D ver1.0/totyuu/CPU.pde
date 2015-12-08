class CPU {
  float xCPU;
  float yCPU;
  color colCPU;
  float dx,dy;
  int g;
  int angleCPU;
  int steps;

  
  CPU(float x,float y,color col){
    xCPU = x;    
    yCPU = y;
    colCPU = col;
    angleCPU = 270;
    steps = 0;             //歩幅
    g = int(random(4));    //進む方向
  }
  
  void drawCPU(PImage u){
    pushMatrix();
    translate(xCPU,yCPU);
    rotate(radians(angleCPU));
    fill(colCPU);
    image(u,0,0,30,30);
    popMatrix();
    if(steps == 0){
      steps = int(random(20,30));
      g = int(random(4));
      if(g == 0){
        dx = random(-1.1,-0.5);
        dy = 0;
        angleCPU = 270;
        
      }else if(g == 1){
        dx = 0;
        dy = random(-1.1,-0.5);
        angleCPU = 0;
        
      }else if(g == 2){
        dx = random(0.5,1.1);
        dy = 0;
        angleCPU = 90;
        
      }else if(g == 3){
        dx = 0;
        dy = random(0.5,1.1);
        angleCPU = 180;
        
      }
    }
    steps--;
    
    xCPU = xCPU + (5*dx);
    yCPU = yCPU + (5*dy);
    xCPU =constrain(xCPU,10,width-10);
    yCPU =constrain(yCPU,10,height-10);
    
  } 
}
