//--クリック
void mousePressed(){
    click();
}

void click(){
    int mx = mouseX, my = mouseY, id;
    color[] col = {#FF0080, #FF00FF, #FF80FF, #FF0000, #800000};

    for (int i = 0; i < 10; i++) {
        id = getemptyID(sp);
        //スパークル表示オーバー対策
        if (id != -1) {
            sp[id] = new Sparcle(
                int(random(2)) + 1,6, //動作タイプ、表示タイプ 
                10, //サイズ
                10.0, //速度
                col[int(random(5))], //色
                random(width), random(height), random(0) //座標、角度
            );
        }
    }
}

//--空きID取得
int getemptyID(Sparcle sps[]) {
    for (int i = 0; i < sps.length; i++) {
        if (sps[i].status == -1) return i;
    }
    return -1;
}
