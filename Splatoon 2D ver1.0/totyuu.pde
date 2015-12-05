import ddf.minim.spi.*;         //minimライブラリインポート
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player;         //スターと画面BGM
AudioPlayer winBGM;
AudioPlayer loseBGM;
AudioPlayer buttleBGM;

int time =0;                //開始時刻を格納する変数
//final homework15

//gameMode0
String splatoooon;
String startButton;
PImage start;
PFont fontStart;

//gameMode1
boolean[][] flipped;          //味方色判定
boolean[][] flippedF;         //敵色判定
color[][] c; //インクの元
color friendOFcol=color(255, 0, 0);    //自分チームの塗る色
color enemyOFcol=color(0, 255, 0); 
color COMcol=color(85, 230, 205);
color COMFcol= color(255, 180, 10);
float angle;         //プレイヤー角度
int xPlayer;          //プレイヤー座標
int yPlayer;          //プレイヤー座標
float vx=0;          //x増加量
float vy=0;          //y増加量
int r=10;            //円の半径  
boolean w, a, s, d, c1,dash;//keyの状態保存
int numberOfcoms=7;  //CPUの数
int[][] aaa;        //色塗りの判定
CPU[] COMs;         //敵CPU
PImage[] img1, img2;
PImage imgResult1;
PImage imgResult2;


//gameMode2
PFont font;
PImage result;
int gameMode=0;
int count=0;
int countF=0;



String win ="WIN";
String lose = "LOSE";


void setup() {
  size(1000, 500);
  smooth();
  c = new color[25][50];                              //縦横の地面の円の数
  aaa = new int[25][50];                              //どっちの色が最後に塗られたかを判定
  
  img1 = new PImage[4];                                //味方アイコン
  img2 = new PImage[4];                               //敵アイコン
  imgResult1 = loadImage("ikaGirl.png");
  imgResult2 = loadImage("ikaBoy.png");
  imageMode(CENTER);                                //アイコン画像の中心を中心の座標にする
  
  COMs = new CPU[numberOfcoms];
  for (int i=0; i < 4; i++) {
    COMs[i] = new CPU(width, (i+1)*height/5,COMcol);
  }
  for (int i=4; i <7; i++) {
    COMs[i] = new CPU(0, (i-2)*height/5, COMFcol);
  }
  for (int j=0; j < 4; j++) {
    img1[j] = loadImage("ikaGirl.png");
    img2[j] = loadImage("ikaBoy.png");
  }
  flipped = new boolean[25][50];
  flippedF = new boolean[25][50];
  for (int y=0; y<c.length; y++) {
    for (int x=0; x<c[0].length; x++) {
      flipped[y][x] = false;              //ウィンドウ上の円の色状態
      flippedF[y][x] = false;             //ウィンドウ上の円の色状態
      aaa[y][x]=0;
    }
  }
  angle = 90;                            //プレイヤ―の向き初期値
  xPlayer=r;                             //プレイヤーのx座標初期値
  yPlayer=height/5;
  minim = new Minim(this);
  player = minim.loadFile("startBGM.mp3");
  buttleBGM = minim.loadFile("buttleBGM.mp3");
  winBGM = minim.loadFile("winBGM.mp3");
  loseBGM = minim.loadFile("loseBGM.mp3");
  player.loop();


  //gameMode0
  start = loadImage("paint.png");
  fontStart = loadFont("HGSoeiKakupoptai-48.vlw");
  textFont(fontStart, 100);
  splatoooon = "Splatoooon";
  startButton = "Press [S]!!!";
}

