void  inIt(){
  gameMode=0;
  COMs = new CPU[numberOfcoms];
  for (int i=0; i < 4; i++) {
    COMs[i] = new CPU(width, (i+1)*height/5,COMcol);
  }
  for (int i=4; i <7; i++) {
    COMs[i] = new CPU(0, (i-2)*height/5, COMFcol);
  }
  c = new color[25][50];
  aaa = new int[25][50];
  flipped = new boolean[25][50];
  flippedF = new boolean[25][50];
  for (int y=0; y<c.length; y++) {
    for (int x=0; x<c[0].length; x++) {
      flipped[y][x] = false;              //ウィンドウ上の円の色状態
      flippedF[y][x] = false;             //ウィンドウ上の円の色状態
      aaa[y][x]=0;
    }
  } 
  xPlayer=r;                             //プレイヤーのx座標初期値
  yPlayer=height/5;
}
