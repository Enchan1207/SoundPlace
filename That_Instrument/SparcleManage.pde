/*
 * スパークルマネージャ
*/

class SparcleManager{
    //--
    static final int SPARCLE_MAX = 1024; //スパークル最大表示数
    Sparcle sp[] = new Sparcle[SPARCLE_MAX];

    //--スパークル初期化
    SparcleManager(){
        for (int i = 0; i < SPARCLE_MAX; i++) {
            sp[i] = new Sparcle(0, 0, 0, 0, 0, 0, 0, 0);
            sp[i].status = -1;
        }
    }

    /*
     * エフェクトコンポーネント
    */

    //--ビート
    public void beatEffect(color col){
        int id = 0;
        for(int i = 0; i < 2; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    3, 0, //動作タイプ、表示タイプ
                    300, //サイズ
                    10.0, //速度
                    col, //色
                    width * i, height, 0 //座標、角度
                );
            }
        }
    }

    //--放射状
    public void radialEffect(color col){
        int id = 0;
        for(int i = 0; i < 12; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    4, 0, //動作タイプ、表示タイプ
                    30, //サイズ
                    random(5,10), //速度
                    col, //色
                    width / 2 + 200 * cos(radians(i * 30)), height / 2 + 200 * sin(radians(i * 30)), //座標
                    radians(i * 30 + 30) //角度
                );
            }
        }
    }

    //--なんかLivePhotosのアレみたいな
    public void ellipseEffect(color col){
        int id = 0;
        for(int i = 0; i < 5; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    0, 0, //動作タイプ、表示タイプ
                    1300 - i * 300, //サイズ
                    15, //速度
                    col, //色
                    width / 2, height / 2, //座標
                    0 //角度
                );
            }
        }
    }

    //--バラバラに動くライン
    public void lineEffect(color col){
        int id = 0;
        for(int i = 0; i < 10; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    7, 7, //動作タイプ、表示タイプ
                    200, //サイズ
                    40, //速度
                    col, //色
                    random(width), random(height), //座標
                    radians((i % 2) * 180 + int(random(120)) - 60) //角度
                );
            }
        }
    }

    //--直線
    public void straightEffect(color col){
        int id = 0;
        for(int i = 0; i < 10; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    6, 7, //動作タイプ、表示タイプ
                    200, //サイズ
                    random(30) + 10, //速度
                    col, //色
                    (i % 2) * width, random(height), //座標
                    radians((i % 2) * 180) //角度
                );
            }
        }
    }

    //--六角形それっぽい位置に
    public void hexaEffect(color col){
        int id = 0;
        for(int i = 0; i < 4; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    8, 3, //動作タイプ、表示タイプ
                    300, //サイズ
                    10, //速度
                    col, //色
                    500 + i * 400, height, //座標
                    0 //角度
                );
            }
        }
        for(int i = 0; i < 4; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    8, 3, //動作タイプ、表示タイプ
                    300, //サイズ
                    10, //速度
                    #00CC00, //色
                    width - 500 - i * 400, 1, //座標
                    radians(180) //角度
                );
            }
        }
    }

    //--収束する立方体
    public void rollboxEffect(color col){
        int id = 0;
        //--細かいスパークル
        for(int i = 0; i < 10; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    4, 6, //動作タイプ、表示タイプ
                    200, //サイズ
                    10, //速度
                    col, //色
                    width / 2 + 1000 * cos(radians(i * 36)), height / 2 + 1000 * sin(radians(i * 36)), //座標
                    radians(i * 36 + 210) //角度
                );
            }
        }
    }

    //--バブル
    public void bubbleEffect(color col){
        int id = 0;
        //--細かいスパークル
        for(int i = 0; i < 30; i++){
            id = getemptyID();
            if (id != -1) {
                float opt[] = {3,3};
                int size = int(random(50) + 5);
                sp[id] = new Sparcle(
                    9, 0, //動作タイプ、表示タイプ
                    size, //サイズ
                    (60 - size) / 2, //速度
                    col, //色
                    int(random(width)), height + 50,//座標
                    radians(90), //角度
                    opt //アディショナルパラメータ
                );
            }
        }        
    }

    //--花火
    public void fireEffect(color col){
        int id = 0;
        for(int j = 0; j < 5; j++){
            for(int i = 0; i < 30; i++){
                id = getemptyID();
                if (id != -1) {
                    int iniDif = j * 100; //初期位相
                    sp[id] = new Sparcle(
                        10, 7, //動作タイプ、表示タイプ
                        (5 - j) * 20, //サイズ
                        10, //速度
                        col, //色
                        width / 2 + iniDif * cos(radians(i * 12)), height / 2 + iniDif * sin(radians(i * 12)),//座標
                        radians(i * 12) //角度
                    );
                }
            }  
        }
    }

    //--ellipseEffectの小型版 音に合わせる用
    public void toneEffect(color col){
        int id = 0;

        //--まず真ん中の位置を決めてデカい円を一つ
        float x = random(width - 100) + 50, y = random(height - 100) + 50; //端から50px以内には置かない
        id = getemptyID();
        if (id != -1) {
            sp[id] = new Sparcle(
                0, 0, //動作タイプ、表示タイプ
                200, //サイズ
                8, //速度
                col, //色
                x, y, //座標
                0 //角度
            );
        }
    }

    //--固定IDで背景に選択状態を表示
    public void bgEffect(){
        int id = 0;
        for(int i = 0; i < 4; i++){
            id = getemptyID();
            float opt[] = {i};
            if(id != -1){
                sp[id] = new Sparcle(
                    11, 8, //動作タイプ、表示タイプ
                    width / 4, //サイズ
                    5, //速度
                    0, //色
                    i * (width / 4), 0, //座標
                    0, //角度
                    opt //オプショナルパラメータ
                );
            }
        }
    }

    //--3Dで手前から奥に六角形を飛ばしてみるよ
    public void hexa3DEffect(color col){
        int id = 0;
        for(int i = 0; i < 10; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    12, 9, //動作タイプ、表示タイプ
                    100, //サイズ
                    20, //速度
                    col, //色
                    i * 200, height - 300, 500 + (i % 2) * 400,//座標
                    radians(90) //角度
                );
            }
        }

    }

    //--なんか立方体前に飛ばす
    public void box3DEffect(color col){
        col = color(red(col), green(col), blue(col), 0);
        int id = 0;
        int size = int(random(130) + 130);
        for(int i = 0; i < 100; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    13, 6, //動作タイプ、表示タイプ
                    size, //サイズ
                    size / 5, //速度
                    col, //色
                    // random(width*2), random(height*2), -900 + (100 - random(200)),//座標
                    random(-2000,2000), random(-height, height), random(-2000, 2000),//座標
                    radians(random(360)) //角度
                );
            }
        }
    }

    //--なんかノーツみたいなの飛んでくる
    public void note3DEffect(color col, int idx){
        col = color(red(col), green(col), blue(col), 0);
        int id = 0;
        float size[] = {90, 90, 500};
        id = getemptyID();
        if (id != -1) {
            sp[id] = new Sparcle(
                14, 10, //動作タイプ、表示タイプ
                30, //サイズ
                70, //速度
                col, //色
                (width / 4) * idx + width / 8, height - 100, -4000,//座標
                0, //角度
                size //タイプ10はサイズ値を読まないのでここで指定
            );
        }
    }

    //--なんか不等号いっぱい
    public void arrowEffect(color col){
        int pos[] = {-400, 0, 200, 400};
        int spd[] = {20, 15, 10, 5};
        for(int i = 0; i < 4; i++){
            for(int j = 0; j < 3; j++){
                float bx = pos[i], by = random(height * 2) - 400;
                for(int k = 0; k < 3; k++){
                    int id = 0;
                    id = getemptyID();
                    if (id != -1) {
                        sp[id] = new Sparcle(
                            12, 4, //動作タイプ、表示タイプ
                            100, //サイズ
                            spd[i], //速度
                            col, //色
                            bx, by, 650 + random(-150, 150) + k * 30,//座標
                            radians(90) //角度
                        );
                    }
                }
            }
        }
    }

    //--六角形でも描きます?
    public void hexaWallEffect(color col){
        int cnt = 0;
        for(int z = 500; z > -1000; z-=200){
            for(int y = -height; y < height * 2; y+=400){
                int ty = y, tx = 300;
                if(cnt % 2 == 0){
                    ty = y + 100;
                    tx = -800;
                }
                int id = 0;
                id = getemptyID();
                if (id != -1) {
                    sp[id] = new Sparcle(
                        12, 3, //動作タイプ、表示タイプ
                        200, //サイズ
                        15, //速度
                        col, //色
                        tx, ty, z,//座標
                        radians(90) //角度
                    );
                }
            }
            cnt++;
        }

    }

    /*
     *  スパークル制御
    */

    //--任意Sparcleインスタンスを生成
    public void newSparcle(Sparcle sp_){
        int id = getemptyID();
        if (id != -1) {
            sp[id] = sp_;
        }
    }

    //--各スパークルを更新
    public void update(){
        for (int i = 0; i < SPARCLE_MAX; i++) {
            if (sp[i].move() == 1) continue;
        }
    }

    //--空きID取得
    public int getemptyID() {
        for (int i = 0; i < SPARCLE_MAX; i++) {
            if (sp[i].status == -1) return i;
        }
        return -1;
    }

}