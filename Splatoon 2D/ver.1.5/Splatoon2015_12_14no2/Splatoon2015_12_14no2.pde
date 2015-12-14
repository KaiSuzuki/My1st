//2015.12.6 ver.1.1
//シューターを使えるようにした

//2015.12.8 ver1.2
//色塗りシステム大幅変更
//弾発射可能（色は塗れない）

//2015.12.13 ver1.3
//色塗り可能

//2015.12.13.ver1.4
//Playerクラス実装（元々ただの関数だった）

//2015.12.14 ver1.5
//Shooterクラスの構成変更、Buleltクラスの作成



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

//gameMode0  スタート画面
String splatoooon;          //Start画面の文字
String startButton;        
PImage start;
PFont fontStart;

//gameMode1  ゲーム画面
color friendOFcol=color(255, 0, 0);    //自分チームの塗る色
color enemyOFcol=color(0, 255, 0); 
color COMcol=color(85, 230, 205);
color COMFcol= color(255, 180, 10);

//float xPlayer;          //プレイヤー座標
//float yPlayer;          //プレイヤー座標
float vx=0;          //プレイヤーx増加量
float vy=0;          //プレイヤーy増加量
float r=10;            //円の半径  //プレイヤーのx座標初期値
boolean w, a, s, d, c1, dash;//keyの状態保存
int numberOfcoms=7;  //CPUの数
int[][] aaa;        //色塗りの判定
CPU[] COMs;         //CPUクラスを呼び出す時に格納する変数
Player Players;
PImage[] img1, img2;      //キャラ画像
PImage imgResult1;      //リザルト画面キャラ画像
PImage imgResult2;      //リザルト画面キャラ画像

//保留中
int buki;
int FiringRange;              //射程
int PowerRange;               //攻撃力



//gameMode2  リザルト画面
PFont font;
PImage result;
int gameMode=0;
int count=0;
int countF=0;
String win ="WIN";
String lose = "LOSE";


//Shooterクラス設定
//Shooter[] Shooters;
//int Bulletcount=0;                    //何発目の弾か

Bullet Bullets[];
int BulletNum=10;                        //プレイヤー弾数
int PlayerBulletCount=0;                //何発目の弾か

Ink Inks[];
int InkNum = 100;                      //インクの個数
int PlayerInkCount=0;                    //何発目のインクか
void setup() {
  size(1000, 500);
  smooth();
  Init();
}


void draw() {
  //println(Shooters[0].pxInk1, Shooters[0].pyInk1, Shooters[0].pxInk2, Shooters[0].pyInk2);
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

void mousePressed() {
  /*Shooters[Bulletcount].xInk = mouseX;
   Shooters[Bulletcount].yInk = mouseY;
   Shooters[Bulletcount].pxInk1 = Players.xPlayer;
   Shooters[Bulletcount].pyInk1 = Players.yPlayer;
   Shooters[Bulletcount].pxInk2 = Players.xPlayer;
   Shooters[Bulletcount].pyInk2 = Players.yPlayer;
   Shooters[Bulletcount].Init();
   Bulletcount++;
   if(Bulletcount == num){
   Bulletcount = 0;
   }
   Shooters[Bulletcount].Shori();*/
  Bullets[PlayerBulletCount].PlayerBulletInit();        //発射した時の座標保存もろもろ
  PlayerBulletCount++;                                  //何発目かのカウント増やす
  if (PlayerBulletCount == BulletNum) {                 //最大弾数までいったら初期化
    PlayerBulletCount = 0;
  }
}

void stop() {
  player.close();
  winBGM.close();
  loseBGM.close();
  minim.stop();
  super.stop();
}


