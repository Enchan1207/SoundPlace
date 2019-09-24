//--
Sparcle sp[] = new Sparcle[4096];
int sequencer[][] = { //シーケンサの状態
        {0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0}
    };

//--
void setup() {
    //size(500,400, P3D);
    fullScreen(P3D);
    noCursor();
    
    //--スパークル初期化
    for (int i = 0; i < sp.length; i++) {
        sp[i] = new Sparcle(0, 0, 0, 0, 0, 0, 0, 0);
        sp[i].status = -1;
    }

    //シーケンサに適当な値をぶち込む
    sequencer[2][7] = 1;
    sequencer[3][5] = 1;
}

void draw() {
    background(0);
    //--各スパークルの描画
    for (int i = 0; i < sp.length; i++) {
        // sp[i].move();
    }

    //--シーケンサ表示
    pushMatrix();
    // rotateX(radians(30));
    stroke(#FF0000);
    rect(30,30, width-60,90);
    popMatrix();
}
