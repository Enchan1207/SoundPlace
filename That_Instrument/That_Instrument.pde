//--
Sparcle sp[] = new Sparcle[128];
int sequencer[][] = { //シーケンサの状態
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0}
};
color colortable[] = {
    #FF0000,
    #00FF00,
    #FF8000,
    #FFFF00
};
int lcnt = 0;

//--
void setup() {
    // size(1000,700, P3D);
    fullScreen(P3D);
    noCursor();
    
    //--スパークル初期化
    for (int i = 0; i < sp.length; i++) {
        sp[i] = new Sparcle(0, 0, 0, 0, 0, 0, 0, 0);
        sp[i].status = -1;
    }

    //シーケンサに適当な値をぶち込む
    for(int y = 0; y < 4; y++){
        for(int x = 0; x < 8; x++){
            sequencer[y][x] = int(random(2));
        }
    }
}

int cur = 0;
void draw() {
    background(0);
    //--各スパークルの描画
    for (int i = 0; i < sp.length; i++) {
        sp[i].move();
    }

    //--シーケンサ表示
    pushMatrix();
    rotateX(radians(45));

    int init_x = (width - (60*9)) / 2;
    int init_y = height - 350;
    
    //--動くライン
    noStroke();
    fill(#0000FF,128);
    rect((init_x + 50) + (60 * cur), init_y - 10, 60, 240);
    if(lcnt%10==0)cur++;
    if(cur > 7)cur = 0;

    //--ボタン
    noFill();
    for(int y = 0; y < 4; y++){
        for(int x = 0; x < 9; x++){
            strokeWeight((y * 2) + 2);
            stroke(colortable[y]);
            if(x != 0){
                rect(init_x + x * 60, init_y + y * 60, 40, 40);
            }else{
                ellipseMode(CORNER);
                ellipse(init_x, init_y + y * 60, 40, 40);
            }
        }
    }
    popMatrix();



    delay(1);
    lcnt++;
}
