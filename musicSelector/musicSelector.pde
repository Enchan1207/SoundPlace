//選曲システムどうするんや
CellList cl = new CellList();

void setup(){
  size(500, 500);
  cl.createCellList();
}

void draw(){  
  cl.show();
  println("選択中の曲" + cl.list[cl.index].title);
}

void keyTyped(){
  //--リストスクロール
  if(key == 'w'){
    cl.move(-1);    
  }else if(key == 's'){
    cl.move(1);      
  }
}
