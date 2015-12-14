void Init(){
  gameMode = 0;
  imageMode(CENTER);
  //c = new color[25][50];     //縦横の地面の円の数
  //aaa = new int[25][50];                              //どっちの色が最後に塗られたかを判定
  
  img1 = new PImage[4];                                //味方アイコン
  img2 = new PImage[4];                               //敵アイコン
  imgResult1 = loadImage("ikaGirl.png");
  imgResult2 = loadImage("ikaBoy.png");                                //アイコン画像の中心を中心の座標にする
  
  COMs = new CPU[numberOfcoms];
  for (int i=0; i < 4; i++) {
    COMs[i] = new CPU(width, (i+1)*height/5,COMcol);
  }
  for (int i=4; i <7; i++) {
    COMs[i] = new CPU(0, (i-2)*height/5, COMFcol);
  }
  for (int j=0; j < 4; j++) {
    img1[j] = loadImage("ikaGirl.png");
    img2[j] = loadImage("ikaBoy.png");
  }
  /*flipped = new boolean[25][50];
  flippedF = new boolean[25][50];
  for (int y=0; y<c.length; y++) {
    for (int x=0; x<c[0].length; x++) {
      flipped[y][x] = false;              //ウィンドウ上の円の色状態
      flippedF[y][x] = false;             //ウィンドウ上の円の色状態
      aaa[y][x]=0;
    }
  }*/
  angle = 90;                            //プレイヤ―の向き初期値
  xPlayer=r;                             //プレイヤーのx座標初期値
  yPlayer=height/5;
  
  minim = new Minim(this);
  player = minim.loadFile("startBGM.mp3");
  buttleBGM = minim.loadFile("buttleBGM.mp3");
  winBGM = minim.loadFile("winBGM.mp3");
  loseBGM = minim.loadFile("loseBGM.mp3");
  player.loop();
  //gameMode0
  start = loadImage("paint.png");
  fontStart = loadFont("HGSoeiKakupoptai-48.vlw");
  textFont(fontStart, 100);
  splatoooon = "Splatoon";
  startButton = "Press [S]!!!";
  
  Shooters = new Shooter[num];
  for(int i=0;i<num;i++){
    Shooters[i] = new Shooter(-100,-100);
    Shooters[i].setupBullet();
  }
}
  
