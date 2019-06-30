import java.io.*;

//--楽曲リスト
class CellList{
  Cell list[];
  int index; //ファイル数/インデックス
  int status; //セル移動ステータス
  
  CellList(){
    index = 0;
  }
  
  //--楽曲セルリストを作成
  void createCellList(){
    File dir = new File(dataPath(""));
    File files[] = dir.listFiles();
    //(.DS_Store対策をはさむべき?)
    this.list = new Cell[files.length];
    for(int i = 0; i < list.length; i++){
      String info[] = loadStrings(files[i].getAbsolutePath()+"/info.txt");
      list[i] = new Cell(files[i].getAbsolutePath() + "/icon.jpg", info[0], info[1]);
      println("楽曲を取得しました タイトル:" + info[0] + " 作曲者:" + info[1]);
    }
  }
  
  //--移動
  void move(int val){
    index += int(val > 0 && index < list.length-1) - int(val < 0 && index > 0);
    status = 0;
  }
  
  //--セルリストを表示
  void show(){
    for(int i = 0; i < list.length; i++){
      //--ジャケットリスト
      int dist = i - index; //選択中のインデックスからの距離
      int w = 200 - (abs(dist) * 20); //各セルのサイズ
      int alpha = 0xff - abs(dist)*50; //こういうことするから256曲目で困る 
      int margin = dist * 120; //マージン(アイコン間の空白量)
      
      pushMatrix();
      tint(alpha);
      translate((width /2) + margin , height / 2, -(abs(dist) * 1));
      image(list[i].icon, -w / 2, -w / 2, w, w);
      popMatrix();
      
      //--選択中の曲の情報
      pushMatrix();
      translate(width / 2, height - 70);
      textAlign(CENTER);
      textSize(20);
      text(list[index].title, 0, 0);
      textSize(15);
      text(list[index].composer, 0, 40);
      popMatrix();
    }
  }
  
}
