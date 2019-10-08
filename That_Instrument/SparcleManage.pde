/*
 * スパークルマネージャ
*/

class SparcleManager{
    //--
    static final int SPARCLE_MAX = 4096; //スパークル最大表示数
    private Sparcle sp[] = new Sparcle[SPARCLE_MAX];

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
    public void beatEffect(){
        int id = 0;
        for(int i = 0; i < 2; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    3, 0, //動作タイプ、表示タイプ
                    300, //サイズ
                    10.0, //速度
                    #FF00FF, //色
                    width * i, height, 0 //座標、角度
                );
            }
        }
    }

    //--放射状
    public void radialEffect(){
        int id = 0;
        for(int i = 0; i < 12; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    4, 0, //動作タイプ、表示タイプ
                    30, //サイズ
                    random(5,10), //速度
                    #FFFFFF, //色
                    width / 2 + 200 * cos(radians(i * 30)), height / 2 + 200 * sin(radians(i * 30)), //座標
                    radians(i * 30 + 30) //角度
                );
            }
        }
    }

    //--なんかLivePhotosのアレみたいな
    public void ellipseEffect(){
        int id = 0;
        for(int i = 0; i < 5; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    0, 0, //動作タイプ、表示タイプ
                    1300 - i * 300, //サイズ
                    10, //速度
                    #FFCC00, //色
                    width / 2, height / 2, //座標
                    0 //角度
                );
            }
        }
    }

    //--バラバラに動くライン
    public void lineEffect(){
        int id = 0;
        for(int i = 0; i < 10; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    7, 7, //動作タイプ、表示タイプ
                    200, //サイズ
                    40, //速度
                    #CCFF00, //色
                    random(width), random(height), //座標
                    radians((i % 2) * 180 + int(random(120)) - 60) //角度
                );
            }
        }
    }

    //--直線
    public void straightEffect(){
        int id = 0;
        for(int i = 0; i < 10; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    6, 7, //動作タイプ、表示タイプ
                    200, //サイズ
                    random(30) + 10, //速度
                    #CCFF00, //色
                    (i % 2) * width, random(height), //座標
                    radians((i % 2) * 180) //角度
                );
            }
        }
    }

    //--六角形それっぽい位置に
    public void hexaEffect(){
        int id = 0;
        for(int i = 0; i < 4; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    8, 3, //動作タイプ、表示タイプ
                    300, //サイズ
                    10, //速度
                    #00CC00, //色
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
    public void rollboxEffect(){
        int id = 0;
        //--細かいスパークル
        for(int i = 0; i < 10; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    4, 6, //動作タイプ、表示タイプ
                    200, //サイズ
                    10, //速度
                    #00CCFF, //色
                    width / 2 + 1000 * cos(radians(i * 36)), height / 2 + 1000 * sin(radians(i * 36)), //座標
                    radians(i * 36 + 210) //角度
                );
            }
        }
    }

    //--バブル
    public void bubbleEffect(){
        int id = 0;
        //--細かいスパークル
        for(int i = 0; i < 30; i++){
            id = getemptyID();
            if (id != -1) {
                float opt[] = {3,5};
                int size = int(random(40) + 10);
                sp[id] = new Sparcle(
                    9, 0, //動作タイプ、表示タイプ
                    size, //サイズ
                    (60 - size) / 2, //速度
                    #00FFCC, //色
                    int(random(width)), height + 50,//座標
                    radians(90), //角度
                    opt //アディショナルパラメータ
                );
            }
        }        
    }

    /*
     *  スパークル制御
    */

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