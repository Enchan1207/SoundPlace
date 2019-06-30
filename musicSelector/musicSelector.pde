//選曲システムどうするんや
CellList cl = new CellList();

void setup(){
  size(500, 500, P3D);
  cl.createCellList();
}

void draw(){  
  background(0);
  cl.show();
}

void keyTyped(){
  //--リストスクロール
  cl.move(int(key == 's') - int(key == 'w'));
}
