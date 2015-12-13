//2015.12.6 ver.1.1
//シューターを使えるようにした
//2015.12.8 ver1.2

import ddf.minim.spi.*;         //minimライブラリインポート
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player;         //スタート画面BGM
AudioPlayer winBGM;
AudioPlayer loseBGM;
AudioPlayer buttleBGM;

int time =0;                //開始時刻を格納する変数

//gameMode0
String splatoooon;          //Start画面の文字
String startButton;        
PImage start;
PFont fontStart;

//gameMode1
boolean[][] flipped;          //敵色判定
boolean[][] flippedF;         //味方色判定
color[][] c; //インクの元
color friendOFcol=color(255, 0, 0);    //自分チームの塗る色
color enemyOFcol=color(0, 255, 0); 
color COMcol=color(85, 230, 205);
color COMFcol= color(255, 180, 10);
int angle;         //プレイヤー角度
int xPlayer;          //プレイヤー座標
int yPlayer;          //プレイヤー座標
float vx=0;          //x増加量
float vy=0;          //y増加量
int r=10;            //円の半径  
boolean w, a, s, d, c1, dash;//keyの状態保存
int numberOfcoms=7;  //CPUの数
int[][] aaa;        //色塗りの判定
CPU[] COMs;         //CPUクラスを呼び出す時に格納する変数
PImage[] img1, img2;
PImage imgResult1;
PImage imgResult2;

Weapon CharacterWeapon;        //Weaponクラスを呼び出すときに格納する変数
int buki;
int FiringRange;              //射程
int PowerRange;               //攻撃力
int bulletX,bulletY,bulletD;    //弾丸直径


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
  Init();
}


void draw() {
  println(millis(), gameMode);
  if (gameMode ==0) {
    drawStart();
  }
  if (gameMode==1) {
    background(255);
    drawGame();
  }
  //gameMode2
  if (gameMode==2) {
    drawResult();
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
  if (key == 'd') {
    dash = true;
  } else if (key == 's') {
    gameMode=1;
    time = millis();
    player.pause();
    buttleBGM.loop();
  }
  if (key == 'r') {
    loop();
    if (gameMode==2) {
      Init();
      if (countF>count) {
        winBGM.pause();
      } else if (countF<count) {
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
  if (key == 'd') {
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



