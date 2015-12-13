class Shooter {
  float xInk;                      //弾が着弾する位置
  float yInk;                      //弾が着弾する位置
  float pxInk1, pyInk1;          //発射した位置のプレイヤーの座標保存（不変）
  float pxInk2, pyInk2;          //発射後の弾丸座標（変化する）
  float BulletRange=100;          //射程距離
  PVector vBullet;                  //キャラとマウスのベクトル保存
  PImage OrangeInk1;                  //インク画像
  PImage BulletImage;                 //弾の画像
  int inkRandom;                      //どのインクを選ぶか決める
  int expention=1;                    //インク画像サイズ
  boolean exCount;                    //弾が打たれたかどうかを決める
  boolean BulletJudge=false;                //弾が存在してるかどうか
  Shooter(float x, float y) {
    xInk = x;
    yInk = y;
  }
  void setupBullet() {
    //インク画像設定
    inkRandom = int(random(3));
    switch(inkRandom) {
    case 0:
      OrangeInk1 = loadImage("CyanInkSplash1.png");
      break;

    case 1:
      OrangeInk1 = loadImage("CyanInkSplash2.png");
      break;

    case 2:
      OrangeInk1 = loadImage("CyanInkSplash3.png");
      break;
    }
    BulletImage = loadImage("inkGun.png");
  }

  void drawBullet() {

    if (BulletJudge) {
      vBullet = get_normalV(xInk-pxInk1, yInk-pyInk1);
      //弾丸移動
      pxInk2 += vBullet.x*6;
      pyInk2 += vBullet.y*6;
      pushMatrix();
      translate(pxInk2, pyInk2);
      image(BulletImage, 0, 0, 30, 30);
      popMatrix();

      if (BulletRange<dist(pxInk1, pyInk1, pxInk2, pyInk2)) {
        BulletJudge = false;
        exCount = true;
      }
    }
    if (exCount) {
      expention += 10;
      if (expention >= 50) {
        //expention = 50;
        exCount = false;
      }
    }


    pushMatrix();
    translate(pxInk2, pyInk2);
    image(OrangeInk1, 0, 0, expention, expention);
    popMatrix();
  }


  PVector get_normalV(float vx, float vy) {
    PVector v = new PVector(vx, vy);
    v.normalize();
    //pxInk += v.x*2;
    //pyInk += v.y*2;
    return v;
  }
  void Init() {
    BulletJudge = true;
  }

  void Shori() {
    expention = 1;
  }
}

