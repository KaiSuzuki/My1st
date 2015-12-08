void drawGame() {
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
      if (aaa[k][l]==1) {                   
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
  if (millis()-time >= 30000) {
    save("result.png");
    buttleBGM.pause();
    gameMode=2;
  }
}

