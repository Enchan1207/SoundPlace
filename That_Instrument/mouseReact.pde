//--クリック
void mousePressed() {
    int mx = mouseX, my = mouseY, id;

    switch(0) {
        case 0: //バブル
            for (int i = 0; i < 32; i++) {
                id = getemptyID(sp);
                //スパークル表示オーバー対策
                if (id != -1) {
                    sp[id] = new Sparcle(
                        2, 6, //動作タイプ、表示タイプ 
                        30, //サイズ
                        10.0, //速度
                        color(#FF00FF), //色
                        random(width), random(height), random(0) //座標、角度
                    );
                }
            }
            break;
        case 1: //ライン
            float angle = random(360);
            for (int i = 0; i < (int)random(2)+1; i++) {
                id = getemptyID(sp);
                //スパークル表示オーバー対策
                if (id != -1) {
                    sp[id] = new Sparcle(
                        3, 5, //動作タイプ、表示タイプ 
                        70, //サイズ
                        2, //速度
                        color(#88CCCC), //色
                        mx, my, angle //座標、角度
                    );
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
