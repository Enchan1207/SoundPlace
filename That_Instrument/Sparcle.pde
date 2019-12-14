/*
 * スパークル描画クラス
*/


class Sparcle {
    //--
    int mtype, stype; //移動タイプ、描画タイプ
    int size; //サイズ
    float spd; //速度
    color col; //色
    float x = 0, y = 0, z = 0; //座標
    int status; //動作状態(-1:未使用またはアニメーション終了)
    float angle; //角度
    float opt[]; //オプショナルパラメータ

    //--スパークル生成
    Sparcle(int mtype, int stype, int size, float spd, color col, float x, float y, float z, float angle, float opt[]) {
        this.mtype = mtype;
        this.stype = stype;
        this.size = size;
        this.spd = spd;
        this.col = col;
        this.x = x;
        this.y = y;
        this.z = z;
        this.angle = angle;
        this.opt = opt;
    }

    Sparcle(int mtype, int stype, int size, float spd, color col, float x, float y, float angle, float opt[]) {
        this.mtype = mtype;
        this.stype = stype;
        this.size = size;
        this.spd = spd;
        this.col = col;
        this.x = x;
        this.y = y;
        this.angle = angle;
        this.opt = opt;
    }

    Sparcle(int mtype, int stype, int size, float spd, color col, float x, float y, float z, float angle) {
        this.mtype = mtype;
        this.stype = stype;
        this.size = size;
        this.spd = spd;
        this.col = col;
        this.x = x;
        this.y = y;
        this.z = z;
        this.angle = angle;
    }

    Sparcle(int mtype, int stype, int size, float spd, color col, float x, float y, float angle) {
        this.mtype = mtype;
        this.stype = stype;
        this.size = size;
        this.spd = spd;
        this.col = col;
        this.x = x;
        this.y = y;
        this.angle = angle;
    }

    //--移動
    int move() {
        //動作状態が-1ならループごとスキップ
        if(status != -1){
            switch(mtype) {
                case 0: //フェードアウトしながら縮小し、消滅
                    if (size > 0 || alpha(col) > 0) {
                        status = 1;
                        col = color(red(col), green(col), blue(col), alpha(col) - this.spd);
                        size -= this.spd;
                    } else {
                        status = -1;
                    }
                    break;
                case 1: //回転(cw)+フェードアウト+拡大
                    if (alpha(col) > 0) {
                        status = 1;
                        angle += 0.1;
                        size += this.spd;
                        col = color(red(col), green(col), blue(col), alpha(col) - this.spd);
                    } else {
                        status = -1;
                    }
                    break;
                case 2: //回転(ccw)+フェードアウト+拡大
                    if (alpha(col) > 0) {
                        status = 1;
                        angle -= 0.1;
                        size += this.spd;
                        col = color(red(col), green(col), blue(col), alpha(col) - this.spd);
                    } else {
                        status = -1;
                    }
                    break;
                case 3: //フェードアウト+拡大
                    if (alpha(col) > 0) {
                        status = 1;
                        size += this.spd;
                        col = color(red(col), green(col), blue(col), alpha(col) - this.spd);
                    } else {
                        status = -1;
                    }
                    break;
                case 4: //angleの向いている方向に移動+フェードアウト
                    if (alpha(col) > 0) {
                        x += cos(angle) * this.spd;
                        y += sin(angle) * this.spd;
                        col = color(red(col), green(col), blue(col), alpha(col) - this.spd / 2);
                    } else {
                        status = -1;
                    }
                    break;

                case 5: //フェードアウトのみ
                    if (alpha(col) > 0) {
                        status = 1;
                        col = color(red(col), green(col), blue(col), alpha(col) - this.spd);
                    } else {
                        status = -1;
                    }
                    break;
                
                case 6: //とにかく端まで移動する
                    if (x >= 0 && x <= width && y >= 0 && y <= height) {
                        x += cos(angle) * this.spd;
                        y += sin(angle) * this.spd;
                        col = color(red(col), green(col), blue(col), alpha(col) - 2);
                    } else {
                        status = -1;
                    }
                    break;

                case 7: //跳ね返らせてみる
                    if (alpha(col) > 0) {
                        x += cos(angle) * this.spd;
                        y += sin(angle) * this.spd;
                        col = color(red(col), green(col), blue(col), alpha(col) - 10);
                        //--跳ね返り処理
                        if(x <= 0 || y <= 0) angle += radians(90);
                        if(x >= width || y >= height) angle -= radians(90);
                    } else {
                        status = -1;
                    }
                    break;

                case 8: //alpha(sin)でうにょんうにょん+移動
                    if (x >= 0 && x <= width && y >= 0 && y <= height) {
                        x += cos(angle) * this.spd;
                        y += sin(angle) * this.spd;
                        col = color(red(col), green(col), blue(col), 128 * sin(radians(sqrt(x * x  + y * y)) + 128));
                    } else {
                        status = -1;
                    }
                    break;

                case 9: //sinの軌跡+フェードアウト
                    if (alpha(col) > 0) {
                        x += cos(radians(y + int(random(20) - 10))) * opt[0];
                        y -= this.spd;
                        col = color(red(col), green(col), blue(col), alpha(col) - opt[1]);
                    } else {
                        status = -1;
                    }
                    break;
                
                case 10: //花火風に
                    if (alpha(col) > 0) {
                        x += this.spd * cos(angle);
                        y += this.spd * sin(angle);
                        //--中心からの距離を計算
                        float diff = sqrt(pow(x - width / 2, 2) + pow(y - height / 2, 2)) / 20;
                        col = color(red(col), green(col) - diff, blue(col) - diff, alpha(col) - 3);
                    } else {
                        status = -1;
                    }
                    break;

                case 11: //sinフェード(消えないので実質ID占有 使いすぎないように)
                    y += spd;
                    if(y > 360) y = 0;
                    col = efColor[selidx[int(opt[0])]];
                    col = color(red(col), green(col), blue(col), 48 * sin(radians(y)) + 48);
                    break;

                case 12: //奥に飛ばす(3D)

                    if (z > -3000) {
                        z -= this.spd;
                        col = color(red(col), green(col), blue(col), alpha(col) - 1);
                    } else {
                        status = -1;
                    }
                    break;
                case 13: //回転しながら手前に飛んでくる(3D)
                    if(x < 2000){
                        x += this.spd;
                        angle += radians(5);
                        col = color(red(col), green(col), blue(col), alpha(col) + 5);
                    }else{
                        status = -1;
                    }
                    break;

                case 14: //まっすぐ手前に飛んでくる(3D)
                    if(z < 1000){
                        z += this.spd;
                        col = color(red(col), green(col), blue(col), alpha(col) + 2);
                    }else{
                        status = -1;
                    }
                    break;

            }
            show();
            return 0;
        }
        
        return 1;
    }

