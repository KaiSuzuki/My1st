class Bullet{
  float xPlayerInk2;                      //発射した瞬間のマウスの座標
  float yPlayerInk2;                      //発射した瞬間のマウスの座標
  float xPlayerInk1, yPlayerInk1;          //発射した位置のプレイヤーの座標保存（不変）
  float PlayerXBullet, PlayerYBullet;      //発射後の弾丸座標（変化する）
  float PlayerBulletRange=100;             //射程距離
  PVector vPlayerBullet;                  //キャラとマウスのベクトル保存(方向ベクトル）
  PImage PlayerBulletImage;                 //弾の画像
  boolean PlayerBulletJudge;                //弾が存在してるかどうか
  
  
  


  Bullet(float x, float y) {
    PlayerXBullet = x;
    PlayerYBullet = y;
  }
  
  void setupBullet() {                  //初期化処理、弾画像読み込み
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
  
  void drawBullet() {                    //弾描画
    //println(PlayerBulletJudge);
    if (PlayerBulletJudge) {                                  //弾が発射されたら
      
      vPlayerBullet = get_PlayernormalV(xPlayerInk2-xPlayerInk1,    //方向ベクトル作成＆保存
      yPlayerInk2-yPlayerInk1);
      //println(PlayerBulletCount,xPlayerInk1[0],xPlayerInk2[0],PlayerXBullet[0],vPlayerBullet[0].x);
      //弾丸移動
      PlayerXBullet += vPlayerBullet.x*6;                //弾の座標移動
      PlayerYBullet += vPlayerBullet.y*6;                //弾の座標移動
      pushMatrix();
      translate(PlayerXBullet, PlayerYBullet);            
      image(PlayerBulletImage, 0, 0, 30, 30);            //弾描画
      popMatrix();

      if (PlayerBulletRange<dist(xPlayerInk1, yPlayerInk1,   //弾が射程距離を超えたら（着弾したら）
      PlayerXBullet, PlayerYBullet)) {                      
        Inks[PlayerInkCount].xInk = PlayerXBullet;          //着弾した座標を保存（インクの描画に使うため）
        Inks[PlayerInkCount].yInk = PlayerYBullet;          //着弾した座標を保存（インクの描画に使うため）
        PlayerBulletJudge = false;                          //弾存在しない判定
        Inks[PlayerInkCount].exCount = true;                //着弾した判定
        PlayerInkCount++;                                   //インクが何発目かを更新
        if(PlayerInkCount == InkNum){                       //インクの最大個数を超えたら
          PlayerInkCount = 0;                                 //インク個数を初期化
        }
        Inks[PlayerInkCount].ExceptionInit();                //インクを再利用して描画するときに、画像を一度小さくして次の描画で拡大できるようにするため
      }
    }
  }
  
  PVector get_PlayernormalV(float vx, float vy) {            //方向ベクトル求めるメソッド　vx,vyにはそれぞれ二点間の座標の差を入れる（今回の場合、キャラ座標とマウス座標の差）
    PVector v = new PVector(vx, vy);                          //仮のベクトル作る
    v.normalize();                                            //正規化（長さを１にする）
    return v;
  }
  
  void PlayerBulletInit() {                                  //マウス押した時の処理
    xPlayerInk1 = Players.xPlayer;                           //方向ベクトル求める時に使用
    yPlayerInk1 = Players.yPlayer;                           //方向ベクトル求める時に使用
    xPlayerInk2 = mouseX;                                    //方向ベクトル求める時に使用
    yPlayerInk2 = mouseY;                                    //方向ベクトル求める時に使用
    PlayerXBullet = Players.xPlayer;                         //弾が発射されたときの初期の座標
    PlayerYBullet = Players.yPlayer;                         //弾が発射されたときの初期の座標
    PlayerBulletJudge = true;                                //弾が存在するという判定
  }
}
