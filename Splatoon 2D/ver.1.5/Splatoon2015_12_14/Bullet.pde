class Bullet{
  float xPlayerInk2;                      //弾が着弾する位置
  float yPlayerInk2;                      //弾が着弾する位置
  float xPlayerInk1, yPlayerInk1;          //発射した位置のプレイヤーの座標保存（不変）
  float PlayerXBullet, PlayerYBullet;          //発射後の弾丸座標（変化する）
  float PlayerBulletRange=500;          //射程距離
  PVector vPlayerBullet;                  //キャラとマウスのベクトル保存
  PImage PlayerBulletImage;                 //弾の画像
  boolean PlayerBulletJudge;                //弾が存在してるかどうか
  
  
  


  Bullet(float x, float y) {
    PlayerXBullet = x;
    PlayerYBullet = y;
  }
  
  void setupBullet() {
    /*xPlayerInk1 = new float[num];
    yPlayerInk1 = new float[num];
    xPlayerInk2 = new float[num];
    yPlayerInk2 = new float[num];
    PlayerXBullet = new float[num];
    PlayerYBullet = new float[num];
    vPlayerBullet = new PVector[num];
    PlayerBulletJudge = new boolean[num];*/
    PlayerBulletImage = loadImage("inkGun.png");
  }
  
  void drawBullet() {
    println(PlayerBulletJudge);
    if (PlayerBulletJudge) {
      
      vPlayerBullet = get_PlayernormalV(xPlayerInk2-xPlayerInk1, 
      yPlayerInk2-yPlayerInk1);
      //println(PlayerBulletCount,xPlayerInk1[0],xPlayerInk2[0],PlayerXBullet[0],vPlayerBullet[0].x);
      //弾丸移動
      PlayerXBullet += vPlayerBullet.x*6;
      PlayerYBullet += vPlayerBullet.y*6;
      pushMatrix();
      translate(PlayerXBullet, PlayerYBullet);
      image(PlayerBulletImage, 0, 0, 30, 30);
      popMatrix();

      if (PlayerBulletRange<dist(xPlayerInk1, yPlayerInk1, 
      PlayerXBullet, PlayerYBullet)) {
        PlayerBulletJudge = false;
        //exCount = true;
      }
    }
  }
  
  PVector get_PlayernormalV(float vx, float vy) {
    PVector v = new PVector(vx, vy);
    v.normalize();
    return v;
  }
  
  void PlayerBulletInit() {                                  //マウス押した時の処理
    xPlayerInk1 = Players.xPlayer;
    yPlayerInk1 = Players.yPlayer;
    xPlayerInk2 = mouseX;
    yPlayerInk2 = mouseY;
    PlayerXBullet = Players.xPlayer;
    PlayerYBullet = Players.yPlayer;
    PlayerBulletJudge = true;
  }
}