    //--描画
    void show() {
        stroke(col);
        strokeWeight(size / 15);
        strokeCap(PROJECT);
        noFill();
        if (status != -1) {
            switch(stype) {
                case 0: //円
                    ellipseMode(RADIUS);
                    ellipse(x, y, size, size);
                    break;

                case 1: //正方形
                    pushMatrix();
                    translate(x, y);
                    rotate(angle);
                    rect(-size / 2, -size / 2, size, size);
                    popMatrix();
                    break;

                case 2: //正三角形
                    pushMatrix();
                    translate(x, y);
                    rotate(angle);
                    //--各頂点の座標を求める 重心からの距離=sizeとする                    
                    triangle(
                        0, -size, 
                        -size * cos(radians(30)), size * sin(radians(30)), 
                        size * cos(radians(30)), size * sin(radians(30))
                        );
                    popMatrix();
                    break;
                case 3: //六角形
                    pushMatrix();
                    translate(x, y, z);
                    rotateY(angle);
                    //--各頂点の座標を求める
                    beginShape();
                    vertex(-size, 0);
                    vertex(-size * cos(radians(60)), size * sin(radians(60)));
                    vertex(size * cos(radians(60)), size * sin(radians(60)));
                    vertex(size, 0);
                    vertex(size * cos(radians(60)), -size * sin(radians(60)));
                    vertex(-size * cos(radians(60)), -size * sin(radians(60)));
                    endShape(CLOSE);
                    popMatrix();
                    break;

                    //--不等号
                case 4: //不等号
                    if(sin(radians(abs(z) / 5)) > 0.8){
                        noStroke();
                    }else{
                        stroke(col);
                    }
                    pushMatrix();
                    translate(x,y,z);
                    rotateY(angle);
                    strokeWeight(10);
                    //--各頂点の座標を求める
                    beginShape();
                    vertex(-size * cos(radians(45)), size * sin(radians(45)));
                    vertex(size, 0);
                    vertex(-size * cos(radians(45)), -size * sin(radians(45)));
                    endShape();
                    popMatrix();
                    break;
                case 5: //ライン
                    pushMatrix();
                    translate(x, y);
                    rotate(angle);
                    //--角度に従って線を描く
                    line(-2000, 0, 2000, 0);
                    popMatrix();
                    break;
                    
                    //--立方体
                case 6: //立方体
                    pushMatrix();
                    strokeWeight(2);
                    translate(x, y, z);
                    rotateZ(-angle);
                    rotateX(angle);
                    box(size);
                    popMatrix();
                    break;

                case 7: //長さ指定
                    pushMatrix();
                    translate(x, y, z);
                    rotateY(angle);
                    //--角度に従って線を描く
                    strokeWeight(3);
                    line(-size / 2, 0, size / 2, 0);
                    popMatrix();
                    break;

                case 8: //長方形(塗り潰し)
                    pushMatrix();
                    translate(x, 0);
                    noStroke();
                    fill(col);
                    rect(0, 0, size, height);
                    noFill();
                    popMatrix();
                    break;

                case 9: //六角形(3D)
                    pushMatrix();
                    translate(x, y, z);
                    rotateX(angle);
                    //--各頂点の座標を求める
                    beginShape();
                    vertex(-size, 0);
                    vertex(-size * cos(radians(60)), size * sin(radians(60)));
                    vertex(size * cos(radians(60)), size * sin(radians(60)));
                    vertex(size, 0);
                    vertex(size * cos(radians(60)), -size * sin(radians(60)));
                    vertex(-size * cos(radians(60)), -size * sin(radians(60)));
                    endShape(CLOSE);
                    popMatrix();
                    break;

                case 10: //直方体(optで寸法指定)
                    pushMatrix();
                    translate(x, y, z);
                    noStroke();
                    fill(col);
                    box(opt[0], opt[1], opt[2]);
                    popMatrix();
                    break;
            }
        }
    }
}