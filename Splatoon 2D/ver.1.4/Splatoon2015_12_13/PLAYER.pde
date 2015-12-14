class Player {
  float xPlayer, yPlayer;
  int angle;         //プレイヤー角度

  //プレイヤー発射処理
  float[] xPlayerInk2;                      //弾が着弾する位置
  float[] yPlayerInk2;                      //弾が着弾する位置
  float[] xPlayerInk1, yPlayerInk1;          //発射した位置のプレイヤーの座標保存（不変）
  float[] PlayerXBullet, PlayerYBullet;          //発射後の弾丸座標（変化する）
  float PlayerBulletRange=100;          //射程距離
  PVector[] vPlayerBullet;                  //キャラとマウスのベクトル保存
  PImage PlayerBulletImage;                 //弾の画像
  boolean[] PlayerBulletJudge;                //弾が存在してるかどうか
  int PlayerBulletCount=0;


  Player(float x, float y,int a) {
    xPlayer = x;
    yPlayer = y;
    angle = a;                            //プレイヤ―の向き初期値
  }

  PVector get_PlayernormalV(float vx, float vy) {
    PVector v = new PVector(vx, vy);
    v.normalize();
    return v;
  }

  void PlayerBulletInit() {                                  //マウス押した時の処理
    xPlayerInk1[PlayerBulletCount] = xPlayer;
    yPlayerInk1[PlayerBulletCount] = yPlayer;
    xPlayerInk2[PlayerBulletCount] = mouseX;
    yPlayerInk2[PlayerBulletCount] = mouseY;
    PlayerXBullet[PlayerBulletCount] = xPlayer;
    PlayerYBullet[PlayerBulletCount] = yPlayer;
    PlayerBulletJudge[PlayerBulletCount] = true;
    PlayerBulletCount++;
    if (PlayerBulletCount == num) {
      PlayerBulletCount = 0;
    }
  }

  void setupPlayer() {
    xPlayerInk1 = new float[num];
    yPlayerInk1 = new float[num];
    xPlayerInk2 = new float[num];
    yPlayerInk2 = new float[num];
    PlayerXBullet = new float[num];
    PlayerYBullet = new float[num];
    vPlayerBullet = new PVector[num];
    PlayerBulletJudge = new boolean[num];
    PlayerBulletImage = loadImage("inkGun.png");
  }

  void drawBullet() {

    if (PlayerBulletJudge[PlayerBulletCount]) {
      vPlayerBullet[PlayerBulletCount] = get_PlayernormalV(xPlayerInk2[PlayerBulletCount]-xPlayerInk1[PlayerBulletCount], 
      yPlayerInk2[PlayerBulletCount]-yPlayerInk1[PlayerBulletCount]);
      //弾丸移動
      PlayerXBullet[PlayerBulletCount] += vPlayerBullet[PlayerBulletCount].x*6;
      PlayerYBullet[PlayerBulletCount] += vPlayerBullet[PlayerBulletCount].y*6;
      pushMatrix();
      translate(PlayerXBullet[PlayerBulletCount], PlayerYBullet[PlayerBulletCount]);
      image(PlayerBulletImage, 0, 0, 30, 30);
      popMatrix();

      if (PlayerBulletRange<dist(xPlayerInk1[PlayerBulletCount], yPlayerInk1[PlayerBulletCount], 
      PlayerXBullet[PlayerBulletCount], PlayerYBullet[PlayerBulletCount])) {
        PlayerBulletJudge[PlayerBulletCount] = false;
        //exCount = true;
      }
    }
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
      switch(angle) {
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
}

