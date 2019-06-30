//--クリック
void mousePressed() {
  int mx = mouseX, my = mouseY, id;

  switch(2) {
    //--0:バブル風
  case 0:
    for (int i = 0; i < 10; i++) {
      id = getemptyID(sp);
      //スパークル表示オーバー対策
      if (id != -1) {
        sp[id] = new Sparcle(
          3, 0, //動作タイプ、表示タイプ 
          (int)random(20) + 10, //サイズ
          color(#88CCCC), //色
          mx+random(120)-70, my+random(120)-70, random(360)); //座標、角度
      }
    }
    break;

    //--1:ライン
  case 1:
    float angle = random(360);
    for (int i = 0; i < (int)random(2)+1; i++) {
      id = getemptyID(sp);
      //スパークル表示オーバー対策
      if (id != -1) {
        sp[id] = new Sparcle(
          3, 5, //動作タイプ、表示タイプ 
          70, //サイズ
          color(#88CCCC), //色
          mx, my, angle); //座標、角度
        angle += random(100) - 50;
      }
    }
    break;

  }
}

//--空きID取得
int getemptyID(Sparcle sps[]) {
  for (int i = 0; i < sps.length; i++) {
    if (sps[i].status == -1) return i;
  }
  return -1;
}
