//--スパークル
class Sparcle {
  //--
  int mtype, stype; //移動タイプ、描画タイプ
  int size;
  color col;
  float x, y;
  int status; //動作状態(-1:未使用またはアニメーション終了)
  float angle;

  //--スパークル生成
  Sparcle(int mtype, int stype, int size, color col, float x, float y, float angle) {
    this.mtype = mtype;
    this.stype = stype;
    this.size = size;
    this.col = col;
    this.x = x;
    this.y = y;
    this.angle = angle;
  }

  //--移動
  void move() {
    switch(mtype) {
      //--タイプ0: フェードアウトしながら縮小し、消滅
    case 0:
      if (size > 0 || alpha(col) > 0) {
        status = 1;
        col = color(red(col), green(col), blue(col), alpha(col) - 5);
        size--;
      } else {
        status = -1;
      }
      break;

      //--タイプ1:回転(cw)+フェードアウト+拡大
    case 1:
      if (alpha(col) > 0) {
        status = 1;
        angle += 0.1;
        size++;
        col = color(red(col), green(col), blue(col), alpha(col) - 5);
      } else {
        status = -1;
      }
      break;

      //--タイプ2:回転(ccw)+フェードアウト+拡大
    case 2:
      if (alpha(col) > 0) {
        status = 1;
        angle -= 0.1;
        size++;
        col = color(red(col), green(col), blue(col), alpha(col) - 5);
      } else {
        status = -1;
      }
      break;

      //--タイプ3:フェードアウト+拡大
    case 3:
      if (alpha(col) > 0) {
        status = 1;
        size++;
        col = color(red(col), green(col), blue(col), alpha(col) - 5);
      } else {
        status = -1;
      }
      break;

      //--タイプ4:angleの向いている方向に移動+フェードアウト
    case 4:
      if (alpha(col) > 0) {
        status = 1;
        x += cos(angle) * 2;
        y += sin(angle) * 2;
        col = color(red(col), green(col), blue(col), alpha(col) - 2);
      } else {
        status = -1;
      }
      break;
    }
    show();
  }

  //--描画
  void show() {
    stroke(col);
    strokeWeight(size / 15);
    noFill();
    if (status != -1) {
      switch(stype) {
        //--円
      case 0:
        ellipseMode(RADIUS);
        ellipse(x, y, size, size);
        break;

        //--正方形
      case 1:
        pushMatrix();
        translate(x, y);
        rotate(angle);
        rect(-size / 2, -size / 2, size, size);
        popMatrix();
        break;

        //--正三角形
      case 2:
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

        //--六角形
      case 3:
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
      case 4:
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

        //--ライン
      case 5:
        pushMatrix();
        translate(x, y);
        rotate(angle);
        //--角度に従って線を描く
        line(-2000, 0, 2000, 0);
        popMatrix();
        break;
        
        //--立方体
      case 6:
        pushMatrix();
        translate(x, y);
        rotateZ(-angle);
        rotateX(angle);
        box(size);
        popMatrix();
        break;
        
      }
    }
  }
}
