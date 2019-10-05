/*
 * スパークル描画クラス
*/


class Sparcle {
    //--
    int mtype, stype; //移動タイプ、描画タイプ
    int size; //サイズ
    float spd; //速度
    color col; //色
    float x, y; //座標
    int status; //動作状態(-1:未使用またはアニメーション終了)
    float angle; //角度

    //--スパークル生成
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
                        angle += radians(this.spd);
                        x += cos(angle) * this.spd;
                        y += sin(angle) * this.spd;
                        col = color(red(col), green(col), blue(col), alpha(col) - this.spd);
                    } else {
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
                    translate(x, y);
                    rotate(angle);
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
                    pushMatrix();
                    translate(x, y);
                    rotate(angle);
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
                    translate(x, y);
                    rotateZ(-angle);
                    rotateX(angle);
                    box(size);
                    popMatrix();
                    break;

                case 7: //長さ指定
                    pushMatrix();
                    translate(x, y);
                    rotate(angle);
                    //--角度に従って線を描く
                    strokeWeight(3);
                    line(-size / 2, 0, size / 2, 0);
                    popMatrix();
                    break;
                    
            }
        }
    }
}