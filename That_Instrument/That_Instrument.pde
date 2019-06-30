//--
Sparcle sp[] = new Sparcle[200];

//--
void setup() {
  size(500,400, P3D);
  //fullScreen(P3D);
  //noCursor();
  
  //--スパークル初期化
  for (int i = 0; i < sp.length; i++) {
    sp[i] = new Sparcle(0, 0, 0, 0, 0, 0, 0);
    sp[i].status = -1;
  }
}

void draw() {
  background(0);
  //--各スパークルの描画
  for (int i = 0; i < sp.length; i++) {
    sp[i].move();
  }
}
