import java.io.*;

//--楽曲リスト
class CellList{
  Cell list[];
  int size, index; //ファイル数/インデックス
  int status; //セル移動ステータス
  
  CellList(){
    index = 0;
  }
  
  //--楽曲セルリストを作成
  void createCellList(){
    File dir = new File(dataPath(""));
    File files[] = dir.listFiles();
    //--ディレクトリのみ抽出
    for(int i = 0; i < files.length; i++){
      size += int(files[i].isDirectory()); 
    }
    
    //--ディレクトリ内のinfo.txtからセルのデータを呼び出す
    this.list = new Cell[size];
    for(int i = 0; i < size; i++){
      String info[] = loadStrings(files[i].getAbsolutePath()+"/info.txt");
      list[i] = new Cell(files[i].getAbsolutePath() + "/icon.jpg", info[0], info[1]);
      println("楽曲を取得しました タイトル:" + info[0] + " 作曲者:" + info[1]);
    }
  }
  
  //--移動
  void move(int val){
    index += int(val > 0 && index < size-1) - int(val < 0 && index > 0);
    status = 0;
  }
  
  //--セルリストを表示
  void show(){
    
    
    
    
  }
}
