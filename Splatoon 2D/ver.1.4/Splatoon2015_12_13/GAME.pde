void drawGame() {  
  //プレイヤー弾丸処理
  /*for(int i=0;i<num;i++){
    Shooters[i].drawBullet();
  }*/
  Players.drawBullet() ;
  
  //プレイヤー描画
  Players.drawPlayer();
  for (int i=0; i <4; i++) {
    COMs[i].drawCPU(img2[i]);
  }
  for (int i=4; i<7; i++) {
    COMs[i].drawCPU(img1[i-3]);
  }
  if (millis()-time >= 1000000000) {
    save("result.png");
    buttleBGM.pause();
    gameMode=2;
  }
}

