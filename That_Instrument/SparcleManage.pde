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

    //--ビート用エフェクト
    public void beatEffect(){
        int id = 0;
        for(int i = 0; i < 2; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    3, 0, //動作タイプ、表示タイプ 
                    10, //サイズ
                    10.0, //速度
                    #FFFFFF, //色
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

    //--これいけるかな rect使って疑似3D
    public void parseEffect(){
        int id = 0;
        for(int i = 0; i < 5; i++){
            id = getemptyID();
            if (id != -1) {
                sp[id] = new Sparcle(
                    0, 0, //動作タイプ、表示タイプ 
                    100 - i * 30, //サイズ
                    10, //速度
                    #FFFFFF, //色
                    width / 2, height / 2, //座標
                    0 //角度
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