void draw() {
  println(millis(),gameMode);
  if (gameMode ==0) {
    drawStart();
  }
  if (gameMode==1) {
    background(255);
    for (int y=0; y<c.length; y++) {
      for (int x=0; x<c[0].length; x++) {
        if (flippedF[y][x]) {                    //左からx番目、上からy番目の円の色塗り状態が真の時
          fill(friendOFcol);                     //その座標の円を味方の色で塗る
        } else if (flipped[y][x]) {              //左からx番目、上からy番目の円の色塗り状態が真の時
          fill(enemyOFcol);                      //その座標の円を敵の色で塗る
        } else {
          fill(255);                             //どっちでもない時は白で塗る
        }
        noStroke();
        ellipse(2*r*x+r, 2*r*y+r, 2*r, 2*r);    //ウィンドウ上に円を描く
      }
    }
    for (int k=0; k<c.length; k++) {
      for (int l=0; l<c[0].length; l++) {
        if (aaa[k][l]==1) {                   //
          fill(friendOFcol);

          noStroke();
          ellipse(2*r*l+r, 2*r*k+r, 2*r, 2*r);
        } else if (aaa[k][l]==2) {
          fill(enemyOFcol);


          noStroke();
          ellipse(2*r*l+r, 2*r*k+r, 2*r, 2*r);
        }
      }
    }
    drawPlayer();
    for (int i=0; i <4; i++) {
      COMs[i].drawCPU(img2[i]);
      aaa[int(COMs[i].yCPU)/20][int(COMs[i].xCPU)/20]=2;
      flipped[int(COMs[i].yCPU)/20][int(COMs[i].xCPU)/20] = true;
    }
    for (int i=4; i<7; i++) {
      COMs[i].drawCPU(img1[i-3]);
      aaa[int(COMs[i].yCPU)/20][int(COMs[i].xCPU)/20]=1;
      flippedF[int(COMs[i].yCPU)/20][int(COMs[i].xCPU)/20] = true;
    }
    if (millis()-time >= 60000) {
      save("result.png");
      buttleBGM.pause();
      gameMode=2;
    }
  }

  //gameMode2
  if (gameMode==2) {
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
}


void keyPressed() {
  switch(keyCode) {
  case LEFT:
    a = true;
    break;

  case DOWN:
    s = true;
    break;

  case UP:
    w = true;
    break;

  case RIGHT:
    d = true;
    break;
  }
  if (key == 'c') {
    c1 = true;
  }
  if(key == 'd'){
    dash = true;
  }else if (key == 's') {
    gameMode=1;
    time = millis();
    player.pause();
    buttleBGM.loop();
  }
  if (key == 'r'){
    loop();
    if(gameMode==2){
    inIt();
    if(countF>count){
      winBGM.pause();
    }else if(countF<count){
      loseBGM.pause();
    }
    }
  }
}

void keyReleased() {
  switch(keyCode) {
  case UP:
    w = false;
    vx = vy = 0;
    break;
  case LEFT:
    a = false;
    vx = vy = 0;
    break;
  case DOWN:
    s = false;
    vx = vy = 0;
    break;
  case RIGHT:
    d = false;
    vx = vy = 0;
    break;
  }
  if (key == 'c') {
    c1 = false;
  }
  if(key == 'd'){
    dash = false;
  }
}

void stop() {
  player.close();
  winBGM.close();
  loseBGM.close();
  minim.stop();
  super.stop();
}

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
    //xPlayer +=vx;
    //yPlayer +=vy;
    if(dash){
      vy = -6;
      c1 = false;
    }
  }
  if (a) {
    angle = 270;
    vx = -3;
    vy = 0;
    //xPlayer +=vx;
    //yPlayer +=vy;
    if(dash){
      vx = -6;
      c1 = false;
    }
  }
  if (s) {
    angle = 180;
    vx = 0;
    vy = 3;
    //xPlayer +=vx;
    //yPlayer +=vy;
    if(dash){
      vy = 6;
      c1 = false;
    }
  }
  if (d) {
    angle = 90;
    vx = 3;
    vy = 0;
    //xPlayer +=vx;
    //yPlayer +=vy;
    if(dash){
      vx = 6;
      c1 = false;
    }
  }
    
  if (c1) {
    flippedF[yPlayer/20][xPlayer/20] = true;

    aaa[yPlayer/20][xPlayer/20]=1;
  }
  xPlayer = constrain(xPlayer, 10, width-10);
  yPlayer = constrain(yPlayer, 10, height-10);
}

