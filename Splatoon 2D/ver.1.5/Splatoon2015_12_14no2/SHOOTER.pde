class Ink {
  float xInk;                      //弾が着弾する位置
  float yInk;                      //弾が着弾する位置
  PImage OrangeInk1;                  //インク画像
  int inkRandom;                      //どのインクを選ぶか決める
  int expention=1;                    //インク画像サイズ
  boolean exCount;                    //弾が着弾したかどうかを決める

  Ink(float x, float y) {
    xInk = x;
    yInk = y;
  }
  void setupInk() {
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
  }

  void drawInk() {                              //インク描画メソッド

   /* if (BulletJudge) {
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
    }*/
    if (exCount) {                              //弾が着弾したら
      expention += 10;                          //インク画像サイズをだんだん大きくする（ピシャッを表現）
      if (expention >= 50) {                    //インク画像のサイズが上限になったら
        //expention = 50;
        exCount = false;                        //インク画像サイズ固定
      }
    }


    pushMatrix();
    translate(xInk, yInk);                        
    image(OrangeInk1, 0, 0, expention, expention);      //インク画像描画
    popMatrix();
  }


  void ExceptionInit() {                              //インクの最大個数を超え再利用するとき、画像サイズを初期化するため
    expention = 1;
  }
}

